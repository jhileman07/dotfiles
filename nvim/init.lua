require("config.init")
require("config.lazy")

-- Put in your init.lua (or a sourced lua file)

vim.cmd("filetype plugin indent on")
vim.o.updatetime = 300 -- snappier CursorHold
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false, scope = "line", source = "if_many", border = "rounded" })
	end,
})

-- Prevent 'std::' from triggering an unindent
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "cpp", "c" },
	callback = function()
		vim.opt_local.indentkeys:remove(":")
    vim.opt_local.smartindent = false
    vim.opt_local.cindent = false
    vim.opt_local.indentexpr = "v:lua.vim.treesitter.indent()"
	end,
})

