--if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- TODO: AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    capabilities = {
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      },
    },
    -- Configuration table of features provided by AstroLSP
    features = {
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      "codebook",
      "djlsp",
      -- "pyrefly",
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      codebook = {
        cmd = { "codebook-lsp", "serve" },
        filetypes = {
          "c",
          "cpp",
          "css",
          "gitcommit",
          "go",
          "haskell",
          "html",
          "htmldjango",
          "java",
          "javascript",
          "javascriptreact",
          "lua",
          "markdown",
          "php",
          "python",
          "ruby",
          "rust",
          "toml",
          "text",
          "typescript",
          "typescriptreact",
        },
        root_markers = { ".git", "codebook.toml", ".codebook.toml" },
        -- use closest codebook.toml file, starting at file itself not project folder
        root_dir = function(fname)
          if not fname or fname == "" then return nil end

          -- Search upward from the buffer's directory
          local found = vim.fs.find(
            { "codebook.toml", ".codebook.toml", ".git" },
            { upward = true, path = vim.fs.dirname(fname) }
          )[1]

          if found then return vim.fs.dirname(found) end

          return vim.fs.dirname(fname)
        end,
        settings = {},
      },

      eslint = {
        filetypes = {
          "javascript",
          "javascriptreact",
          "mjs",
          "cjs",
          "html",
          "css", -- ⭐ add this
        },
      },

      -- Python LSP Configuration
      basedpyright = {
        -- flags = {
        --   debounce_text_changes = 2000,
        -- },
        root_dir = function(fname)
          if not fname or fname == "" then return nil end
          -- Search upward from the buffer's directory
          local found = vim.fs.find({
            "pyrightconfig.json",
            "pyproject.toml",
            "setup.py",
            "setup.cfg",
            "requirements.txt",
            "Pipfile",
            "manage.py",
            ".git",
            ".venv", -- dangerous
          }, { upward = true, path = vim.fs.dirname(fname) })[1]
          if found then return vim.fs.dirname(found) end
          return vim.fs.dirname(fname)
        end,
        -- on_attach = function(client, bufnr)
        --   client.server_capabilities.completionProvider = false
        --   client.server_capabilities.definitionProvider = false
        --   client.server_capabilities.documentHighlightProvider = false
        --   client.server_capabilities.renameProvider = false
        --   client.server_capabilities.semanticTokensProvider = false
        -- end,
        -- settings = { -- see https://docs.basedpyright.com/latest/configuration/language-server-settings/
        --   basedpyright = {
        --     disableOrganizeImports = true, -- use ruff instead of it
        --     analysis = {
        --       autoImportCompletions = true,
        --       autoSearchPaths = true, -- auto search command paths like 'src'
        --       diagnosticMode = "openFilesOnly",
        --       useLibraryCodeForTypes = true,
        --       diagnosticSeverityOverrides = {
        --         reportUnusedImport = "none",
        --         reportUnusedFunction = "none",
        --         reportUnusedVariable = "none",
        --         reportUnusedParameter = "none",
        --         reportUnknownMemberType = "none",
        --         reportPrivateImportUsage = "none",
        --         -- keep real type errors
        --         reportGeneralTypeIssues = "error",
        --         reportOptionalMemberAccess = "error",
        --         reportOptionalSubscript = "error",
        --       },
        --     },
        --   },
        -- },
      },

      djlsp = {
        cmd = { "djlsp" }, -- the executable installed by Mason
        filetypes = {
          "html",
          "htmldjango",
          "django",
        },
        root_dir = function(fname)
          if not fname or fname == "" then return nil end
          -- Search upward from the buffer's directory -
          local found = vim.fs.find({
            "pyproject.toml",
            "requirements.txt",
            "manage.py",
            ".git",
            ".venv",
          }, { upward = true, path = vim.fs.dirname(fname) })[1]
          if found then return vim.fs.dirname(found) end
          return vim.fs.dirname(fname)
        end,
        init_options = {
          django_settings_module = "mysite.settings",
        },
      },

      -- pyrefly = {
      --   cmd = {
      --     "bash",
      --     "-c",
      --     vim.fn.stdpath "data" .. "/mason/bin/pyrefly lsp 2>/dev/null",
      --   },
      --   -- cmd = { "pyrefly", "lsp" },
      --   -- cmd = { "bash", "-c", "pyrefly lsp 2>/dev/null" },
      --   filetypes = { "python" },
      --   root_dir = function(fname)
      --     if not fname or fname == "" then return nil end
      --     -- Search upward from the buffer's directory
      --     local found = vim.fs.find({
      --       "pyrefly.toml",
      --       "pyproject.toml",
      --       "setup.py",
      --       "setup.cfg",
      --       "requirements.txt",
      --       "Pipfile",
      --       ".git",
      --       "manage.py",
      --       ".venv", -- dangerous
      --     }, { upward = true, path = vim.fs.dirname(fname) })[1]
      --     if found then return vim.fs.dirname(found) end
      --     return vim.fs.dirname(fname)
      --   end,
      --   handlers = {
      --     ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
      --       if result and result.diagnostics then
      --         local filtered = {}
      --         for _, diag in ipairs(result.diagnostics) do
      --           local code = diag.code
      --           if type(code) == "table" then code = code.value end
      --           if code ~= "unused-import" and code ~= "unused-variable" and code ~= "unused-parameter" then
      --             table.insert(filtered, diag)
      --           end
      --         end
      --         result.diagnostics = filtered
      --       end
      --       vim.lsp.handlers["textDocument/publishDiagnostics"](err, result, ctx, config)
      --     end,
      --   },
      --   on_attach = function(client, bufnr)
      --     -- Disable all UX features from Pyrefly
      --     client.server_capabilities.codeActionProvider = false -- basedpyright has more kinds
      --     client.server_capabilities.documentSymbolProvider = false -- basedpyright has more kinds
      --     client.server_capabilities.hoverProvider = false -- basedpyright has more kinds
      --     client.server_capabilities.inlayHintProvider = false -- basedpyright has more kinds
      --     client.server_capabilities.referenceProvider = false -- basedpyright has more kinds
      --     client.server_capabilities.signatureHelpProvider = false -- basedpyright has more kinds
      --     -- client.server_capabilities.semanticTokensProvider = false -- for treesitter only highlighting
      --   end,
      --   on_exit = function(code, _, _)
      --     vim.notify("Closing Pyrefly LSP exited with code: " .. code, vim.log.levels.INFO)
      --   end,
      --   settings = {},
      -- },

      ruff = {
        capabilities = {
          general = {
            -- positionEncodings = { "utf-8", "utf-16", "utf-32" }, -- <--- this is the default,
            positionEncodings = { "utf-16" },
          },
        },
        root_dir = function(fname)
          if not fname or fname == "" then return nil end
          -- Search upward from the buffer's directory
          local found = vim.fs.find(
            { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git", ".venv", "manage.py" },
            { upward = true, path = vim.fs.dirname(fname) }
          )[1]
          if found then return vim.fs.dirname(found) end
          return vim.fs.dirname(fname)
        end,
        -- on_attach = function(client, bufnr)
        --   client.server_capabilities.hoverProvider = false
        --   client.server_capabilities.documentFormattingProvider = false
        --   client.server_capabilities.documentRangeFormattingProvider = false
        -- end,
      },

      jinja_lsp = {
        filetypes = { "jinja-html", "jinja" },
      },
    },

    -- customize how language servers are attached
    handlers = {
      emmet_ls = false,
      -- ruff = false,
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      -- function(server, opts) require("lspconfig")[server].setup(opts) end

      -- the key is the server that is being setup with `lspconfig`
      -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
    },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_codelens_refresh = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        cond = "textDocument/codeLens",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "InsertLeave", "BufEnter" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh { bufnr = args.buf } end
          end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
        ["<Leader>uY"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "Toggle LSP semantic highlight (buffer)",
          cond = function(client)
            return client:supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
          end,
        },
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(client, bufnr)
      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
    end,
  },
}
