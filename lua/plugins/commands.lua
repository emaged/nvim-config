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

return {}
