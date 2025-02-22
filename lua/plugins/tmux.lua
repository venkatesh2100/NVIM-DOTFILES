
return {
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy", -- Loads on demand to improve startup time
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<CR>", desc = "Navigate left in Tmux" },
      { "<C-j>", "<cmd>TmuxNavigateDown<CR>", desc = "Navigate down in Tmux" },
      { "<C-k>", "<cmd>TmuxNavigateUp<CR>", desc = "Navigate up in Tmux" },
      { "<C-l>", "<cmd>TmuxNavigateRight<CR>", desc = "Navigate right in Tmux" },
      { "<C-\\>", "<cmd>TmuxNavigatePrevious<CR>", desc = "Navigate to previous Tmux pane" },
    },
  },
}
