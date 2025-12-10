return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/snacks.nvim",
    },

    config = function()
      local harpoon = require "harpoon"
      local Snacks = require "snacks"
      harpoon:setup()

      ---------------------------------------------------------------------------
      -- util: normalize table indices (Harpoon creates sparse lists)
      ---------------------------------------------------------------------------
      local function normalize_list(t)
        local norm = {}
        for i = 1, #t do
          if t[i] ~= nil then norm[#norm + 1] = t[i] end
        end
        return norm
      end

      ---------------------------------------------------------------------------
      -- Snacks picker finder for Harpoon items
      ---------------------------------------------------------------------------
      local function harpoon_finder()
        local items = normalize_list(harpoon:list().items)
        local results = {}

        for _, item in ipairs(items) do
          results[#results + 1] = {
            text = item.value,
            file = item.value,
          }
        end

        return results
      end

      ---------------------------------------------------------------------------
      -- Snacks picker action for deleting items
      ---------------------------------------------------------------------------
      local function harpoon_delete(picker, item)
        local target = item or picker:selected()
        if not target then return end

        -- Remove by value (Harpoon v2)
        harpoon:list():remove { value = target.text }

        -- Normalize after deletion
        harpoon:list().items = normalize_list(harpoon:list().items)

        -- Refresh picker UI
        picker:find { refresh = true }
      end

      ---------------------------------------------------------------------------
      -- Keymaps for Harpoon
      ---------------------------------------------------------------------------
      vim.keymap.set("n", "<A-a>", function() harpoon:list():add() end, { desc = "Harpoon Add File" })

      vim.keymap.set(
        "n",
        "<A-e>",
        function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
        { desc = "Harpoon Menu" }
      )

      ---------------------------------------------------------------------------
      -- Snacks picker for Harpoon
      ---------------------------------------------------------------------------
      vim.keymap.set(
        "n",
        "<Leader>H",
        function()
          Snacks.picker {
            finder = harpoon_finder,

            win = {
              input = {
                keys = {
                  ["dd"] = { "harpoon_delete", mode = "n" },
                },
              },
              list = {
                keys = {
                  ["dd"] = { "harpoon_delete", mode = "n" },
                },
              },
            },

            actions = {
              harpoon_delete = harpoon_delete,
            },
          }
        end,
        { desc = "Harpoon Snacks Picker" }
      )

      ---------------------------------------------------------------------------
      -- Jump mappings
      ---------------------------------------------------------------------------
      vim.keymap.set("n", "<A-h>", function() harpoon:list():select(1) end, { desc = "Harpoon Jump 1" })
      vim.keymap.set("n", "<A-t>", function() harpoon:list():select(2) end, { desc = "Harpoon Jump 2" })
      vim.keymap.set("n", "<A-n>", function() harpoon:list():select(3) end, { desc = "Harpoon Jump 3" })
      vim.keymap.set("n", "<A-s>", function() harpoon:list():select(4) end, { desc = "Harpoon Jump 4" })
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
