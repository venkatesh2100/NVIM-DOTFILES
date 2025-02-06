return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- Start when opening a file
  config = function()
    require("persistence").setup({
      dir = vim.fn.stdpath("data") .. "/sessions/",
      options = { "buffers", "curdir", "tabpages", "winsize" },
    })
  end,
}
