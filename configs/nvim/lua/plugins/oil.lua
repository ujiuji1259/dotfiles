return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  keys = {
    -- Top Pickers & Explorer
    { "<leader>o", function() require("oil").open() end, desc = "Oil File Explorer" },
  },
  config = function ()
    require("oil").setup({
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
      },
    })
  end,
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
