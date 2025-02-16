#!/bin/bash

set -euo pipefail

if ! which npm > /dev/null 2>&1; then
  echo "[ERROR] Please install npm"
  exit 1
fi

read -p "Do you expand the boilerplates at \"$(pwd)\"? [y/n]: "
if [[ "${REPLY}" != "y" ]]; then
  exit 0
fi

read -p "Do you run your codes on Node.js? [y = Node.js/n = Browser]: " is_node

curl -L https://raw.githubusercontent.com/github/gitignore/master/Node.gitignore -o .gitignore

BOILERPLATE_URL="https://raw.githubusercontent.com/hoddy3190/anylang-build/refs/heads/main/project_build/typescript/templates"
curl -sSO ${BOILERPLATE_URL}/package.json
curl -sSO ${BOILERPLATE_URL}/tsconfig.json
curl -sSO ${BOILERPLATE_URL}/eslint.config.js


# https://www.typescriptlang.org/download/
npm i -D typescript

# https://eslint.org/docs/latest/use/getting-started#manual-set-up
npm i -D eslint @eslint/js

# https://typescript-eslint.io/packages/typescript-eslint
npm i -D typescript-eslint

# https://prettier.io/docs/en/install.html
npm i -D --save-exact prettier
node --eval "fs.writeFileSync('.prettierrc','{}\n')"

# https://github.com/prettier/eslint-config-prettier#installation
npm i -D eslint-config-prettier

if [[ "${is_node}" = "y" ]]; then
  npm i -D @types/node tsx
else
  sed -i '' 's!"module": "NodeNext",!"module": "ESNext",  !ig' tsconfig.json
  sed -i '' 's!"moduleResolution": "NodeNext",!"moduleResolution": "Bundler", !ig' tsconfig.json
fi
