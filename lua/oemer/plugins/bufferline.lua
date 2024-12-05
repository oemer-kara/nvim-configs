return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers", -- Change from "tab" to "buffers"
				style_preset = require("bufferline").style_preset.minimal,
				themable = true,
				view = "multiwindow",
				-- Rest of your existing configuration remains the same
				indicator = {
					icon = "▎",
					style = "icon",
				},
				buffer_close_icon = "✕",
				modified_icon = "●",
				close_icon = "✗",
				left_trunc_marker = "",
				right_trunc_marker = "",
				diagnostics = "nvim_lsp",
				diagnostics_update_in_insert = false,
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " " or " "
					return icon .. count
				end,
				separator_style = "slant",
				always_show_bufferline = true,
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				sort_by = "insert_after_current",
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer 🗃️",
						highlight = "Directory",
						separator = true,
					},
				},
				highlights = {
					buffer_selected = {
						bold = true,
						italic = true,
					},
					diagnostic_selected = {
						bold = true,
					},
					fill = {
						bg = {
							attribute = "bg",
							highlight = "TabLineFill",
						},
					},
				},
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
			},
		})

		-- Your existing keymaps remain the same
		local map = vim.keymap.set
		map("n", "<Tab>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
		map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
		map("n", "<leader>bp", ":BufferLinePick<CR>", { noremap = true, silent = true, desc = "Pick Buffer" })
		map(
			"n",
			"<leader>bo",
			":BufferLineCloseOthers<CR>",
			{ noremap = true, silent = true, desc = "Close Other Buffers" }
		)
	end,
}
