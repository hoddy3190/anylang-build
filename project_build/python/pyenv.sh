#!/bin/bash

set -euo pipefail

# インストール可能なバージョンリストを更新
# mafifestの最新化を行って、"definition not found"が起きないようにする
brew update
brew install pyenv
brew upgrade pyenv
brew install pipenv
brew upgrade pipenv

version=${1:-''}

# 特にバージョン指定がなければ最新版をインストールする
if [[ -z "$version" ]]; then
    version=$(pyenv install --list | grep --extended-regexp "^\s*[0-9][0-9.]*[0-9]\s*$" | tail -1 | tr -d ' ')
    # 途中のgrepで落ちないように+eしておく
    # set +e
    # latest_version=$(
    #     curl -s https://www.python.org/ |\
    #     grep "Latest: " |\
    #     perl -anle "print \$1 if (\$_ =~ /\>Python (.*)\<\/a\>/)"
    # )
    # .pkg or .tar.xz or .exe があるのでmacosxで絞る
    # latest_version=$(
    #     curl -s https://www.python.org/downloads/macos/ |\
    #     grep -e 'Latest Python 3 Release' |\
    #     perl -anle "print \$1 if (\$_ =~ /Latest Python 3 Release \- Python (.*)\<\/a\>/)"
    # )
    # set -e
    # スクレイピングに近いことをやってltsを取得しているので安定しないはず
    # 取得できなくなったらエラーで落として、コード修正を促す
    # if [[ -z "$latest_stable_version" ]]; then
    #     echo "cannot get latest version name, fix scraping codes"
    #     exit 1
    # fi
    # version=$latest_stable_version
fi

echo "$version will be installed."

if [[ $(pyenv root) = "$HOME/.pyenv" ]]; then
    cat << "EOS" >> ~/.zshrc.local
export PYENV_ROOT="$XDG_CONFIG_HOME/pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
EOS
    # pyenv install する前に、PYENV_ROOT を設定しておかないと、
    # install 先が $HOME/.pyenv になってしまう
    source ~/.zshrc.local
fi

pyenv install $version
pyenv global $version
pyenv rehash

# install したので、$PYENV_ROOT/bin ディレクトリができる
# 再ログインして ~/.zshrc.local を読み込むことで、 $PYENV_ROOT/bin を PATH に追加する
exec $SHELL -l
