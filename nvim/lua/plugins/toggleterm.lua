return {
	"akinsho/toggleterm.nvim",
	version = "*",
	keys = {
		-- ID 1: The Main Floating Terminal (Ctrl + \)
		{
			"<C-\\>",
			"<cmd>ToggleTerm direction=float<cr>",
			mode = { "n", "t" },
			desc = "Toggle Floating Terminal",
		},

		-- ID 2: The Horizontal Terminal (<leader>th)
		{
			"<leader>th",
			"<cmd>2ToggleTerm size=15 direction=horizontal<cr>",
			desc = "Toggle Horizontal (ID 2)",
		},

		-- ID 3: The Vertical Terminal (<leader>tv)
		{
			"<leader>tv",
			"<cmd>3ToggleTerm size=80 direction=vertical<cr>",
			desc = "Toggle Vertical (ID 3)",
		},
	},
	opts = {
		size = 20,
		-- Remove 'open_mapping' since we define keys manually above
		-- open_mapping = [[<C-\>]],

		hide_numbers = true,
		shade_terminals = true,
		start_in_insert = true,
		insert_mappings = true,
		persist_size = true,
		direction = "float",
		close_on_exit = true,
		shell = vim.o.shell,
		float_opts = {
			border = "curved",
			winblend = 0,
			highlights = {
				border = "Normal",
				background = "Normal",
			},
		},
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		-- Better terminal navigation
		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "jj", [[<C-\><C-n>]], opts)

			-- Allow moving out of terminal with Ctrl+hjkl
			vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
			vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
			vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
			vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
		end

		-- Auto-apply keymaps when a terminal opens
		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
	end,
}
