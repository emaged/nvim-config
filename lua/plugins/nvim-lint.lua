return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      lua = { "selene" },
      html = { "eslint_d", "htmlhint" },
      css = { "stylelint", "eslint_d" },
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      python = { "ruff" },
      htmldjango = { "djlint" },
      jinja = { "djlint" },
      ["jinja-html"] = { "djlint" },
    },
    linters = {
      selene = {
        cmd = "selene",
        stdin = false,
        args = function(ctx)
          -- Find selene.toml starting from the file location
          local config = vim.fs.find("selene.toml", {
            path = vim.fn.fnamemodify(ctx.filename, ":h"),
            upward = true,
            type = "file",
          })[1]

          -- If no config found, Selene will use defaults
          if config then
            return { "--config", config, ctx.filename }
          else
            return { ctx.filename }
          end
        end,
      },
      eslint_d = (function()
        -- resolve to a string now (not a function) so astrocommunity’s check is happy
        local local_bin = vim.fn.fnamemodify("./node_modules/.bin/eslint_d", ":p")
        local cmd = vim.loop.fs_stat(local_bin) and local_bin or "eslint_d"

        return {
          cmd = cmd, -- string, not function
          stdin = true,
          args = {
            "--format",
            "json",
            "--stdin",
            "--stdin-filename",
            function() return vim.api.nvim_buf_get_name(0) end,
          },
          stream = "stdout",
          ignore_exitcode = true,
          parser = function(output, bufnr)
            if string.find(output, "Error: Could not find config file") then return {} end
            local result = require("lint.linters.eslint").parser(output, bufnr)
            for _, d in ipairs(result) do
              d.source = "eslint_d"
            end
            return result
          end,
        }
      end)(),

      stylelint = (function()
        local severities = {
          warning = vim.diagnostic.severity.WARN,
          error = vim.diagnostic.severity.ERROR,
        }

        -- Convert original cmd() function into a static string
        local function resolve_cmd()
          local local_bin = vim.fn.fnamemodify("./node_modules/.bin/stylelint", ":p")
          if vim.loop.fs_stat(local_bin) then return local_bin end
          return "stylelint"
        end

        local resolved_cmd = resolve_cmd()

        return {
          cmd = resolved_cmd, -- MUST be a string for AstroNvim
          stdin = true,
          args = {
            "-f",
            "json",
            "--stdin",
            "--stdin-filename",
            function() return vim.fn.expand "%:p" end,
          },
          stream = "both",
          ignore_exitcode = true,

          parser = function(output)
            local ok, decoded = pcall(vim.json.decode, output)
            if ok then
              decoded = decoded[1]
            else
              decoded = {
                warnings = {
                  {
                    line = 1,
                    column = 1,
                    text = "Stylelint error — run `stylelint " .. vim.fn.expand "%" .. "` for details.",
                    severity = "error",
                    rule = "none",
                  },
                },
                errored = true,
              }
            end

            local diagnostics = {}

            for _, message in ipairs(decoded.warnings or {}) do
              table.insert(diagnostics, {
                lnum = message.line - 1,
                col = message.column - 1,
                end_lnum = message.line - 1,
                end_col = message.column - 1,
                message = message.text,
                code = message.rule,
                user_data = { lsp = { code = message.rule } },
                severity = severities[message.severity] or vim.diagnostic.severity.WARN,
                source = "stylelint",
              })
            end

            return diagnostics
          end,
        }
      end)(),
    },
  },
}
