#!/bin/bash

ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/.bash/.aliases ~/.aliases
ln -s ~/.dotfiles/.bash/.bashrc ~/.bashrc
ln -s ~/.dotfiles/.xinitrc ~/.xinitrc
ln -s ~/.dotfiles/.Xresources ~/.Xresources

mkdir -p ~/.config/i3
ln -s ~/.dotfiles/i3/config ~/.config/i3/config
ln -s ~/.dotfiles/i3/.i3status.conf ~/.i3status.conf

ln -s ~/.dotfiles/vscode/keybindings.json ~/.config/Code\ -\ OSS/User/keybindings.json
ln -s ~/.dotfiles/vscode/settings.json ~/.config/Code\ -\ OSS/User/settings.json

mkdir -p ~/.config/zathura
ln -s ~/.dotfiles/zathurarc ~/.config/zathura/zathurarc