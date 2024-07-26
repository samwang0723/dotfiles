local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local options = {
	-- Plugin configuration
	tools = {},
	server = {
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			-- to enable rust-analyzer settings visit:
			-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
			["rust-analyzer"] = {
				-- enable clippy on save
				checkOnSave = {
					command = "clippy",
				},
			},
		},
		standalone = false,
	},
	-- debugging stuff
	dap = {
		adapter = {
			type = "executable",
			command = "lldb",
			name = "rt_lldb",
		},
	},
}

return options
