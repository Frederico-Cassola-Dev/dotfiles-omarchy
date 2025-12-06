return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top", -- Set prompt position here globally
        },
      },
      sorting_strategy = "ascending",
      winblend = 0,
    },
    -- pickers = {
    --   find_files = {
    --     hidden = true,
    --     no_ignore = true,
    --   },
    -- },
  },
  keys = {
    {
      "<leader>fh",
      function()
        require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
      end,
      desc = "Find Files (show hidden and gitignored)",
    },
  },
}
