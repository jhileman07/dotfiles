require "init"
require "set"
require "lazy_loader"
require "remap"

-- Put in your init.lua (or a sourced lua file)

vim.cmd("filetype plugin indent on")
vim.o.updatetime = 300 -- snappier CursorHold
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false, scope = "line", source = "if_many", border = "rounded" })
	end,
})

