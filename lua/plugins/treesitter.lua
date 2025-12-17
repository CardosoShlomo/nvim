return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true,
      ensure_installed = {
        "lua", "javascript", "typescript", "tsx", "json",
        "yaml", "html", "css", "dart", "go", "rust",
        "dockerfile", "terraform", "markdown", "markdown_inline",
        "bash", "regex", "kotlin",
      },
    })
  end,
};
