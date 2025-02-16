# https://marketplace.visualstudio.com/items?itemName=rust-lang.rust-analyzer
code --install-extension rust-lang.rust-analyzer

mkdir -p .vscode
curl -L https://raw.githubusercontent.com/hoddy3190/anylang-build/main/project_build/rust/templates/settings.json -o ./.vscode/settings.json
