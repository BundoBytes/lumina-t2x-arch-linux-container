local builtin = require('telescope.builtin')
--'n' means: while in NORMAL mode, do this....
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
--'<C-p>' means Ctrl + p while in normal mode.
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ")})
end)
