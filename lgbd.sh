#!/bin/sh

set -euo pipefail

lang="$1"
ver=${2:-''}

SCRIPT_DIR=$(cd $(dirname "$0"); pwd)

# brewで使うとき、シムリンクから呼ばれるので、そこをふまえてBASE_DIRを取得する
set +e # symlinkでなかったときにエラーになるので+eしておく
SYM=$(readlink "$0")
set -e

BASE_DIR="${SCRIPT_DIR}/${SYM}"

case "$lang" in
    "go"   ) "$BASE_DIR"/envs/"$lang"env/build.sh "$ver" ;;
    "j"    ) "$BASE_DIR"/envs/"$lang"env/build.sh "$ver" ;;
    "node" ) "$BASE_DIR"/envs/"$lang"nv/build.sh "$ver" ;;
    "py"   ) "$BASE_DIR"/envs/"$lang"env/build.sh "$ver" ;;
    "rb"   ) "$BASE_DIR"/envs/"$lang"env/build.sh "$ver" ;;
    *      ) echo "$lang は対応していない言語です"; exit 1 ;;
esac
