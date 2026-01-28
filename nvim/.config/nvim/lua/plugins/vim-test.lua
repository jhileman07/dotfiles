return {
	"vim-test/vim-test",
	dependencies = {
		"preservim/vimux",
	},
	config = function()
		-- 1. Set up the Keymaps
		vim.keymap.set("n", "<leader>t", ":TestNearest<CR>")
		vim.keymap.set("n", "<leader>T", ":TestFile<CR>")
		vim.keymap.set("n", "<leader>a", ":TestSuite<CR>")

		-- 2. Set the Strategy correctly
		-- We use 'vim.g' to ensure it sets the global variable
		vim.g["test#strategy"] = "vimux"
	end,
}
