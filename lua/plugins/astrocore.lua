--if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        foo = "fooscript",
      },
      filename = {
        [".foorc"] = "fooscript",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,

        -- Remove all default DAP mappings from <leader>d
        ["<Leader>d"] = false,
        ["<Leader>db"] = false,
        ["<Leader>dB"] = false,
        ["<Leader>dc"] = false,
        ["<Leader>dC"] = false,
        ["<Leader>di"] = false,
        ["<Leader>do"] = false,
        ["<Leader>dO"] = false,
        ["<Leader>dq"] = false,
        ["<Leader>dQ"] = false,
        ["<Leader>dp"] = false,
        ["<Leader>dr"] = false,
        ["<Leader>dR"] = false,
        ["<Leader>ds"] = false,
        ["<Leader>dE"] = false,
        ["<Leader>du"] = false,
        ["<Leader>dh"] = false,

        -- setting Noice which-key group
        ["<leader>N"] = { desc = " Noice" },

        -- set DAP mappings to <leader>r
        -- DAP on <Leader>r
        ["<leader>r"] = {
          desc = " Debugger",
        },

        ["<Leader>rb"] = {
          function() require("dap").toggle_breakpoint() end,
          desc = "Toggle Breakpoint (F9)",
        },

        ["<Leader>rB"] = {
          function() require("dap").clear_breakpoints() end,
          desc = "Clear Breakpoints",
        },

        ["<Leader>rc"] = {
          function() require("dap").continue() end,
          desc = "Start/Continue (F5)",
        },

        ["<Leader>rC"] = {
          function()
            vim.ui.input({ prompt = "Condition: " }, function(c)
              if c then require("dap").set_breakpoint(c) end
            end)
          end,
          desc = "Conditional Breakpoint (S-F9)",
        },

        ["<Leader>ri"] = {
          function() require("dap").step_into() end,
          desc = "Step Into (F11)",
        },

        ["<Leader>ro"] = {
          function() require("dap").step_over() end,
          desc = "Step Over (F10)",
        },

        ["<Leader>rO"] = {
          function() require("dap").step_out() end,
          desc = "Step Out (S-F11)",
        },

        ["<Leader>rq"] = {
          function() require("dap").close() end,
          desc = "Close Session",
        },

        ["<Leader>rQ"] = {
          function() require("dap").terminate() end,
          desc = "Terminate Session (S-F5)",
        },

        ["<Leader>rp"] = {
          function() require("dap").pause() end,
          desc = "Pause (F6)",
        },

        ["<Leader>rr"] = {
          function() require("dap").restart_frame() end,
          desc = "Restart Frame (C-F5)",
        },

        ["<Leader>rR"] = {
          function() require("dap").repl.toggle() end,
          desc = "Toggle REPL",
        },

        ["<Leader>rs"] = {
          function() require("dap").run_to_cursor() end,
          desc = "Run To Cursor",
        },

        ["<Leader>rE"] = {
          function()
            vim.ui.input({ prompt = "Expression: " }, function(expr)
              if expr then require("dapui").eval(expr, { enter = true }) end
            end)
          end,
          desc = "Evaluate Input",
        },

        ["<Leader>ru"] = {
          function() require("dapui").toggle() end,
          desc = "Toggle Debugger UI",
        },

        ["<Leader>rh"] = {
          function() require("dap.ui.widgets").hover() end,
          desc = "Debugger Hover",
        },
      },
      v = {
        ["<Leader>dE"] = false,
        -- nvim-dap remap
        ["<Leader>rE"] = {
          function() require("dapui").eval() end,
          desc = "Evaluate Selection",
        },
      },
    },
  },
}
