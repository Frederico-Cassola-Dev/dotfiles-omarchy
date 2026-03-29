return {
  -- Configure Mason
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "phpactor",
        "php-cs-fixer",
        "twig-cs-fixer",
        "phpstan",
        "php-debug-adapter",
      })
    end,
  },

  -- Configure LSP for PHP and Twig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          -- settings for intelephense
          settings = {
            intelephense = {
              completion = {
                fullyQualifyImportedSymbols = true,
              },
              diagnostics = {
                enable = true,
              },
            },
          },
        },
        phpactor = {
          -- settings for phpactor
          settings = {
            phpactor = {
              language_server_php_cs_fixer = {
                enabled = true,
              },
              language_server_phpstan = {
                enabled = true,
              },
            },
          },
        },
        twigls = {},
      },
    },
  },

  -- Configure formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        php = { "php-cs-fixer" },
        twig = { "twig-cs-fixer" },
      },
      formatters = {
        ["php-cs-fixer"] = {
          command = "php-cs-fixer",
          args = {
            "fix",
            "$FILENAME",
            "--rules=@PSR12", -- Use Symfony coding standards
          },
          stdin = false,
        },
        ["twig-cs-fixer"] = {
          command = "twig-cs-fixer",
          args = {
            "fix",
            "$FILENAME",
          },
          stdin = false,
        },
      },
    },
  },
}
