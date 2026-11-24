-- 設定を再読み込みするとき、同じ自動コマンドが重複しないようにする。
local group = vim.api.nvim_create_augroup("HighlightYank", { clear = true })

-- yy などでヤンク（コピー）すると、対象の範囲を一瞬強調する。
vim.api.nvim_create_autocmd("TextYankPost", {
	group = group,
	desc = "Briefly highlight yanked text",
	callback = function()
		vim.hl.on_yank()
	end,
})
