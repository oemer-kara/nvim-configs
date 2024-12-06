local map = vim.keymap.set
local opts = { noremap = true, silent = true } -- Common options for most keymaps

-- Leader Key
vim.g.mapleader = " " -- Space as the leader key
vim.g.maplocalleader = " " -- Local leader key

vim.api.nvim_exec(
	[[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * lua vim.highlight.on_yank({higroup="IncSearch", timeout=200})
  augroup END
]],
	false
)

-- General Keybindings
map("i", "<C-h>", "<C-w>", vim.tbl_extend("force", opts, { desc = "Delete Previous Word" }))
map("n", "<C-s>", ":w<CR>", vim.tbl_extend("force", opts, { desc = "Save File" }))
map("n", "<C-q>", ":q<CR>", vim.tbl_extend("force", opts, { desc = "Quit Neovim" }))
map("n", "<Leader>h", ":nohlsearch<CR>", vim.tbl_extend("force", opts, { desc = "Clear Search Highlights" }))
map("n", "x", '"_x', vim.tbl_extend("force", opts, { desc = "Delete Without Copying Into Register" }))
map("v", "b", "<C-v>", vim.tbl_extend("force", opts, { desc = "Switch to Block Mode" }))

-- Window Management
map("n", "<Leader>sv", ":vsplit<CR>", vim.tbl_extend("force", opts, { desc = "Split Window Vertically" }))
map("n", "<Leader>sh", ":split<CR>", vim.tbl_extend("force", opts, { desc = "Split Window Horizontally" }))
map("n", "<Leader>se", "<C-w>=", vim.tbl_extend("force", opts, { desc = "Equalize Split Sizes" }))
map("n", "<Leader>sx", ":close<CR>", vim.tbl_extend("force", opts, { desc = "Close Current Split" }))

-- Navigate Between Windows
map("n", "<C-h>", "<C-w>h", vim.tbl_extend("force", opts, { desc = "Move to Left Window" }))
map("n", "<C-j>", "<C-w>j", vim.tbl_extend("force", opts, { desc = "Move to Bottom Window" }))
map("n", "<C-k>", "<C-w>k", vim.tbl_extend("force", opts, { desc = "Move to Top Window" }))
map("n", "<C-l>", "<C-w>l", vim.tbl_extend("force", opts, { desc = "Move to Right Window" }))

-- Buffer Management
map("n", "<Leader>bx", ":bd<CR>", vim.tbl_extend("force", opts, { desc = "Close Buffer" }))
map("n", "<Leader>bn", ":bnext<CR>", vim.tbl_extend("force", opts, { desc = "Go to Next Buffer" }))
map("n", "<Leader>bp", ":bprevious<CR>", vim.tbl_extend("force", opts, { desc = "Go to Previous Buffer" }))
map("n", "<Leader>bs", ":w<CR>", vim.tbl_extend("force", opts, { desc = "Save Buffer" }))

-- Resizing Windows
map("n", "<C-Down>", ":resize +4<CR>", vim.tbl_extend("force", opts, { desc = "Increase Window Height" }))
map("n", "<C-Up>", ":resize -4<CR>", vim.tbl_extend("force", opts, { desc = "Decrease Window Height" }))
map("n", "<C-Right>", ":vertical resize -4<CR>", vim.tbl_extend("force", opts, { desc = "Decrease Window Width" }))
map("n", "<C-Left>", ":vertical resize +4<CR>", vim.tbl_extend("force", opts, { desc = "Increase Window Width" }))

-- Useful Keybinds
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("i", "JJ", "<Esc>", vim.tbl_extend("force", opts, { desc = "Escape Alternative (JJ)" }))
map("i", "jj", "<Esc>", vim.tbl_extend("force", opts, { desc = "Escape Alternative (jj)" }))
map("v", "<", "<gv")
map("v", ">", ">gv")
