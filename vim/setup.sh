#! /bin/sh

ln -s ~/dotfiles/vim/.vimrc ~/.vimrc

cd ~/.vim/bundle

git clone https://github.com/flazz/vim-colorschemes.git ~/.vim/vim-colorschemes
ln -s ~/.vim/vim-colorschemes/colors ~/.vim/colors

git clone https://github.com/pdf/ubuntu-mono-powerline-ttf.git ~/.fonts/ubuntu-mono-powerline-ttf
fc-cache -vf

echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo "might need to export TERM=xterm-256color in .bashrc"
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"







