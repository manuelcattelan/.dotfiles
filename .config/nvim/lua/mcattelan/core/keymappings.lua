vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set("n", "q:", "<nop>")
vim.keymap.set("n", "<Esc>", "<CMD>nohlsearch<CR>")
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>p", '"_dP')
vim.keymap.set("v", "<leader>d", '"-d')
vim.keymap.set("n", "<leader>w", "<CMD>only<CR>")
vim.keymap.set("n", "<leader>t", "<CMD>tabonly<CR>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
