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

-- Configure clipboard to use Windows' built-in clip.exe and PowerShell
vim.g.clipboard = {
  name = "win-clipboard",
  copy = {
    ["+"] = "/mnt/c/Windows/System32/clip.exe",
    ["*"] = "/mnt/c/Windows/System32/clip.exe",
  },
  paste = {
    ["+"] = '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -NoProfile -ExecutionPolicy RemoteSigned -Command "Get-Clipboard"',
    ["*"] = '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -NoProfile -ExecutionPolicy RemoteSigned -Command "Get-Clipboard"',
  },
  cache_enabled = 1,
}

-- Use the system clipboard for all yank, delete, and put operations.
vim.opt.clipboard = "unnamedplus"
