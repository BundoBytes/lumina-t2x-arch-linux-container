local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<leader>r", mark.toggle_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
vim.cmd('highlight! TabLineFill guibg=white guifg=white')

--vim.keymap.set("n", "<C-F1>", function() ui.nav_file(1) end)
--vim.keymap.set("n", "<C-F2>", function() ui.nav_file(2) end)
--vim.keymap.set("n", "<C-F3>", function() ui.nav_file(3) end)
--vim.keymap.set("n", "<C-F4>", function() ui.nav_file(4) end)
