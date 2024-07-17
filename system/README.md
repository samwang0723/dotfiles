# System Installation

## Install oh-my-zsh

    curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh

### Plugins

    mkdir -p ~/.local/share/zsh/plugins && ln -s /usr/share/zsh/plugins/powerlevel10k ~/.local/share/zsh/plugins/
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting

## (Optional) TMUX

    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    cp .tmux.conf ~/.tmux.conf

## Upgrade tools

    xcode-select --install
