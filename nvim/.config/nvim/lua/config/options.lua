-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = false
vim.opt.spelllang = { "en", "fr" }
vim.opt.spell = true

-- Change the default snack picker to use telescope
-- vim.g.lazyvim_picker = "telescope"
--
-- AutoSession ==> This ensure that:
-- Window positions and sizes are saved and restored.
-- Terminal buffers are included in the session.
-- Folds and tabs are preserved.
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
