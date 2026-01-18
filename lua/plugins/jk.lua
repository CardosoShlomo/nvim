-- Escape insert mode with jk, kj, JK, KJ
return {
  "max397574/better-escape.nvim",
  event = "InsertEnter",
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
    },
  },
};
