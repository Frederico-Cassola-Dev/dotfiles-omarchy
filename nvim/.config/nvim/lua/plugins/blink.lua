return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        -- Show documentation when a completion item is selected
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        -- Display icons for completion items
        menu = {
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
          },
        },
      },
      -- Enable signature help (parameter hints)
      signature = { enabled = true },
    },
  },
}
