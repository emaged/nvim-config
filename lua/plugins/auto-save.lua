return {
  "okuuva/auto-save.nvim",
  event = { "User AstroFile", "InsertEnter" },
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      autocmds = {
        autoformat_toggle = {
          -- Disable autoformat before saving
          {
            event = "User",
            desc = "Disable autoformat before saving",
            pattern = "AutoSaveWritePre",
            callback = function()
              -- Save global autoformat status
              vim.g.OLD_AUTOFORMAT = vim.g.autoformat
              vim.g.autoformat = false

              local old_autoformat_buffers = {}
              -- Disable all manually enabled buffers
              for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
                if vim.b[bufnr].autoformat then
                  table.insert(old_autoformat_buffers, bufnr)
                  vim.b[bufnr].autoformat = false
                end
              end

              vim.g.OLD_AUTOFORMAT_BUFFERS = old_autoformat_buffers
            end,
          },
          -- Re-enable autoformat after saving
          {
            event = "User",
            desc = "Re-enable autoformat after saving",
            pattern = "AutoSaveWritePost",
            callback = function()
              -- Restore global autoformat status
              vim.g.autoformat = vim.g.OLD_AUTOFORMAT
              -- Re-enable all manually enabled buffers
              for _, bufnr in ipairs(vim.g.OLD_AUTOFORMAT_BUFFERS or {}) do
                vim.b[bufnr].autoformat = true
              end
            end,
          },
        },
      },
    },
  },
  -- ADD THIS BLOCK ↓↓↓
  config = function(_, opts)
    -- set up the plugin with its opts
    require("auto-save").setup(opts)

    -- your custom autocmds
    local group = vim.api.nvim_create_augroup("autosave", {})

    vim.api.nvim_create_autocmd("User", {
      pattern = "AutoSaveEnable",
      group = group,
      callback = function() vim.notify("AutoSave enabled", vim.log.levels.INFO) end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "AutoSaveDisable",
      group = group,
      callback = function() vim.notify("AutoSave disabled", vim.log.levels.INFO) end,
    })
  end,
  -- END BLOCK ↑↑↑
  opts = {
    condition = function(buf)
      -- when using fyler enable this:
      -- if vim.tbl_contains({
      --   "Fyler",
      -- }, vim.fn.getbufvar(buf, "&filetype")) then return false end

      -- 1. Set Excludes
      local excluded_filetypes = {
        "gitcommit",
        "NvimTree",
        "Outline",
        "TelescopePrompt",
        "alpha",
        "dashboard",
        "lazygit",
        "neo-tree",
        "oil",
        "prompt",
        "toggleterm",
      }

      local excluded_filenames = {
        "do-not-autosave-me.lua",
      }

      -- 2. GET FILE PATH
      local filepath = vim.api.nvim_buf_get_name(buf)
      if filepath == "" then return false end

      -- exclude certain filetypes
      if vim.tbl_contains(excluded_filetypes, vim.bo[buf].filetype) then return false end

      -- exclude by filename
      local filename = vim.fn.fnamemodify(filepath, ":t")
      if vim.tbl_contains(excluded_filenames, filename) then return false end

      -- 3. ONLY AUTOSAVE IN ~/projects
      local root = vim.fn.expand "~/projects"
      if filepath:find(root, 1, true) ~= 1 then return false end

      -- 4. ONLY AUTOSAVE WRITABLE FILE BUFFERS
      if vim.bo[buf].buftype ~= "" then return false end
      -- this is checked by auto-save.nvim
      -- if not vim.bo[buf].modifiable then return false end
      if vim.bo[buf].readonly then return false end

      return true
    end,
  },
  keys = {
    { "<Leader>W", "<cmd>ASToggle<CR>", desc = "Toggle auto-save" },
  },
}
