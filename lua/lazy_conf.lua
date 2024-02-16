require("lazy").setup({
	{
		"windwp/nvim-autopairs",
		dependencies = "windwp/nvim-ts-autotag",
		config = function()
			require("nvim-autopairs").setup({
				disable_filetype = { "TelescopePrompt", "vim" },
			})
			require("nvim-treesitter.configs").setup({
				autotag = {
					enable = true,
				},
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("editor.git_signs")
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		event = "VeryLazy",
		config = function()
			require("editor/devicons")
		end,
	},
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	"folke/neodev.nvim",
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"neovim/nvim-lspconfig",
			"onsails/lspkind.nvim",
		},
		config = function()
			require("tools/mason_config")
			require("tools/lsp_config")
			require("tools/lsp_kind")
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
		config = function()
			require("editor/treesitter_conf")
		end,
	},

	{
		"mrcjkb/rustaceanvim",
		version = "^4",
		ft = { "rust" },
	},

	{
		"hrsh7th/nvim-cmp",
		event = "VeryLazy",
		dependencies = {
			"sar/cmp-lsp.nvim",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("tools/completion")
		end,
	},
})
