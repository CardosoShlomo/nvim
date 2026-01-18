-- Show available keybindings as you type
return {
  "folke/which-key.nvim",
  lazy = false,
  config = function()
    local wk = require("which-key")
    wk.setup({
      delay = 300,
      icons = {
        mappings = false,
      },
    })
    wk.add({
      { "<leader>x", group = "trouble" },
      { "<leader>g", group = "git" },
      { "<leader>c", group = "code" },
      { "s", group = "search" },
    })
  end,
}
