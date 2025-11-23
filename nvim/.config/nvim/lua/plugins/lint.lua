-- -- Add markdown lint rules
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
      },
    },
  },
}
