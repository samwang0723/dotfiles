# NvChad Install
Choose NvChad because it has complete initial setup of common needs.

## Install NvChad (note: after v2.5, no custom config supported)

    $ git clone https://github.com/NvChad/NvChad --branch v2.0 ~/.config/nvim
    $ cp -R .config/nvim/lua/custom ~/.config/nvim/lua/

## Soft link to your .config/nvim

    ln -s $GOPATH/src/github.com/samwang0723/dotfiles/.config/nvim/lua/custom ~/.config/nvim/lua/custom
