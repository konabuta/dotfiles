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

-- カーソル行の強調は、現在操作しているウィンドウだけに表示する。
local cursorline_group = vim.api.nvim_create_augroup("ActiveWindowCursorline", { clear = true })

local function update_cursorline()
	local active_win = vim.api.nvim_get_current_win()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		vim.wo[win].cursorline = win == active_win
	end
end

vim.api.nvim_create_autocmd("WinEnter", {
	group = cursorline_group,
	desc = "Show cursorline only in the active window",
	callback = update_cursorline,
})

vim.api.nvim_create_autocmd("WinNew", {
	group = cursorline_group,
	desc = "Update cursorline after creating a window",
	callback = function()
		-- フォーカスを移さず開く場合も、作成中だけ新しいウィンドウが現在のウィンドウになる。
		vim.schedule(update_cursorline)
	end,
})

update_cursorline()
