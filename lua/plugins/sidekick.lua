local prefix = "<leader>O"

return {
  "folke/sidekick.nvim",
  event = "User AstroFile",

  opts = {
    nes = { enabled = false },
    cli = {
      mux = {
        backend = "tmux",
        enabled = true,
      },
    },
  },

  keys = function(_, keys)
    -- Rebuild the keymap using the new prefix
    return vim.list_extend({
      {
        "<c-.>",
        function() require("sidekick.cli").toggle() end,
        desc = "Sidekick Toggle",
        mode = { "n", "t", "i", "x" },
      },
      {
        prefix .. "a",
        function() require("sidekick.cli").toggle() end,
        desc = "Sidekick Toggle CLI",
      },
      {
        prefix .. "s",
        function() require("sidekick.cli").select() end,
        desc = "Select CLI",
      },
      {
        prefix .. "d",
        function() require("sidekick.cli").close() end,
        desc = "Detach CLI Session",
      },
      {
        prefix .. "t",
        function() require("sidekick.cli").send { msg = "{this}" } end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        prefix .. "f",
        function() require("sidekick.cli").send { msg = "{file}" } end,
        desc = "Send File",
      },
      {
        prefix .. "v",
        function() require("sidekick.cli").send { msg = "{selection}" } end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
      {
        prefix .. "p",
        function() require("sidekick.cli").prompt() end,
        mode = { "n", "x" },
        desc = "Sidekick Prompt",
      },
      {
        prefix .. "c",
        function() require("sidekick.cli").toggle { name = "claude", focus = true } end,
        desc = "Sidekick Toggle Claude",
      },
    }, keys)
  end,

  -- replace "specs" with proper AstroNvim-style overrides
  dependencies = {
    -- Add the which-key group
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        opts.mappings = opts.mappings or {}
        opts.mappings.n = opts.mappings.n or {}

        opts.mappings.n[prefix] = {
          desc = require("astroui").get_icon("sidekick", 1, true) .. "Sidekick",
        }
      end,
    },

    -- add icon
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
