return {
	"folke/which-key.nvim",
	config = function()
		require("mini.icons") -- Load mini.icons if it's part of your setup
	end,
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		win = {
			border = "rounded", -- Softer, more modern border
			position = "bottom",
			margin = { 1, 2, 1, 2 },
			padding = { 1, 2, 1, 2 },
		},

		-- improved layout configuration
		layout = {
			align = "center",
			height = { min = 4, max = 30 }, -- slightly increased max height
			width = { min = 25, max = 60 }, -- wider max width
			spacing = 5, -- more breathing room between entries
		},

		triggers = {
			"n", -- Normal mode
			"i", -- Insert mode
		}, -- Limit the modes where which-key is triggered

		-- visual and functional enhancements
		icons = {
			breadcrumb = "»", -- symbol used for breadcrumbs
			separator = "➜ ", -- symbol used between a key and its definition
			group = "+", -- symbol prepended to group names
		},

		-- popup rendering and behavior
		popup_mappings = {
			scroll_down = "<c-d>", -- scroll down through long help texts
			scroll_up = "<c-u>", -- scroll up through long help texts
		},

		ignore_missing = false,
		show_help = true, -- show help hints in the popup
		show_keys = true, -- display actual key combinations

		-- performance and display optimization
		plugins = {
			marks = true, -- show marks in the which-key window
			registers = true, -- show registers in the which-key window
			spelling = {
				enabled = true, -- enable spell check suggestions
				suggestions = 20, -- number of suggestions
			},
		},
	},
}
