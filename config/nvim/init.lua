-- Setup clipboard:
vim.opt.clipboard = 'unnamedplus'

-- Use 2 spaces for indentation
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- Highlight currently selected line
vim.wo.cursorline = true

-- Draw Vertical Ruler
-- vim.api.nvim_set_option_value('textwidth', 95, {}) -- Set column position
vim.api.nvim_set_option_value('colorcolumn', '94', {}) -- Display the ruler
vim.cmd 'highlight ColorColumn ctermbg=lightgrey guibg=lightgrey'
--vim.cmd 'hi SignColumn guibg=none'
vim.opt.signcolumn = "no"

--lazy is a NeoVim package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--This is how you run lazy plugin manager:
require("lazy").setup({
  { 'williamboman/mason.nvim' }, --LSPs download manager
  { 'williamboman/mason-lspconfig.nvim' }, --Mason extension to configure installed LSPs
  { 'VonHeikemen/lsp-zero.nvim',  --Middle-man that bridges nvim-lspconfig + nvim-cmp
    branch = 'v3.x',
    lazy = true,
    config = false,
  },
  { 'neovim/nvim-lspconfig',  --Lang Server Protocol; syntax checking/auto-completions, etc.
    dependencies = {          --It does NOT handle installing LSPs; use Mason instead for that.
      {'hrsh7th/cmp-nvim-lsp'}
    }
  },
  { 'hrsh7th/nvim-cmp',       --The actual auto-completion implementation
    dependencies = {
      {'L3MON4d3/LuaSnip'}
    }
  },
  { 'tpope/vim-fugitive' }, --Git functionality
  { 'mbbill/undotree' },
  { 'ThePrimeagen/harpoon' },
  { 'rose-pine/neovim', name = 'rose-pine' }, --Colors
  { 'nvim-lua/plenary.nvim' }, --Dependency of telescope, which is a fuzzy finder
  {
    'nvim-treesitter/nvim-treesitter', --Highlighting of text!
    build = ":TSUpdate"
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
    depedencies = { 'nvim-lua/plenary.nvim' }
  },
  { 'karb94/neoscroll.nvim' }, --Ctrl+u/d to scroll up and down
  {  --Multi-line editing
    'mg979/vim-visual-multi',
    init = function()
      vim.g["VM_default_mappings"] = 0
      vim.g["VM_maps"] = {
        ["Mouse Cursor"] = '<M-LeftMouse>',
        ["Add Cursor Up"] = '<C-k>',
        ["Add Cursor Down"] = '<C-j>'
      }
    end
  },
  { 'luukvbaal/nnn.nvim' },
  { --Markdown Live Preview (i.e. README.md files) with :MarkdownPreview command:
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  }
})

require("bundo")
require("bundo.colors")
require("bundo.telescope")
require("bundo.treesitter")
require("bundo.harpoon")
require("bundo.undotree")
require("bundo.fugitive")
require("bundo.lsp")
require("bundo.neoscroll")
require("bundo.multi")
require("bundo.nnn")

-- Enable spell checking for .txt files:
vim.api.nvim_exec([[
  autocmd BufNewFile,BufRead *.txt setlocal spell
]], false)
