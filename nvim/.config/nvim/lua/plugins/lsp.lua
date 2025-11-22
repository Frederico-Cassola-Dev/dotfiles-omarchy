-- Change default lazyvim distro parameters of LSP diagnostics and inlay_hints
return {
	"neovim/nvim-lspconfig",
	opts = {
		-- Option to disable at startup the inlay hints feature of LSP
		inlay_hints = {
			enabled = false,
		},
		-- Option to disable virtual text for LSP diagnostics
		diagnostics = {
			virtual_text = false,
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
