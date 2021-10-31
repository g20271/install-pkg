#!/bin/bash

echo "prootをインストールします"

BIN_PATH=$HOME/.local/bin


mkdir -p $BIN_PATH
cd  $BIN_PATH
wget https://proot.gitlab.io/proot/bin/proot -O proot
chmod 700 proot

if [ -e $BIN_PATH/proot ]; then
    echo "prootのインストールに成功しました"
else
    echo "prootのインストールに失敗しました"
fi


grep -q "export PATH=\"\$PATH:$BIN_PATH\" #For proot" $HOME/.bashrc
if [ $? -eq 1 ] ; then
    echo "環境変数を設定しました"
    echo "export PATH=\"\$PATH:$BIN_PATH\" #For proot" >> $HOME/.bashrc
fi
