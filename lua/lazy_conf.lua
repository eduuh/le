local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"folke/which-key.nvim",
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	"folke/neodev.nvim",
	{
		"williamboman/mason.nvim",
		dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
		config = function()
			require("tools/mason_config")
		end,
	},

	{
		"p00f/clangd_extensions.nvim",
		event = "VeryLazy",
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("editor/theme")
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "clangd_extensions.nvim", "mason.nvim" },
		config = function()
			require("formatting")
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
		},
		config = function()
			require("editor/telescope_config")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},
})
