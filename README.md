# kuromajutsu
PRootとnix package managerを使い、学校等の管理者権限を持てない環境用の、非Root環境で最新のC言語開発環境が作れる完全私的ツール。

# Installation
```
ssh [学籍番号]@10.128.1.4 #で接続したあと
git clone https://github.com/g20271/kuromajutsu
cd kuromajutsu
chmod 700 install.sh
source ./install.sh
```

インストールしてもproot環境に入らないとnixやnvimは使えません  
`nix-on`
するとnvimが使えるシェルに入れます  
nvimの初回起動はプラグインのインストールで遅いので全く操作が効かなくても待ってください  
