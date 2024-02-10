#!/bin/sh

set -euo pipefail

read -p "このコンピュータでpyenv/build.shをしましたか？[y/n]: " has_build
if [[ "${has_build}" != "y" ]]; then
  exit 1
fi

set +e
# .pkg or .tar.xz or .exe があるのでmacosxで絞る
latest_version=$(
    curl -s https://www.python.org/downloads/macos/ |\
    grep -e 'Latest Python 3 Release' |\
    perl -anle "print \$1 if (\$_ =~ /Latest Python 3 Release \- Python (.*)\<\/a\>/)"
)
set -e

read -p "このプロジェクトで使用するPythonのバージョンはなんですか(default: ${latest_version})？ [x.y.z]: " input_version
version=${input_version:-"${latest_version}"}

set +x
pipenv --python "${version}"
set -x
