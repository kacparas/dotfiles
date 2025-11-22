-- ============================================================================
-- Keybindings
-- ============================================================================

local keymap = vim.keymap.set

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to top window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- File explorer
keymap("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle file explorer" })

-- Telescope (fuzzy finder)
keymap("n", "<leader>ff", function()
  require('telescope.builtin').find_files({
    hidden = true,
    file_ignore_patterns = {
      "Library/.*",
      "Photos/.*",
      "Music/.*",
      "Movies/.*",
      "Downloads/.*",
    }
  })
end, { desc = "Find files (current dir)" })

keymap("n", "<leader>fh", function()
  require('telescope.builtin').find_files({ 
    cwd = vim.fn.expand('~'), 
    hidden = true,
    file_ignore_patterns = {
      "Library",
      "Photos",
      "Music",
      "Movies",
      ".local",
      ".cache",
      "venvs",
      "site%-packages",
      "Zotero"
    }
  })
end, { desc = "Find files from home" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Search in files" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })

-- LSP keybindings
keymap("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
keymap("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
keymap("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
keymap("n", "<leader>dx", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- REPL keybindings (Iron.nvim)
keymap("n", "<leader>rs", "<cmd>IronRepl<cr>", { desc = "Start REPL" })
keymap("n", "<leader>rr", "<cmd>IronRestart<cr>", { desc = "Restart REPL" })
keymap("n", "<leader>ro", "<cmd>IronFocus<cr>", { desc = "Focus REPL" })
keymap("n", "<leader>rh", "<cmd>IronHide<cr>", { desc = "Hide REPL" })

-- Send code to REPL
keymap("n", "<leader>rl", function() require("iron.core").send_line() end,   { desc = "Send line to REPL" })
keymap("v", "<leader>rv", function() require("iron.core").visual_send() end, { desc = "Send selection to REPL" })
keymap("n", "<leader>rf", function() require("iron.core").send_file() end,   { desc = "Send file to REPL" })

-- Quick save and quit
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })


-- Venv selector
keymap("n", "<leader>vs", "<cmd>VenvSelect<cr>", { desc = "Select venv" })
keymap("n", "<leader>vc", "<cmd>VenvSelectCached<cr>", { desc = "Select cached venv" })

-- Dashboard
keymap("n", "<leader>a", "<cmd>Alpha<cr>", { desc = "Open dashboard" })

-- Override ZQ to return to dashboard instead of quitting
keymap("n", "ZQ", function()
  local buffers = vim.fn.getbufinfo({buflisted = 1})
  if #buffers <= 1 then
    -- Last buffer or no listed buffers, go to dashboard
    vim.cmd("bdelete!")
    require("alpha").start()
  else
    -- More buffers exist, just delete current one
    vim.cmd("bdelete!")
  end
end, { desc = "Close buffer, return to dashboard" })

-- Terminal
keymap("n", "<leader>tt", "<cmd>terminal<cr>", { desc = "Open terminal" })
keymap("n", "<leader>tv", "<cmd>vsplit | terminal<cr>", { desc = "Open terminal in vsplit" })

-- Claude
keymap("n", "<leader>tc", "<cmd>terminal claude<cr>", { desc = "Open Claude" })
keymap("n", "<leader>tC", "<cmd>vsplit | terminal claude<cr>", { desc = "Open Claude in split" })
