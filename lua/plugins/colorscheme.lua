-- Colorscheme
-- return {
--   "rebelot/kanagawa.nvim",
--   priority = 1000,
--   config = function()
--     vim.cmd.colorscheme("kanagawa")
--   end,
-- }
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("catppuccin-mocha")
  end,
}
