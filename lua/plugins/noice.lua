return {
  "folke/noice.nvim",
  event = "VeryLazy",
  keys = {
    -- Clear search + dismiss Noice
    {
      "<Esc>",
      function()
        -- run your actions
        vim.cmd "nohlsearch"
        vim.cmd "NoiceDismiss"

        -- return <Esc> so Flash sees it
        return "<Esc>"
      end,
      mode = "n",
      expr = true, -- THIS is required so the return value is sent as keys
      silent = true,
      desc = "Clear search + dismiss Noice",
    },
    {
      "<leader>N",
      mode = "n",
      silent = true,
      desc = " Noice",
    },
    -- Noice last message
    {
      "<leader>Nl",
      function() require("noice").cmd "last" end,
      mode = "n",
      desc = "Noice Last Message",
    },
    -- Noice message history
    {
      "<leader>Nh",
      function() require("noice").cmd "history" end,
      mode = "n",
      desc = "Noice History",
    },
    -- Redirect commandline with Shift-Enter
    {
      "<S-Enter>",
      function() require("noice").redirect(vim.fn.getcmdline()) end,
      mode = "c",
      desc = "Redirect Cmdline",
    },
    -- Noice LSP scrolling (<C-f>)
    {
      "<C-f>",
      function()
        if not require("noice.lsp").scroll(4) then return "<C-f>" end
      end,
      mode = { "n", "i", "s" },
      expr = true,
      silent = true,
      desc = "Noice LSP scroll (down)",
    },
    -- Noice LSP scrolling (<C-b>)
    {
      "<C-b>",
      function()
        if not require("noice.lsp").scroll(-4) then return "<C-b>" end
      end,
      mode = { "n", "i", "s" },
      expr = true,
      silent = true,
      desc = "Noice LSP scroll (up)",
    },
  },
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = function(_, opts)
    local utils = require "astrocore"
    return utils.extend_tbl(opts, {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = utils.is_available "inc-rename.nvim", -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    })
  end,
  specs = {
    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if opts.ensure_installed ~= "all" then
          opts.ensure_installed = require("astrocore").list_insert_unique(
            opts.ensure_installed,
            { "bash", "markdown", "markdown_inline", "regex", "vim" }
          )
        end
      end,
    },
    {
      "AstroNvim/astrolsp",
      optional = true,
      ---@param opts AstroLSPOpts
      opts = function(_, opts)
        local noice_opts = require("astrocore").plugin_opts "noice.nvim"
        -- disable the necessary handlers in AstroLSP
        if not opts.defaults then opts.defaults = {} end
        -- TODO: remove lsp_handlers when dropping support for AstroNvim v4
        if not opts.lsp_handlers then opts.lsp_handlers = {} end
        if vim.tbl_get(noice_opts, "lsp", "hover", "enabled") ~= false then
          opts.defaults.hover = false
          opts.lsp_handlers["textDocument/hover"] = false
        end
        if vim.tbl_get(noice_opts, "lsp", "signature", "enabled") ~= false then
          opts.defaults.signature_help = false
          opts.lsp_handlers["textDocument/signatureHelp"] = false
          if not opts.features then opts.features = {} end
          opts.features.signature_help = false
        end
      end,
    },
    {
      "folke/edgy.nvim",
      optional = true,
      opts = function(_, opts)
        if not opts.bottom then opts.bottom = {} end
        table.insert(opts.bottom, {
          ft = "noice",
          size = { height = 0.4 },
          filter = function(_, win) return vim.api.nvim_win_get_config(win).relative == "" end,
        })
      end,
    },
    {
      "catppuccin",
      optional = true,
      ---@type CatppuccinOptions
      opts = { integrations = { noice = true } },
    },
  },
}
