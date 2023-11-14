local status_ok, blankline = pcall(require, "ibl")
if not status_ok then
  return
end

blankline.setup {
    -- for example, context is off by default, use this to turn it on
   --show_current_context = true,
   --show_current_context_start = true,
}
