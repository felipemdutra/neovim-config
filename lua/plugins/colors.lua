return {
	"rose-pine/neovim",
	name = "rose-pine",
	lazy = false,    -- Load at startup (important for colorschemes)
	priority = 1000, -- Highest priority to prevent flickering
	config = function()
		-- Enable 24-bit color (required for transparency)
		vim.opt.termguicolors = true

		-- Configure rose-pine with transparency
		require('rose-pine').setup({
			variant = 'main', -- 'main', 'moon', or 'dawn'
			disable_background = true,  -- Critical for transparency
			disable_float_background = true,
		})

	end
}
