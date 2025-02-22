return {
  -- Mason for installing LSPs & tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_extend("force", opts.ensure_installed or {}, {
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",
        "pyright",
        "black",
        "ruff"
      })
    end,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      diagnostics = {
        virtual_text = false,  -- Disable inline diagnostics
        signs = true,          -- Keep signs in the gutter
        underline = true,      -- Underline issues
        update_in_insert = false,
      },
      servers = {
        cssls = {},
        tailwindcss = {
          root_dir = require("lspconfig.util").root_pattern("tailwind.config.js", "package.json", ".git"),
        },
        tsserver = {
          root_dir = require("lspconfig.util").root_pattern("tsconfig.json", "package.json", ".git"),
          single_file_support = false,
          settings = {
            typescript = { inlayHints = { includeInlayParameterNameHints = "literal" } },
            javascript = { inlayHints = { includeInlayParameterNameHints = "all" } },
          },
        },
        html = {},
        lua_ls = {
          single_file_support = true,
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              diagnostics = { disable = { "incomplete-signature-doc", "trailing-space" } },
              format = { enable = true, defaultConfig = { indent_style = "space", indent_size = "2" } },
            },
          },
        },
      },
    },
  }, -- Autocompletion with nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- Keybindings for Diagnostics
  {
    "LazyVim/LazyVim",
    opts = function()
      vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, { desc = "Show diagnostics popup" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
      vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Show diagnostics in location list" })
      vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Show diagnostics in quickfix list" })
      vim.keymap.set("n", "<leader>dt", function()
        local current = vim.diagnostic.config().virtual_text
        vim.diagnostic.config({ virtual_text = not current })
      end, { desc = "Toggle virtual text diagnostics" })
    end,
  },
}

