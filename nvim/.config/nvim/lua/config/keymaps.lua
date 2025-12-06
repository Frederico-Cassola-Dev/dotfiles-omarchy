-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Define neo-tree to open the float window in the level from the buffer that we are
vim.keymap.set("n", "<leader>e", function()
  local file_path = vim.fn.expand("%:p")
  if file_path == nil or file_path == "" then
    -- Open Neo-tree normally without reveal if no file path
    require("neo-tree.command").execute({ toggle = true })
  else
    -- Reveal the current file in the tree
    require("neo-tree.command").execute({ toggle = true, reveal_file = file_path })
  end
end, { silent = true })

-- Find hidden files with telescope
vim.keymap.set("n", "<leader>fh", function()
  require("lazyvim.util").pick("files", { hidden = true })()
end, { desc = "Find Files (show hidden)" })

-- UndotreeToggle
vim.keymap.set("n", "<leader><F5>", ":UndotreeToggle<CR>", { silent = true, desc = "Toggle Undotree" })
