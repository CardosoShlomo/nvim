-- Essential: Git integration (MUST-HAVE)
return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup()
  end,
};
