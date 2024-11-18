return {
	-- NeoTree plugin setup
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree", -- Lazy-load on the 'Neotree' command
	dependencies = {
		"MunifTanjim/nui.nvim", -- Add nui.nvim as a dependency
	},
	keys = {
		{
			"<leader>fe",
			function()
				-- Use current working directory (cwd) as the root for NeoTree
				local project_root = vim.fn.getcwd() -- Get the current working directory
				require("neo-tree.command").execute({ toggle = true, dir = project_root })
			end,
			desc = "Explorer NeoTree (Root Dir)",
		},
		{
			"<leader>fE",
			function()
				-- Use current working directory (cwd) as the root for NeoTree
				local cwd = vim.uv.cwd() -- Get the current working directory
				require("neo-tree.command").execute({ toggle = true, dir = cwd })
			end,
			desc = "Explorer NeoTree (cwd)",
		},
		{ "<leader>e", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
		{ "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
		{
			"<leader>ge",
			function()
				require("neo-tree.command").execute({ source = "git_status", toggle = true })
			end,
			desc = "Git Explorer",
		},
		{
			"<leader>be",
			function()
				require("neo-tree.command").execute({ source = "buffers", toggle = true })
			end,
			desc = "Buffer Explorer",
		},
	},
	deactivate = function()
		-- Close NeoTree
		require("neo-tree").close()
	end,
	init = function()
		-- Autocmd for lazy-loading NeoTree based on directory
		vim.api.nvim_create_autocmd("BufEnter", {
			group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
			desc = "Start Neo-tree with directory",
			once = true,
			callback = function()
				-- Only load NeoTree if not already loaded
				if not package.loaded["neo-tree"] then
					local stats = vim.uv.fs_stat(vim.fn.argv(0))
					if stats and stats.type == "directory" then
						require("neo-tree")
					end
				end
			end,
		})
	end,
	opts = {
		sources = { "filesystem", "buffers", "git_status" },
		open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
		filesystem = {
			bind_to_cwd = false,
			follow_current_file = { enabled = true },
			use_libuv_file_watcher = true,
		},
		window = {
			mappings = {
				["l"] = "open", -- Open the item
				["h"] = "close_node", -- Close the node
				["<space>"] = "none", -- Disable space (no action)
				["Y"] = {
					function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						vim.fn.setreg("+", path, "c") -- Copy path to clipboard
					end,
					desc = "Copy Path to Clipboard",
				},
				["O"] = {
					function(state)
						require("lazy.util").open(state.tree:get_node().path, { system = true }) -- Open with system application
					end,
					desc = "Open with System Application",
				},
				["P"] = { "toggle_preview", config = { use_float = false } }, -- Toggle preview
			},
		},
		default_component_configs = {
			indent = {
				with_expanders = true, -- If file nesting is enabled, expanders will be shown
				expander_collapsed = "", -- Collapsed expander icon
				expander_expanded = "", -- Expanded expander icon
				expander_highlight = "NeoTreeExpander", -- Expander highlight group
			},
			git_status = {
				symbols = {
					unstaged = "󰄱", -- Unstaged symbol
					staged = "󰱒", -- Staged symbol
				},
			},
		},
	},
	config = function(_, opts)
		local Snacks = require("snacks")

		local function on_move(data)
			Snacks.rename.on_rename_file(data.source, data.destination)
		end

		local events = require("neo-tree.events")
		opts.event_handlers = opts.event_handlers or {}
		vim.list_extend(opts.event_handlers, {
			{ event = events.FILE_MOVED, handler = on_move },
			{ event = events.FILE_RENAMED, handler = on_move },
		})

		-- Setup NeoTree with the options passed
		require("neo-tree").setup(opts)

		-- Refresh git status in NeoTree when lazygit terminal is closed
		vim.api.nvim_create_autocmd("TermClose", {
			pattern = "*lazygit",
			callback = function()
				if package.loaded["neo-tree.sources.git_status"] then
					require("neo-tree.sources.git_status").refresh()
				end
			end,
		})
	end,
}
