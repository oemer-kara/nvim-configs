return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- Load the nvim-tree plugin
		local nvimtree = require("nvim-tree")

		-- Disable netrw to prevent conflicts with nvim-tree
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- Setup configuration for nvim-tree
		nvimtree.setup({
			view = {
				adaptive_size = true, -- Automatically adjust the size of the tree
				side = "right", -- Keep the file explorer on the right
				relativenumber = true, -- Enable relative line numbers for navigation
			},
			renderer = {
				indent_markers = {
					enable = true, -- Show indent markers for folders
				},
				icons = {
					glyphs = {
						default = "📄", -- Icon for default files
						symlink = "🔗", -- Icon for symlinks
						folder = {
							arrow_closed = "+", -- Icon for closed folder
							arrow_open = "-", -- Icon for open folder
							default = "📁", -- Default folder icon
							open = "📂", -- Open folder icon
							empty = "🗂️", -- Empty folder icon
						},
					},
				},
				highlight_git = true, -- Highlight git changes
			},
			actions = {
				open_file = {
					window_picker = {
						enable = false, -- Disable window picker for smooth splits
					},
				},
			},
			filters = {
				dotfiles = false, -- Show dotfiles
				custom = { ".DS_Store" }, -- Hide unnecessary system files
			},
			git = {
				ignore = false, -- Show ignored files in Git
			},
		})

		-- Keymaps for nvim-tree with enhanced descriptions
		local keymap = vim.keymap -- Shorthand for setting keymaps
		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })
		keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", { desc = "Focus on Current File" })
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse All Folders" })
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh File Explorer" })
		keymap.set(
			"n",
			"<leader>ev",
			"<cmd>lua require('nvim-tree.api').node.open.vertical()<CR>",
			{ desc = "Open File in Vertical Split" }
		)
		keymap.set(
			"n",
			"<leader>eh",
			"<cmd>lua require('nvim-tree.api').node.open.horizontal()<CR>",
			{ desc = "Open File in Horizontal Split" }
		)
		keymap.set("n", "<leader>ea", function()
			local api = require("nvim-tree.api")
			api.tree.open()
			api.tree.expand_all()
		end, { desc = "Expand All Folders" })
	end,
}
