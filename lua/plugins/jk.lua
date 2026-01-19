-- Escape with jk, kj, JK, KJ in all modes except normal
return {
  "max397574/better-escape.nvim",
  lazy = false,
  opts = {
    timeout = 200,
    default_mappings = false,
    mappings = {
      i = {
        j = { k = "<Esc>" },
        k = { j = "<Esc>" },
        J = { K = "<Esc>" },
        K = { J = "<Esc>" },
      },
      v = {
        j = { k = "<Esc>" },
        k = { j = "<Esc>" },
      },
      c = {
        j = { k = "<C-c>" },
        k = { j = "<C-c>" },
      },
      t = {
        j = { k = "<Esc>" },
        k = { j = "<Esc>" },
      },
    },
  },
}
