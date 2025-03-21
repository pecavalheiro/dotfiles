-- more configs at https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
	"lua_ls",
	"solargraph",
	"ts_ls",
	"jsonls",
	"elixirls",
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
	ensure_installed = {
		"html",
		"lua_ls",
		"ts_ls",
		"jsonls",
		"elixirls",
	},
	--automatic_installation = true, -- any used server will be installed
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

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "pedro.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end
