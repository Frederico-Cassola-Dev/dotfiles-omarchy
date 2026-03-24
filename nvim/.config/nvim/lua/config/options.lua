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

-- WSL win32yank clipboard (yank → Windows, paste ← Windows, no ^M)
-- Force disable tmux + auto-detection
-- vim.g.loaded_clipboard_provider = 0
vim.g.loaded_tmux_clipboard = 1

-- Simple clip.exe (no win32yank needed)
if vim.fn.executable("win32yank.exe") == 1 then
  print("win32yank.exe is executable")
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = 0,
  }
else
  print("win32yank.exe is NOT executable")
end
vim.opt.clipboard = "unnamedplus"
