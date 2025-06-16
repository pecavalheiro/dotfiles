-- more configs at https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
  "elixirls",
  "html",
  "jsonls",
  "lua_ls",
  "solargraph",
  "ts_ls",
}

require("mason").setup({
  ui = {
    border = "none",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
})

require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = false, -- any used server will be installed
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("pedro.lsp.handlers").on_attach,
    capabilities = require("pedro.lsp.handlers").capabilities,
  }

  -- Handle server names with version specifiers
  local server_name = vim.split(server, "@")[1]

  -- Load server-specific settings if available
  local require_ok, conf_opts = pcall(require, "pedro.lsp.settings." .. server_name)
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  -- Setup the server
  lspconfig[server_name].setup(opts)
end
