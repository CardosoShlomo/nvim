return {

  -- Escape insert mode with jk
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {
      mapping = { "jk" },
      timeout = 200,
      clear_empty_lines = false,
      keys = "<Esc>",
    },
  },

  -- Essential: Fuzzy finder (MUST-HAVE)
  {
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
  },

  -- Essential: Git integration (MUST-HAVE)
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- Essential: Auto-close brackets (MUST-HAVE)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- Essential: Commenting (MUST-HAVE)
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Treesitter (Updated with full stack languages)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        indent = { enable = true },
        auto_install = true,
        ensure_installed = {
          "lua", "javascript", "typescript", "tsx", "json", "yaml", "html", "css",
          "dart", "go", "rust", "dockerfile", "terraform",
          "markdown", "markdown_inline", "bash", "regex",
        },
      })
    end,
  },
  
  -- Linting (Updated with Go and Rust linters)
  {
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
      }

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },

  -- Auto-close JSX/HTML tags (great for React/Next.js)
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- Tailwind CSS support (color previews, sorting, etc.)
  {
    "luckasRanarison/tailwind-tools.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    opts = {},
  },
  
  -- Surround: Wrap text easily
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  -- Discover keyboard shortcuts visually
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup()
    end,
  },

  -- Oil: Edit filesystem like a buffer
  {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup()
    end,
  },

  -- MUST: Status line (everyone has this)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          component_separators = "|",
          section_separators = "",
        },
      })
    end,
  },

  -- MUST: Better diagnostics/error list
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup()
    end,
  },

  -- MUST: Jump anywhere instantly
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = function()
      require("flash").setup()
    end,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = {
          char = "▏",
        },
        scope = {
          enabled = false,
        },
      })

    end,
  },

}
