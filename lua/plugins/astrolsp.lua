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
      -- "pyright"
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
        root_dir = function(_)
          local fname = vim.api.nvim_buf_get_name(0)

          -- Search upward from the buffer's directory
          local found = vim.fs.find(
            { "codebook.toml", ".codebook.toml", ".git" },
            { upward = true, path = vim.fs.dirname(fname) }
          )[1]

          if found then return vim.fs.dirname(found) end

          return vim.fs.dirname(fname)
        end,
      },

      djlsp = {
        cmd = { "django-template-lsp" }, -- the executable installed by Mason
        filetypes = {
          "html",
          "htmldjango",
          "djangohtml",
          "django",
        },
        root_dir = function(fname)
          local util = require "lspconfig.util"

          -- 1. Prefer Django/Jinja project configs
          local root =
            util.root_pattern("manage.py", "pyproject.toml", "requirements.txt", "setup.py", "Pipfile", ".git")(fname)

          if root then return root end

          -- 2. Fallback to file directory
          return vim.fs.dirname(fname)
        end,
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

      jinja_lsp = {
        filetypes = { "jinja-html", "jinja" },
      },

      ruff = {
        capabilities = {
          general = {
            -- positionEncodings = { "utf-8", "utf-16", "utf-32" }  <--- this is the default
            positionEncodings = { "utf-16" },
          },
        },
      },
    },
    -- customize how language servers are attached
    handlers = {
      emmet_ls = false,
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      -- function(server, opts) require("lspconfig")[server].setup(opts) end

      -- the key is the server that is being setup with `lspconfig`
      -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
      -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
      codebook = function(_, opts) require("lspconfig").codebook.setup(opts) end,
      djlsp = function(_, opts) require("lspconfig").djlsp.setup(opts) end,
    },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      codebook_force_diagnostics = {
        event = "BufEnter",
        desc = "Force Codebook diagnostics on file open",
        callback = function(args)
          local bufnr = args.buf

          -- Get active LSP clients for this buffer (new API)
          local clients = vim.lsp.get_clients { bufnr = bufnr }
          local codebook = nil

          for _, c in ipairs(clients) do
            if c.name == "codebook" then
              codebook = c
              break
            end
          end

          if not codebook then return end

          -- If Codebook supports pull diagnostics, request them
          if codebook.supports_method "workspace/diagnostic" then
            vim.lsp.buf_request(bufnr, "workspace/diagnostic", {
              identifier = "codebook-open",
              previousResultIds = {},
            })
            return
          end

          -- Fallback: apply a reversible "fake edit" to trigger didChange
          vim.api.nvim_buf_set_text(bufnr, 0, 0, 0, 0, { "" })
          vim.api.nvim_buf_set_text(bufnr, 0, 0, 1, 0, {})
        end,
      },
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
