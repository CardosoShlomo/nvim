return {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim',
    },
    opts = {
      dev_log = {
        enabled = true,
        open_cmd = "botright 70vnew",
        filter = function(log_line)
          if not log_line then return true end
          return log_line:match("flutter")
              or log_line:match("^Launching")
              or log_line:match("^Running")
              or log_line:match("^Syncing")
              or log_line:match("^Restarted")
              or log_line:match("^Error")
              or log_line:match("^Exception")
        end,
      },
      lsp = {
        settings = {
          analysisExcludedFolders = {},
          completeFunctionCalls = true,
          includeDependenciesInWorkspaceSymbols = true,
        },
      },
    },
}
