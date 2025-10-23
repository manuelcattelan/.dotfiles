return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		style = "night",
		styles = {
			comments = { italic = false },
			keywords = { italic = false },
			sidebars = "normal",
			floats = "normal",
		},
		lualine_bold = true,
		---@param highlights tokyonight.Highlights
		---@param colors ColorScheme
		on_highlights = function(highlights, colors)
			highlights.FloatBorder = { fg = colors.dark5 }
			highlights.BlinkCmpMenuBorder = { fg = colors.dark5 }
			highlights.BlinkCmpDocBorder = { fg = colors.dark5 }
			highlights.BlinkCmpSignatureHelpBorder = { fg = colors.dark5 }
			highlights.TelescopeBorder = { fg = colors.dark5 }
			highlights.TelescopePromptBorder = { fg = colors.dark5 }
			highlights.TelescopePromptTitle = { fg = colors.dark5 }
			highlights.WinSeparator = { fg = colors.dark5 }
		end,
	},
	config = function(_, opts)
		require("tokyonight").setup(opts)
		vim.cmd.colorscheme("tokyonight")
	end,
}
