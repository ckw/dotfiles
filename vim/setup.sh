#! /bin/sh

ln -s ~/dotfiles/vim/.vimrc ~/.vimrc
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -so ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
cp -r after ~/.vim

cd ~/.vim/bundle

git clone https://github.com/vim-scripts/JSON.vim.git
git clone https://github.com/mileszs/ack.vim.git
git clone https://github.com/tpope/vim-surround.git
git clone https://github.com/scrooloose/syntastic.git
git clone git://github.com/tpope/vim-fugitive.git
git clone https://github.com/vim-scripts/LustyJuggler.git
git clone git@github.com:ckw/vim-powerline.git
git clone https://github.com/Lokaltog/vim-easymotion.git
git clone https://github.com/sjl/gundo.vim.git
git clone https://github.com/Shougo/neocomplcache
git clone https://github.com/kien/ctrlp.vim
git clone https://github.com/airblade/vim-gitgutter.git
git clone https://github.com/duff/vim-scratch.git

git clone https://github.com/flazz/vim-colorschemes.git ~/.vim/vim-colorschemes
ln -s ~/.vim/vim-colorschemes/colors ~/.vim/colors

git clone https://github.com/pdf/ubuntu-mono-powerline-ttf.git ~/.fonts/ubuntu-mono-powerline-ttf
fc-cache -vf

echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo "might need to export TERM=xterm-256color in .bashrc"
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"







