-- Neovim init.lua
vim.o.number = true
vim.o.relativenumber = true
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.smartindent = true
vim.o.termguicolors = true
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
    vim.keymap.set("n", "<leader>fD", builtin.lsp_definitions, { desc = "Go to definition(s)" })
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

	-- File explorer
	{ "nvim-tree/nvim-tree.lua" },
	{ "nvim-tree/nvim-web-devicons" },

	-- LSP & Completion
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim" },
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },

	-- Snippets (LuaSnip is more popular than vsnip)
	{ "L3MON4D3/LuaSnip" },
	{ "saadparwaiz1/cmp_luasnip" },

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},

	-- Formatting & Linting (replaces null-ls)
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					dart = { "dart_format" },
					terraform = { "terraform_fmt" },
					lua = { "stylua" },
				},
			})
		end,
	},
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
  
  -- Surround: Wrap text easily
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  -- Auto-imports & better code actions
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- Organize imports
          null_ls.builtins.code_actions.gitsigns,
        },
      })
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

  -- Add these to your plugins section in require("lazy").setup({

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

require("mason").setup()

-- Treesitter
require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	indent = { enable = true },
})

-- Folding (must be after Treesitter setup)
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

-- Move lines up/down (Vim-style with Shift)
vim.keymap.set("n", "<S-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<S-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<S-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<S-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Trouble keybindings
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics" })
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", { desc = "Quickfix List" })

-- Flash keybindings
vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash jump" })
vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })

-- Buffer management
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Delete buffer" })

-- Quick save
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file" })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save file" })

-- Organize/add all imports (Dart-specific, safe to auto-apply)
vim.keymap.set("n", "<leader>co", function()
  vim.lsp.buf.code_action({
    context = {
      only = { "source.organizeImports" },
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

-- Configure Dart LSP for better import behavior
vim.lsp.config.dartls = {
  cmd = { "dart", "language-server", "--protocol=lsp" },
  settings = {
    dart = {
      completeFunctionCalls = true,
      showTodos = true,
      -- Import preferences
      enableSnippets = true,
      lineLength = 80,
      -- This makes it prefer package imports over relative
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
}

-- Configure Lua LSP for Neovim
vim.lsp.config.lua_ls = {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = { vim.env.VIMRUNTIME },
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
}

-- LSP
vim.lsp.enable({ "ts_ls", "dartls", "terraformls", "jsonls", "yamlls", "dockerls", "lua_ls" })

-- Autocomplete
local cmp = require("cmp")
local luasnip = require("luasnip")

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
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
})

-- Autopairs + cmp integration
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
