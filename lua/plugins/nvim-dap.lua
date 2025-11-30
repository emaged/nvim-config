return {
  {
    "mfussenegger/nvim-dap",
    lazy = true,

    config = function()
      ---------------------------------------------------------
      -- 1. PYTHON DAP CONFIG (AUTO-DETECT VENV)
      ---------------------------------------------------------
      local dap = require "dap"

      dap.adapters.python = {
        type = "executable",
        command = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python",
        args = { "-m", "debugpy.adapter" },
      }

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch current file",
          program = "${file}",
          console = "integratedTerminal",
          pythonPath = function()
            if vim.env.VIRTUAL_ENV then return vim.env.VIRTUAL_ENV .. "/bin/python" end

            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
              return cwd .. "/venv/bin/python"
            elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
              return cwd .. "/.venv/bin/python"
            end

            return "python"
          end,
        },
      }

      ---------------------------------------------------------
      -- 2. RESTORE DAP-UI AUTO OPEN/CLOSE (OPTIONAL)
      ---------------------------------------------------------
      local ok_dapui, dapui = pcall(require, "dapui")
      if ok_dapui then
        dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
        dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
        dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
      end
    end,
  },
}
