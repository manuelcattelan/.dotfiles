-- Modes
-- normal_mode = "n",
-- insert_mode = "i",
-- visual_mode = "v",
-- visual_block_mode = "x",
-- term_mode = "t",
-- command_mode = "c",

local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- Set leader key
vim.g.mapleader = " "

-- Source current file
map("n", "<leader><CR>", "<cmd>source %<CR>", opts)

-- buffer navigation
map("n", "<leader>nb", "<cmd>bnext<CR>", opts)
map("n", "<leader>pb", "<cmd>bprevious<CR>", opts)
map("n", "<leader>db", "<cmd>bdelete<CR>", opts)

-- Window navigation
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Window resizing
map("n", "<S-Up>", "<cmd>resize -2<CR>", opts)
map("n", "<S-Down>", "<cmd>resize +2<CR>", opts)
map("n", "<S-Left>", "<cmd>vertical resize -2<CR>", opts)
map("n", "<S-Right>", "<cmd>vertical resize +2<CR>", opts)

-- Vim file explorer
map("n", "<leader>pv", "<cmd>Vexplore<CR>", opts)

-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Move text up and down
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Delete selected text without yanking
map("v", "<leader>d", '"-d"', opts)
-- Replace selected text without yanking
map("v", "<leader>p", '"_dP', opts)
-- Copy selected text to system clipboard
map("v", "<leader>y", '"+y', opts)

-- Telescope key mappings (project find, search and buffer)
map("n", '<leader>pf', ":lua require'telescope.builtin'.find_files()<CR>", opts)
map("n", '<leader>ps', ":lua require'telescope.builtin'.live_grep()<CR>", opts)
map("n", '<leader>ob', ":lua require'telescope.builtin'.buffers()<CR>", opts)
