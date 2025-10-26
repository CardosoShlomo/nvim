local map = vim.keymap.set

-- Quick access to init.lua
map("n", "<leader><leader>", ":e $MYVIMRC<CR>", { desc = "Open init.lua" })

-- Oil file explorer
map("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open parent directory" })

-- Trouble keybindings
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics" })
map("n", "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", { desc = "Quickfix List" })

-- Flash keybindings
map({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash jump" })
map({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })

-- Move lines up/down
map('n', '<M-S-Up>', ':move .-2<CR>==', { desc = 'Move line up' })
map('n', '<M-S-Down>', ':move .+1<CR>==', { desc = 'Move line down' })
map('x', '<M-S-Up>', ":move '<-2<CR>gv=gv", { desc = 'Move selection up' })
map('x', '<M-S-Down>', ":move '>+1<CR>gv=gv", { desc = 'Move selection down' })
