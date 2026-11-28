return {
	"eldritch-theme/eldritch.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		-- transparent = true,
		on_highlights = function(hl, c)
			hl.SnacksDashboardHeader = { fg = "#37f499" } -- Mint green Cthulhu art
			hl.SnacksDashboardIcon = { fg = "#37f499" } -- Mint green icons
			hl.SnacksDashboardDesc = { fg = "#04d1f9" } -- Cyan menu labels
			hl.SnacksDashboardKey = { fg = "#a48cf2" } -- Purple shortcut keys [f], [n]...
			hl.SnacksDashboardFooter = { fg = "#04d1f9", italic = true }
		end,
	},
}
