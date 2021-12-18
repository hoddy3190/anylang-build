#!/bin/sh

set -euo pipefail

lang="$1"
ver=${2:-''}

SCRIPT_DIR=$(cd $(dirname "$0"); pwd)

case "$lang" in
    "go"   ) "$SCRIPT_DIR"/"$lang"env/build.sh "$ver" ;;
    "j"    ) "$SCRIPT_DIR"/"$lang"env/build.sh "$ver" ;;
    "node" ) "$SCRIPT_DIR"/"$lang"nv/build.sh "$ver" ;;
    "py"   ) "$SCRIPT_DIR"/"$lang"env/build.sh "$ver" ;;
    "rb"   ) "$SCRIPT_DIR"/"$lang"env/build.sh "$ver" ;;
    *      ) echo "$lang は対応していない言語です"; exit 1 ;;
esac
