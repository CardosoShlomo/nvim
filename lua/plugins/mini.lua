return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.ai').setup()
    require('mini.comment').setup()
    require('mini.pairs').setup()
    require('mini.statusline').setup({
      use_icons = true,
      content = {
        active = function()
          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
          local git = MiniStatusline.section_git({ trunc_width = 40 })
          local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
          local filename = MiniStatusline.section_filename({ trunc_width = 140 })
          local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
          local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

          return MiniStatusline.combine_groups({
            { hl = mode_hl, strings = { mode } },
            { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
            { hl = 'MiniStatuslineFilename', strings = { filename } },
            '%=',
            { hl = 'MiniStatuslineFileinfo', strings = { fileinfo, search } },
          })
        end,
      },
    })
  end,
}
