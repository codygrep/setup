#!/bin/bash

PLUGIN_DIR="$HOME/.vim/pack/plugins/start"

PLUGINS=(
  "fatih/vim-go"
  "scrooloose/NERDTree"
  "vim-airline/vim-airline"
  "tpope/vim-fugitive"
  "janet-lang/janet.vim"
  "vim-scripts/paredit.vim"
)

mkdir -p $PLUGIN_DIR

for PLUGIN in ${PLUGINS[@]}; do
  DIRNAME="$(basename $PLUGIN)"
  if [ ! -d "$PLUGIN_DIR/$DIRNAME" ]; then
    echo "Downloading $DIRNAME"
    git clone https://github.com/$PLUGIN.git $PLUGIN_DIR/$DIRNAME
  else
    echo "$DIRNAME already installed"
  fi
done

if [ ! -d ~/setup/vim/.vimrc ]; then
  ln -s ~/setup/vim/.vimrc ~/.vimrc
fi

echo "vim setup is complete"
