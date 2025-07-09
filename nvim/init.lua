require("lazy_setup")

vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.termguicolors = true
vim.opt.fillchars = { eob = " " }

require("catppuccin").setup({
  flavour = "macchiato",
  transparent_background = true,
})
vim.cmd.colorscheme "catppuccin"

require("nvim-tree").setup({
  view = {
    width = 25,
    side = "right",
  },
})

vim.o.guicursor = "n-v-c:block-blinkon0,i:ver25"
vim.opt.guicursor = {
  "v-c-i:block",
  "n:Block",
}
vim.cmd([[
  hi Normal guibg=NONE ctermbg=NONE
  hi NormalNC guibg=NONE ctermbg=NONE
  hi EndOfBuffer guibg=NONE ctermbg=NONE
]])
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  pattern = "*",
  callback = function()
    vim.cmd("silent! write")
  end,
})
