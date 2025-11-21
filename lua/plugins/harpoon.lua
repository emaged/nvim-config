return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },

  config = function()
    local harpoon = require "harpoon"
    harpoon:setup {}

    ---------------------------------------------------------------------------
    -- Telescope integration
    ---------------------------------------------------------------------------
    local conf = require("telescope.config").values

    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    ---------------------------------------------------------------------------
    -- Harpoon extensions
    ---------------------------------------------------------------------------

    harpoon:extend {
      UI_CREATE = function(cx)
        vim.keymap.set(
          "n",
          "<A-v>",
          function() harpoon.ui:select_menu_item { vsplit = true } end,
          { buffer = cx.bufnr }
        )

        vim.keymap.set("n", "<A-x>", function() harpoon.ui:select_menu_item { split = true } end, { buffer = cx.bufnr })

        vim.keymap.set(
          "n",
          "<A-t>",
          function() harpoon.ui:select_menu_item { tabedit = true } end,
          { buffer = cx.bufnr }
        )
      end,
    }

    ---------------------------------------------------------------------------
    -- Harpoon keymaps
    ---------------------------------------------------------------------------

    -- Add file to Harpoon
    vim.keymap.set("n", "<A-a>", function() harpoon:list():add() end, { desc = "Harpoon Add File" })

    -- Harpoon quick menu (built-in UI)
    vim.keymap.set(
      "n",
      "<A-e>",
      function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { desc = "Harpoon Quick Menu" }
    )

    -- Telescope version (optional alternative)
    vim.keymap.set(
      "n",
      "<leader>te",
      function() toggle_telescope(harpoon:list()) end,
      { desc = "Harpoon Telescope Menu" }
    )

    -- Direct navigation to Harpoon slots
    vim.keymap.set("n", "<A-h>", function() harpoon:list():select(1) end, { desc = "Harpoon Jump 1" })

    vim.keymap.set("n", "<A-t>", function() harpoon:list():select(2) end, { desc = "Harpoon Jump 2" })

    vim.keymap.set("n", "<A-n>", function() harpoon:list():select(3) end, { desc = "Harpoon Jump 3" })

    vim.keymap.set("n", "<A-s>", function() harpoon:list():select(4) end, { desc = "Harpoon Jump 4" })

    -- Previous / next navigation
    vim.keymap.set("n", "<A-S-P>", function() harpoon:list():prev() end, { desc = "Harpoon Previous" })

    vim.keymap.set("n", "<A-S-N>", function() harpoon:list():next() end, { desc = "Harpoon Next" })
  end,
}
