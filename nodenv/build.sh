#!/usr/bin/env bash -eu

# インストール可能なバージョンリストを更新
anyenv update nodenv

version=${1:-''}

# 特にバージョン指定がなければ推奨版をインストールする
if [[ -z "$version" ]]; then
    lts_version=$(
        curl -s https://nodejs.org/en/download/ |\
        grep 'Latest LTS Version:' |\
        perl -anle "print \$1 if (\$_ =~ /\<strong\>(.*)\<\/strong\>/)"
    )
    # スクレイピングに近いことをやってltsを取得しているので安定しないはず
    # 取得できなくなったらエラーで落として、コード修正を促す
    if [[ -z "$lts_version" ]]; then
        echo "cannot get lts version name, fix scraping codes"
        exit 1
    fi
    version=$lts_version

    # 最新版取得コマンド
    # latest_version=$(curl https://api.github.com/repos/nodejs/node/releases/latest | jq -r .tag_name | sed -e 's/v//')
fi

echo "$version will be installed."

# nodeのインストールと一緒にnpmもついてくる
nodenv install $version

# $NODENV_ROOT/versionというファイルが作成/更新される
nodenv global $version

# $NODENV_ROOT/shimsに配置されるコマンドを現在のversionにあわせて再編成するコマンド
# https://qiita.com/Neetless/items/160fcc126c17590b664a#shim%E3%81%A8%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3%E5%88%87%E3%82%8A%E6%9B%BF%E3%81%88%E3%81%AE%E4%BB%95%E7%B5%84%E3%81%BF
# ls $HOME/.anyenv/envs/nodenv/shims
# browserify  <-- 12.18.1
# node        <-- 12.18.1
# npm         <-- 12.18.1
# npx         <-- 12.18.1
# textlint    <-- 12.14.1
# 12.18.1でrehashしても12.14.1でインストールしたtextlintは残る
# nodeやnpmは12.14.1でもあるがrehashすることにより12.18.1のものに差し替わる
nodenv rehash

# 初めてnodenvでnodeをインストールした後、npm i -gしたパッケージへのパスが通っていなかった
exec $SHELL -l
