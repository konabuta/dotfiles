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

-- 削除・変更で直前のヤンクを上書きしない。ビジュアル貼り付けは P で選択範囲を置き換える。
map({ "n", "x" }, "x", '"_x', { desc = "Delete without yanking" })
map({ "n", "x" }, "<leader>d", '"_d', { desc = "Delete without yanking" })
map({ "n", "x" }, "<leader>c", '"_c', { desc = "Change without yanking" })
map("n", "<leader>p", "p", { desc = "Paste without changing the yank register" })
map("x", "<leader>p", "P", { desc = "Replace selection without changing the yank register" })
map("n", "dw", '"_db', { desc = "Delete backward by one word without yanking" })

-- 数値の操作と、バッファ全体の選択。
map({ "n", "x" }, "+", "<C-a>", { desc = "Increment number" })
map({ "n", "x" }, "-", "<C-x>", { desc = "Decrement number" })
map("n", "<C-a>", "ggVG", { desc = "Select entire buffer" })

-- ノーマルモードでタブを開く、または切り替える。
map("n", "te", "<Cmd>tabnew<CR>", { desc = "Open a new tab" })
map("n", "<Tab>", "<Cmd>tabnext<CR>", { desc = "Go to next tab" })
map("n", "<S-Tab>", "<Cmd>tabprevious<CR>", { desc = "Go to previous tab" })

-- Space なしでも分割やウィンドウ間の移動ができる。
map("n", "ss", "<Cmd>split<CR>", { desc = "Split horizontally" })
map("n", "sv", "<Cmd>vsplit<CR>", { desc = "Split vertically" })
map("n", "sh", "<C-w>h", { desc = "Focus left window" })
map("n", "sj", "<C-w>j", { desc = "Focus lower window" })
map("n", "sk", "<C-w>k", { desc = "Focus upper window" })
map("n", "sl", "<C-w>l", { desc = "Focus right window" })

map("n", "<C-m>", "<C-i>", { desc = "Jump forward in the jump list" })

-- o/O で開いた行から、自動挿入されたコメントの続きを消して入力する。
map("n", "<leader>o", 'o<Esc>^"_Da', { desc = "Open line below without continuing comment" })
map("n", "<leader>O", 'O<Esc>^"_Da', { desc = "Open line above without continuing comment" })
