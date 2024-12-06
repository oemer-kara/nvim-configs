return {
	"nvim-lualine/lualine.nvim",
	requires = { "nvim-tree/nvim-web-devicons", opt = true },
	config = function()
		-- Lualine setup
		--
		local function clock()
			return os.date("%A, %H:%M")
		end

		require("lualine").setup({
			options = {
				theme = "onedark", -- Use the 'onedark' theme for consistency
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				icons_enabled = true, -- Use devicons for a polished look
				globalstatus = true, -- Enables a single statusline across all windows
				disabled_filetypes = {
					statusline = { "packer" }, -- Avoid conflicts with packer
					winbar = {}, -- Ensure all windows, including NvimTree, use the statusline
				},
			},
			sections = {
				lualine_a = { { "mode", fmt = string.upper } }, -- Highlight mode in uppercase
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { { "filename", path = 1 } }, -- Show full file path
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location", clock },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = { "fugitive", "quickfix", "nvim-tree" },
		})

		-- Ensure winbar compatibility for NvimTree
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "NvimTree",
			callback = function()
				vim.opt_local.winbar = "%#Normal# NvimTree" -- Add a simple winbar for NvimTree
			end,
		})
	end,
}
