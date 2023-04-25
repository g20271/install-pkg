#!/bin/bash
#Using Proot Medhod from https://nixos.wiki/wiki/Nix_Installation_Guide#PRoot

INSTALL_FILE_PATH=nix-2.9.2-x86_64-linux/install

mkdir -p $HOME/.config/nix/
touch $HOME/.config/nix/nix.conf
grep -q "sandbox = false" $HOME/.config/nix/nix.conf
if [ $? -eq 1 ] ; then
    echo "sandbox = false" >> $HOME/.config/nix/nix.conf
fi

mkdir -p $HOME/.nix
wget https://releases.nixos.org/nix/nix-2.9.2/nix-2.9.2-x86_64-linux.tar.xz -O nix-2.9.2-x86_64-linux.tar.xz
tar -xvf nix-2.9.2-x86_64-linux.tar.xz
DEL_ROW=`grep -n "NIX_SSL_CERT_FILE\"" $INSTALL_FILE_PATH`
DEL_ROW=${DEL_ROW%%:*}
sed -i '193d' $INSTALL_FILE_PATH
sed -i '195d' $INSTALL_FILE_PATH
#sed -i ''$DEL_LOW'd' $INSTALL_FILE_PATH
#sed -i ''$(($DEL_LOW+2))'d' $INSTALL_FILE_PATH #Doesn't work...
#Fix ca-certificate error

proot -b ~/.nix:/nix /bin/bash $INSTALL_FILE_PATH

grep -q "source $HOME/.nix-profile/etc/profile.d/nix.sh #For nix" $HOME/.bashrc
if [ $? -eq 1 ] ; then
    echo "source $HOME/.nix-profile/etc/profile.d/nix.sh #For nix" >> $HOME/.bashrc
fi

grep -q "alias nix-on='proot -b ~/.nix:/nix /bin/bash'" $HOME/.bashrc
if [ $? -eq 1 ] ; then
    echo "alias nix-on='proot -b ~/.nix:/nix /bin/bash'" >> $HOME/.bashrc
fi

echo "nix package managerのインストールが完了しました"
