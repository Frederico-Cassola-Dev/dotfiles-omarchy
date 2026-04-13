-- Markdown: markdownlint does not read `.editorconfig`. When a project defines one,
-- skip this linter so only EditorConfig buffer options + EditorConfig-aware formatters apply.
return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      markdown = { "markdownlint" },
    },
    linters = {
      markdownlint = {
        cmd = "markdownlint-cli2", -- use the correct executable name
        args = { "--disable", "MD013" },
        ---@param ctx { filename: string, dirname: string }
        condition = function(ctx)
          return not vim.fs.find(".editorconfig", { path = ctx.filename, upward = true })[1]
        end,
      },
    },
  },
}
