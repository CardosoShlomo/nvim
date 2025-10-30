-- Essential: Fuzzy finder (MUST-HAVE)
return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    -- Telescope fullscreen configuration
    require("telescope").setup({
      defaults = {
        layout_strategy = "horizontal",
        layout_config = {
          height = 0.99,
          width = 0.99,
          preview_width = 0.6,
        },
        sorting_strategy = "ascending",
        file_ignore_patterns = { "node_modules", "%.git/", "%.dart_tool/", "build/", "%.idea/" },
      },
    })

    local builtin = require("telescope.builtin")

    -- File & Content Search
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files by name" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Search text in all files (live grep)" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Switch between open buffers" })
    vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recently opened files" })
    vim.keymap.set("n", "<leader>f/", builtin.current_buffer_fuzzy_find, { desc = "Fuzzy search in current file" })
    vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Search word under cursor in all files" })

    -- LSP Symbol Search (Classes, Functions, etc.)
    vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Find symbols (class/function) in current file" })
    vim.keymap.set("n", "<leader>fS", builtin.lsp_workspace_symbols, { desc = "Find symbols in entire workspace" })
    vim.keymap.set("n", "<leader>fi", builtin.lsp_implementations, { desc = "Find all implementations of interface/abstract" })
    vim.keymap.set("n", "<leader>fR", builtin.lsp_references, { desc = "Find all references to symbol" })
    vim.keymap.set("n", "<leader>fT", builtin.lsp_type_definitions, { desc = "Go to type definition" })

    -- Diagnostics & Help
    vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Show all errors/warnings in project" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Search Neovim help documentation" })
    vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Show all keybindings" })
    vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Search all available commands" })

    -- Navigation History
    vim.keymap.set("n", "<leader>fj", builtin.jumplist, { desc = "Show jump history (where you've been)" })
    vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "Show all bookmarks/marks" })
    vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "Show quickfix list" })

    -- Git Integration
    vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Browse git commit history" })
    vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Show modified/staged files (git status)" })
    vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "List and switch git branches" })
    vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Find files tracked by git only" })
    vim.keymap.set("n", "<leader>gS", builtin.git_stash, { desc = "Browse git stashes" })

  end,
}
