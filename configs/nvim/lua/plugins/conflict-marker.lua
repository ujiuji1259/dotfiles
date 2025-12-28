return {
    'tronikelis/conflict-marker.nvim',
    opts = {
        highlights = true,
        on_attach = function(conflict)
            local MID = "^=======$"

            vim.keymap.set("n", "[x", function()
              vim.cmd("?" .. MID)
            end, { buffer = conflict.bufnr })

            vim.keymap.set("n", "]x", function()
              vim.cmd("/" .. MID)
            end, { buffer = conflict.bufnr })

            local map = function(key, fn)
              vim.keymap.set("n", key, fn, { buffer = conflict.bufnr })
            end

            map("co", function()
              conflict:choose_ours()
            end)
            map("ct", function()
              conflict:choose_theirs()
            end)
            map("cb", function()
              conflict:choose_both()
            end)
            map("cn", function()
              conflict:choose_none()
            end)
        end,
    },
}
