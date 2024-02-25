local map = vim.keymap.set

require("rest-nvim").setup({
	result_split_horizontal = false,
	result_split_in_place = true,
	skip_ssl_verification = false,
	encode_url = true,
	highlight = {
		enabled = true,
		timeout = 500,
	},
	result = {
		show_url = true,
		show_curl_command = false,
		show_http_info = true,
		show_headers = true,
		formatters = {
			json = "jq",
			html = function(body)
				return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
			end,
		},
	},
	jump_to_request = false,
	env_file = ".env",
	custom_dynamic_variables = {},
	yank_dry_run = true,
})

map({ "n", "v" }, "<leader>rr", function()
	require("rest-nvim").run()
end, { desc = "Run Rest Request" })

map({ "n", "v" }, "<leader>lr", function()
	require("rest-nvim").last()
end, { desc = "Run last request" })

vim.keymap.set({ "n", "v" }, "<leader>sp", function()
	require("rest-nvim").preview()
end, { desc = "Run toggle preview" })
