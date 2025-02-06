return {
  "catppuccin/nvim",
  lazy = false, -- Load immediately (prevents flashing when changing themes)
  name = "catppuccin",

  opts = {
    flavour = "mocha", -- Set theme variant (options: latte, frappe, macchiato, mocha)
    transparent_background = true, -- Enable transparent background

    integrations = {
      cmp = true, -- nvim-cmp (completion)
      gitsigns = true, -- Git integration
      nvimtree = true, -- File Explorer
      treesitter = true, -- Syntax highlighting
      telescope = { enabled = true }, -- Telescope UI
      notify = true, -- Notifications UI
      which_key = true, -- Keymap hints UI
      dashboard = true, -- Alpha/Dashboard UI
      indent_blankline = { enabled = true, scope_color = "lavender" }, -- Indentation guides
      lsp_trouble = true, -- LSP diagnostics UI
    },

    custom_highlights = function(colors)
      return {
        -- 🌟 Custom UI Enhancements
        TabLineSel = { bg = colors.blue, fg = colors.base },
        BufferLineBufferSelected = { fg = colors.sky, bold = true },
        DiffChange = { bg = colors.green, fg = colors.base },
        DiffDelete = { bg = colors.red, fg = colors.base },
        Visual = { bg = colors.lavender, fg = colors.base },
        CursorLine = { bg = colors.surface0 },

        -- 🚀 Highlight Word Under Cursor
        illuminatedWordText = { bg = colors.blue, fg = colors.base, bold = true },

        -- 🔍 Search Highlights
        Search = { bg = colors.yellow, fg = colors.base },
        IncSearch = { bg = colors.peach, fg = colors.base },

        -- 🔧 UI Elements
        QuickFixLine = { bg = colors.sapphire, fg = colors.base, bold = true },
        Comment = { fg = colors.overlay1, italic = true },

        -- 🛠️ Statusline & Winbar
        StatusLine = { bg = colors.crust, fg = colors.text },
        WinSeparator = { fg = colors.overlay2 },
      }
    end,
  },

  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin") -- Ensure the theme is applied
  end,
}
