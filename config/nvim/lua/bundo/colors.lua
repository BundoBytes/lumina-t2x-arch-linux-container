function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

        --Check out NeoVim's syntax section #highlight-groups section:
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
