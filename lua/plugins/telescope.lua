return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")

		telescope.setup()

		vim.keymap.set("n", "<leader>pf", builtin.find_files, { })
		vim.keymap.set("n", "<leader>gs", builtin.git_files, { })
		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end
		)
	end
}
