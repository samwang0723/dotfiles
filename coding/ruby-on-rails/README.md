# Ruby on Rails

## Setup prettier

.pretterrc.yml
```yaml
printWidth: 80
trailingComma: none
pluginSearchDirs:
  - /Users/samwang/node_modules/prettier-plugin-sql
plugins:
  - prettier-plugin-sql
  - prettier-plugin-sh
  - "@prettier/plugin-ruby"

sql/format:
  keywordCase: upper
  identifierCase: lower
  quoteIdentifiers: false
  indentSize: 2
```

Install Gem and Setup prettier
```bash
# inside neovim :Mason install prettier
which prettier

yarn add --dev prettier @prettier/plugin-ruby

gem install bundler
gem install prettier_print
gem install syntax_tree
gem install syntax_tree-haml
gem install syntax_tree-rbs
# (optional if failed) gem install rbs -v 3.1.3
gem install syntax_tree-rbs

prettier -c {{file}}.rb
```

## Rails LSP

```bash
gem install rubocop
gem install rubocop-performance
gem install rubocop-rails
gem install solargraph
gem install solargraph-rails

solargraph clear
solargraph download-core
yard gems
```

## Rails Neovim Configuration

***The key:** .solargraph.yml need to specifically mark the folder should parse*

null-ls configuration
```lua
local null_ls = require("null-ls")

local conditional = function(fn)
    local utils = require("null-ls.utils").make_conditional_utils()
    return fn(utils)
end

null_ls.setup({
    sources = {
        conditional(function(utils)
            return utils.root_has_file("Gemfile")
                    and null_ls.builtins.formatting.rubocop.with({
                        command = "bundle",
                        args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.formatting.rubocop._opts.args),
                    })
                or null_ls.builtins.formatting.rubocop
        end),
    },
})
```

lsp-config - Solargraph
```lua
lspconfig.solargraph.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
  cmd = { "/Users/samwang/.asdf/shims/solargraph", "stdio" },
  root_dir = util.root_pattern("Gemfile", ".git", "."),
  settings = {
    solargraph = {
      autoformat = true,
      completion = true,
      diagnostic = true,
      folding = true,
      references = true,
      rename = true,
      symbols = true,
    },
  },
}
```

## Debugging

[*https://github.com/pry/pry-stack_explorer*](https://github.com/pry/pry-stack_explorer)

```bash
gem 'pry-stack_explorer', '~> 0.6.0' into Gemfile
bundle install
```

[*https://github.com/deivid-rodriguez/pry-byebug*](https://github.com/deivid-rodriguez/pry-byebug)

*Insert **binding.pry** to the place you want to break*

```bash
show-stack
```

*Only execute failed rspec*

[*https://relishapp.com/rspec/rspec-core/docs/command-line/only-failures*](https://relishapp.com/rspec/rspec-core/docs/command-line/only-failures)

```bash
rspec spec/... --only-failures
```

```ruby
# Check raw SQL
SomeClass.where(uuid: u.uuid).where.not(id: 'xxx').to_sql
```

