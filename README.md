# kuromajutsu
prootインストール後、パスを通す必要がある  
deinのinit.vimのパスを変更する必要がある  
nixのパス追加  
nvimの初回起動は遅い  
  
ssh [学籍番号]@10.128.1.4  
で接続後  
git clone https://github.com/g20271/kuromajutsu  
cd kuromajutsu  
chmod 700 install.sh  
source ./install.sh  
でエラー吐くので  
nix-on  
source ./install-nvim.sh  
するとnvimが使えるようになります  
