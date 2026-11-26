-- <Leader> は Space。ショートカットでは Space を先に押す。
vim.g.mapleader = " "
-- ファイルタイプ固有のマッピングで使う <LocalLeader> も Space にする。
vim.g.maplocalleader = " "

local opt = vim.opt

-- マウス操作を無効にし、キーボードで操作する。
opt.mouse = ""
-- ヤンクや貼り付けでシステムのクリップボードを使う。
opt.clipboard = "unnamedplus"
-- foo-bar のような名前を単語移動や単語選択で1語として扱う。
opt.iskeyword:append("-")

-- 現在行に実際の行番号を表示する。
opt.number = true
-- ほかの行に現在行からの距離を表示する。5j で5行下へ移動できる。
opt.relativenumber = true
-- カーソルのある行を強調する。
opt.cursorline = true
-- 長い行は折り返さず、横にスクロールして表示する。
opt.wrap = false
-- スクロール時、可能な範囲でカーソルの上下に10行ずつ残す。
opt.scrolloff = 10
-- 横スクロール時、可能な範囲でカーソルの左右に8桁ずつ残す。
opt.sidescrolloff = 8
-- 診断などのマーク用の列を常に確保し、テキストの横ずれを防ぐ。
opt.signcolumn = "yes"
-- コマンドラインの常設行を省き、ステータスラインを画面全体で1本にする。
opt.cmdheight = 0
opt.laststatus = 3
-- フローティングウィンドウの既定の枠を角丸にする。
opt.winborder = "rounded"
-- ポップアップメニューを最大10行にし、少し透過させる。
opt.pumheight = 10
opt.pumblend = 10
-- 閉じ括弧を入力したとき、対応する開き括弧を一瞬表示する。
opt.showmatch = true
-- 対応する括弧の表示時間を0.2秒にする。
opt.matchtime = 2
-- 端末のタイトルに編集中のファイル名を表示する。
opt.title = true
-- diff で対応する行がない箇所を斜線で埋める。
opt.fillchars:append({ diff = "/" })

-- 検索時に大文字と小文字を同一視する。
opt.ignorecase = true
-- 検索語に大文字が含まれる場合は、大文字と小文字を区別する。
opt.smartcase = true
-- :find でサブディレクトリも再帰的に探す。
opt.path:append("**")
-- コマンドライン補完で、まず共通部分を補い、続けて候補を切り替える。
opt.wildmode = "longest:full,full"
-- 補完候補から依存パッケージやビルド生成物を除く。
opt.wildignore:append({ "*/node_modules/*", "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })

-- ファイル内のタブ文字を2桁幅で表示する。
opt.tabstop = 2
-- 自動インデントや >> で字下げするときの幅を2桁にする。
opt.shiftwidth = 2
-- 挿入モードで Tab や Backspace を押したときの字下げ幅を2桁にする。
opt.softtabstop = 2
-- 挿入モードで Tab を押したとき、タブ文字の代わりにスペースを入れる。
opt.expandtab = true
-- 改行時に、波括弧などをもとに字下げを調整する。
opt.smartindent = true

-- スワップファイルと上書き前の一時バックアップを作らない。
opt.swapfile = false
opt.writebackup = false
-- 保存時に undo 履歴を記録し、ファイルを開き直しても u で戻せるようにする。
opt.undofile = true
opt.undodir = vim.fn.expand("~/.cache/nvim/undodir")
-- 操作が止まってから CursorHold が発生するまでの時間を300ミリ秒にする。
opt.updatetime = 300
-- キーマップの続きは500ミリ秒待ち、端末のキーコードの続きは待たない。
opt.timeoutlen = 500
opt.ttimeoutlen = 0

-- 上下に分割したとき、新しいウィンドウを下に開く。
opt.splitbelow = true
-- 左右に分割したとき、新しいウィンドウを右に開く。
opt.splitright = true

-- Tree-sitter が解析した構文に沿って折りたたみ範囲を決める。
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- ファイルを開いたときは折りたたみを開いておき、必要な箇所だけ zc で閉じる。
opt.foldlevel = 99

-- 短い通知は画面右下に表示し、長い出力はスクロールできるペインに送る。
require("vim._core.ui2").enable({
	msg = {
		target = "msg",
		targets = {
			-- 入力したコマンドの出力は種類に関係なく、次のキー入力まで下部に表示する。
			typed_cmd = "cmd",
			emsg = "pager",
			echoerr = "pager",
			lua_error = "pager",
			rpc_error = "pager",
			list_cmd = "pager",
			verbose = "pager",
			shell_cmd = "pager",
			shell_err = "pager",
			shell_out = "pager",
			shell_ret = "pager",
			progress = "pager",
			search_cmd = "cmd",
			search_count = "cmd",
			completion = "cmd",
			wildlist = "cmd",
			confirm = "cmd",
		},
		cmd = { height = 0.5 },
		msg = { height = 0.3, timeout = 5000 },
		pager = { height = 0.5 },
	},
})
