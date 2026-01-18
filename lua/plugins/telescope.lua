-- Essential: Fuzzy finder (MUST-HAVE)
return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    -- File & Content Search
    { "sf", function() require("telescope.builtin").find_files() end, desc = "Search files" },
    { "sg", function() require("telescope.builtin").live_grep() end, desc = "Search grep" },
    { "sb", function() require("telescope.builtin").buffers() end, desc = "Search buffers" },
    { "sr", function() require("telescope.builtin").oldfiles() end, desc = "Search recent" },
    { "s/", function() require("telescope.builtin").current_buffer_fuzzy_find() end, desc = "Search in file" },
    { "sw", function() require("telescope.builtin").grep_string() end, desc = "Search word under cursor" },
    -- LSP Symbol Search
    { "sy", function() require("telescope.builtin").lsp_document_symbols() end, desc = "Search symbols" },
    { "sY", function() require("telescope.builtin").lsp_workspace_symbols() end, desc = "Search workspace symbols" },
    { "si", function() require("telescope.builtin").lsp_implementations() end, desc = "Search implementations" },
    { "sR", function() require("telescope.builtin").lsp_references() end, desc = "Search references" },
    { "sT", function() require("telescope.builtin").lsp_type_definitions() end, desc = "Search type definitions" },
    -- Diagnostics & Help
    { "sd", function() require("telescope.builtin").diagnostics() end, desc = "Search diagnostics" },
    { "sh", function() require("telescope.builtin").help_tags() end, desc = "Search help" },
    { "sk", function() require("telescope.builtin").keymaps() end, desc = "Search keymaps" },
    { "sc", function() require("telescope.builtin").commands() end, desc = "Search commands" },
    -- Navigation History
    { "sj", function() require("telescope.builtin").jumplist() end, desc = "Search jumplist" },
    { "sm", function() require("telescope.builtin").marks() end, desc = "Search marks" },
    { "sq", function() require("telescope.builtin").quickfix() end, desc = "Search quickfix" },
    -- Git
    { "<leader>gc", function() require("telescope.builtin").git_commits() end, desc = "Git commits" },
    { "<leader>gs", function() require("telescope.builtin").git_status() end, desc = "Git status" },
    { "<leader>gb", function() require("telescope.builtin").git_branches() end, desc = "Git branches" },
    { "<leader>gf", function() require("telescope.builtin").git_files() end, desc = "Git files" },
    { "<leader>gS", function() require("telescope.builtin").git_stash() end, desc = "Git stash" },
  },
  opts = {
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
  },
}
