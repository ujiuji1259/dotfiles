return {
    'lambdalisue/vim-gin',
    dependencies = {
        'vim-denops/denops.vim',
        { 'nvim-telescope/telescope.nvim', tag = 'v0.2.0', dependencies = { 'nvim-lua/plenary.nvim' } },
    },
    keys = {
        { '<C-g>s', '<Cmd>GinStatus<Cr>', desc = 'Git Status (Gin)' },
        { '<C-g>l', '<Cmd>GinLog --graph --oneline<Cr>', desc = 'Git Log (Gin)' },
        { '<C-g>b', '<Cmd>GinBranch<Cr>', desc = 'Git Log (Gin)' },
    },
    config = function()
        vim.api.nvim_create_autocmd(
          'FileType',
          {
              pattern = { 'gin-diff', 'gin-log', 'gin-status', 'gin-branch' },
              callback = function()
                local keymap = vim.keymap.set
                local opts = { buffer = true, noremap = true }
                keymap({ 'n' }, 'c', '<Cmd>Gin commit<Cr>', opts)
                keymap({ 'n' }, 'S', '<Cmd>GinStatus<Cr>', opts)
                keymap({ 'n' }, 'L', '<Cmd>GinLog --graph --oneline<Cr>', opts)
                keymap({ 'n' }, 'B', '<Cmd>GinBranch<Cr>', opts)
                keymap({ 'n' }, 'd', '<Cmd>GinDiff --cached<Cr>', opts)
                keymap({ 'n' }, 'q', '<Cmd>bdelete<Cr>', opts)
                keymap({ 'n' }, 'P', [[<Cmd>lua vim.notify("Gin push")<Cr><Cmd>GinPush<Cr>]], opts)
                keymap({ 'n' }, 'p', [[<Cmd>lua vim.notify("Gin pull")<Cr><Cmd>GinPull<Cr>]], opts)
              end,
          }
        )

        vim.api.nvim_create_autocmd(
            'FileType',
            {
                pattern = 'gin-status',
                callback = function()
                    local keymap = vim.keymap.set
                    local opts = { buffer = true, noremap = true }
                    keymap({ 'n' }, 'h', '<Plug>(gin-action-stage)', opts)
                    keymap({ 'n' }, 'l', '<Plug>(gin-action-unstage)', opts)
                end,
            }
        )

        vim.api.nvim_create_autocmd(
            'FileType',
            {
                pattern = 'gin-log',
                callback = function()
                    local keymap = vim.keymap.set
                    local opts = { buffer = true, noremap = true }
                    keymap({ 'n' }, 'if', '<Plug>(gin-action-fixup:instant-fixup)', opts)
                    keymap({ 'n' }, 'ir', '<Plug>(gin-action-unstage)', opts)
                end,
            }
        )

        vim.api.nvim_create_autocmd(
            'FileType',
            {
                pattern = 'gin-branch',
                callback = function()
                    local keymap = vim.keymap.set
                    local opts = { buffer = true, noremap = true }
                    keymap({ 'n' }, 'n', '<Plug>(gin-action-new)', opts)
                    keymap({ 'n' }, 'd', '<Plug>(gin-action-delete)', opts)
                end,
            }
        )

        vim.api.nvim_create_autocmd("BufReadCmd", {
          group = vim.api.nvim_create_augroup("gin-custom", {}),
          pattern = "ginlog://*" ,
          callback = function(ctx)
            vim.keymap.set("n", "a", function()
              require("telescope.builtin").keymaps({ default_text = "gin-action " })
            end, { buffer = ctx.buf })
          end,
        })
    end,
}
