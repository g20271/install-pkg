#!/bin/bash
#v1.0

chmod 700 install-*.sh

./install-proot.sh
source $HOME/.bashrc

./install-nix.sh
source $HOME/.bashrc
exec proot -b ~/.nix:/nix /bin/bash -c "echo neovimをインストールします; ./install-nvim.sh"
