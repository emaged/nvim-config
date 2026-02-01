return {
  "obsidian-nvim/obsidian.nvim",
  -- version = "*", -- recommended, use latest release instead of latest commit
  -- ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  event = { "BufReadPre  */Dropbox/Vault/*.md" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["gf"] = {
              function()
                if require("obsidian").util.cursor_on_markdown_link() then
                  return "<Cmd>Obsidian follow_link<CR>"
                else
                  return "gf"
                end
              end,
              desc = "Obsidian Follow Link",
            },
          },
        },
      },
    },
  },
  opts = function(_, opts)
    local astrocore = require "astrocore"
    return astrocore.extend_tbl(opts, {
      legacy_commands = false, -- this will be removed in the next major release
      ui = { enable = false },

      workspaces = {
        {
          path = vim.env.HOME .. "/Dropbox/Vault", -- specify the vault location. no need to call 'vim.fn.expand' here
        },
      },
      open = {
        use_advanced_uri = true,
      },
      finder = (astrocore.is_available "snacks.pick" and "snacks.pick")
        or (astrocore.is_available "telescope.nvim" and "telescope.nvim")
        or (astrocore.is_available "fzf-lua" and "fzf-lua")
        or (astrocore.is_available "mini.pick" and "mini.pick"),

      templates = {
        subdir = "templates",
        date_format = "%Y-%m-%d-%a",
        time_format = "%H:%M",
      },
      daily_notes = {
        folder = "daily",
      },
      completion = {
        nvim_cmp = astrocore.is_available "nvim-cmp",
        blink = astrocore.is_available "blink",
      },

      frontmatter = { -- ai version
        func = function(note)
          local out = { id = note.id, aliases = note.aliases, tags = note.tags }
          if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
            for k, v in pairs(note.metadata) do
              out[k] = v
            end
          end
          return out
        end,
      },

      -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
      -- URL it will be ignored but you can customize this behavior here.
      -- follow_url_func = vim.ui.open, -- deprecated
    })
  end,
  ---@module 'obsidian'
  ---@type obsidian.config
  -- opts = {
  --   legacy_commands = false, -- this will be removed in the next major release
  --   ui = { enable = false },
  --
  --   workspaces = {
  --     {
  --       name = "work",
  --       path = "~/Dropbox/Vault",
  --     },
  --   },
  --   -- see below for full list of options 👇
  -- },
  -- run before the plugin loads to block its LSP
  init = function()
    package.loaded["obsidian.lsp"] = nil
    package.preload["obsidian.lsp"] = function()
      return { start = function() return nil end }
    end
  end,
}
