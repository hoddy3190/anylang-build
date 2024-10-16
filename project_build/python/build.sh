#!/bin/sh

set -euo pipefail

if ! which pyenv > /dev/null 2>&1; then
  echo "[ERROR] Please install pyenv"
  exit 1
fi

read -p "Do you expand the boilerplates at \"$(pwd)\"? [y/n]: "
if [[ "${REPLY}" != "y" ]]; then
  exit 0
fi

curl -L https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore -o .gitignore

cur_version=$(pyenv version-name)
read -p "What version do you use in this project (default: ${cur_version})? [x.y.z]: " input_version
version=${input_version:-"${cur_version}"}

set +x
pipenv --python "${version}"
set -x

# flake8: linterの詰め合わせ https://zenn.dev/yamaden/articles/23d3805fc85d99#flake8
# autopep8: formatter
pipenv install --dev autopep8 flake8
