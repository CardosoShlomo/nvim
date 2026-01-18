return {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim',
    },
    opts = {
      lsp = {
        settings = {
          -- Include external packages in analysis
          analysisExcludedFolders = {},
          -- Better completion
          completeFunctionCalls = true,
          -- Show SDK source in go-to-definition
          includeDependenciesInWorkspaceSymbols = true,
        },
      },
    },
}
