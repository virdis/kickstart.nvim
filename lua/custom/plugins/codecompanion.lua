return {
  'olimorris/codecompanion.nvim',
  version = '^18.0.0',
  opts = function()
    return {
      strategies = {
        chat = {
          adapter = 'ollama',
          slash_commands = {
            ['buffer'] = {
              callback = 'strategies.chat.slash_commands.buffer',
              description = 'Insert open buffers',
              opts = {
                contains_code = true,
                provider = 'telescope',
              },
            },
            ['file'] = {
              callback = 'strategies.chat.slash_commands.file',
              description = 'Insert current file',
              opts = {
                contains_code = true,
                provider = 'telescope',
              },
            },
          },
          inline = { adapter = 'ollama' },
          cmd = { adapter = 'ollama' },
        },
      },
      adapters = {
        http = {
          opts = {
            show_presets = false,
            show_model_choices = true,
          },
        },
        ollama = function()
          return require('codecompanion.adapters').extend('ollama', {
            name = 'ollama_glm47flash', -- Give this adapter a different name to differentiate it from the default ollama adapter
            opts = {
              -- vision = true,
              stream = true,
            },
            schema = {
              model = {
                default = 'glm-4.7-flash:bf16',
              },
              num_ctx = {
                default = 20000,
              },
              think = {
                default = true,
                -- or, if you want to automatically turn on `think` for certain models:
                default = function(adapter)
                  -- this'll set `think` to true if the model name contain `qwen3` or `deepseek-r1`
                  local model_name = adapter.model.name:lower()
                  return vim.iter({ 'glm-', 'gpt-' }):any(function(kw) return string.find(model_name, kw) ~= nil end)
                end,
              },
              keep_alive = {
                default = '15m',
              },
            },
          })
        end,
        gpt_ollama = function()
          return require('codecompanion.adapters').extend('ollama', {
            name = 'gpt_ollama', -- Give this adapter a different name to differentiate it from the default ollama adapter
            opts = {
              -- vision = true,
              stream = true,
            },
            schema = {
              model = {
                default = 'gpt-oss:120b',
              },
              num_ctx = {
                default = 20000,
              },
              think = {
                default = true,
                -- or, if you want to automatically turn on `think` for certain models:
                default = function(adapter)
                  -- this'll set `think` to true if the model name contain `qwen3` or `deepseek-r1`
                  local model_name = adapter.model.name:lower()
                  return vim.iter({ 'glm-', 'gpt-' }):any(function(kw) return string.find(model_name, kw) ~= nil end)
                end,
              },
              keep_alive = {
                default = '15m',
              },
            },
          })
        end,
      },
    }
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
}
