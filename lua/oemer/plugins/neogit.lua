return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration

		-- Only one of these is needed.
		"nvim-telescope/telescope.nvim", -- optional
		"ibhagwan/fzf-lua", -- optional
		"echasnovski/mini.pick", -- optional
	},

	config = function()
		-- Setup Neogit
		require("neogit").setup({})

		-- Keymaps
		local keymap = vim.keymap -- For conciseness
		keymap.set("n", "<leader>go", "<cmd>Neogit<cr>", { desc = "Open Neogit" })
		keymap.set("n", "<leader>gs", "<cmd>Neogit kind=split<cr>", { desc = "Open Neogit in Split" })
		keymap.set("n", "<leader>gc", "<cmd>Neogit commit<cr>", { desc = "Commit Changes" })
		keymap.set("n", "<leader>gl", "<cmd>Neogit log<cr>", { desc = "View Git Log" })
		keymap.set("n", "<leader>gp", "<cmd>Neogit push<cr>", { desc = "Push Changes" })
		keymap.set("n", "<leader>gP", "<cmd>Neogit pull<cr>", { desc = "Pull Changes" })
		keymap.set("n", "<leader>gf", "<cmd>Neogit fetch<cr>", { desc = "Fetch Changes" })
		keymap.set("n", "<leader>gr", "<cmd>Neogit rebase<cr>", { desc = "Rebase Branch" })
		keymap.set("n", "<leader>gR", "<cmd>Neogit reset<cr>", { desc = "Reset Changes" })
		keymap.set("n", "<leader>gb", "<cmd>Neogit checkout<cr>", { desc = "Checkout Branch" })
		keymap.set("n", "<leader>gm", "<cmd>Neogit merge<cr>", { desc = "Merge Changes" })
		keymap.set("n", "<leader>gd", "<cmd>Neogit diff<cr>", { desc = "View Diffs" })
		keymap.set("n", "<leader>gD", "<cmd>Neogit discard<cr>", { desc = "Discard Changes" })
		keymap.set("n", "<leader>gh", "<cmd>Neogit help<cr>", { desc = "Neogit Help" })
	end,
}
