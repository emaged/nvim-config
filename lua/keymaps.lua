-- Keymaps (run immediately)
-- =========================

-- yanky clear history
vim.keymap.set("n", "<Leader>ux", ":YankyClearHistory<cr>", { desc = "Clear Yanky history" })
vim.keymap.set("n", "y,", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "y.", "<Plug>(YankyNextEntry)")

-- luansip
-- local ls = require "luasnip"
-- vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
-- vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
-- vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })
-- vim.keymap.set({ "i", "s" }, "<C-E>", function()
--   if ls.choice_active() then ls.change_choice(1) end
-- end, { silent = true })

--reload package
vim.keymap.set("n", "<Leader>pl", ":Lazy reload ", { desc = "reload package" })
-- AstroReload
vim.keymap.set("n", "<Leader>pA", "<cmd>AstroReload<cr>", { desc = "AstroReload, experimental!" })
-- source current file
vim.keymap.set("n", "<Leader><Leader>s", "<cmd>source %<cr>", { desc = "source current file" })

-- easy arrow keymap
vim.keymap.set("i", "<C-l>", "<space>=><space>")

-- Search and replace word under the cursor
vim.keymap.set("n", "gre", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { desc = "native search and replace" })

-- open current file with alt + b
vim.keymap.set("n", "<A-b>", ":!xdg-open % &<CR><CR>", {
  silent = true,
})

-- Select all with Leader + A
vim.keymap.set("n", "<Leader>a", "ggVG", {
  silent = true,
})

-- Copy buffer content
vim.keymap.set("n", "<Leader>y", ":%y<CR>", {
  silent = true,
})

-- New line with enter/ shift enter in normal mode
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "" then
      vim.keymap.set("n", "<CR>", "o<Esc>", { buffer = true, silent = true })
      vim.keymap.set("n", "<A-CR>", "O<Esc>j", { buffer = true, silent = true })
    end
  end,
})

vim.keymap.set({ "v", "n" }, "<localleader>,", ",", { desc = "backwards search" })

-- Delete c without yank
vim.keymap.set({ "v", "n" }, "<localleader>c", '"_c', {
  silent = true,
})
vim.keymap.set({ "v", "n" }, "<localleader>C", '"_C', {
  silent = true,
})

-- Delete s without yank in normal Mode
-- vim.keymap.set("n", "<localleader>s", '"_s', {
--   silent = true,
-- })
-- -- Delete s without yank in Visual Mode
-- vim.keymap.set("v", "<localleader>s", '"_c', {
--   silent = true,
-- })
-- -- Delete S without yank
-- vim.keymap.set({ "v", "n" }, "<localleader>S", '"_S', {
--   silent = true,
-- })

-- Delete x without yank in normal Mode
vim.keymap.set("n", "<localleader>x", '"_x', {
  silent = true,
})
-- Delete x without yank in Visual Mode
vim.keymap.set("v", "<localleader>x", '"_d', {
  silent = true,
})

-- Alternative delete
vim.keymap.set({ "v", "n" }, "<localleader>d", '"_d', {
  silent = true,
})
vim.keymap.set({ "v", "n" }, "<localleader>D", '"_D', {
  silent = true,
})

-- -- Make Ctrl+q Visual Visual Block Mode
vim.keymap.set({ "v", "n" }, "<C-q>", "<C-v>", {
  silent = true,
  desc = "Visual Block Mode",
})

-- Visual mode: copy selection to system clipboard
vim.keymap.set("i", "<C-v>", "<C-o>p", {
  silent = true,
  desc = "regular paste",
})
vim.keymap.set("n", "<C-v>", "p", {
  silent = true,
  desc = "regular paste",
})
vim.keymap.set("v", "<C-v>", "P", {
  silent = true,
  desc = "regular paste",
})

-- Visual mode: copy selection to system clipboard
vim.keymap.set({ "v", "n" }, "<C-c>", "y", {
  silent = true,
  desc = "Copy selection to clipboard",
})

--Regular Regular cut with Ctrl-x
-- vim.keymap.set({ "v" }, "<C-x>", "c", {
--   silent = true,
--   desc = "Regular cut with Ctrl-x",
-- })

-- Primeagen Keymaps Keymaps
vim.keymap.set("n", "<C-d>", "<C-d>zz", {
  silent = true,
  desc = "Center on down",
})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {
  silent = true,
  desc = "Center on up",
})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {
  silent = true,
  desc = "Move selection down",
})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {
  silent = true,
  desc = "Move selection up",
})

-- tmux sessionizer keymaps --
-- ------------------------ --
vim.keymap.set("n", "<M-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
--long running sessions
vim.keymap.set("n", "<M-l>", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>")
vim.keymap.set("n", "<M-o>", "<cmd>silent !tmux neww tmux-sessionizer -s 1<CR>")
vim.keymap.set("n", "<M-p>", "<cmd>silent !tmux neww tmux-sessionizer -s 2<CR>")
vim.keymap.set("n", "<M-r>", "<cmd>silent !tmux neww tmux-sessionizer -s 3<CR>")
