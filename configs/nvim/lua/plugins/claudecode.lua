return {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
        { "<leader>a", nil, desc = "AI/Claude Code" },
        { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
        { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
        { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
        { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
        { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
        { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
        { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
        {
            "<leader>as",
            "<cmd>ClaudeCodeTreeAdd<cr>",
            desc = "Add file",
            ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
        },
        -- Diff management
        { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
        { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
    opts = {
        -- ... other options
        condition = function(buf)
            local fn = vim.fn
            local utils = require("auto-save.utils.data")

            -- First check the default conditions
            if not (fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {})) then
                return false
            end

            -- Exclude claudecode diff buffers by buffer name patterns
            local bufname = vim.api.nvim_buf_get_name(buf)
            if
                bufname:match("%(proposed%)")
                or bufname:match("%(NEW FILE %- proposed%)")
                or bufname:match("%(New%)")
            then
                return false
            end

            -- Exclude by buffer variables (claudecode sets these)
            if
                vim.b[buf].claudecode_diff_tab_name
                or vim.b[buf].claudecode_diff_new_win
                or vim.b[buf].claudecode_diff_target_win
            then
                return false
            end

            -- Exclude by buffer type (claudecode diff buffers use "acwrite")
            local buftype = fn.getbufvar(buf, "&buftype")
            if buftype == "acwrite" then
                return false
            end

            return true -- Safe to auto-save
        end,
    },
}
