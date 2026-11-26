-- 「:」の入力欄を横中央、画面の上から20%の位置に表示する。
require("tiny-cmdline").setup({
	position = { x = "50%", y = "20%" },
	native_types = { "/", "?", "@", "=", ">", "-" },
})
