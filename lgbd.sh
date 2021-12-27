#!/bin/sh

set -euo pipefail

lang="$1"
ver=${2:-''}

# brewで使うとき、シムリンクから呼ばれるので、リンク先のディレクトリを取得する
# $0がシムリンクでないときはそのdirnameがSCRIPT_DIRに入る
SCRIPT_DIR=$(dirname $(perl -MCwd -e 'print Cwd::abs_path shift' "$0"))

case "$lang" in
    "go"   ) "$SCRIPT_DIR"/envs/"$lang"env/build.sh "$ver" ;;
    "j"    ) "$SCRIPT_DIR"/envs/"$lang"env/build.sh "$ver" ;;
    "node" ) "$SCRIPT_DIR"/envs/"$lang"nv/build.sh "$ver" ;;
    "py"   ) "$SCRIPT_DIR"/envs/"$lang"env/build.sh "$ver" ;;
    "rb"   ) "$SCRIPT_DIR"/envs/"$lang"env/build.sh "$ver" ;;
    *      ) echo "$lang は対応していない言語です"; exit 1 ;;
esac
