local lsp_zero = require('lsp-zero')

-- Note: on_attach() is attached to any buffer that has an LSP associated with it.
--       The buffer content refers to anything being displayed on the terminal. Thus,
--       the following keymaps only apply towards the currently displayed text.
lsp_zero.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}
  -- Lookup definition:
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  -- Exclusive for searching stuff in nvim's folders:
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.lsp.buf.open_float() end, opts)
end)

-- Add LSPs from:
-- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'rust_analyzer', 'lua_ls', 'clangd', 'golangci_lint_ls', 'jdtls',
                      'tsserver', 'pylsp'},
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end
  },
  -- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  -- Ignore Python line-limit error E501:
  settings = {
    require('lspconfig').pylsp.setup({ settings = { pylsp = { plugins = { pycodestyle =
                                      { ignore = { "E501" } } } } } }),
    require('lspconfig').golangci_lint_ls.setup({
      cmd = { "golangci-lint-langserver" },
    })
  }
})

--[[Old Setup Auto-Completion Settings with lsp-zero
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'nvim_lua'}
  },
  formatting = lsp_zero.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  })
})
--]]

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- Trigger and select completion menu
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    ['<C-Space>'] = cmp.mapping.complete(),
    -- Navigate between snippets
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    -- Scroll up and down in completion docs
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  })
})
