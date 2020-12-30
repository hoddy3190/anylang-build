#!/usr/bin/env bash -l

# sdkコマンドは実行可能ファイルではなく関数であり（try: type sdk）、これを使うためには、
# sdkmanセットアップ時に.bash_profileに記載されたコードを読み込む必要があるため
# bashに-lオプションが必要

# ディストリビューションごとのバージョンの検索コマンド: sdk list java
# 引数でバージョンを指定しない場合は最新安定版をインストールする
version=${1:-''}

# SDKMANで最新安定版のJavaをインストール
# 最新安定版の取得は、SDKMANの中で下のURLをたたいている
# https://api.sdkman.io/2/candidates/default/java
# いくつかあるOpenJDKディストリビューション中で、AdoptOpenJDKが選ばれているが、
# 他のディストリビューションを選択したい場合は、version指定しないとダメっぽい
if [[ -z "$version" ]]; then
    sdk i java
    version=$(java --version | head -1 | cut -d' ' -f2) # 雑にバージョン取得
else
    sdk i java "$version"
fi

# SDKMANでインストールされたバージョンは自動でデフォルト設定になるので、
# jenvにaddするJDKは常にcurrentにしておけば問題ない
jenv add $HOME/.sdkman/candidates/java/current

jenv global $version

# $JENV_ROOT/shimsに配置されるコマンドを現在のversionにあわせて再編成するコマンド
# https://qiita.com/Neetless/items/160fcc126c17590b664a#shim%E3%81%A8%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3%E5%88%87%E3%82%8A%E6%9B%BF%E3%81%88%E3%81%AE%E4%BB%95%E7%B5%84%E3%81%BF
jenv rehash
