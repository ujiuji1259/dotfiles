-- 基本オプションの設定
require('options')
require('keymaps')

require("config.lazy")

-- setup must be called before loading
vim.cmd("colorscheme nightfox")

-- setup accelerated-jk
vim.api.nvim_set_keymap('n', 'j', '<Plug>(accelerated_jk_gj)', {})
vim.api.nvim_set_keymap('n', 'k', '<Plug>(accelerated_jk_gk)', {})

