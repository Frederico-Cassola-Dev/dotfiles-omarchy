-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Make the diagnostics message in a float focusable window

vim.api.nvim_create_autocmd("CursorHold", {
  group = vim.api.nvim_create_augroup("ShowDiagnosticsFloat", { clear = true }),
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = true,
      scope = "line",
      close_events = { "CursorMoved", "InsertEnter" },
    })
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.jsx",
  callback = function()
    vim.bo.filetype = "javascript"
  end,
})
--
-- -- Auto-Format on Save - ### BASH ###
-- vim.cmd([[
--   augroup FormatAutogroup
--     autocmd!
--     autocmd BufWritePre *.sh,*.bash lua vim.lsp.buf.format({ async = false })
--   augroup END
-- ]])
