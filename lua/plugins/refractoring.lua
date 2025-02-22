return {
  -- Incremental Rename
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    keys = {
      {
        "<leader>rn",
        function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        desc = "Incremental rename",
        mode = "n",
        noremap = true,
        expr = true,
      },
    },
    config = function()
      require("inc_rename").setup({
        preview = true, -- Show live preview while renaming
        input_buffer_type = "dressing", -- Use a better UI for rename input
      })
    end,
  },

  -- Refactoring Tool
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }, -- Required dependency
    keys = {
      {
        "<leader>r",
        function()
          require("refactoring").select_refactor()
        end,
        desc = "Open Refactoring Menu",
        mode = "v",
        noremap = true,
        silent = true,
      },
    },
    config = function()
      require("refactoring").setup({
        prompt_func_return_type = {
          go = true,
          cpp = true,
          c = true,
          java = true,
        },
        prompt_func_param_type = {
          go = true,
          cpp = true,
          c = true,
          java = true,
        },
        show_success_message = true,
      })
    end,
  },
}
