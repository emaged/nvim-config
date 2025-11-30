return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- this will be removed in the next major release
    ui = { enable = false },

    workspaces = {
      {
        name = "work",
        path = "~/Dropbox/Vault",
      },
    },
    -- see below for full list of options 👇
  },
  -- run before the plugin loads to block its LSP
  init = function()
    package.loaded["obsidian.lsp"] = nil
    package.preload["obsidian.lsp"] = function()
      return { start = function() return nil end }
    end
  end,
}
