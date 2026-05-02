return {
    "ingur/floatty.nvim",
    config = function()
        -- initialize config
        local term = require("floatty").setup({})

        -- set toggle keybinds (supports v:count by default!)
        vim.keymap.set("n", "<C-t>", function()
            term.toggle()
        end)
        vim.keymap.set("t", "<C-t>", function()
            term.toggle()
        end)
    end,
}
