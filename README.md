# anylang-build

anyenvを使って、言語をインストールする際の処理をまとめたリポジトリ。

# 事前準備

+ [anyenv](https://github.com/anyenv/anyenv)をインストールしておく
+ `*env install --list`をたたき、インストールしたいバージョンを見つけておく

# プロジェクトに言語環境を構築するやり方

+ Python
  - `./pyenv/build.sh` をたたく。このときpipenvも一緒にインストールされる。
  - Pythonプロジェクトを設定したいディレクトリに移動し、`pipenv --python x.y.z` をたたく。

# TODO

- [] template repository で作った方がいい？
- [] Dev Container を調査する