-- pok.nvim — local checkout is the source of truth
return {
  "pok-lang/pok.nvim",
  dir = vim.fn.expand("~/Projects/pok.nvim"),
  lazy = false,
  config = function()
    require("pok").setup()
  end,
}
