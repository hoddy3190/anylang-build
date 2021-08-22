#!/usr/bin/env bash -l

# sdkコマンドは実行可能ファイルではなく関数であり（try: type sdk）、これを使うためには、
# sdkmanセットアップ時に.bash_profileに記載されたコードを読み込む必要があるため
# bashに-lオプションが必要

# bashに-euオプションをつけて実行したいが、-lによって読み込まれる/etc/bashrcがこけるため、
# ここでsetする
set -eu

# インストール可能なバージョンリストを更新
anyenv update jenv

sdk_wrapper () {
    # sdkコマンド（関数）は、set -uの状態だとエラーになるので一時的に-uを外す
    set +u
    sdk "$@"
    set -u
}

# ディストリビューションごとのidentifierの検索コマンド: sdk list java
# 引数でidentifierを指定しない場合は最新安定版をインストールする
identifier=${1:-''}

if [[ -z "$identifier" ]]; then
    # 最新安定版の取得はsdk i javaでできる。sdkmanの処理を読むと次のURLをたたいて最新安定版名を取得している。
    # https://api.sdkman.io/2/candidates/default/java
    # このスクリプトも最新安定版の取得方法はsdkmanにならう
    # なお上のURLが返すディストリビューションはAdoptOpenJDKである
    # 他のディストリビューションを選択したい場合は、identifier指定しないとダメ
    identifier=$(curl https://api.sdkman.io/2/candidates/default/java)
fi

sdk_wrapper i java "$identifier"

# SDKMANでインストールされたバージョンは自動でデフォルト設定になるので、
# jenvにaddするJDKは常にcurrentにしておけば問題ない
jenv add $HOME/.sdkman/candidates/java/current

# jenvで使うためのJavaバージョン名取得
# identifierから生成するのは困難であるため、java --versionを実行して取得
# AdoptOpenJDK以外はこのシェルコマンドで取得できるかは不明
version=$($HOME/.sdkman/candidates/java/current/bin/java --version | head -1 | cut -d' ' -f2)

jenv global $version

# $JENV_ROOT/shimsに配置されるコマンドを現在のversionにあわせて再編成するコマンド
# https://qiita.com/Neetless/items/160fcc126c17590b664a#shim%E3%81%A8%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3%E5%88%87%E3%82%8A%E6%9B%BF%E3%81%88%E3%81%AE%E4%BB%95%E7%B5%84%E3%81%BF
jenv rehash

exec $SHELL -l
