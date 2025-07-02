#!/bin/bash

set -euo pipefail

read -p "Is the project directory here: \"$(pwd)\"? [y/n]: "
if [[ "${REPLY}" != "y" ]]; then
  exit 0
fi

if ! which rustup > /dev/null 2>&1; then
  # https://www.rust-lang.org/learn/get-started
  # This command installs the following tools:
  #   - rustup (the Rust installer and version management tool)
  #   - cargo (the Rust build tool and package manager)
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

# https://rust-lang.github.io/rustup/basics.html#keeping-rustup-up-to-date
# Although rustup updates itself automatically if we installed it without --no-default-features option.
# we updates rustup manually just in case.
rustup update # include rustup self update

cargo init
# `cargo init` generates .gitignore file but its content is not enough.
# So, we use github/Rust.gitignore to generate .gitignore file.
curl -L https://raw.githubusercontent.com/github/gitignore/master/Rust.gitignore -o .gitignore

stable_version=$(rustc --version | awk '{print $2}')
echo "stable_version: $stable_version"

cat << EOF > rust-toolchain.toml
[toolchain]
channel = "$stable_version"
EOF
