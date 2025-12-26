---@type LazyPluginSpec
return {
    "neovim/nvim-lspconfig",
    -- Bufferが読み込まれるときをトリガーに遅延ロードする
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        -- pylsp configuration with all linting disabled
        vim.lsp.config.pylsp = {
            cmd = { "pylsp" },
            filetypes = { "python" },
            settings = {
                pylsp = {
                    plugins = {
                        -- Disable all linting plugins
                        flake8 = { enabled = false },
                        pycodestyle = { enabled = false },
                        pydocstyle = { enabled = false },
                        pylint = { enabled = false },
                        mccabe = { enabled = false },
                        pyflakes = { enabled = false },
                    }
                }
            }
        }
    end,
}
