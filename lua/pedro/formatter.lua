local status_ok, formatter = pcall(require, "formatter")
if not status_ok then
  return
end

local util = require "formatter.util"

formatter.setup {
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    ruby = { require("formatter.filetypes.ruby").rubocop },
    typescriptreact = {
      function()
        return {
          exe = "yarn run --silent prettier",
          args = { util.escape_path(util.get_current_buffer_file_path()) },
          stdin = true,
        }
      end
    },
    ["*"] = {
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}

vim.cmd [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END
]]
