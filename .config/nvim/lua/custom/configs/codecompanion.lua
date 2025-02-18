local status_ok, codecompanion = pcall(require, "codecompanion")
if not status_ok then
  vim.notify("codecompanion: cannot be found!")
  return
end

codecompanion.setup({
  strategies = {
    chat = {
      adapter = "anthropic",
      slash_commands = {
        ["file"] = {
          -- Location to the slash command in CodeCompanion
          callback = "strategies.chat.slash_commands.file",
          description = "Select a file using Telescope",
          opts = {
            provider = "telescope", -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
            contains_code = true,
          },
        },
      },
    },
    inline = {
      adapter = "anthropic",
    },
  },
  display = {
    chat = {
      intro_message = "Welcome to CodeCompanion ✨! Press ? for options",
      show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
      separator = "─", -- The separator between the different messages in the chat buffer
      show_references = true, -- Show references (from slash commands and variables) in the chat buffer?
      show_settings = false, -- Show LLM settings at the top of the chat buffer?
      show_token_count = true, -- Show the token count for each response?
      start_in_insert_mode = true, -- Open the chat buffer in insert mode?
    },
  },
  opts = {
    log_level = "DEBUG",
    send_code = true,
  },
  adapters = {
    chat = {
      notify = function(msg, level)
        require("fidget").notify(msg, level)
      end,
    },
    openai = function()
      return require("codecompanion.adapters").extend("openai", {
        schema = {
          model = {
            default = "o1",
          },
        },
      })
    end,
    anthropic = function()
      return require("codecompanion.adapters").extend("anthropic", {
        schema = {
          model = {
            default = "claude-3-5-sonnet-latest",
          },
        },
      })
    end,
  },
})
