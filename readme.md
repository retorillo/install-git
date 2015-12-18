# PowerShell Script to install git and posh-git with custom profile

## This script DO:

- Install `git` and `posh-git` using Chocolaty.
- Copy `poshgit-profile.ps1` into `~\Documents\WindowsPowerShell`.
- Create or modify `~\Documents\WindowsPowerShell\Profile.ps1`.
	- To run `poshgit-profile.ps1`
	- To add path `C:\Program Files\Git\usr\bin`

## Your PowerShell get the following features after this installation

- Many Linux commands (`git`, `ssh`, `grep`, `less`, and so on)
- Short-Style prompt ( `PS>` or `GIT>` )
- posh-git style indication (only if current directory has '.git')

## How to use this

- `Chocolaty` is required on your Windows.
- Please understand this installation contains my custom posh-git profile. see `poshgit.profile.ps1`.
- Please run this script only if you have knowledge to remove them manually. (Uninstall script is not provided) 
- Run `install.ps1` as administrative privilege if you okay.
- Type encoding name of your profile.ps1 to modify correctly. (ex: utf-8, shift-jis, and so on)
