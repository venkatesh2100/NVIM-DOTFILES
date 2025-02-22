return{
  "folke/zen-mode.nvim",
  opts = {
    -- Default configuration options (optional)
    window = {
      backdrop = 0.95, -- Shade the backdrop (0 = fully transparent, 1 = fully opaque)
      width = 120,     -- Width of the Zen window
      height = 1,      -- Height of the Zen window (1 = full height)
      options = {
        signcolumn = "no",  -- Hide the sign column
        number = false,      -- Hide line numbers
        relativenumber = false, -- Hide relative line numbers
        cursorline = false, -- Hide cursor line
        cursorcolumn = false, -- Hide cursor column
        foldcolumn = "0",    -- Hide fold column
        list = false,        -- Hide listchars
      },
    },
    plugins = {
      options = {
        enabled = true,
        ruler = false,       -- Hide the ruler
        showcmd = false,     -- Hide the command line
      },
      twilight = { enabled = true }, -- Integrate with twilight.nvim (optional)
    },
  },
  keys = {
    -- Keybinding to toggle Zen mode
    { "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
  },
}
