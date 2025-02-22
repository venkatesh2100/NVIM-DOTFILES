return {
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy", -- Load only when needed
    opts = {
      -- 🔹 Define TODO keywords
      keywords = {
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "ISSUE" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },

      -- 🔹 Highlight Configuration
      highlight = {
        comments_only = true, -- Only highlight TODOs inside comments
        pattern = [[.*<(KEYWORDS)\s*:]], -- Match TODOs in comments
        max_line_len = 400, -- Ignore long lines
      },

      -- 🔹 Custom Ripgrep Search (Scoped to Current Directory)
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--hidden", -- Include hidden files
          "--glob=!.git/**", -- Ignore Git files
          "--glob=!.venv/**", -- Ignore virtual environments
          "--glob=!.cache/**", -- Ignore cache
          "." -- 👈 Search only in the current directory
        },
        pattern = [[\b(KEYWORDS):]], -- Match TODO, FIXME, HACK, etc.
      },
    },

    -- 🔹 Keybinding: `;+c` to Search TODOs in Current Directory
    config = function()
      require("todo-comments").setup()

      vim.keymap.set("n", ";+c", function()
        require("telescope").extensions.todo_comments.todo({
          search = "TODO|FIXME|HACK|NOTE|TEST",
          cwd = vim.fn.expand("%:p:h"), -- 👈 Set search scope to current directory
        })
      end, { desc = "Find TODOs in Current Directory" })
    end,
  },
}
