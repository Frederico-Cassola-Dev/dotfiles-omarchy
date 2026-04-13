return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.default_format_opts = vim.tbl_extend("force", opts.default_format_opts or {}, {
        timeout_ms = 10000,
      })
    end,
  },
}
