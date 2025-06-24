local prettier_status_ok, prettier = pcall(require, "prettier")
if not prettier_status_ok then
  vim.notify "prettier: cannot be found!"
  return
end

prettier.setup {
  debug = false,
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "css",
    "scss",
    "html",
    "json",
    "yaml",
    "markdown",
    "go",
    "ruby",
    "less",
  },
  bin = "prettier",
  --args = { "--config", vim.env.HOME .. "/.prettierrc.yml", "-" },
  --to_stdin = true,
  ["none-ls"] = {
    condition = function()
      return prettier.config_exists {
        -- if `false`, skips checking `package.json` for `"prettier"` key
        check_package_json = true,
      }
    end,
    runtime_condition = function(params)
      -- return false to skip running prettier
      return true
    end,
    timeout = 10000,
  },
  cli_options = {
    -- arrow_parens = "always",
    -- bracket_spacing = true,
    -- bracket_same_line = false,
    embedded_language_formatting = "auto",
    -- end_of_line = "lf",
    -- html_whitespace_sensitivity = "css",
    -- jsx_bracket_same_line = false,
    -- jsx_single_quote = false,
    print_width = 80,
    --prose_wrap = "preserve",
    quote_props = "preserve",
    -- semi = true,
    -- single_attribute_per_line = false,
    single_quote = true,
    --tab_width = 2,
    trailing_comma = "none",
    --use_tabs = false,
    --vue_indent_script_and_style = false,
  },
}
