return {
  "williamboman/mason-lspconfig.nvim",
  opts = {
    -- list of servers for mason to install
    ensure_installed = {
      "ts_ls",
      "html",
      "cssls",
      "tailwindcss",
      "lua_ls",
      "graphql",
      "emmet_ls",
      "prismals",
      "pyright",
      "eslint",
    },
  },
  dependencies = {
    {
      "williamboman/mason.nvim",
      opts = {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      },
      config = function()
        local mason_registry = require("mason-registry")

        mason_registry.refresh(function()
          local packages_to_install = {
            "eslint_d",
            "tflint",
            "hadolint",
            "golangci-lint",
            "jsonlint",
            "yamllint",
            "htmlhint",
            "stylelint",
            "markdownlint",
            "shellcheck",
          }

          for _, package_name in ipairs(packages_to_install) do
            local ok, package = pcall(mason_registry.get_package, package_name)
            if ok and not package:is_installed() then
              vim.notify("Installing " .. package_name, vim.log.levels.INFO)
              package:install()
            end
          end
        end)

        require("mason").setup()
      end,
    },
    "neovim/nvim-lspconfig",
  },
}
