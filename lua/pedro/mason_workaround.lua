-- Workaround for mason-lspconfig compatibility issue
local M = {}

-- This function creates a patched version of the automatic_enable feature
M.setup = function()
    -- Get the original automatic_enable module
    local ok, automatic_enable = pcall(require, "mason-lspconfig.features.automatic_enable")
    if not ok then
        vim.notify("Could not find mason-lspconfig.features.automatic_enable", vim.log.levels.WARN)
        return
    end

    -- Create a patched version of the init function
    local original_init = automatic_enable.init
    automatic_enable.init = function(...)
        -- Check if lspconfig is properly loaded
        local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
        if not lspconfig_ok then
            vim.notify("lspconfig not found, skipping automatic_enable", vim.log.levels.WARN)
            return
        end

        -- Make sure the enable function exists for each server
        for _, server_name in ipairs(require("mason-lspconfig").get_installed_servers()) do
            if lspconfig[server_name] and not lspconfig[server_name].enable then
                lspconfig[server_name].enable = function(opts)
                    lspconfig[server_name].setup(opts or {})
                end
            end
        end

        -- Call the original init function
        pcall(original_init, ...)
    end
end

return M
