#!/bin/bash

BUNDLE_DIR=".vim/bundle"

PLUGINS=" \
    https://github.com/scrooloose/nerdtree.git \
    https://github.com/majutsushi/tagbar.git \
    https://github.com/junegunn/fzf.vim.git \
    https://github.com/romainl/vim-qf.git \
    https://github.com/vim-syntastic/syntastic.git \
    https://github.com/fatih/vim-go.git \
    https://github.com/tpope/vim-fugitive.git \
"

cd $BUNDLE_DIR

for plugin in $PLUGINS
    do git clone $plugin
done

cd -

cp -R .vim* $HOME/
