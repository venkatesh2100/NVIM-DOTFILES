return {
  -- 🔹 Highlight colors using mini.hipatterns (Useful for syntax enhancements)
  {
    "echasnovski/mini.hipatterns",
    event = "BufReadPre",
    opts = {},
  },

  -- 🔹 Main Telescope Configuration
  {
    "nvim-telescope/telescope.nvim",
    priority = 1000,
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make", -- Compiles FZF for better performance
      },
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-media-files.nvim", -- Allows image & PDF previews
      "nvim-telescope/telescope-project.nvim", -- Quickly switch between projects
    },
 -- Disable the hidden files search in Telescope
    keys = {
      {
        "<leader>ff",
        function()
          local builtin = require("telescope.builtin")
          builtin.find_files({ no_ignore = false, hidden = false })
        end,
        desc = "Find files (respects .gitignore)",
      },
      {
        "<leader>fg",
        function()
          local builtin = require("telescope.builtin")
          builtin.git_files()
        end,
        desc = "Find files in Git repository (faster)",
      },
      {
        "<leader>fr",
        function()
          local builtin = require("telescope.builtin")
          builtin.live_grep()
        end,
        desc = "Live Grep (Search for text inside files)",
      },
      {
        "<leader>fb",
        function()
          local builtin = require("telescope.builtin")
          builtin.buffers()
        end,
        desc = "List open buffers",
      },
      {
        "<leader>fh",
        function()
          local builtin = require("telescope.builtin")
          builtin.help_tags()
        end,
        desc = "Search help tags",
      },
      {
        "<leader>fd",
        function()
          local builtin = require("telescope.builtin")
          builtin.diagnostics()
        end,
        desc = "List diagnostics for all buffers",
      },
      {
        "<leader>ft",
        function()
          local builtin = require("telescope.builtin")
          builtin.treesitter()
        end,
        desc = "List function names and variables from Treesitter",
      },
      {
        "<leader>fp",
        function()
          require("telescope").extensions.project.project()
        end,
        desc = "List and switch between projects",
      },
      {
        "<leader>fm",
        function()
          require("telescope").extensions.media_files.media_files()
        end,
        desc = "Preview media files (images, PDFs, etc.)",
      },
      {
        "<leader>fe",
        function()
          local telescope = require("telescope")
          local function telescope_buffer_dir()
            return vim.fn.expand("%:p:h")
          end

          telescope.extensions.file_browser.file_browser({
            path = "%:p:h",
            cwd = telescope_buffer_dir(),
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            previewer = true,
            initial_mode = "normal",
            layout_config = { height = 40 },
          })
        end,
        desc = "Open file browser in current buffer directory",
      },
    },

    config = function(_, opts)
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions

      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        wrap_results = true,
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          n = {},
        },
      })

      opts.pickers = {
        diagnostics = {
          theme = "ivy",
          initial_mode = "normal",
          layout_config = {
            preview_cutoff = 9999,
          },
        },
      }

       opts.extensions = {
        file_browser = {
          theme = "dropdown",
          hijack_netrw = true, -- Replace netrw with file browser
          mappings = {
            ["n"] = {
              ["N"] = fb_actions.create,
              ["h"] = fb_actions.goto_parent_dir,
              ["<C-u>"] = function(prompt_bufnr)
                for _ = 1, 10 do
                  actions.move_selection_previous(prompt_bufnr)
                end
              end,
              ["<C-d>"] = function(prompt_bufnr)
                for _ = 1, 10 do
                  actions.move_selection_next(prompt_bufnr)
                end
              end,
            },
          },
        },
      }

      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
      telescope.load_extension("media_files")
      telescope.load_extension("project")
    end,
  },
}
