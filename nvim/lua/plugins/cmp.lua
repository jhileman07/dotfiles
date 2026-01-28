return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter", -- Load only when you start typing
	dependencies = {
		"hrsh7th/cmp-nvim-lsp", -- Connects to your LSP
		"hrsh7th/cmp-buffer", -- Suggests words in the current file
		"hrsh7th/cmp-path", -- Suggests file paths
		"L3MON4D3/LuaSnip", -- Required snippet engine
		"saadparwaiz1/cmp_luasnip", -- Connects LuaSnip to CMP
		"rafamadriz/friendly-snippets", -- Adds standard snippets (like "for" loops)
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		-- Load "friendly-snippets" (vs-code style snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			snippet = {
				-- REQUIRED: This tells cmp how to expand snippets
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				-- Scroll through the documentation window
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),

				-- Trigger the menu manually (Ctrl + Space)
				["<C-Space>"] = cmp.mapping.complete(),

				-- Cancel the menu
				["<C-e>"] = cmp.mapping.abort(),

				-- Confirm selection with Enter
				["<CR>"] = cmp.mapping.confirm({ select = true }),

				-- NAVIGATE THE LIST:
				-- Use Ctrl+n (down) and Ctrl+p (up)
				-- or standard Tab / Shift+Tab behavior
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- Prioritize LSP suggestions
				{ name = "luasnip" }, -- Snippets
			}, {
				{ name = "buffer" }, -- Words in file
				{ name = "path" }, -- File paths
			}),
		})
	end,
}
