--if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- ~/.config/nvim/lua/user/mappings.lua (or polish.lua)
-- Replace the "p" prefix with ";"
-- polish.lua
--
-- Always resolve symlinked working directories (critical for DAP/LSP)
-- vim.schedule(function()
--   local cwd = vim.fn.getcwd()
--   local real = vim.fn.resolve(cwd)
--   if real ~= cwd then vim.cmd.cd(real) end
-- end)

-- vim.treesitter.language.register("html", "jinja-html")
-- vim.treesitter.language.register("jinja2", "html")
-- vim.treesitter.language.register("jinja", "html")
-- vim.treesitter.language.register("jinja", "jinja-html")
-- vim.treesitter.language.register("htmldjango", "jinja-html")

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "jinja-html",
--   command = "setlocal syntax=jinja",
-- })
