local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

lspconfig.gopls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls", "-v", "-rpc.trace", "serve", "--debug=localhost:6060" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      staticcheck = false,
      usePlaceholders = true,
      semanticTokens = true,
      codelenses = {
        generate = true,
        test = true,
      },
      matcher = "fuzzy",
      symbolMatcher = "fuzzy",
      analyses = {
        printf = true,
        fillreturns = true,
        nonewvars = true,
        undeclaredname = true,
        unusedparams = true,
        unreachable = true,
        -- fieldalignment = true,
        ifaceassert = true,
        nilness = true,
        shadow = true,
        unusedwrite = true,
        fillstruct = true,
      },
      annotations = {
        escape = true,
        inline = true,
        bounds = true,
      },
      deepCompletion = true,
      verboseOutput = true,
      gofumpt = true,
      directoryFilters = {
        "-node_modules",
        "-third_party",
      },
    },
  },
})

lspconfig.golangci_lint_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
})

-- Javascript & Typescript LSP
lspconfig.ts_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
})

lspconfig.eslint.setup({
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
  capabilities = capabilities,
})

-- HTML/CSS LSP
-- npm i -g vscode-langservers-extracted
lspconfig.html.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
})

-- npm i -g vscode-langservers-extracted
lspconfig.cssls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
})

-- npm i -g vscode-langservers-extracted
lspconfig.jsonls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Python
lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
})

-- Solargraph
lspconfig.solargraph.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
  root_dir = function(fname)
    local root = fname:match(".*/github.com/cdc-internal/.-/")
    return root ~= nil and root or util.root_pattern(".git", "Gemfile")(fname)
  end,
  commandPath = "/Users/samwang/.asdf/shims/solargraph",
  useBundler = false,
  diagnostics = true,
  completion = true,
  autoformat = true,
  diagnostic = true,
  folding = true,
  references = true,
  rename = true,
  symbols = true,
})

-- General LSP loading
local f_status_ok, fidget = pcall(require, "fidget")
if not f_status_ok then
  vim.notify("fidget: cannot be found!")
  return
end

fidget.setup({})
