-- Lua モジュールの読み込みを高速化する。
if vim.loader then
	vim.loader.enable()
end

-- 共通のヘルパーを Config として参照できるようにする。
_G.Config = require("utils")

-- 表示・検索などの設定を読み込む。Leader キーもここで設定する。
require("config.options")
-- Leader キーの設定後にショートカットを登録する。
require("config.keymaps")
-- ヤンクなどのイベントで自動実行する処理を登録する。
require("config.autocmds")
require("config.commands")
require("config.workarounds")

-- プラグインの設定は基本設定の読み込み後に行う。
require("plugins")
