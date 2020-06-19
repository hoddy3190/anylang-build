#!/usr/bin/env bash -eu

version=$1

# nodeのインストールと一緒にnpmもついてくる
nodenv install $version

# $NODENV_ROOT/versionというファイルが作成/更新される
nodenv global $version

# $NODENV_ROOT/shimsに配置されるコマンドを現在のversionにあわせて再編成するコマンド
# https://qiita.com/Neetless/items/160fcc126c17590b664a#shim%E3%81%A8%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3%E5%88%87%E3%82%8A%E6%9B%BF%E3%81%88%E3%81%AE%E4%BB%95%E7%B5%84%E3%81%BF
nodenv rehash
