#!/bin/bash

set -euo pipefail

# インストール可能なバージョンリストを更新
# mafifestの最新化を行って、"definition not found"が起きないようにする
brew update
brew install pyenv
brew upgrade pyenv

version=${1:-''}

# 特にバージョン指定がなければ最新版をインストールする
if [[ -z "$version" ]]; then
    version=$(pyenv install --list | grep --extended-regexp "^\s*[0-9][0-9.]*[0-9]\s*$" | tail -1 | tr -d ' ')
fi

echo "$version will be installed."

if [[ $(pyenv root) != "$XDG_CONFIG_HOME/pyenv" ]]; then
    cat <<"EOS" >>~/.zshrc.local
export PYENV_ROOT="$XDG_CONFIG_HOME/pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

EOS
    # pyenv install する前に、PYENV_ROOT を設定しておかないと、
    # install 先が $HOME/.pyenv になってしまう
    ~/.zshrc.local
fi

pyenv install --skip-existing "${version}"
pyenv global "${version}"
pyenv rehash

# install したので、$PYENV_ROOT/bin ディレクトリができる
# 再ログインして ~/.zshrc.local を読み込むことで、 $PYENV_ROOT/bin を PATH に追加する
exec $SHELL -l
