# anylang-build

*envを使って、言語をインストールする際の処理をまとめたリポジトリ。

# 事前準備

+ [dotfiles](https://github.com/hoddy3190/dotfiles)のREADMEに従い環境構築
+ ` anyenv update [env名] ` をたたき、*envを最新にする。[env名]を指定した場合は指定したenvのみが最新化される。[env名]を指定しなかった場合はanyenvでインストールしたすべてのenvが最新化される。
+ ` *env install --list ` をたたき、インストールしたいバージョンを見つける
  - TODO: 自動で安定版を見つける
