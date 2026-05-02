return {
  'rcarriga/nvim-notify',
  config = function()
    vim.keymap.set('n', '<leader>dn', function()
      require('notify').dismiss { silent = true }
    end, { desc = 'Dismiss notifications' })
  end,
}
