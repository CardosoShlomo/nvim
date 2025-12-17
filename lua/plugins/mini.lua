return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.ai').setup()
    require('mini.comment').setup()
    require('mini.pairs').setup()
    require('mini.surround').setup()
    require('mini.statusline').setup({
      use_icons = true,
      set_vim_settings = false,
    })
  end,
}
