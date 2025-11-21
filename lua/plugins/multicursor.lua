return {
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    event = "VeryLazy",
    cond = true,
    config = function()
      local mc = require "multicursor-nvim"
      mc.setup()
      local set = vim.keymap.set

      -- Add or skip cursor above/below the main cursor.
      set({ "n", "x" }, "<up>", function() mc.lineAddCursor(-1) end)
      set({ "n", "x" }, "<down>", function() mc.lineAddCursor(1) end)
      set({ "n", "x" }, "<leader><up>", function() mc.lineSkipCursor(-1) end, { desc = "Skip cursor above" })
      set({ "n", "x" }, "<leader><down>", function() mc.lineSkipCursor(1) end, { desc = "Skip cursor below" })

      -- Add or skip adding a new cursor by matching word/selection
      set({ "n", "x" }, "<leader>m", function() mc.matchAddCursor(1) end, { desc = "Add cursor on match forward" })
      set({ "n", "x" }, "<leader>z", function() mc.matchSkipCursor(1) end, { desc = "Skip cursor on match forward" })
      set({ "n", "x" }, "<leader>M", function() mc.matchAddCursor(-1) end, { desc = "Add cursor on match backward" })
      set({ "n", "x" }, "<leader>Z", function() mc.matchSkipCursor(-1) end, { desc = "Skip cursor on match backward" }) -- Advanced Actions

      -- Add a cursor for all matches of cursor word/selection in the document.
      set({ "n", "x" }, "<leader>A", mc.matchAllAddCursors)

      -- Append/insert for each line of visual selections.
      -- Similar to block selection insertion.
      set("x", "I", mc.insertVisual)
      set("x", "A", mc.appendVisual)

      -- Add a cursor and jump to the next/previous search result.
      set("n", "<leader>/m", function() mc.searchAddCursor(1) end)
      set("n", "<leader>/M", function() mc.searchAddCursor(-1) end)

      -- Jump to the next/previous search result without adding a cursor.
      set("n", "<leader>/z", function() mc.searchSkipCursor(1) end)
      set("n", "<leader>/Z", function() mc.searchSkipCursor(-1) end)

      -- Add a cursor to every search result in the buffer.
      set("n", "<leader>/A", mc.searchAllAddCursors)

      -- Add and remove cursors with control + left click.
      set("n", "<c-leftmouse>", mc.handleMouse)
      set("n", "<c-leftdrag>", mc.handleMouseDrag)
      set("n", "<c-leftrelease>", mc.handleMouseRelease)

      -- Disable and enable cursors.
      set({ "n", "x" }, "gm", mc.toggleCursor)

      -- Mappings defined in a keymap layer only apply when there are
      -- multiple cursors. This lets you have overlapping mappings.
      mc.addKeymapLayer(function(layerSet)
        -- Select a different cursor as the main one.
        layerSet({ "n", "x" }, "<left>", mc.prevCursor)
        layerSet({ "n", "x" }, "<right>", mc.nextCursor)

        -- Delete the main cursor.
        layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

        -- Enable and clear cursors using escape.
        layerSet("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)

      -- Customize how cursors look.
      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", {
        reverse = true,
      })
      hl(0, "MultiCursorVisual", {
        link = "Visual",
      })
      hl(0, "MultiCursorSign", {
        link = "SignColumn",
      })
      hl(0, "MultiCursorMatchPreview", {
        link = "Search",
      })
      hl(0, "MultiCursorDisabledCursor", {
        reverse = true,
      })
      hl(0, "MultiCursorDisabledVisual", {
        link = "Visual",
      })
      hl(0, "MultiCursorDisabledSign", {
        link = "SignColumn",
      })
    end,
  },
}
