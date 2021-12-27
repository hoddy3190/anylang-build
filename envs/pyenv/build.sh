#!/bin/bash

set -euo pipefail

# インストール可能なバージョンリストを更新
# mafifestの最新化を行って、"definition not found"が起きないようにする
anyenv update pyenv

version=${1:-''}

# 特にバージョン指定がなければ最新版をインストールする
if [[ -z "$version" ]]; then
    # 途中のgrepで落ちないように+eしておく
    set +e
    # .pkg or .tar.xz or .exe があるのでmacosxで絞る
    latest_version=$(
        curl -s https://www.python.org/downloads/macos/ |\
        grep -e 'Latest Python 3 Release' |\
        perl -anle "print \$1 if (\$_ =~ /Latest Python 3 Release \- Python (.*)\<\/a\>/)"
    )
    set -e
    # スクレイピングに近いことをやってltsを取得しているので安定しないはず
    # 取得できなくなったらエラーで落として、コード修正を促す
    if [[ -z "$latest_version" ]]; then
        echo "cannot get latest version name, fix scraping codes"
        exit 1
    fi

    version=$latest_version
fi

echo "$version will be installed."

pyenv install $version

pyenv global $version

# $PYENV_ROOT/shimsに配置されるコマンドを現在のversionにあわせて再編成するコマンド
# https://qiita.com/Neetless/items/160fcc126c17590b664a#shim%E3%81%A8%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3%E5%88%87%E3%82%8A%E6%9B%BF%E3%81%88%E3%81%AE%E4%BB%95%E7%B5%84%E3%81%BF
pyenv rehash

pip install --upgrade pip
pip3 install pipenv # pipenvコマンドはversionごとにインストールする
