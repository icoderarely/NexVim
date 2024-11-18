return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			background = { -- :h background
				light = "latte",
				dark = "macchiato",
			},
			transparent_background = false, -- disables setting the background color.
			show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
			term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
			dim_inactive = {
				enabled = false, -- dims the background color of inactive window
				shade = "dark",
				percentage = 0.15, -- percentage of the shade to apply to the inactive window
			},
			default_integrations = true,
			integrations = {
				cmp = true,
				gitsigns = true,
				neotree = true,
				treesitter = true,
				notify = false,
				mini = {
					enabled = true,
					indentscope_color = "",
				},
				-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
			},
		})

		-- setup must be called before loading
		vim.cmd.colorscheme("catppuccin")

		local bg_transparent = false -- Initially set to false

		-- Toggle background transparency
		local toggle_transparency = function()
			bg_transparent = not bg_transparent
			require("catppuccin").setup({
				transparent_background = bg_transparent, -- Set the transparency based on the toggle
			})
			vim.cmd.colorscheme("catppuccin") -- Reload the colorscheme to apply changes
		end

		vim.keymap.set("n", "<leader>tg", toggle_transparency, { noremap = true, silent = true })
	end,
}
