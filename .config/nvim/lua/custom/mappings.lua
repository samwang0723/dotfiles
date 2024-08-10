local M = {}

M.dap = {
	plugin = true,
	n = {
		["<leader>db"] = {
			"<cmd> DapToggleBreakpoint <CR>",
			"Add breakpoint at line",
		},
		["<leader>dus"] = {
			function()
				local widgets = require("dap.ui.widgets")
				local sidebar = widgets.sidebar(widgets.scopes)
				sidebar.open()
			end,
			"Open debugging sidebar",
		},
	},
}

M.crates = {
	plugin = true,
	n = {
		["<leader>rcu"] = {
			function()
				require("crates").upgrade_all_crates()
			end,
			"update crates",
		},
	},
}

M.dap_go = {
	plugin = true,
	n = {
		["<leader>dgt"] = {
			function()
				require("dap-go").debug_test()
			end,
			"Debug go test",
		},
		["<leader>dgl"] = {
			function()
				require("dap-go").debug_last()
			end,
			"Debug last go test",
		},
	},
}

M.gopher = {
	plugin = true,
	n = {
		["<leader>gsj"] = {
			"<cmd> GoTagAdd json <CR>",
			"Add json struct tags",
		},
		["<leader>gsy"] = {
			"<cmd> GoTagAdd yaml <CR>",
			"Add yaml struct tags",
		},
	},
}

M.dap_python = {
	plugin = true,
	n = {
		["<leader>dpr"] = {
			function()
				require("dap-python").test_method()
			end,
		},
	},
}

M.lspsaga = {
	plugin = true,
	n = {
		["<leader>lf"] = {
			"<cmd> Lspsaga finder <CR>",
			"Lsp finder",
		},
		["<leader>ld"] = {
			"<cmd> Lspsaga diagnostic_jump_prev <CR>",
			"Lsp diagnostic_jump_prev",
		},
		["<leader>lr"] = {
			"<cmd> Lspsaga rename <CR>",
			"Lsp rename",
		},
	},
}

M.outlines = {
	plugin = true,
	n = {
		["<leader>so"] = {
			"<cmd> SymbolsOutline <CR>",
			"Show outline",
		},
	},
}

M.neotest = {
	plugin = true,
	n = {
		["<leader>tr"] = {
			function()
				require("neotest").run.run()
			end,
			"Run the nearest test",
		},
		["<leader>tf"] = {
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			"Run the current file",
		},
		["<leader>tc"] = {
			function()
				require("coverage").load(true)
			end,
			"Load coverage status",
		},
		["<leader>th"] = {
			function()
				require("coverage").hide()
			end,
			"Hide coverage status",
		},
	},
}

M.inlay = {
	plugin = false,
	n = {
		["<leader>ht"] = {
			function()
				vim.lsp.inlay_hint.enable(true)
			end,
			"Enabled inlay hints",
		},
		["<leader>hs"] = {
			function()
				vim.lsp.inlay_hint.enable(false)
			end,
			"Disabled inlay hints",
		},
	},
}

return M
