-- Keymaps (run immediately)
-- =========================

-- open current file with alt + b
vim.keymap.set("n", "<A-b>", ":!xdg-open % &<CR><CR>", {
  noremap = true,
  silent = true,
})

-- Select all with leader + A
vim.keymap.set("n", "<leader>a", "ggVG", {
  noremap = true,
  silent = true,
})

-- New line with enter in normal mode
vim.keymap.set("n", "<CR>", "o<Esc>", {
  noremap = true,
  silent = true,
})

-- Delete s without yank in normal Mode
vim.keymap.set("n", "<leader>s", '"_s', {
  noremap = true,
  silent = true,
})

-- Delete x without yank in normal Mode
vim.keymap.set("n", "<leader>x", '"_x', {
  noremap = true,
  silent = true,
})

-- Delete s without yank in Visual Mode
vim.keymap.set("v", "<leader>s", '"_c', {
  noremap = true,
  silent = true,
})

-- Delete x without yank in Visual Mode
vim.keymap.set("v", "<leader>x", '"_d', {
  noremap = true,
  silent = true,
})

--- When not having clipboard=unnamed ---
--[[ -- Yank to + register
vim.keymap.set({ "v", "n" }, "<leader>y", '"+y', {
  noremap = true,
  silent = true,
})

-- Yank to + register
vim.keymap.set({ "v", "n" }, "<leader>Y", '"+Y', {
  noremap = true,
  silent = true,
}) ]]

-- Alternative cut c to black hole
vim.keymap.set({ "v", "n" }, "<leader>k", '"_c', {
  noremap = true,
  silent = true,
})

-- Alternative delete
vim.keymap.set({ "v", "n" }, "<leader>d", '"_d', {
  noremap = true,
  silent = true,
})
vim.keymap.set({ "v", "n" }, "<leader>D", '"_D', {
  noremap = true,
  silent = true,
})

-- Alternative paste without yank -- deprecated,
-- can use P for this
-- vim.keymap.set("v", "<leader>p", '"_dP', {
--   noremap = true,
--   silent = true,
-- })

-- Visual mode: copy selection to system clipboard
vim.keymap.set({ "v", "n", "i" }, "<C-v>", '"_dP', {
  noremap = true,
  silent = true,
  desc = "regular paste",
})

-- Visual mode: copy selection to system clipboard
vim.keymap.set({ "v", "n" }, "<C-c>", '"+y', {
  noremap = true,
  silent = true,
  desc = "Copy selection to clipboard",
})

-- -- Make Ctrl+q Visual Visual Block Mode
vim.keymap.set({ "v", "n" }, "<C-q>", "<C-v>", {
  noremap = true,
  silent = true,
  desc = "Visual Block Mode",
})

--Regular Regular cut with Ctrl-x
vim.keymap.set({ "v" }, "<C-x>", "c", {
  noremap = true,
  silent = true,
  desc = "Regular cut with Ctrl-x",
})

-- Primeagen Keymaps Keymaps
vim.keymap.set("n", "<C-d>", "<C-d>zz", {
  noremap = true,
  silent = true,
  desc = "Center on down",
})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {
  noremap = true,
  silent = true,
  desc = "Center on up",
})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {
  noremap = true,
  silent = true,
  desc = "Move selection down",
})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {
  noremap = true,
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
