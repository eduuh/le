local js_based_languages = { "typescript", "javascript", "typescriptreact" }
local dap = require("dap")

local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
local codelldb = mason_path .. "bin/codelldb"
local liblldb_path = mason_path .. "packages/codelldb/extension/lldb/lib/liblldb"

local this_os = vim.loop.os_uname().sysname
-- The path in windows is different
if this_os:find("Windows") then
	codelldb = mason_path .. "packages\\codelldb\\extension\\adapter\\codelldb.exe"
	liblldb_path = mason_path .. "packages\\codelldb\\extension\\lldb\\bin\\liblldb.dll"
else
	-- The liblldb extension is .so for linux and .dylib for macOS
	liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
end

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = codelldb,
		args = { "--port", "${port}" },

		-- On windows you may have to uncomment this:
		-- detached = false,
	},
}

for _, language in ipairs(js_based_languages) do
	dap.configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-chrome",
			request = "launch",
			name = 'Start Chrome with "localhost"',
			url = "http://localhost:3000",
			webRoot = "${workspaceFolder}",
			userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
		},
	}
end

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.expand("%:p:r:h") .. ".out"
		end,
		cwd = "${workspaceFolder}",
		stopAtEntry = false,
		-- setupCommands = {
		-- 	{
		-- 		text = "-enable-pretty-printing",
		-- 		description = "enable pretty printing",
		-- 		ignoreFailures = false,
		-- 	},
		-- },
	},
	{
		name = "Attach to gdbserver :1234",
		type = "codelldb",
		request = "launch",
		MIMode = "gdb",
		miDebuggerServerAddress = "localhost:1234",
		miDebuggerPath = "/usr/bin/gdb",
		cwd = "${workspaceFolder}",
		-- setupCommands = {
		-- 	{
		-- 		text = "-enable-pretty-printing",
		-- 		description = "enable pretty printing",
		-- 		ignoreFailures = false,
		-- 	},
		-- },
		program = function()
			return vim.fn.expand("%:p:r:h") .. ".out"
		end,
	},
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- read launch.json
require("dap.ext.vscode").load_launchjs(nil, {})
