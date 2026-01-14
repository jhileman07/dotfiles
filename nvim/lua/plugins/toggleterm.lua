return {
	"akinsho/toggleterm.nvim",
	version = "*",
	keys = {
		-- Toggle a floating terminal from NORMAL or TERMINAL mode
		{
			"<C-\\>",
			function()
				vim.cmd("ToggleTerm direction=float")
			end,
			mode = { "n", "t" },
			desc = "Toggle floating terminal",
		},

		-- Optional: quick horizontal / vertical toggles
		{
			"<leader>th",
			function()
				vim.cmd("ToggleTerm size=12 direction=horizontal")
			end,
			desc = "ToggleTerm horizontal",
		},
		{
			"<leader>tv",
			function()
				vim.cmd("ToggleTerm size=80 direction=vertical")
			end,
			desc = "ToggleTerm vertical",
		},
	},
	opts = {
		direction = "float",
		float_opts = { border = "rounded" },
		open_mapping = [[<C-\>]], -- plugin also binds this; fine to keep for redundancy
		shade_terminals = true,
		insert_mappings = true,
		start_in_insert = true,
		persist_mode = false,
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		-- Make <Esc> (and jj) exit terminal-insert mode cleanly
		vim.api.nvim_create_autocmd("TermOpen", {
			pattern = "term://*",
			callback = function()
				vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { buffer = 0, desc = "Terminal: normal mode" })
				vim.keymap.set("t", "jj", [[<C-\><C-n>]], { buffer = 0, desc = "Terminal: normal mode (jj)" })
			end,
		})
	end,
}
