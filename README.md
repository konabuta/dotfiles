# dotfiles

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
