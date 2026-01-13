-- Show linters for the current buffer's file type
vim.api.nvim_create_user_command("LintInfo", function()
  local filetype = vim.bo.filetype
  local linters = require("lint").linters_by_ft[filetype]

  if linters then
    print("Linters for " .. filetype .. ": " .. table.concat(linters, ", "))
  else
    print("No linters configured for filetype: " .. filetype)
  end
end, {})

vim.api.nvim_create_user_command("WatchRun", function()
  local overseer = require "overseer"
  overseer.run_task({ name = "run script", autostart = false }, function(task)
    if task then
      task:add_component { "restart_on_save", paths = { vim.fn.expand "%:p" } }
      task:start()
      task:open_output "vertical"
    else
      vim.notify("WatchRun not supported for filetype " .. vim.bo.filetype, vim.log.levels.ERROR)
    end
  end)
end, {})

-- grug-far
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("grug-far-fixed", { clear = true }),
  pattern = { "grug-far" },
  callback = function()
    vim.keymap.set("n", "<localleader>T", function()
      local state = unpack(require("grug-far").get_instance(0):toggle_flags { "--fixed-strings" })
      vim.notify("grug-far: fixed-strings " .. (state and "ON" or "OFF"))
    end, { buffer = true, desc = "Toggle --fixed-strings" })
  end,
})

vim.keymap.set({ "n", "x" }, "<leader>sl", function()
  local search = vim.fn.getreg "/"
  -- surround with \b if "word" search (such as when pressing `*`)
  if search and vim.startswith(search, "\\<") and vim.endswith(search, "\\>") then
    search = "\\b" .. search:sub(3, -3) .. "\\b"
  end
  require("grug-far").open {
    prefills = {
      search = search,
    },
  }
end, { desc = "grug-far: Search using @/ register value or visual selection" })

-- substitute
vim.keymap.set({ "n", "x", "o" }, "<Esc>", function()
  pcall(require("substitute.range").clear_match)
  return "<Esc>"
end, { expr = true })

return {}
