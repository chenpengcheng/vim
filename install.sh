#!/bin/bash

BUNDLE_DIR=".vim/bundle"
PATCHED_PLUGINS="fzf.vim nerdtree tagbar vim-snippets"

git submodule update --init --recursive

$BUNDLE_DIR/YouCompleteMe/install.py --clang-completer --go-completer --java-completer --ts-completer

sudo npm install -g \
    eslint eslint-config-prettier eslint-config-standard \
    eslint-plugin-import eslint-plugin-node eslint-plugin-promise eslint-plugin-standard \
    eslint-plugin-graphql prettier
    git+https://github.com/Perlence/tstags.git

cp fzf/tags.py .vim/bundle/fzf.vim/bin/
patch -p1 < fzf/001-python-tags.patch
patch -p1 < tagbar/001-fix-status-line-crash.patch

cp nerdtree/custom.vim .vim/bundle/nerdtree/nerdtree_plugin/
patch -p1 < nerdtree/001-disable-bookmark-deletion-confirmation.patch

cp snippets/go.snippets .vim/bundle/vim-snippets/UltiSnips/

rm -fr /tmp/.vim*
mv $HOME/.vim* /tmp/
cp -R .vim* $HOME/

for plugin in $PATCHED_PLUGINS; do
    cd $BUNDLE_DIR/$plugin
    git reset --hard
    git clean -f
    cd -
done

cp -f ctags $HOME/.ctags
