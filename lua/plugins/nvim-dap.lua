return {
  {
    "mfussenegger/nvim-dap",
    specs = {
      "AstroNvim/astrocore",
      cmd = { "DapContinue", "DapToggleBreakpoint", "DapTerminate" }, -- lazy load,

      opts = function(_, opts)
        -- Remove original <Leader>d bindings
        local leader_d_keys = {
          "b",
          "B",
          "c",
          "C",
          "i",
          "o",
          "O",
          "q",
          "Q",
          "p",
          "r",
          "R",
          "s",
          "E",
          "u",
          "h",
        }
        for _, k in ipairs(leader_d_keys) do
          opts.mappings.n["<Leader>d" .. k] = false
          opts.mappings.v["<Leader>d" .. k] = false
        end
        opts.mappings.n["<Leader>r"] = vim.tbl_get(opts, "_map_sections", "d")
        opts.mappings.n["<Leader>d"] = false
        opts.mappings.v["<Leader>d"] = false

        -- Add <Leader>r mappings (lazy, no require here)
        opts.mappings.n["<Leader>rb"] =
          { "<cmd>lua require('dap').toggle_breakpoint()<CR>", desc = "Toggle Breakpoint (F9)" }
        opts.mappings.n["<Leader>rB"] =
          { "<cmd>lua require('dap').clear_breakpoints()<CR>", desc = "Clear Breakpoints" }
        opts.mappings.n["<Leader>rc"] = { "<cmd>lua require('dap').continue()<CR>", desc = "Start/Continue (F5)" }
        opts.mappings.n["<Leader>rC"] = {
          "<cmd>lua vim.ui.input({ prompt = 'Condition: ' }, function(c) if c then require('dap').set_breakpoint(c) end end)<CR>",
          desc = "Conditional Breakpoint (S-F9)",
        }
        opts.mappings.n["<Leader>ri"] = { "<cmd>lua require('dap').step_into()<CR>", desc = "Step Into (F11)" }
        opts.mappings.n["<Leader>ro"] = { "<cmd>lua require('dap').step_over()<CR>", desc = "Step Over (F10)" }
        opts.mappings.n["<Leader>rO"] = { "<cmd>lua require('dap').step_out()<CR>", desc = "Step Out (S-F11)" }
        opts.mappings.n["<Leader>rq"] = { "<cmd>lua require('dap').close()<CR>", desc = "Close Session" }
        opts.mappings.n["<Leader>rQ"] = { "<cmd>lua require('dap').terminate()<CR>", desc = "Terminate Session (S-F5)" }
        opts.mappings.n["<Leader>rp"] = { "<cmd>lua require('dap').pause()<CR>", desc = "Pause (F6)" }
        opts.mappings.n["<Leader>rr"] = { "<cmd>lua require('dap').restart_frame()<CR>", desc = "Restart (C-F5)" }
        opts.mappings.n["<Leader>rR"] = { "<cmd>lua require('dap').repl.toggle()<CR>", desc = "Toggle REPL" }
        opts.mappings.n["<Leader>rs"] = { "<cmd>lua require('dap').run_to_cursor()<CR>", desc = "Run To Cursor" }
        opts.mappings.n["<Leader>rE"] = {
          "<cmd>lua vim.ui.input({ prompt = 'Expression: ' }, function(e) if e then require('dapui').eval(e, { enter = true }) end end)<CR>",
          desc = "Evaluate Input",
        }
        opts.mappings.n["<Leader>ru"] = { "<cmd>lua require('dapui').toggle()<CR>", desc = "Toggle Debugger UI" }
        opts.mappings.n["<Leader>rh"] = { "<cmd>lua require('dap.ui.widgets').hover()<CR>", desc = "Debugger Hover" }

        opts.mappings.v["<Leader>rE"] = { "<cmd>lua require('dapui').eval()<CR>", desc = "Evaluate Input" }
      end,
    },
  },
}
