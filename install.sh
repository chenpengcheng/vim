#!/bin/bash

BUNDLE_DIR=".vim/bundle"

PLUGINS=" \
    https://github.com/scrooloose/nerdtree.git \
    https://github.com/majutsushi/tagbar.git \
    https://github.com/farmergreg/vim-lastplace.git \
    https://github.com/mhinz/vim-startify.git \
    https://github.com/junegunn/fzf.vim.git \
    https://github.com/justinmk/vim-sneak.git \
    https://github.com/Valloric/YouCompleteMe.git \
    https://github.com/godlygeek/tabular.git \
    https://github.com/scrooloose/nerdcommenter.git \
    https://github.com/tpope/vim-fugitive.git \
    https://github.com/vim-syntastic/syntastic.git \
    https://github.com/vim-airline/vim-airline.git \
    https://github.com/romainl/vim-qf.git \
    https://github.com/airblade/vim-gitgutter.git \
    https://github.com/fatih/vim-go.git \
"

cd $BUNDLE_DIR
for plugin in $PLUGINS
    do git clone $plugin
done
cd -

cp fzf/tags.py .vim/bundle/fzf.vim/bin/
patch -p1 < fzf/001-python-tags.patch
patch -p1 < tagbar/001-fix-status-line-crash.patch
patch -p1 < nerdtree/001-disable-bookmark-split-window.patch
cp nerdtree/custom.vim .vim/bundle/nerdtree/nerdtree_plugin/

cd .vim/bundle/YouCompleteMe/
git submodule update --init --recursive
./install.py --clang-completer --go-completer --js-completer
cd -

rm -fr /tmp/.vim*
mv $HOME/.vim* /tmp/
cp -R .vim* $HOME/

cd .vim/bundle/
rm -fr YouCompleteMe/ fzf.vim/ nerdcommenter/ nerdtree/ syntastic/ tabular tagbar/ vim-*
cd -
