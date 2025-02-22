-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- VScode Addons
-- keymap.set("n", "x", '"_x')
-- keymap.set("n", "<C-l>", "yy")
keymap.set("n", "<C-s>", "<Esc>:w<CR>a")
keymap.set("n", "<C-w>", ":bd<CR>")
keymap.set("n", "<C-a>", "gg<S-v>G")
--keymap.set("n", "<C-e>", "$", opts)


--
vim.keymap.set("n", "<leader>t", function()
  require("telescope").extensions.file_browser.file_browser({
    path = "%:p:h", -- Open in the parent directory of the current file
    select_buffer = true, -- Keep buffer selection consistent
  })
end, { desc = "Open Telescope File Browser" })
-- Ensure `<leader>t` opens Neo-Tree
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle Neo-Tree" })


-- 📌 Show TODOs in Quickfix only for the current directory

-- vim.keymap.set("n", "<leader>;t", function()
--   require("todo-comments.telescope").search_todos({
--     cwd = vim.fn.expand("%:p:h"), -- ✅ Search only in the current directory
--   })
-- end, { desc = "Quickfix TODOs in Current Directory" })
-- Map <leader>j to compile and run the current Java file
keymap.set("n", "<leader>j", ":w<CR>:!javac % && java %:r<CR>", { noremap = true, silent = true })
-- Map <leader>r to run the current Python file
keymap.set("n", "<leader>cp", ":w<CR>:sp | term python3 %:p<CR>", { noremap = true, silent = true })
-- Map Alt+number keys to switch to the respective buffer

keymap.set("n", "<A-1>", ":BufferLineGoToBuffer 1<CR>", { noremap = true, silent = true })
keymap.set("n", "<A-2>", ":BufferLineGoToBuffer 2<CR>", { noremap = true, silent = true })
keymap.set("n", "<A-3>", ":BufferLineGoToBuffer 3<CR>", { noremap = true, silent = true })
-- Add more mappings as needed

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x> ")

-- Save file and quit
keymap.set("n", "<Leader>w", ":update<Return>", opts)
keymap.set("n", "<Leader>q", ":quit<Return>", opts)
keymap.set("n", "<Leader>Q", ":qa<Return>", opts)

-- File explorer with NvimTree
-- keymap.set("n", "<Leader>f", ":NvimTreeFindFile<Return>", opts)
-- keymap.set("n", "<Leader>t", ":NvimTreeToggle<Return>", opts)

-- keymap.set("n", "<tab>", ":tabnext<Return>", opts)
-- keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
-- keymap.set("n", "tw", ":tabclose<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-p>", "<C-w>l")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-l>", "<C-w>l")

-- Resize window
keymap.set("n", "<A-h>", "<C-w><")
keymap.set("n", "<A-l>", "<C-w>>")
-- keymap.set("n", "<C-S-k>", "<C-w>+")
-- keymap.set("n", "<C-S-j>", "<C-w>-")

-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)

keymap.set("n", "<leader>qn", "<cmd>cnext<CR>", opts)
keymap.set("n", "<leader>qp", "<cmd>cprev<CR>", opts)
keymap.set("n", "<Leader>qf", "cmd>Telescope quickfix<CR>", opts)
keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
