#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(
  cd "$(dirname "$0")"
  pwd
)

read -rp "Do you expand the boilerplates at \"$(pwd)\"? [y/n]: "
if [[ "${REPLY}" != "y" ]]; then
  exit 0
fi

read -rp "What version do you use in this project(default: latest released version)? [x.y.z]: " input_version

curl -L https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore -o .gitignore
curl -L https://raw.githubusercontent.com/hoddy3190/anylang-build/main/project_build/python/templates/Makefile -o Makefile

"${SCRIPT_DIR}"/vscode.sh

"${SCRIPT_DIR}"/pyenv.sh "${input_version}"
# python -m venv .venv は、現在の python のバージョンで作られるため、
# pyenv で使いたいバージョンを先にインストールし、global に設定する必要がある
make venv
