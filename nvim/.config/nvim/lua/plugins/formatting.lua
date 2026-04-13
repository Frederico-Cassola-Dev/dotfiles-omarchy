local function has_editorconfig(ctx)
  local path = ctx.filename
  if not path or path == "" then
    path = vim.api.nvim_buf_get_name(ctx.buf or 0)
  end
  if path == "" then
    return false
  end
  return vim.fs.find(".editorconfig", { path = path, upward = true })[1] ~= nil
end

return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.default_format_opts = vim.tbl_extend("force", opts.default_format_opts or {}, {
        timeout_ms = 10000,
      })

      -- Prettier respects `.editorconfig`; markdownlint-cli2 / markdown-toc do not.
      -- In EditorConfig projects, only run Prettier from the markdown pipeline (LazyVim extra).
      opts.formatters = opts.formatters or {}
      local md_lint_fmt = opts.formatters["markdownlint-cli2"] or {}
      local md_lint_prev = md_lint_fmt.condition
      opts.formatters["markdownlint-cli2"] = vim.tbl_extend("force", md_lint_fmt, {
        condition = function(self, ctx)
          if has_editorconfig(ctx) then
            return false
          end
          if md_lint_prev then
            return md_lint_prev(self, ctx)
          end
          return true
        end,
      })

      local md_toc = opts.formatters["markdown-toc"] or {}
      local md_toc_prev = md_toc.condition
      opts.formatters["markdown-toc"] = vim.tbl_extend("force", md_toc, {
        condition = function(self, ctx)
          if has_editorconfig(ctx) then
            return false
          end
          if md_toc_prev then
            return md_toc_prev(self, ctx)
          end
          return false
        end,
      })
    end,
  },
}
