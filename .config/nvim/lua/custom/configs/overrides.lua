local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
    "rust",
    "bash",
    "cpp",
    "dockerfile",
    "elixir",
    "gitignore",
    "go",
    "gomod",
    "json",
    "jsonc",
    "make",
    "nix",
    "proto",
    "python",
    "query",
    "ruby",
    "scss",
    "sql",
    "toml",
    "vimdoc",
    "xml",
    "yaml",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",
    "eslint_d",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- python stuff
    "black",
    "debugpy",
    "pyright",

    -- golang stuff
    "gci",
    "gofumpt",
    "goimports-reviser",
    "golangci-lint",
    "golangci-lint-langserver",
    "golines",
    "gopls",

    -- rust stuff
    "ruff",
    "rust-analyzer",

    -- others
    "shfmt",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
