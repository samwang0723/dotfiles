local cmp = require("cmp")
local overrides = require("custom.configs.overrides")
require("core.utils").load_mappings("inlay")

local plugins = {
  "NvChad/nvcommunity",

  {
    import = "nvcommunity.lsp.lspsaga",
    require("core.utils").load_mappings("lspsaga"),
  },
  {
    "lewis6991/gitsigns.nvim",
    init = function()
      require("gitsigns").setup()
    end,
  },

  -- LSP configurations
  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.configs.lspconfig")
      require("custom.configs.lspconfig")
    end,
    lazy = false,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      return require("custom.configs.null-ls")
    end,
    lazy = false,
  },
  {
    "MunifTanjim/prettier.nvim",
    dependencies = "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("custom.configs.prettier")
    end,
    lazy = false,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local M = require("plugins.configs.cmp")
      M.completion.completeopt = "menu,menuone,noselect"
      M.mapping["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = false,
      })
      table.insert(M.sources, { name = "crates" })
      return M
    end,
  },
  { "j-hui/fidget.nvim",      tag = "legacy" },
  {
    "simrat39/symbols-outline.nvim",
    init = function()
      require("symbols-outline").setup()
      require("core.utils").load_mappings("outlines")
    end,
  },

  -- Rust configurations
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function()
      vim.g.rustaceanvim = require("custom.configs.rustaceanvim")
    end,
  },
  {
    "mfussenegger/nvim-dap",
    init = function()
      require("core.utils").load_mappings("dap")
    end,
  },
  {
    "saecki/crates.nvim",
    ft = { "toml" },
    config = function(_, opts)
      local crates = require("crates")
      crates.setup(opts)
      require("cmp").setup.buffer({
        sources = { { name = "crates" } },
      })
      crates.show()
      require("core.utils").load_mappings("crates")
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = false,
    config = function(_, opts)
      require("nvim-dap-virtual-text").setup()
    end,
  },

  -- Golang configurations
  {
    "dreamsofcode-io/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings("dap_go")
    end,
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings("gopher")
    end,
    build = function()
      vim.cmd([[silent! GoInstallDeps]])
    end,
  },

  -- Python configurations
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      require("core.utils").load_mappings("dap_python")
    end,
  },

  -- Style configurations
  {
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    config = function()
      require("custom.configs.nvim-tree")
    end,
    lazy = false,
  },

  -- ChatGPT / AI
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = function()
      local M = {}
      M.copilot = {
        -- Possible configurable fields can be found on:
        -- https://github.com/zbirenbaum/copilot.lua#setup-and-configuration
        suggestion = {
          enable = false,
        },
        panel = {
          enable = false,
        },
      }
      return M
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup()
        end,
      },
    },
    opts = {
      sources = {
        { name = "nvim_lsp", group_index = 2 },
        { name = "copilot",  group_index = 2 },
        { name = "luasnip",  group_index = 2 },
        { name = "buffer",   group_index = 2 },
        { name = "nvim_lua", group_index = 2 },
        { name = "path",     group_index = 2 },
      },
    },
  },

  -- Moody for mode cursorline
  {
    "svampkorg/moody.nvim",
    event = { "ModeChanged", "BufWinEnter", "WinEnter" },
    dependencies = {
      -- or whatever "colorscheme" you use to setup your HL groups :)
      -- Colours can also be set within setup, in which case this is redundant.
      "catppuccin/nvim",
      -- for seeing Moody's take on folds
      "kevinhwang91/nvim-ufo",
    },
    opts = {
      -- you can set different blend values for your different modes.
      -- Some colours might look better more dark, so set a higher value
      -- will result in a darker shade.
      blends = {
        normal = 0.3,
        insert = 0.3,
        visual = 0.45,
        command = 0.4,
        operator = 0.4,
        replace = 0.4,
        select = 0.4,
        terminal = 0.4,
        terminal_n = 0.4,
      },
      -- there are two ways to define colours for the different modes.
      -- one way is to define theme here in colors. Another way is to
      -- set them up with highlight groups. Any highlight group set takes
      -- precedence over any colours defined here.
      colors = {
        normal = "#00BFFF",
        insert = "#70CF67",
        visual = "#AD6FF7",
        command = "#EB788B",
        operator = "#FF8F40",
        replace = "#E66767",
        select = "#AD6FF7",
        terminal = "#4CD4BD",
        terminal_n = "#00BBCC",
      },
      -- disable filetypes here. Add for example "TelescopePrompt" to
      -- not have any coloured cursorline for the telescope prompt.
      disabled_filetypes = { "TelescopePrompt" },
      -- disabled buftypes here
      disabled_buftypes = {},
      -- you can turn on or off bold characters for the line numbers
      bold_nr = true,
      -- you can turn on and off a feature which shows a little icon and
      -- registry number at the end of the CursorLine, for when you are
      -- recording a macro! Default is false.
      recording = {
        enabled = false,
        icon = "󰑋",
        -- you can set some text to surround the recording registry char with
        -- or just set one to empty to maybe have just one letter, an arrow
        -- perhaps! For example recording to q, you could have! "󰑋    q" :D
        pre_registry_text = "[",
        post_registry_text = "]",
        -- if you have some other plugin showing up on the right you can pad
        -- the recording indicator on the right side, to shift it to the left.
        -- For example if you use Satellite you have to shift recording to the left.
        -- using right padding.
        right_padding = 2,
      },
      -- extend the cursorline to cover line numbers.
      extend_to_linenr = true,
      -- extend_to_linenr_visual enables moodys built in statuscolumn to cover linenr in
      -- visual selection to show the visual range of the selection highlighted by
      -- Visual hl group.
      extend_to_linenr_visual = false,
      -- setting reduce_cursorline to true will reduce the moodys cursorline to.. nothing!
      -- It will make the cursorline have the default value of whatever cursorline has in the
      -- default "hightlight namespace", 0. TLDR: no moody change in cursorline with ModeChanged.
      reduce_cursorline = false,
      -- fold_options.enabled also enables the built in SignColumn in moody. These folds takes a bit of a different
      -- approach to showing folds and their range. Try it out and see if you like it :) If not you can use
      -- the SignColumn as is, with extend_to_linenr. It will then only show diagnostic signs and linenr.
      -- This requires nvim-ufo, and will possibly break your current custom SignColumn (if you have any)
      fold_options = {
        enabled = false,
        -- these are two colors you can specifiy which will be used to generate a gradient
        -- with one step for each fold level, specified by vim.o.foldnestmax
        start_color = "#C1C1C1",
        end_color = "#2F2F2F",
      },
    },
  },

  -- testing
  {
    "andythigpen/nvim-coverage",
    requires = "nvim-lua/plenary.nvim",
    -- Optional: needed for PHP when using the cobertura parser
    rocks = { "lua-xmlreader" },
    config = function()
      require("coverage").setup({
        commands = true, -- create commands
        highlights = {
          -- customize highlight groups created by the plugin
          covered = { fg = "#C3E88D" }, -- supports style, fg, bg, sp (see :h highlight-gui)
          uncovered = { fg = "#F07178" },
        },
        signs = {
          -- use your own highlight groups or text markers
          covered = { hl = "CoverageCovered", text = "▎" },
          uncovered = { hl = "CoverageUncovered", text = "▎" },
        },
        summary = {
          -- customize the summary pop-up
          min_coverage = 80.0, -- minimum coverage threshold (used for highlighting)
        },
        lang = {
          -- customize language specific settings
        },
      })
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "fredrikaverpil/neotest-golang", -- Installation
      "mrcjkb/rustaceanvim",
    },
    init = function()
      require("core.utils").load_mappings("neotest")
    end,
    config = function()
      local config = { -- Specify configuration
        go_test_args = {
          "-v",
          "-race",
          "-count=1",
          "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
        },
      }
      require("neotest").setup({
        adapters = {
          require("neotest-golang")(config), -- Registration
          require("rustaceanvim.neotest"),
        },
      })
    end,
  },
  -- diff view
  { "sindrets/diffview.nvim", lazy = false },
}
return plugins
