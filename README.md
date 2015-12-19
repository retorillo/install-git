# Custom installation script for git and posh-git

This script install `git` and `posh-git`.

## The following features will be installed:

- Newer version of `git` and `posh-git` than GitHub Desktop
- Many Linux commands (`git`, `ssh`, `grep`, `less`, and so on)
- Short-Style prompt ( `PS>` or `GIT>` )
- posh-git style indication (only if current directory has '.git')

## This script DO:

- Install `git` and `posh-git` using Chocolaty.
- Copy `poshgit-profile.ps1` into `~\Documents\WindowsPowerShell` by using '$OutputEncoding'
- Create new ssh-key by using `ssh-keygen` only if `id-rsa` does not exist
- Show wizard to configure `.gitconfig` (Enter your Git's username and mailaddress)
- Create or modify `~\Documents\WindowsPowerShell\Profile.ps1` as follows:
	- To run `poshgit-profile.ps1`
	- To add path `C:\Program Files\Git\usr\bin`
- Show Public Key to register into GitHub	

## Pay attention that:

- This script is tested on `Windows10`, `git 2.6.4` and `poshgit 0.5.2`
- This script is assumed `id-rsa` is default SSH key and it will be registered to GitHub. Please re-configure this script if your environment has multiple keys.
- `Chocolaty` is required on your Windows.
- Please run this script only if you have knowledge to remove them manually. (Uninstall script is not provided) 
- Run `install.ps1` as administrative privilege.
