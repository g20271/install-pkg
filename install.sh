#!/bin/bash
#v1.0

#やること
#SSH経由で接続の実装
#init.vimを上書きしないようにする
#補完をたくさん出るようにする

chmod 700 install-*.sh

./install-proot.sh
./install-nix.sh

proot -b ~/.nix:/nix /bin/bash -c "echo neovimをインストールします; ./install-nvim.sh"
