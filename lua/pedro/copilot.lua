local status_ok, copilot = pcall(require, "copilot")
if not status_ok then
  return
end

copilot.setup {
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
  },
  copilot_node_command = 'node', -- Node.js version must be > 16.x
  server_opts_overrides = {},
}
