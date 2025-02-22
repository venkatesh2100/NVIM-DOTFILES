
return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- 🎯 General UI Settings
      messages = {
        enabled = true, -- Enables Noice message UI
      },
      notify = {
        enabled = true, -- Enables notifications
        view = "mini", -- Use a more compact notification UI
        timeout = 3000, -- Keeps messages visible a bit longer (3s)
        level = vim.log.levels.WARN, -- Shows warnings & errors only
      },

      -- ⚡ Performance Tweaks
      throttle = 100, -- Faster updates (was 150ms)
      debounce = 50,  -- Reduces input lag (was 100ms)

      -- ⚙️ LSP Settings (Disabled for a cleaner UI)
      lsp = {
        progress = { enabled = false }, -- Disables LSP progress notifications
        message = { enabled = false }, -- Suppresses LSP status messages
        hover = { enabled = false }, -- Disables hover popups
        signature = { enabled = false }, -- Disables function signature help
      },

      -- 📌 Command Line UI Enhancements
      cmdline = {
        enabled = true, -- Enables Noice command-line UI
        view = "cmdline", -- Use a clean, modern command-line UI
        format = {
          cmdline = { icon = "⌨️" }, -- Adds an icon for commands
          search_down = { icon = "🔍↓" }, -- Adds an icon for downward search
          search_up = { icon = "🔍↑" }, -- Adds an icon for upward search
        },
      },
    },
  },
}
