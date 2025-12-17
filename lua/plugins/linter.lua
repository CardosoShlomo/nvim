return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      terraform = { "tflint" },
      dockerfile = { "hadolint" },
      go = { "golangci-lint" },
      rust = { "clippy" },
      json = { "jsonlint" },
      yaml = { "yamllint" },
      html = { "htmlhint" },
      css = { "stylelint" },
      scss = { "stylelint" },
      markdown = { "markdownlint" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
      swift = { "swiftlint" },
      kotlin = { "ktlint" },
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
};
