return {
  -- LSP + Completion
  { 'neovim/nvim-lspconfig' },          -- LSP support
  { 'hrsh7th/nvim-cmp' },               -- Completion engine
  { 'hrsh7th/cmp-nvim-lsp' },           -- LSP source for cmp
  { 'L3MON4D3/LuaSnip' },               -- Snippet engine
  { 'saadparwaiz1/cmp_luasnip' },       -- Snippets source
  { 'rafamadriz/friendly-snippets' },   -- Snippet collection
  { 'hrsh7th/cmp-buffer' },             -- Buffer completions
  { 'hrsh7th/cmp-path' },               -- File path completions

  -- Mason + Mason-LSP
  {
    'williamboman/mason.nvim',
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls", "pyright", "clangd", "html", "cssls", "jsonls", "bashls" },
        automatic_installation = true,
      })
    end,
  },
  { "mattn/emmet-vim" }
}
