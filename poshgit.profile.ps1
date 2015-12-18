pushd C:\tools\poshgit\dahlbyk-posh-git-fadc4dd\
Import-Module .\posh-git 
$env:WindowTitleFormat = '{0} - Windows PowerShell';
[Security.Principal.WindowsIdentity]::GetCurrent().Groups | % { 
	if ($_.value -eq "S-1-5-32-544") { 
		$env:WindowTitleFormat = 'Administrator: ' + $env:WindowTitleFormat
	}
}
function global:prompt {
	$realLASTEXITCODE = $LASTEXITCODE
	if ($HOME -ieq $pwd.ProviderPath) {
		$current = '~/'
	}
	else {
		$current = $pwd.ProviderPath.Replace($HOME, '~');
	}
	$Host.UI.RawUI.WindowTitle     = $env:WindowTitleFormat -f $current
	$Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor
	if (Test-Path .git) {
		Write-Host "GIT" -NoNewLine
		Write-VcsStatus
	}
	else {
		Write-Host "PS" -NoNewLine
	}
	$global:LASTEXITCODE = $realLASTEXITCODE
	return "> "
}
popd
