# dotfiles

## 管理している設定ファイル

chezmoi がリポジトリ内のファイルをホームディレクトリに配置します。変更するときは、表の「リポジトリ内」を開きます。

| 用途 | リポジトリ内 | 配置先 | 内容 |
| --- | --- | --- | --- |
| Neovim | [`dot_config/nvim/`](dot_config/nvim/) | `~/.config/nvim/` | エディターの基本設定、キーマップ、自動コマンド、プラグイン設定。 |
| Fish | [`dot_config/private_fish/config.fish`](dot_config/private_fish/config.fish) | `~/.config/fish/config.fish` | シェル起動時に読み込むテーマ、エイリアス、開発ツールのパス。 |
| Fish（macOS） | [`dot_config/private_fish/config-mac.fish`](dot_config/private_fish/config-mac.fish) | `~/.config/fish/config-mac.fish` | Homebrew の環境設定や、`eza`・`bat`・`fzf` の設定。 |
| Fisher | [`dot_config/private_fish/fish_plugins`](dot_config/private_fish/fish_plugins) | `~/.config/fish/fish_plugins` | Fisher で管理する Fish プラグインの一覧。 |
| Homebrew | [`dot_config/Brewfile`](dot_config/Brewfile) | `~/.config/Brewfile` | macOS で使うコマンド、アプリ、フォントの一覧。 |
| Herdr | [`dot_config/herdr/config.toml`](dot_config/herdr/config.toml) | `~/.config/herdr/config.toml` | テーマ、端末表示、サイドバー、ペインやワークスペースの操作キー。 |
| Karabiner-Elements | [`dot_config/private_karabiner/private_karabiner.json`](dot_config/private_karabiner/private_karabiner.json) | `~/.config/karabiner/karabiner.json` | キーボード入力の割り当てを変えるルール。 |

### Neovim の設定を探す

| リポジトリ内の場所 | 内容 |
| --- | --- |
| [`init.lua`](dot_config/nvim/init.lua) | 起動時の入口。共通ヘルパー、基本設定、プラグインの順に読み込みます。 |
| [`lua/config/options.lua`](dot_config/nvim/lua/config/options.lua) | 表示、検索、Undo、折りたたみ、メッセージ表示などの設定。 |
| [`lua/config/keymaps.lua`](dot_config/nvim/lua/config/keymaps.lua) | 編集、タブ切り替え、ウィンドウ分割などのキーマップ。 |
| [`lua/config/autocmds.lua`](dot_config/nvim/lua/config/autocmds.lua) | ヤンク時の強調と、操作中のウィンドウのカーソル行表示。 |
| [`lua/config/commands.lua`](dot_config/nvim/lua/config/commands.lua)・[`workarounds.lua`](dot_config/nvim/lua/config/workarounds.lua) | ユーザー定義コマンドや Neovim の回避設定を追加する場所。 |
| [`lua/plugins/`](dot_config/nvim/lua/plugins/) | `init.lua` でプラグインを登録し、`ui.lua` でコマンド入力欄を設定します。プラグイン用のキーは `keymaps.lua` に追加します。 |
| [`lua/utils/init.lua`](dot_config/nvim/lua/utils/init.lua) | 共通ヘルパーを公開する場所。 |
| [`dot_gitignore`](dot_config/nvim/dot_gitignore) | 配置先では `.gitignore` になります。Neovim のプラグインロックファイルをローカルの Git 管理から除外します。 |

## CI のしくみ

GitHub Actions の **Dotfiles CI** は、`main` 向けの PR を作成・再オープンしたとき、PR のブランチにコミットが追加されたとき、`main` に push されたときに実行されます。**Validate dotfiles** ジョブが Ubuntu 24.04 上で以下の手順を順に実行します。[ワークフローの定義](.github/workflows/ci.yml)

| ステップ | 確認すること |
| --- | --- |
| `actions/checkout` | 検証対象のコードをランナーに取得します。リポジトリへの権限は読み取りのみで、認証情報はチェックアウト後の Git 設定に残しません。 |
| **Install check tools** | Fish をパッケージマネージャーから導入し、Neovim 0.12.6 と StyLua 2.6.0 を公式リリースから取得します。2つのバージョンはワークフローの `NEOVIM_VERSION` と `STYLUA_VERSION` で指定しています。 |
| **Check formatting and syntax** | StyLua で Neovim の Lua ファイルの整形を確認します。Fish の2ファイルと Brewfile は構文だけをチェックし、Karabiner の JSON と Herdr の TOML は Python で読み込めることを確認します。 |
| **Start Neovim with a fresh profile** | `dot_config/nvim` を一時ディレクトリにコピーし、設定・データ・状態・キャッシュの場所をすべてその下に切り替えてヘッドレスで起動します。初回の `vim.pack` によるプラグイン導入を通り、起動エラーが出た場合や、設定ファイルで定義した `ss` キーマップが見つからない場合は、ジョブが失敗します。 |

Ubuntu 上で行うため、macOS アプリでの設定の動作、Brewfile のパッケージ導入、端末上の見た目は対象外です。

### 失敗したとき

PR の **Checks** タブで **Validate dotfiles** を開き、最初に失敗したステップのログを読みます。

- **Install check tools** で止まったら、Fish のインストールか、Neovim・StyLua のリリース取得のどちらで失敗したかを確認します。
- **Check formatting and syntax** で止まったら、ログに出たファイルと行番号を確認します。Lua の整形は `stylua --check dot_config/nvim` で手元でも再現できます。
- **Start Neovim with a fresh profile** で止まったら、プラグインの導入ログと Neovim の起動エラーを確認します。エラーが見当たらなければ、`lua/config/keymaps.lua` が読み込まれ、`ss` が登録されるかを確認します。
