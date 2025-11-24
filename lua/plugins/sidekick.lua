local prefix = "<leader>O"

return {
  "folke/sidekick.nvim",
  opts = {
    -- add any options here
    cli = {
      mux = {
        backend = "tmux",
        enabled = true,
      },
    },
  },
  keys = {
    {
      "<tab>",
      function()
        -- if there is a next edit, jump to it, otherwise apply it if any
        if not require("sidekick").nes_jump_or_apply() then
          return "<Tab>" -- fallback to normal tab
        end
      end,
      expr = true,
      desc = "Goto/Apply Next Edit Suggestion",
    },
    {
      "<c-.>",
      function() require("sidekick.cli").toggle() end,
      desc = "Sidekick Toggle",
      mode = { "n", "t", "i", "x" },
    },
    {
      "<leader>Oa",
      function() require("sidekick.cli").toggle() end,
      desc = "Sidekick Toggle CLI",
    },
    {
      "<leader>Os",
      function() require("sidekick.cli").select() end,
      -- Or to select only installed tools:
      -- require("sidekick.cli").select({ filter = { installed = true } })
      desc = "Select CLI",
    },
    {
      "<leader>Od",
      function() require("sidekick.cli").close() end,
      desc = "Detach a CLI Session",
    },
    {
      "<leader>Ot",
      function() require("sidekick.cli").send { msg = "{this}" } end,
      mode = { "x", "n" },
      desc = "Send This",
    },
    {
      "<leader>Of",
      function() require("sidekick.cli").send { msg = "{file}" } end,
      desc = "Send File",
    },
    {
      "<leader>Ov",
      function() require("sidekick.cli").send { msg = "{selection}" } end,
      mode = { "x" },
      desc = "Send Visual Selection",
    },
    {
      "<leader>Op",
      function() require("sidekick.cli").prompt() end,
      mode = { "n", "x" },
      desc = "Sidekick Select Prompt",
    },
    -- Example of a keybinding to open Claude directly
    {
      "<leader>Oc",
      function() require("sidekick.cli").toggle { name = "claude", focus = true } end,
      desc = "Sidekick Toggle Claude",
    },
  },
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        opts.mappings = opts.mappings or {}
        opts.mappings.n = opts.mappings.n or {}

        -- Add Sidekick group name + icon to which-key
        opts.mappings.n[prefix] = {
          desc = require("astroui").get_icon("sidekick", 1, true) .. "Sidekick",
        }
      end,
    },

    -- Add the icon itself
    {
      "AstroNvim/astroui",
      opts = {
        icons = {
          sidekick = "󱙺",
        },
      },
    },
  },
}
