return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		local toggleterm = require("toggleterm")
		local Terminal = require("toggleterm.terminal").Terminal
		local utils = require("plenary.path")

		-- Detect and configure terminal shell
		local function detect_terminal_shell()
			local cmder_path = "D:\\Programs\\cmder\\vendor\\init.bat"
			if utils:new(cmder_path):exists() then
				return "cmd.exe /k " .. cmder_path
			end
			return vim.o.shell
		end

		toggleterm.setup({
			-- Cmder shell configuration with fallback
			shell = detect_terminal_shell(),

			-- Intelligent sizing
			size = 15, -- Changed to fixed size of 15 as requested

			direction = "float",

			-- Floating window configuration
			float_opts = {
				border = "rounded",
				width = function()
					return math.floor(vim.o.columns * 0.85)
				end,
				height = function()
					return math.floor(vim.o.lines * 0.75)
				end,
				winblend = 15,
			},

			-- Terminal behavior
			persist_size = true,
			autochdir = true,
			close_on_exit = true,

			-- Highlight configurations
			highlights = {
				Normal = { link = "NormalFloat" },
				NormalNC = { link = "NormalFloat" },
				FloatBorder = { guifg = "#565f89" },

				-- New terminal-specific highlights
				TerminalNormal = { bg = "#1a1b26", fg = "#c0caf5" },
				TerminalNormalNC = { bg = "#16161e", fg = "#7aa2f7" },
			},
		})

		-- Create terminal with enhanced keymaps
		local function create_terminal(opts)
			opts = opts or {}
			return Terminal:new(vim.tbl_deep_extend("force", {
				direction = opts.direction or "float",
				dir = vim.fn.getcwd(),

				-- Terminal setup
				on_open = function(term)
					vim.cmd("startinsert!")

					-- Consistent terminal keymaps
					local mappings = {
						-- Window navigation
						{ "t", "<C-h>", [[<C-\><C-n><C-w>h]], "Move Left" },
						{ "t", "<C-j>", [[<C-\><C-n><C-w>j]], "Move Down" },
						{ "t", "<C-k>", [[<C-\><C-n><C-w>k]], "Move Up" },
						{ "t", "<C-l>", [[<C-\><C-n><C-w>l]], "Move Right" },

						-- Terminal mode escape
						{ "t", "<Esc>", [[<C-\><C-n>]], "Exit Terminal Mode" },
						{ "t", "<C-q>", [[<C-\><C-n>]], "Quick Exit Terminal Mode" },
					}

					for _, map in ipairs(mappings) do
						vim.api.nvim_buf_set_keymap(
							term.bufnr,
							map[1],
							map[2],
							map[3],
							{ noremap = true, silent = true, desc = map[4] }
						)
					end
				end,
			}, opts))
		end

		-- Terminal instances
		local terminals = {
			float = create_terminal({ direction = "float" }),
			horizontal = create_terminal({ direction = "horizontal" }),
			vertical = create_terminal({ direction = "vertical" }),
		}

		-- Keymappings
		local keymap = vim.keymap.set

		-- Terminal toggles
		keymap("n", "<leader>tt", function()
			terminals.float:toggle()
		end, { desc = "Toggle Floating Terminal" })
		keymap("n", "<leader>th", function()
			terminals.horizontal:toggle()
		end, { desc = "Toggle Horizontal Terminal" })
		keymap("n", "<leader>tv", function()
			terminals.vertical:toggle()
		end, { desc = "Toggle Vertical Terminal" })

		-- Terminal management
		keymap("n", "<leader>ta", "<cmd>ToggleTermToggleAll<CR>", { desc = "Toggle All Terminals" })
		keymap("n", "<leader>tl", "<cmd>TermSelect<CR>", { desc = "List Terminals" })

		-- Kill terminal mapping
		keymap("n", "<leader>tx", function()
			local current_term = require("toggleterm.terminal").get(vim.v.count1)
			if current_term then
				current_term:shutdown()
			end
		end, { desc = "Kill Current Terminal" })

		vim.api.nvim_create_user_command("TerminalWorkspace", function() -- Terminal workspace selector
			vim.ui.select(
				{ "Floating", "Horizontal", "Vertical" },
				{ prompt = "Select Terminal Type" },
				function(choice)
					if choice then
						local term_map = {
							Floating = terminals.float,
							Horizontal = terminals.horizontal,
							Vertical = terminals.vertical,
						}
						term_map[choice]:toggle()
					end
				end
			)
		end, {})

		keymap("n", "<leader>tw", ":TerminalWorkspace<CR>", { desc = "Terminal Workspace" })
	end,
}
