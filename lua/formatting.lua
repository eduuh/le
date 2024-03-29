local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		graphql = { "prettier" },
		lua = { "stylua" },
		python = { "isort", "black" },
		css = { "stylelint", "prettier" },
		sh = { "shellcheck", "shfmt" },
		["_"] = { "trim_whitespace", "trim_newlines", "squeeze_blanks" },
		["*"] = { "codespell" },
		cpp = { "clang_format" },
		c = { "clang-format" },
		objc = { "clang_format" },
		objcpp = { "clang_format" },
		cuda = { "clang_format" },
		proto = { "clang_format" },
	},
	format_on_save = {
		lsp_fallback = true,
		async = true,
		timeout_ms = 500,
	},
})
