local opt = vim.opt

-- [] general options
-- show line numbers
opt.number = true
-- relative line numbers, for better navigation
opt.relativenumber = true
-- popup menu height
opt.pumheight = 5
-- set dir for undo file
-- opt.undodir = '~/.somewhere'
-- prompt before saving files
opt.confirm = true
-- enable mouse in all modes
opt.mouse = "a"
-- system clipboard
opt.clipboard = "unnamedplus"
-- disable swap/backup/unfo files
opt.swapfile = false
opt.backup = false
opt.undofile = false
-- hide tildes at the bottom of files
vim.wo.fillchars = "eob: "
-- opt.fillchars = "eob: "
-- opt.fillchars = { eob = ' ' }
-- dont show mode, since in status line
opt.showmode = false
-- Keep signcolumn on by default
opt.signcolumn = "yes"
-- Enable break indent
vim.opt.breakindent = true

-- [] search settings
-- highlight search results
opt.hlsearch = true
-- clear search with <esc>
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>", { noremap = true, silent = true })
-- ignore case in search (case-insensitive)
opt.ignorecase = true
-- case-sensitive for uppercase search
opt.smartcase = true

-- [] display settings
-- enable true color
opt.termguicolors = true
-- highlight current line
opt.cursorline = true
-- vertical splits to right
opt.splitright = true
-- horizontal splits to below
opt.splitbelow = true

-- [] tabs and indentation
-- number of spaces a tab counts
opt.tabstop = 4
-- spaces for each indentation level >>(indent) <<(unindent)
opt.shiftwidth = 4
-- convert tabs to spaces
opt.expandtab = true
-- adjust indentation based on syntax of code
opt.smartindent = true
--  indentation from prev line
opt.autoindent = true

-- faster updates: helpful with lsp or auto-completions
opt.updatetime = 250
-- wait time before considering sequence is finished
opt.timeoutlen = 300

-- format options
-- treat hyphenated words as single word
opt.iskeyword:append("-")

-- Suppress default write message
-- opt.shortmess:append("c")

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank() -- Highlight text after yanking
	end,
})

-- Automatically clear the statusline after 2 seconds of saving
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*",
	callback = function()
		-- Delay in milliseconds (e.g., 1000 ms = 1 second)
		vim.defer_fn(function()
			vim.cmd("echo ''")
		end, 1000)
	end,
})

-- Auto-clear the command-line area after any command is executed
vim.api.nvim_create_autocmd("CmdlineLeave", {
	pattern = "*",
	callback = function()
		-- Delay clearing the command-line area by 1000 ms (1 second)
		vim.defer_fn(function()
			vim.cmd("echo ''") -- Clears the command line
		end, 1000)
	end,
})

-- Keep the command line visible on error
vim.api.nvim_create_autocmd("CmdlineEnter", {
	pattern = "*",
	callback = function()
		if vim.v.errmsg ~= "" then
			print(vim.v.errmsg)
		end
	end,
})
