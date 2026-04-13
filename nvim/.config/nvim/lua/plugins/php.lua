return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, { "phpdoc" })
    end,
  },

  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "intelephense",
        "php-cs-fixer",
        "phpcs",
        "phpstan",
        "php-debug-adapter",
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          settings = {
            intelephense = {
              files = {
                maxSize = 5000000,
                exclude = {
                  "**/node_modules/**",
                  "**/var/cache/**",
                  "**/var/log/**",
                  "**/.git/**",
                },
              },
              environment = {
                phpVersion = "8.5.0",
                shortOpenTag = true,
              },
              diagnostics = {
                enable = true,
                run = "onType",
              },
              completion = {
                fullyQualifyImportedSymbols = true,
                insertUseDeclaration = true,
              },
              format = {
                enable = false,
              },
            },
          },
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local util = require("conform.util")
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      -- Separate name + inherit=false: built-in `php_cs_fixer` merges with find_executable and
      -- still prefers vendor/bin (Composer platform_check vs system PHP). Mason ships a PHAR.
      opts.formatters_by_ft.php = { "php_cs_fixer_mason" }
      opts.formatters = opts.formatters or {}
      opts.formatters.php_cs_fixer_mason = {
        inherit = false,
        command = function()
          local mason = vim.fn.stdpath("data") .. "/mason/bin/php-cs-fixer"
          if vim.fn.executable(mason) == 1 then
            return mason
          end
          return "php-cs-fixer"
        end,
        args = { "fix", "$FILENAME" },
        stdin = false,
        cwd = util.root_file({ "composer.json" }),
      }
    end,
  },

  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      -- `php` runs `php -l` and reports parse errors (e.g. missing `}` before catch).
      opts.linters_by_ft.php = { "php", "phpcs", "phpstan" }
    end,
  },
}
