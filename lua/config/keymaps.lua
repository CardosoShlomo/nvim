local map = vim.keymap.set

-- Quick access to init.lua
-- map("n", "<leader><leader>", ":e $MYVIMRC<CR>", { desc = "Open init.lua" })

-- Oil file explorer
map("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open parent directory" })

-- Trouble keybindings
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics" })
map("n", "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", { desc = "Quickfix List" })
map("n", "U", "<C-r>", { desc = "Redo" })
