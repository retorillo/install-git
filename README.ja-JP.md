# git と posh-git のカスタムインストールスクリプト 

GitHub デスクトップをインストールせずに、gitとposh-gitを直接インストールします。

## このスクリプト実行後に次の機能が追加されます:

- GitHub デスクトップに含まれるものよりも新しいバージョンの `git` と `posh-git`
- 多くのLinuxコマンド (`git` や `ssh`、`grep`、`less` など)
- 短縮されたプロンプト表示 (`PS>` または `GIT>`)
- posh-gitスタイルの表示  (カレントディレクトリに'.git'を含む場合のみ)

## このスクリプトは次のことを行います:

- `git` および `posh-git` を Chocolaty を使いインストールします
- `poshgit.profile.ps1` を `$home\Documents\WindowsPowerShell` に `$OutputEncoding` でコピーします
- `id-rsa`が存在しない場合、`ssh-keygen` でSSHキーを作成します
- `.gitcofig`を設定するウィザードを表示します（ユーザー名とメールアドレスを入力してください）
- `$home\Documents\WindowsPowerShell\Profile.ps1` を次の通り作成するか追記します
	- `poshgit.profile.ps1` を 実行します
	- $env:Path に `C:\Program Files\Git\usr\bin` を追加します 
- GitHubなどに登録するための公開鍵を表示します

## 次の点にご注意ください:

- `install.ps1`は管理者権限で実行してください
- SSHキーは`id-rsa`をGitHubに登録する前提で作っています。複数鍵の環境では便宜調整してください。
- `Windows 10`、 `git 2.6.4`、 `poshgit 0.5.2` で動作確認しています。
- 各パッケージのバージョン変更などでパスが変更になるとうまく動作しない場合があります。便宜変更してください
- 実行には [Chcolaty](https://chocolatey.org/) が必要です
- あくまで個人的に使いやすいように調整したものなので、スクリプトの内容をよくご確認の上で実行してください。
- アンインストールスクリプトは提供されませんので、手作業で削除できる知識のある方以外は実行しないでください。

