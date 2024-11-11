# https://marketplace.visualstudio.com/items?itemName=ms-python.python
code --install-extension ms-python.python --force
# https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance
code --install-extension ms-python.vscode-pylance --force
# https://marketplace.visualstudio.com/items?itemName=ms-python.debugpy
code --install-extension ms-python.debugpy --force
# https://marketplace.visualstudio.com/items?itemName=charliermarsh.ruff
code --install-extension charliermarsh.ruff --force
# https://marketplace.visualstudio.com/items?itemName=ms-python.mypy-type-checker
code --install-extension ms-python.mypy-type-checker --force

mkdir -p .vscode
curl -L https://raw.githubusercontent.com/hoddy3190/anylang-build/main/project_build/python/templates/settings.json -o ./.vscode/settings.json