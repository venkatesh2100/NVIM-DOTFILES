-- https://github.com/eldritch-theme/eldritch.nvim

return {
  "eldritch-theme/eldritch.nvim",
  lazy = true,
  name = "eldritch",
  opts = {
    -- This function is found in the documentation
    on_highlights = function(highlights)
      -- nvim-spectre highlight colors
      highlights.DiffChange = { bg = "#37f499", fg = "black" }
      highlights.DiffDelete = { bg = "#f265b5", fg = "black" }

      -- horizontal line that goes across where cursor is
      highlights.CursorLine = { bg = "#3f404f" }
      highlights.Comment = { fg = "#a5afc2" }

      -- I do the line below to change the color of bold text
      highlights["@markup.strong"] = { fg = "#f265b5", bold = true }

      -- Trying to change the spell underline color
      -- vim.cmd("highlight SpellBad cterm=undercurl gui=undercurl guisp=#37f499")
      -- highlights["@spell"] = { undercurl = true, sp = "#37f499" }
      -- highlights.SpellBad = { undercurl = true, sp = "#37f499" }
      highlights.SpellBad = { sp = "#37f499", undercurl = true }
      highlights.SpellCap = { sp = "#37f499", undercurl = true }
      highlights.SpellLocal = { sp = "#37f499", undercurl = true }
      highlights.SpellRare = { sp = "#37f499", undercurl = true }
    end,
  },
}
