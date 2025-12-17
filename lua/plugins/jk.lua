-- Escape insert mode with jk
return {
  "max397574/better-escape.nvim",
  event = "InsertEnter",
  opts = {
    mapping = { "jk" },
    timeout = 200,
    clear_empty_lines = false,
    keys = "<Esc>",
  },
};
