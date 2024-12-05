return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
		"debugloop/telescope-undo.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local transform_mod = require("telescope.actions.mt").transform_mod
		local trouble = require("trouble")
		local trouble_telescope = require("trouble.sources.telescope")

		-- Custom actions with enhanced functionality
		local custom_actions = transform_mod({
			-- Advanced actions
			smart_send_to_qflist = function(prompt_bufnr)
				local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
				local multi_select = picker:get_multi_selection()

				-- If multi-select, send those; otherwise, send current selection
				local items = #multi_select > 0 and multi_select or { picker:get_selection() }

				actions.send_to_qflist(prompt_bufnr)()
				trouble.open("quickfix")
			end,

			-- Preview scrolling with smoother experience
			preview_scroll_up = function(prompt_bufnr)
				actions.preview_scrolling_up(prompt_bufnr)
			end,

			preview_scroll_down = function(prompt_bufnr)
				actions.preview_scrolling_down(prompt_bufnr)
			end,
		})

		-- Advanced Telescope setup with modern aesthetics
		telescope.setup({
			defaults = {
				-- Stylish and informative path display
				path_display = {
					"smart",
					shorten = { len = 3, exclude = { -2, -1 } },
				},

				-- Enhanced preview configuration
				preview = {
					treesitter = true,
					check_mime_type = true,
				},

				-- Modern, clean sorting and layout
				sorting_strategy = "ascending",
				layout_strategy = "flex",
				layout_config = {
					flex = {
						flip_columns = 120,
					},
					horizontal = {
						preview_width = 0.55,
						width = 0.9,
						height = 0.8,
					},
					vertical = {
						width = 0.8,
						height = 0.9,
						preview_height = 0.5,
					},
				},

				-- Advanced mapping configuration
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-p>"] = custom_actions.preview_scroll_up,
						["<C-n>"] = custom_actions.preview_scroll_down,
						["<C-q>"] = custom_actions.smart_send_to_qflist,
						["<C-t>"] = trouble_telescope.open,
						["<M-h>"] = actions.select_horizontal,
						["<M-v>"] = actions.select_vertical,
						["<C-x>"] = actions.delete_buffer,
					},
					n = {
						["q"] = actions.close,
						["<C-c>"] = actions.close,
					},
				},

				-- Refined UI elements
				borderchars = { "─", "│", "─", "│", "┌", "┐", "└", "┘" }, -- Solid border with corner and edge characters
				prompt_prefix = "→ ", -- Prompt with an arrow for emphasis
				selection_caret = "▶ ", -- Triangle caret for selection
				entry_prefix = "● ", -- Bullet point for entry prefix
				multi_icon = "☑ ", -- Checkmark icon for multi-selection
			},

			-- Per-picker configurations
			pickers = {
				find_files = {
					theme = "dropdown",
					previewer = false,
					hidden = true,
					find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
				},
				live_grep = {
					theme = "ivy",
					additional_args = function()
						return { "--hidden", "-g", "!.git" }
					end,
				},
				git_commits = {
					theme = "dropdown",
				},
			},

			-- Extension configurations
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				undo = {
					side_by_side = true,
					layout_strategy = "vertical",
				},
			},
		})

		-- Load extensions
		telescope.load_extension("fzf")
		telescope.load_extension("todo-comments")
		telescope.load_extension("undo")

		-- Keymappings with descriptive help
		local keymap = vim.keymap
		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find String" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find Todos" })
		keymap.set("n", "<leader>fg", "<cmd>Telescope git_commits<cr>", { desc = "Git Commits" })
		keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>", { desc = "Undo History" })
	end,
}
