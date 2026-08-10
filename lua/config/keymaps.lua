local map = vim.keymap.set

-- Make s trigger which-key for search prefix
map("n", "s", function() require("which-key").show("s") end, { desc = "Search" })

-- Quick access to init.lua
-- map("n", "<leader><leader>", ":e $MYVIMRC<CR>", { desc = "Open init.lua" })

-- Oil file explorer
map("n", "S", "<cmd>Oil<cr>", { desc = "Open parent directory" })

-- Leaving: neither discards. :qa refuses while anything is modified, :wqa saves.
map("n", "q", "<cmd>qa<cr>", { desc = "Quit all" })
map("n", "Q", "<cmd>wqa<cr>", { desc = "Write all and quit" })

-- Trouble keybindings
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics" })
map("n", "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", { desc = "Quickfix List" })
map("n", "U", "<C-r>", { desc = "Redo" })
