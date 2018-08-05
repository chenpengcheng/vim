#!/bin/bash

BUNDLE_DIR=".vim/bundle"

git submodule update --init --recursive

cp fzf/tags.py .vim/bundle/fzf.vim/bin/
patch -p1 < fzf/001-python-tags.patch
patch -p1 < tagbar/001-fix-status-line-crash.patch
cp nerdtree/custom.vim .vim/bundle/nerdtree/nerdtree_plugin/
patch -p1 < nerdtree/001-disable-bookmark-deletion-confirmation.patch

$BUNDLE_DIR/YouCompleteMe/install.py --clang-completer --go-completer --js-completer

rm -fr /tmp/.vim*
mv $HOME/.vim* /tmp/
cp -R .vim* $HOME/

rm -fr $BUNDLE_DIR/*
