-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- for conciseness
local opts = { noremap = true, silent = true }

-- no default behavior - because we using leader key
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Find and center
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Move selected text up and down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "up" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "down" })

-- Move line up and down
vim.keymap.set("n", "K", ":m .-2<CR>==", { desc = "Move current line up" })
vim.keymap.set("n", "J", ":m .+1<CR>==", { desc = "Move current line down" })

-- Helix-like g-prefixed maps
vim.keymap.set("n", "gh", "0", { desc = "Goto line start" })
vim.keymap.set("n", "gl", "$", { desc = "Goto line end" })
vim.keymap.set("n", "gs", "^", { desc = "Goto first non-whitespace character" })

-- Lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Window management
vim.keymap.set("n", "<leader>v", "<C-w>v", opts) -- split window vertically
vim.keymap.set("n", "<leader>h", "<C-w>s", opts) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", opts) -- make split windows equal width & height
vim.keymap.set("n", "<leader>sd", ":close<CR>", opts) -- close current split window

--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Navigate between splits
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", opts)
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", opts)

-- Buffers
if pcall(require, "bufferline.nvim") then
	vim.keymap.set(
		"n",
		"<S-h>",
		"<cmd>BufferLineCyclePrev<cr>",
		{ desc = "Previous buffer", noremap = true, silent = true }
	)
	vim.keymap.set(
		"n",
		"<S-l>",
		"<cmd>BufferLineCycleNext<cr>",
		{ desc = "Next buffer", noremap = true, silent = true }
	)
	vim.keymap.set("n", "<leader>bd", function()
		vim.cmd("bprevious")
		vim.cmd("bdelete #")
	end, { desc = "Delete buffer", noremap = true, silent = true })
else
	vim.keymap.set("n", "<S-h>", "<cmd>bprev<cr>", { desc = "Previous buffer", silent = true })
	vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer", silent = true })
	vim.keymap.set("n", "<leader>bd", function()
		vim.cmd("bprevious")
		vim.cmd("bdelete #")
	end, { desc = "Delete buffer", silent = true })
end

-- Toggle line wrapping
-- vim.keymap.set('n', '<leader>wl', '<cmd>set wrap!<CR>', opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Replace word under cursor
vim.keymap.set("n", "<leader>j", "*``cgn", opts)

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)
