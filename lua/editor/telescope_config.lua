local builtin = require("telescope.builtin")
local map = vim.keymap.set

map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
map("n", "<leader>fw", builtin.live_grep, { desc = "Find Word" })
map("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Find HelpTags" })

-- map("n", "<space>fe", ":Telescope file_browser<CR>", { noremap = true, desc = "File Explorer" })

-- open file_browser with the path of the current buffer
map(
	"n",
	"<space>fe",
	":Telescope file_browser path=%:p:h select_buffer=true<CR>",
	{ noremap = true, desc = "File Explorer" }
)

local fb_actions = require("telescope").extensions.file_browser.actions

require("telescope").setup({
	mappings = {
		["i"] = {
			["<c-h>"] = fb_actions.goto_home_dir,
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})

require("telescope").load_extension("fzf")
