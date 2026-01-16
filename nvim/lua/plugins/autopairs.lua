-- lua/plugins/autopairs.lua
return {
	"windwp/nvim-autopairs",
	event = "InsertEnter", -- load only when you start typing
	opts = {
		check_ts = true, -- use treesitter for smarter pairing
		use_tresitter = true,
		map_cr = true,
		disable_filetype = { "TelescopePrompt", "spectre_panel" },
		ts_config = {
			lua = { "string" }, -- don't add pairs inside TS strings
			javascript = { "template_string" },
			java = false,
		},
		fast_wrap = { -- optional: wrap existing text quickly
			map = "<M-e>",
			chars = { "{", "[", "(", '"', "'" },
			pattern = [=[[%'%"%>%]%)%}%,]]=],
			offset = 0,
			end_key = "$",
			keys = "qwertyuiopzxcvbnmasdfghjkl",
			check_comma = true,
			highlight = "Search",
			highlight_grey = "Comment",
		},
	},

	config = function(_, opts)
		local npairs = require("nvim-autopairs")
		npairs.setup(opts)

		-- NEW: Add this specifically for the Enter key behavior
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local ok, cmp = pcall(require, "cmp")
		if ok then
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end

		-- Manually add a rule for bracket expansion if it's still failing
		local Rule = require("nvim-autopairs.rule")
		local cond = require("nvim-autopairs.conds")

		npairs.add_rules({
			Rule(" ", " "):with_pair(function(opts)
				local pair = opts.line:sub(opts.col - 1, opts.col)
				return vim.tbl_contains({ "()", "[]", "{}" }, pair)
			end),
			Rule("( ", " )")
				:with_pair(function()
					return false
				end)
				:with_move(function(opts)
					return opts.prev_char:match(".%)") ~= nil
				end)
				:use_key(")"),
			Rule("{ ", " }")
				:with_pair(function()
					return false
				end)
				:with_move(function(opts)
					return opts.prev_char:match(".%}") ~= nil
				end)
				:use_key("}"),
			Rule("[ ", " ]")
				:with_pair(function()
					return false
				end)
				:with_move(function(opts)
					return opts.prev_char:match(".%]") ~= nil
				end)
				:use_key("]"),
		})
	end,
}
