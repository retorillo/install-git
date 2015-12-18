$encread  = $true
$encname  = $null
$encoding = $null
while ($encread) {
	try {
		$encname  = Read-Host -Prompt 'Profile Encoding (Codepage / Webname)'
		$encoding = [Text.Encoding]::GetEncoding($encname)
		$encread  = $false
	}
	catch {
		Write-Error "$encname is invalid"
	}
}

$psdir    = "$home\Documents\WindowsPowerShell"
$profile  = "$psdir\Profile.ps1"
$gitbin   = 'C:\Program Files\Git\usr\bin'
$idrsa    = "$home/.ssh/id_rsa"

# ---------------------------------------------------------
# init profile
# ---------------------------------------------------------
if (-not (test-path $psdir)) {
	mkdir $psdir
}
if (-not (test-path $profile)) {
	[IO.File]::WriteAllText($profile, '', $encoding);
}

function appendProfile{
	param($line)
	if (([IO.File]::ReadAllLines($profile, $encoding) | ? { $_ -ieq $line }).Count -eq 0) {
		[IO.File]::AppendAllText($profile, $line + "`r`n", $encoding);
	}
}

# ---------------------------------------------------------
# git
# ---------------------------------------------------------
choco install git
appendProfile ('$env:Path += ' + "';$gitbin'")
$env:Path += ";$gitbin"

# ---------------------------------------------------------
# poshgit
# ---------------------------------------------------------
choco install poshgit
appendProfile '& "$PSScriptRoot\poshgit.profile.ps1"'
copy $PSScriptRoot\poshgit.profile.ps1 $psdir -force

# ----------------------------------------------------------
# ssh
# ----------------------------------------------------------
if (-not (test-path $idrsa)) {
	ssh-keygen -t rsa -b 4096 -C "$env:COMPUTERNAME"
}

write-host "Register the following SSH public key via GitHub your account page:" `
 -foreground Yellow
type ($idrsa + ".pub")
