local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local conditional = function(fn)
  local utils = require("null-ls.utils").make_conditional_utils()
  return fn(utils)
end

local eslint_config = {
  prefer_local = "node_modules/.bin",
  condition = function(utils)
    return utils.root_has_file({
      ".eslintrc",
      ".eslintrc.js",
      ".eslintrc.cjs",
      ".eslintrc.yaml",
      ".eslintrc.yml",
      ".eslintrc.json",
    })
  end,
}

local opts = {
  debug = false,
  sources = {
    -- Rubocop
    conditional(function(utils)
      return utils.root_has_file("Gemfile")
          and formatting.rubocop.with({
            command = "bundle",
            args = vim.list_extend({ "exec", "rubocop" }, formatting.rubocop._opts.args),
            timeout = 10000,
          })
          or formatting.rubocop
    end),
    conditional(function(utils)
      return utils.root_has_file("Gemfile")
          and diagnostics.rubocop.with({
            command = "bundle",
            args = vim.list_extend({ "exec", "rubocop" }, diagnostics.rubocop._opts.args),
            timeout = 10000,
          })
          or diagnostics.rubocop
    end),
    -- Shell
    formatting.shfmt,
    -- StyLua
    formatting.stylua,
    -- Golang
    formatting.gofumpt,
    formatting.golines,
    -- Python
    formatting.black.with({ extra_args = { "--fast" } }),
    -- SQL
    formatting.sql_formatter,
    -- Prettier
    formatting.prettier.with({
      filetypes = {
        "javascript",
        "typescript",
        "css",
        "scss",
        "html",
        "json",
        "yaml",
        "markdown",
        "go",
        "ruby",
        "lua",
      },
      command = "prettier",
      args = { "--config", vim.env.HOME .. "/.prettierrc.yml", "-" },
      to_stdin = true,
    }),
    formatting.eslint_d.with(eslint_config),
    diagnostics.eslint_d.with({
      diagnostics_format = "[eslint] #{m}\n(#{c})",
    }),
    code_actions.eslint_d.with(eslint_config),
    diagnostics.mypy,
    diagnostics.ruff,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.keymap.set("n", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })

      -- format on save
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
      vim.api.nvim_create_autocmd(event, {
        buffer = bufnr,
        group = group,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = async })
        end,
        desc = "[lsp] format on save",
      })
    end

    if client.supports_method("textDocument/rangeFormatting") then
      vim.keymap.set("x", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })
    end
  end,
}
return opts
