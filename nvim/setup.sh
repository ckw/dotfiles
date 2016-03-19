#! /bin/sh

mkdir -p $XDG_CONFIG_HOME/nvim
ln -s ~/dotfiles/nvim/init.vim $XDG_CONFIG_HOME/nvim/init.vim
mkdir -p $XDG_CONFIG_HOME/nvim/autoload $XDG_CONFIG_HOME/nvim/bundle
curl -o $XDG_CONFIG_HOME/nvim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
cp -r after $XDG_CONFIG_HOME/nvim

cd $XDG_CONFIG_HOME/nvim/bundle

git clone https://github.com/vim-scripts/JSON.vim.git
git clone https://github.com/mileszs/ack.vim.git
git clone https://github.com/tpope/vim-surround.git
git clone https://github.com/scrooloose/syntastic.git
git clone git://github.com/tpope/vim-fugitive.git
git clone git@github.com:ckw/vim-powerline.git
git clone https://github.com/Lokaltog/vim-easymotion.git
git clone https://github.com/sjl/gundo.vim.git
git clone https://github.com/Shougo/neocomplcache
git clone https://github.com/kien/ctrlp.vim
git clone https://github.com/airblade/vim-gitgutter.git
git clone https://github.com/duff/vim-scratch.git
git clone https://github.com/derekwyatt/vim-scala
git clone https://github.com/scrooloose/nerdtree.git

git clone https://github.com/flazz/vim-colorschemes.git $XDG_CONFIG_HOME/nvim/vim-colorschemes
ln -s $XDG_CONFIG_HOME/nvim/vim-colorschemes/colors $XDG_CONFIG_HOME/nvim/colors

git clone https://github.com/pdf/ubuntu-mono-powerline-ttf.git ~/.fonts/ubuntu-mono-powerline-ttf
fc-cache -vf

echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo "might need to export TERM=xterm-256color in .bashrc"
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"







