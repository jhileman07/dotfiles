return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			-- core langs you asked for
			"cpp",
			"c",
			"python",
			"rust",
			"lua",
			-- infra & config you’ll touch constantly
			"cmake",
			"make",
			"bash",
			"regex",
			"json",
			"jsonc",
			"yaml",
			"toml",
			"markdown",
			"markdown_inline",
			"query",
			"vim",
			"vimdoc",
			"gitcommit",
			"diff",
			-- nice to have for quant stacks
			"dockerfile",
			"sql",
			"cuda",
			"proto",
		},
		auto_install = true,
		highlight = {
			enable = true,
			disable = function(lang, buf)
				local max = 300 * 1024 -- 300 KB for gigantic vendor files
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				return (ok and stats and stats.size > max) or false
			end,
			additional_vim_regex_highlighting = false,
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
