-- プラグインは vim.pack.add でまとめて登録し、その後グループごとに設定する。
vim.pack.add({
	"https://github.com/rachartier/tiny-cmdline.nvim",
})

require("plugins.ui")
-- プラグイン用のキーマップは各グループの設定後に読み込む。
require("plugins.keymaps")
