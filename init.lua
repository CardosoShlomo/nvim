-- Neovim init.lua

-- Basic Settings
vim.o.number = true
vim.o.relativenumber = true
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.smartindent = true
vim.o.termguicolors = true
vim.o.swapfile = false
vim.g.mapleader = " "

-- Lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({

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

  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },

  -- Essential: Fuzzy finder (MUST-HAVE)
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
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

  -- File explorer (FIXED dependency typo)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- LSP & Completion
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
  },

  -- Mason LSP Installer/Configurator
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { 
      "williamboman/mason.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      
      require("mason-lspconfig").setup({
        -- LSP Servers for your stack
        ensure_installed = {
          "ts_ls",
          "terraformls",
          "jsonls",
          "yamlls",
          "dockerls",
          "lua_ls",
          "html",
          "cssls",
          "eslint",
          -- "gopls",
          "rust_analyzer",
          "tailwindcss",
        },

        -- Custom settings handlers
        handlers = {
          -- Default handler for LSPs without custom settings
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
            })
          end,

          -- Custom handler for dartls (Transferred your settings)
          dartls = function()
            require("lspconfig").dartls.setup({
              capabilities = capabilities,
              settings = {
                dart = {
                  completeFunctionCalls = true,
                  showTodos = true,
                  enableSnippets = true,
                  lineLength = 80,
                  analysisExcludedFolders = {},
                  enableSdkFormatter = true,
                },
              },
              init_options = {
                onlyAnalyzeProjectsWithOpenFiles = false,
                suggestFromUnimportedLibraries = true,
                closingLabels = true,
                outline = true,
                flutterOutline = true,
              },
            })
          end,

          -- Custom handler for lua_ls (Transferred your settings)
          lua_ls = function()
            require("lspconfig").lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  runtime = { version = "LuaJIT" },
                  diagnostics = { globals = { "vim" } },
                  workspace = {
                    library = vim.env.VIMRUNTIME,
                    checkThirdParty = false,
                  },
                  telemetry = { enable = false },
                },
              },
            })
          end,
        },
      })
    end,
  },

  -- Completion Sources
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },

  -- Snippets
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

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

  -- Refactoring tools
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup()
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

  -- MUST: Status line (everyone has this)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight",
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

  -- MUST: Jump anywhere instantly (game-changer)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = function()
      require("flash").setup()
    end,
  },

  -- Indent guides (very minimal)
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

})

-- Configuration blocks

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

-- AUTO-INSTALL: All linters, formatters, and DAPs
local mason_registry = require("mason-registry")

-- Refresh registry to get latest packages
mason_registry.refresh(function()
  local packages_to_install = {
    -- These are the TOOLS (not LSPs) you want auto-installed
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

  -- Loop through and install any missing packages
  for _, package_name in ipairs(packages_to_install) do
    local ok, package = pcall(mason_registry.get_package, package_name)
    if ok and not package:is_installed() then
      vim.notify("Installing " .. package_name, vim.log.levels.INFO)
      package:install()
    end
  end
end)

-- Folding (Must be after Treesitter setup, which is now done in the plugin config)
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldenable = false

-- NvimTree
require("nvim-tree").setup({
  update_focused_file = { enable = true },
  view = { width = 30 },
  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
      glyphs = {
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
})
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- Quick access to init.lua
vim.keymap.set("n", "<leader><leader>", ":e $MYVIMRC<CR>", { desc = "Open init.lua" })

-- LSP keybindings
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })

-- Diagnostics navigation
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- Trouble keybindings
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics" })
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", { desc = "Quickfix List" })

-- Flash keybindings
vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash jump" })
vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })

-- Organize/add all imports (Dart-specific, safe to auto-apply)
vim.keymap.set("n", "<leader>co", function()
  vim.lsp.buf.code_action({
    context = {
      only = { "source.organizeImports" },
      diagnostics = vim.diagnostic.get(0),
    },
    apply = true,
  })
end, { desc = "Organize imports" })

-- Show all code actions in buffer (review one-by-one)
vim.keymap.set("n", "<leader>cA", function()
  vim.lsp.buf.code_action({
    context = {
      diagnostics = vim.diagnostic.get(0),
    },
  })
end, { desc = "Code actions (all buffer)" })

-- Refactoring (visual mode - select code first)
vim.keymap.set("x", "<leader>rr", function()
  require('refactoring').select_refactor()
end, { desc = "Refactor menu" })

-- Autocomplete setup
local cmp = require("cmp")
local luasnip = require("luasnip")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }),
})

-- Autopairs + cmp integration
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

