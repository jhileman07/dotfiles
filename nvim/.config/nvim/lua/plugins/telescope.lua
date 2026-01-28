return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	tag = "0.1.8", -- or remove tag to track latest
	dependencies = { "nvim-lua/plenary.nvim" },

	-- <-- THIS is the lazy.nvim way to do Prime’s mappings -->
	keys = {
		{
			"<leader>ff",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Find files",
		},
		{
			"<C-p>",
			function()
				require("telescope.builtin").git_files()
			end,
			desc = "Git files",
		},
		{
			"<leader>fg",
			function()
				require("telescope.builtin").live_grep()
			end,
		},
		{
			"<leader>fs",
			function()
				local input = vim.fn.input("Grep > ")
				if input ~= "" then
					require("telescope.builtin").grep_string({ search = input })
				end
			end,
			desc = "Project search (grep prompt)",
		},
	},
}
