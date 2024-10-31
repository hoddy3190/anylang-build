#!/bin/sh

set -euo pipefail

SCRIPT_DIR=$(cd $(dirname "$0"); pwd)

read -p "Do you expand the boilerplates at \"$(pwd)\"? [y/n]: "
if [[ "${REPLY}" != "y" ]]; then
  exit 0
fi

read -p "What version do you use in this project(default: latest released version)? [x.y.z]: " input_version

if ! which pyenv > /dev/null 2>&1; then
  echo "install pyenv and pipenv"
  ${SCRIPT_DIR}/pyenv.sh
fi

cur_version=$(pyenv version-name)
version=${input_version:-"${cur_version}"}

curl -L https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore -o .gitignore

set +x
pipenv --python "${version}"
set -x

# flake8: linterの詰め合わせ https://zenn.dev/yamaden/articles/23d3805fc85d99#flake8
# autopep8: formatter
pipenv install --dev autopep8 flake8
