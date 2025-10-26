-- Enable LSP servers
-- vim.lsp.enable('lua_ls')
-- vim.lsp.enable('tsserver')
-- vim.lsp.enable('terraformls')
-- vim.lsp.enable('jsonls')
-- vim.lsp.enable('yamlls')
-- vim.lsp.enable('dockerls')
-- vim.lsp.enable('html')
-- vim.lsp.enable('cssls')
-- vim.lsp.enable('eslint')
-- vim.lsp.enable('rust_analyzer')
-- vim.lsp.enable('tailwindcss')

-- LSP keybindings
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })

-- Diagnostics navigation
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- Organize imports (Dart-specific)
vim.keymap.set("n", "<leader>co", function()
  vim.lsp.buf.code_action({
    context = {
      only = { "source.organizeImports" },
      diagnostics = vim.diagnostic.get(0),
    },
    apply = true,
  })
end, { desc = "Organize imports" })

-- Show all code actions
vim.keymap.set("n", "<leader>cA", function()
  vim.lsp.buf.code_action({
    context = {
      diagnostics = vim.diagnostic.get(0),
    },
  })
end, { desc = "Code actions (all buffer)" })
