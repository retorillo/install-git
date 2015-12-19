$ErrorActionPreference = 'Stop' 

$utf8n   = new-object Text.Utf8Encoding
$psdir   = "$home\Documents\WindowsPowerShell"
$profile = "$psdir\Profile.ps1"
$gitcmd  = "$env:ProgramFiles\Git\cmd"
$gitbin  = "$env:ProgramFiles\Git\usr\bin"
$idrsa   = "$home\.ssh\id_rsa"

# ---------------------------------------------------------
# confirm
# ---------------------------------------------------------
$ct = 'CHECK YOUR $OUTPUTENCODING TO PREVENT YOUR PROFILE FROM BEING BROKEN';
$cm = 'Current $OutputEncoding is "{0}". If it wrong, abort this script and set correct encoding.' `
	-f ($OutputEncoding.WebName)
$co = new-object Management.Automation.Host.ChoiceDescription "&Continue"
$ab = new-object Management.Automation.Host.ChoiceDescription "&Abort"
$an = $host.UI.PromptForChoice($ct, $cm, ($co, $ab), 1)
if ($an -ne 0) { exit }

# ---------------------------------------------------------
# init profile
# ---------------------------------------------------------
if (-not (test-path $psdir)) {
	mkdir $psdir
}
if (-not (test-path $profile)) {
	[IO.File]::WriteAllText($profile, '', $encoding);
}

function appendProfile {
	param($line)
	try {
		if (([IO.File]::ReadAllLines($profile, $OutputEncoding) | ? { $_ -ieq $line }).Count -eq 0) {
			[IO.File]::AppendAllText($profile, $line + "`r`n", $OutputEncoding);
		}
	}
	catch {
		Write-Error $error	
	}
}
function installScript {
	param($src, $dest)
	$lines = [IO.File]::ReadAllLines($src, $utf8n)
	[IO.File]::WriteAllLines($dest, $lines, $OutputEncoding)
}

# ---------------------------------------------------------
# git
# ---------------------------------------------------------
choco install git
appendProfile ('$env:Path += ' + "';$gitbin'")

$gitcmd, $gitbin | % {
	if (-not (Test-Path $gitcmd)) {
		Write-Error "`"$_`" is not found"
		exit
	}
	$env:Path += ";" + $_
}

# ---------------------------------------------------------
# poshgit
# ---------------------------------------------------------
choco install poshgit
appendProfile '& "$PSScriptRoot\poshgit.profile.ps1"'
installScript $PSScriptRoot\poshgit.profile.ps1 $psdir\poshgit.profile.ps1

# ----------------------------------------------------------
# ssh
# ----------------------------------------------------------
if (-not (Test-Path $idrsa)) {
	ssh-keygen -t rsa -b 4096 -C "$env:COMPUTERNAME"
}

# ---------------------------------------------------------- 
# user name
# ----------------------------------------------------------

Write-Host "ENTER YOUR GIT ACCOUNT: " -Foreground Yellow
git config --global user.name  (Read-Host -Prompt 'User Name')
git config --global user.email (Read-Host -Prompt 'Mail Address')

Write-Host "REGISTER THE FOLLOWING SSH PUBLIC KEY VIA GITHUB YOUR ACCOUNT PAGE:" `
 -Foreground Yellow
type ($idrsa + ".pub")

