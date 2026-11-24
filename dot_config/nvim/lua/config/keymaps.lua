local map = vim.keymap.set

-- ノーマルモードで Space → s → s は上下分割。
map("n", "<leader>ss", "<cmd>split<cr>", { desc = "Split horizontally" })
-- Space → s → v は左右分割。
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split vertically" })
-- 分割間の移動は Space → h（左）、j（下）、k（上）、l（右）。
map("n", "<leader>h", "<C-w>h", { desc = "Focus left window" })
map("n", "<leader>j", "<C-w>j", { desc = "Focus lower window" })
map("n", "<leader>k", "<C-w>k", { desc = "Focus upper window" })
map("n", "<leader>l", "<C-w>l", { desc = "Focus right window" })
