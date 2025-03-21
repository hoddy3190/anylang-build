#!/bin/bash

set -euo pipefail

mkdir -p .vscode
# settings.json
curl -L https://raw.githubusercontent.com/hoddy3190/anylang-build/main/project_build/python/templates/settings.json -o ./.vscode/settings.json

# extensions.json
EXTENSIONS_FILE=./.vscode/extensions.json
curl -L https://raw.githubusercontent.com/hoddy3190/anylang-build/main/project_build/python/templates/extensions.json -o "$EXTENSIONS_FILE"
for ext in $(jq -r '.recommendations[]' "$EXTENSIONS_FILE"); do
    code --install-extension "$ext" --force
done