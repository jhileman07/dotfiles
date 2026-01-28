-- core modules
require("set")
require("remap")

-- --- personal helpers --------------------------------------------------------
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local MyGroup = augroup("MyNeovim", { clear = true })
local YankHi = augroup("YankHighlight", { clear = true })

-- Safe hot-reload helper (optional)
function R(name)
	local ok, reload = pcall(require, "plenary.reload")
	if ok then
		reload.reload_module(name)
	end
	return require(name)
end

-- Filetype detection
vim.filetype.add({
	extension = { templ = "templ" },
})

-- --- UX niceties -------------------------------------------------------------
autocmd("TextYankPost", {
	group = YankHi,
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 80 })
	end,
})

-- Trim trailing whitespace on save (skip markdown/gitcommit)
autocmd("BufWritePre", {
	group = MyGroup,
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		if ft == "markdown" or ft == "gitcommit" then
			return
		end
		local view = vim.fn.winsaveview()
		vim.api.nvim_buf_call(args.buf, function()
			vim.cmd([[%s/\s\+$//e]])
		end)
		vim.fn.winrestview(view)
	end,
})

-- Colorscheme: only when opening Zig buffers (prevents flicker)
autocmd("FileType", {
	group = MyGroup,
	pattern = "zig",
	callback = function()
		pcall(vim.cmd.colorscheme, "tokyonight-night")
	end,
})
autocmd("FileType", {
	group = MyGroup,
	pattern = "*",
	callback = function()
		pcall(vim.cmd.colorscheme, "rose-pine-moon")
	end,
})

-- --- LSP on-attach keymaps ---------------------------------------------------
autocmd("LspAttach", {
	group = MyGroup,
	callback = function(e)
		local b = e.buf
		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = b, silent = true, desc = desc })
		end

		map("n", "K", vim.lsp.buf.hover, "Hover docs")
		map("n", "gd", vim.lsp.buf.definition, "Go to definition")
		map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
		map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
		map("n", "gr", vim.lsp.buf.references, "Find references")

		map("n", "<leader>vrn", vim.lsp.buf.rename, "Rename symbol")
		map("n", "<leader>vca", vim.lsp.buf.code_action, "Code action")
		map("n", "<leader>vws", vim.lsp.buf.workspace_symbol, "Workspace symbols")
		map("n", "<leader>vd", vim.diagnostic.open_float, "Line diagnostics")

		-- Conventional directions
		map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
		map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")

		-- Insert mode: signature help (avoid <C-h> conflicts)
		map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
	end,
})

-- --- netrw tweaks (if you keep netrw) ---------------------------------------
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
