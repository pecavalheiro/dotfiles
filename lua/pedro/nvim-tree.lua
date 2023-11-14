local status_ok, configs = pcall(require, "nvim-tree")
if not status_ok then
  return
end

configs.setup {
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
}
