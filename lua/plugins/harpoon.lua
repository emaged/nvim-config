return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/snacks.nvim",
    },
    keys = {
      { "<A-a>", function() require("harpoon"):list():add() end, desc = "Harpoon Add File" },
      {
        "<A-e>",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon Menu",
      },
      {
        "<Leader>H",
        function()
          local harpoon = require("harpoon")
          local Snacks = require("snacks")

          local function harpoon_finder()
            local list = harpoon:list()
            local results = {}
            for i = 1, list:length() do
              local item = list.items[i]
              if item then
                results[#results + 1] = {
                  text = item.value,
                  file = item.value,
                }
              end
            end
            return results
          end

          local function harpoon_delete(picker, item)
            local target = item or picker:selected()
            if not target then return end
            harpoon:list():remove { value = target.text }
            picker:find { refresh = true }
          end

          Snacks.picker {
            finder = harpoon_finder,
            win = {
              input = { keys = { ["dd"] = { "harpoon_delete", mode = "n" } } },
              list = { keys = { ["dd"] = { "harpoon_delete", mode = "n" } } },
            },
            actions = { harpoon_delete = harpoon_delete },
          }
        end,
        desc = "Harpoon Snacks Picker",
      },
      { "<A-h>", function() require("harpoon"):list():select(1) end, desc = "Harpoon Jump 1" },
      { "<A-t>", function() require("harpoon"):list():select(2) end, desc = "Harpoon Jump 2" },
      { "<A-n>", function() require("harpoon"):list():select(3) end, desc = "Harpoon Jump 3" },
      { "<A-s>", function() require("harpoon"):list():select(4) end, desc = "Harpoon Jump 4" },
    },

    config = function()
      local harpoon = require "harpoon"
      harpoon:setup()
    end,
  },
  {
    "catppuccin",
    optional = true,
    ---@type CatppuccinOptions
    opts = {
      integrations = {
        harpoon = true,
      },
    },
  },
}
