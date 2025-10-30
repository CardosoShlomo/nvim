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

  -- Treesitter
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
  
  -- Linting
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
    -- "luckasRanarison/tailwind-tools.nvim",
    -- dependencies = {
    --   "nvim-treesitter/nvim-treesitter",
    -- },
    -- ft = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    -- opts = {},
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
      require("oil").setup({
        view_options = {
          show_hidden = true,
        },
      })
    end,
  },

  -- MUST: Status line
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
