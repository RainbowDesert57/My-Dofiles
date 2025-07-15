vim.g.mapleader = ' '
require("lazy_setup")

vim.cmd ("set tabstop=2 shiftwidth=2 expandtab")
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.termguicolors = true
vim.opt.fillchars = { eob = " " }
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })

--vim.cmd("set tabstop=2")
--vim.cmd("set shitwidth=2")
-- vim.cmd("set expandtab")


-- {
    -- 'nvim-telescope/telescope.nvim', tag = '0.1.8',
      -- dependencies = { 'nvim-lua/plenary.nvim' }
-- }



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
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- require("lazy").setup({
--   spec = {
--     -- import your plugins
--     { import = "plugins" },
--   },
--   -- Configure any other settings here. See the documentation for more details.
--   -- colorscheme that will be used when installing plugins.
--   install = { colorscheme = { "habamax" } },
--   -- automatically check for plugin updates
--   checker = { enabled = true },
-- })


