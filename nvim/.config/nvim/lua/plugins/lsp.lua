-- Change default lazyvim distro parameters of LSP diagnostics and inlay_hints
return {
  "neovim/nvim-lspconfig",
  opts = {
    -- Option to disable at startup the inlay hints feature of LSP
    inlay_hints = {
      enabled = false,
    },
    diagnostics = {
      -- Keep the buffer readable: only show inline text for errors (syntax, etc.).
      -- Warnings still appear in the sign column, :Trouble, and floats (see autocmds).
      virtual_text = {
        severity = { min = vim.diagnostic.severity.ERROR },
      },
      float = {
        source = true,
        border = "rounded",
        win_opts = {
          wrap = true, -- Enables line wrapping
          linebreak = true, -- Ensures wrapping occurs at word boundaries
        },
      },
    },
  },
}
