vim.g.mapleader = " "
vim.keymap.set("n", "<C-h>", "<cmd>bprev<CR>")
vim.keymap.set("n", "<C-l>", "<cmd>bnext<CR>")
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
