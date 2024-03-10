local harpoon = require("harpoon")
harpoon.setup({})

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon",
			finder = require("telescope.finders").new_table({
				results = file_paths,
			}),
			previewer = conf.file_previewer({}),
			sorter = conf.generic_sorter({}),
		})
		:find()
end

vim.keymap.set({ "n", "v" }, "<leader>mm", function()
	toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })

vim.keymap.set({ "n", "v" }, "<leader>am", function()
	harpoon:list():append()
end, { desc = "Append a mark" })

vim.keymap.set({ "n", "v" }, "<leader>fm", function()
	harpoon:list():next()
end, { desc = "go to forward mark" })

vim.keymap.set({ "n", "v" }, "<leader>pm", function()
	harpoon:list():prev()
end, { desc = "go to prev mark" })
