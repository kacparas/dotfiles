local keymap = vim.keymap.set

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to top window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- File explorer
keymap("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle file explorer" })

-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Search in files" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })

-- LSP
keymap("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })
keymap("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
keymap("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

-- Errors
keymap("n", "<leader>dx", "<cmd>lua vim.diagnostic.setloclist()<CR>", { desc = "Open diagnostics list" })
keymap("n", "<leader>dc", "<cmd>lclose<CR>", { desc = "Close diagnostics list" })

-- Iron (Python REPL)
keymap("n", "<leader>rf", "<cmd>IronRepl<cr>", { desc = "Start REPL" })
keymap("n", "<leader>rr", "<cmd>IronRestart<cr>", { desc = "Restart REPL" })
keymap("n", "<leader>ro", "<cmd>IronFocus<cr>", { desc = "Focus REPL" })
keymap("n", "<leader>rh", "<cmd>IronHide<cr>", { desc = "Hide REPL" })

-- Venv
keymap("n", "<leader>vs", "<cmd>VenvSelect<cr>", { desc = "Select venv" })

-- Save / quit
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })
