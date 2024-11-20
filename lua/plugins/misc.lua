return {
	{
		-- tmux & split window navigation
		"christoomey/vim-tmux-navigator",
	},
	{
		"folke/snacks.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
	},
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		-- autoclose tags
		"windwp/nvim-ts-autotag",
	},
	{
		"folke/which-key.nvim",
	},
	{
		-- high-performance color highlighter
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	},
	{
		"echasnovski/mini.animate",
		opts = {
			open = {
				enable = false,
			},
			close = {
				enable = false,
			},
		},
	},
}
