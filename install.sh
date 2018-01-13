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
cp fzf/tags.py .vim/bundle/fzf.vim/bin/
patch -p1 < fzf/001-python-tags.patch

rm -fr /tmp/.vim*
mv $HOME/.vim* /tmp/
cp -R .vim* $HOME/

cd .vim/bundle/
rm -fr fzf.vim/ nerdtree/ syntastic/ tagbar/ vim-*
