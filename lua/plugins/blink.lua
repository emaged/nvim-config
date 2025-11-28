-- lua/plugins/blink.lua
return {
  { -- override blink.cmp plugin
    "Saghen/blink.cmp",
    opts = {
      -- your normal blink settings (optional)
      -- completion = { ... },
      -- sources = { ... },
      -- keymap = { ... },
      completion = {
        list = {
          selection = {
            preselect = true, -- auto-select the first candidate
            auto_insert = false, -- keep this OFF unless you want auto-insertion on highlight
          },
        },
      },
      -- enable ghost text
      cmdline = { completion = { ghost_text = { enabled = true } } },
    },
  },
}
