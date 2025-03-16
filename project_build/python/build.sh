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

latest_commit_hash=$(curl -sL "https://api.github.com/repos/github/gitignore/commits/main" | jq -r '.sha')
cat <<EOF > .gitignore
### Python ###
# https://raw.githubusercontent.com/github/gitignore/${latest_commit_hash}/Python.gitignore

EOF
curl -sL https://raw.githubusercontent.com/github/gitignore/${latest_commit_hash}/Python.gitignore >> .gitignore

curl -sL https://raw.githubusercontent.com/hoddy3190/anylang-build/main/project_build/python/templates/Makefile -o Makefile

"${SCRIPT_DIR}"/vscode.sh

"${SCRIPT_DIR}"/pyenv.sh "${input_version}"
# python -m venv .venv は、現在の python のバージョンで作られるため、
# pyenv で使いたいバージョンを先にインストールし、global に設定する必要がある
make venv
