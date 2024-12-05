return {
	"folke/todo-comments.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim", -- Optional, for Telescope integration
	},
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "TodoTrouble", "TodoTelescope" },
	config = function()
		local todo_comments = require("todo-comments")

		todo_comments.setup({
			-- Slick, modern styling
			signs = true, -- Show icons in the signs column
			sign_priority = 8, -- Lower priority to not overshadow other signs

			-- Custom icons with modern look
			signs_custom_highlight = {
				FIX = " ",
				TODO = " ",
				HACK = " ",
				WARN = " ",
				PERF = " ",
				NOTE = " ",
				TEST = "󰙨 ",
			},

			-- Enhanced color and styling
			keywords = {
				FIX = {
					icon = " ", -- Custom icon
					color = "error",
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
				},
				TODO = {
					icon = " ",
					color = "info",
					alt = { "TIP", "IDEA" },
				},
				HACK = {
					icon = " ",
					color = "warning",
					alt = { "TEMPORARY", "QUICK" },
				},
				WARN = {
					icon = " ",
					color = "warning",
					alt = { "WARNING", "XXX" },
				},
				PERF = {
					icon = " ",
					color = "hint",
					alt = { "OPTIMIZE", "PERFORMANCE" },
				},
				NOTE = {
					icon = " ",
					color = "hint",
					alt = { "INFO", "NOTICE" },
				},
				TEST = {
					icon = "󰙨 ",
					color = "test",
					alt = { "TESTING", "PASSED", "FAILED" },
				},
			},

			-- GUI and highlight configuration
			gui_style = {
				fg = "NONE", -- No foreground color modification
				bg = "BOLD", -- Bold background for emphasis
			},

			-- Advanced merge of similar comments
			merge_keywords = true,

			-- Highlight method
			highlight = {
				multiline = true, -- Highlight multiple lines
				multiline_pattern = "^.", -- Highlight entire line
				multiline_context = 2, -- Lines of context to highlight
				before = "", -- No special before highlight
				keyword = "wide", -- Wide keyword highlighting
				after = "fg", -- Highlight after keyword
				pattern = [[.*<(KEYWORDS)\s*:]], -- Flexible comment pattern
				comments_only = true, -- Only in comments
				max_line_len = 400, -- Maximum line length to highlight
			},

			-- Search configuration
			search = {
				command = "rg",
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
				pattern = [[\b(KEYWORDS):]], -- Search pattern
			},
		})

		-- Optional Telescope integration for TODO navigation
		require("telescope").load_extension("todo-comments")

		-- Keymappings for easy TODO navigation
		local keymap = vim.keymap
		keymap.set("n", "]t", function()
			require("todo-comments").jump_next()
		end, { desc = "Next TODO Comment" })

		keymap.set("n", "[t", function()
			require("todo-comments").jump_prev()
		end, { desc = "Previous TODO Comment" })
	end,
}
