-- ============================================================================
-- Plugins Configuration
-- ============================================================================

require("lazy").setup({

 -- Color scheme - Nord
  {
    "shaunsingh/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Nord customization (optional)
      vim.g.nord_contrast = true
      vim.g.nord_borders = false
      vim.g.nord_disable_background = false
      vim.g.nord_italic = false

      -- Load colorscheme
      require('nord').set()

      vim.cmd([[
        highlight Comment guifg=#ebcb8b gui=italic
        highlight @comment guifg=#ebcb8b gui=italic
        highlight @text.todo guifg=#ebcb8b
        highlight @text.note guifg=#ebcb8b
        highlight SpecialComment guifg=#ebcb8b
      ]])
    end,
  },

  -- Fuzzy finder - find files and search text
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      require('telescope').setup()
      require('telescope').load_extension('fzf')
    end
  },

  -- File explorer
  {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      window = {
        width = 35,
      },
    })
  end,
},

  -- Treesitter - better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "python", "lua", "markdown" },
        highlight = { enable = true },
        indent = { enable = true, disable = { "python" } },
      })
    end,
  },

-- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",
          "ruff",
          "lua-language-server",
          "stylua"
        },
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Use the new vim.lsp.config API (Neovim 0.11+)
      vim.lsp.config.pyright = {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.py", ".git" },
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
            }
          }
        },
        capabilities = capabilities,
      }

      vim.lsp.config.lua_ls = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".git" },
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            diagnostics = { globals = { "vim" } },
          }
        },
        capabilities = capabilities
      }

      vim.lsp.config.ruff = {
        cmd = { "ruff", 'server' },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "ruff.toml", ".git" },
        capabilities = capabilities,
      }

      vim.lsp.config.sourcekit = {
        cmd = { "/Library/Developer/CommandLineTools/usr/bin/sourcekit-lsp" },
        filetypes = { "swift" },
        root_markers = { "Package.swift", ".git" },
        capabilities=capabilities,
      }

      vim.lsp.enable("pyright")
      vim.lsp.enable("ruff")
      vim.lsp.enable("sourcekit")
      vim.lsp.enable("lua_ls")
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
        }),
        sorting = {
           comparators = {
                cmp.config.compare.exact,
                cmp.config.compare.locality,
                cmp.config.compare.recently_used,
                cmp.config.compare.score,
                cmp.config.compare.kind,
                cmp.config.compare.length,
                cmp.config.compare.order,
              },
            },
        })
    end,
  },

  -- REPL integration (Iron.nvim)
  {
    "Vigemus/iron.nvim",
    config = function()
      local iron = require("iron.core")
      iron.setup({
        config = {
          scratch_repl = true,
          repl_definition = {
            python = {
              command = { "ipython",
                          "--no-autoindent" },
              format = require("iron.fts.common").bracketed_paste,
            },
          },
          repl_open_cmd = require("iron.view").split.vertical.botright(80),
        },
        keymaps = {
          send_motion = "<space>rc",
          visual_send = "<space>rc",
          send_line = "<space>rl",
          send_mark = "<space>rm",
          cr = "<space>r<cr>",
          interrupt = "<space>r<space>",
          exit = "<space>rq",
          clear = "<space>rx",
        },
      })
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "nord",
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "venv-selector", "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Dashboard
  {
    "goolord/alpha-nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Header
      dashboard.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                     ",
      }

      -- Menu buttons
      dashboard.section.buttons.val = {
        dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
        dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
        dashboard.button("g", "  Find text", ":Telescope live_grep<CR>"),
        dashboard.button("t", "  Terminal", ":terminal<CR>"),
        dashboard.button("c", "  Claude", ":terminal claude<CR>"),
        dashboard.button("n", "  Config", ":e ~/.config/nvim/init.lua<CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }

      -- Footer
      dashboard.section.footer.val = "Ready to code"

      -- Layout
      dashboard.config.layout = {
        { type = "padding", val = 2 },
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        { type = "padding", val = 1 },
        dashboard.section.footer,
      }

      alpha.setup(dashboard.config)

      -- Auto-open dashboard when nvim starts with no args
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if vim.fn.argc() == 0 and vim.fn.line2byte("$") == -1 then
            require("alpha").start()
          end
        end,
      })

      -- Return to dashboard instead of quitting when closing last window
      vim.api.nvim_create_autocmd("QuitPre", {
        callback = function()
          local tree_wins = {}
          local floating_wins = {}
          local wins = vim.api.nvim_list_wins()
          for _, w in ipairs(wins) do
            local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
            if bufname:match("NvimTree_") ~= nil or bufname:match("neo%-tree") ~= nil then
              table.insert(tree_wins, w)
            end
            if vim.api.nvim_win_get_config(w).relative ~= '' then
              table.insert(floating_wins, w)
            end
          end
          -- If this is the last real window (excluding tree and floating windows)
          if #wins - #tree_wins - #floating_wins == 1 then
            -- Close all buffers and return to dashboard
            vim.cmd("%bdelete!")
            require("alpha").start()
          end
        end,
      })
    end,
  },

  -- Formatter
  {
    "stevearc/conform.nvim",
    opts = {
      format_on_save = { timeout_ms = 500 },
      formatters_by_ft = {
        python = { "ruff_format" },
        lua = { "stylua" },
      },
    },
  },

  -- Venv selector for Python
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    ft = "python",
    opts = {},
  },

})
