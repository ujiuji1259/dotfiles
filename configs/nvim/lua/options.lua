local opt = vim.opt

-- 行番号の表示
opt.number = true

-- タブとインデントの設定
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- 検索設定
opt.ignorecase = true
opt.smartcase = true

-- クリップボードの設定
opt.clipboard = "unnamedplus"

-- clear statusline
opt.laststatus = 0
opt.statusline = "─"
opt.fillchars:append({ stl = "─", stlnc = "─" })
--
-- hide cmdline
vim.opt.cmdheight = 0

