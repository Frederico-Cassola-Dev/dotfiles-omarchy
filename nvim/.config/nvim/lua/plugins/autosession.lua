return {
  "rmagatti/auto-session",
  lazy = false,
  keys = {
    -- Will use Telescope if installed or a vim.ui.select picker otherwise
    { "<leader>wr", "<cmd>AutoSession search<CR>", desc = "Session search" },
    { "<leader>ws", "<cmd>AutoSession save<CR>", desc = "Save session" },
    { "<leader>wa", "<cmd>AutoSession toggle<CR>", desc = "Toggle autosave" },
  },
  opts = {
    auto_save = true, -- Save session on exit
    auto_restore = true, -- Restore session on startup
    auto_create = true, -- Create session if it doesn’t exist
    -- suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" }, -- Optional: skip sessions in these dirs
  },
}
