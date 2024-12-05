return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		-- Completion sources
		"hrsh7th/cmp-buffer", -- Buffer text completion
		"hrsh7th/cmp-path", -- Filesystem path completion
		"hrsh7th/cmp-nvim-lsp", -- LSP-based completion

		-- Snippet engine and related
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
			dependencies = {
				"saadparwaiz1/cmp_luasnip",
				"rafamadriz/friendly-snippets",
			},
		},

		-- Visual enhancements
		"onsails/lspkind.nvim",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		-- Load VS Code-style snippets
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			-- Refined completion experience
			completion = {
				completeopt = "menu,menuone,preview,noselect",
				keyword_length = 2, -- Start suggestions after 2 characters
			},

			-- Snippet expansion
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			-- Enhanced keyboard mappings
			mapping = cmp.mapping.preset.insert({
				["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-u>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				}),
			}),

			-- Prioritized completion sources
			sources = cmp.config.sources({
				{ name = "nvim_lsp", priority = 1000 },
				{ name = "luasnip", priority = 750 },
				{ name = "buffer", priority = 500 },
				{ name = "path", priority = 250 },
			}),

			-- Slick formatting with icons and truncation
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = 50,
					ellipsis_char = "...",
					before = function(entry, vim_item)
						vim_item.menu = ({
							nvim_lsp = "[LSP]",
							luasnip = "[Snippet]",
							buffer = "[Buffer]",
							path = "[Path]",
						})[entry.source.name]
						return vim_item
					end,
				}),
			},

			-- Experimental features
			experimental = {
				ghost_text = true, -- Show virtual text suggestions
			},

			-- Window styling
			window = {
				completion = cmp.config.window.bordered({
					winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel",
				}),
				documentation = cmp.config.window.bordered({
					winhighlight = "Normal:Normal,FloatBorder:BorderBG",
				}),
			},
		})
	end,
}
