require("nnn").setup({
  picker = {
    cmd = "nnn -a -Pp",
    style = { border = "rounded" },
    session = "shared",
    fullscreen = false
  },
  auto_close = true,
  replace_netrw = "picker"
})
