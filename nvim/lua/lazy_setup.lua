local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Theme
  --
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   priority = 1000,
  --   config = function()
  --       require("catppuccin").setup({
  --         flavour = "mocha", -- or latte, frappe, macchiato
  --         transparent_background = true,
  --       })
  --   vim.cmd.colorscheme "catppuccin"
  --   end,
  -- },
  --
  -- {
  --   "folke/tokyonight.nvim",
  --   priority = 1000,
  --   config = function()
  --       require("tokyonight").setup({
  --         style = "night",
  --         transparent = true,  -- ✅ enables transparent background
  --       })
  --   vim.cmd("colorscheme tokyonight")
  --   end,
  -- },
  --

{
  "Rigellute/shades-of-purple.vim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd("colorscheme shades_of_purple")
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        local transparent_groups = {
          "Normal", "NormalNC", "NormalFloat",
          "LineNr", "CursorLineNr", "SignColumn",
          "VertSplit", "StatusLine", "StatusLineNC",
          "EndOfBuffer", "WinSeparator", "FloatBorder",
        }

    for _, group in ipairs(transparent_groups) do
      vim.api.nvim_set_hl(0, group, { bg = "none" })
    end
    end,
  },
  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({view = {width = 25, side = "right"}})
    end,
  },

  -- Statusline (optional, for visual polish)
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   config = function()
  --     require("lualine").setup {
  --       options = { theme = "auto" }
  --     }
  --   end,
  -- },

  {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = {
          normal = {
            a = { fg = "#ffffff", bg = "none", gui = "bold" },
            b = { fg = "#c678dd", bg = "none" },
            c = { fg = "#b894f0", bg = "none" },
          },
          insert = {
            a = { fg = "#ffffff", bg = "none", gui = "bold" },
          },
          visual = {
            a = { fg = "#ffffff", bg = "none", gui = "bold" },
          },
          replace = {
            a = { fg = "#ffffff", bg = "none", gui = "bold" },
          },
          inactive = {
            a = { fg = "#888888", bg = "none" },
            b = { fg = "#888888", bg = "none" },
            c = { fg = "#888888", bg = "none" },
          },
        },
        component_separators = '',
        section_separators = '',
      },
    })
  end,
},
--   require("lualine").setup({
--   options = {
--     theme = {
--       normal = {
--         a = { fg = "#ffffff", bg = "none", gui = "bold" },
--         b = { fg = "#c678dd", bg = "none" },
--         c = { fg = "#a9a9b3", bg = "none" },
--       },
--       insert = {
--         a = { fg = "#ffffff", bg = "none", gui = "bold" },
--       },
--       visual = {
--         a = { fg = "#ffffff", bg = "none", gui = "bold" },
--       },
--       replace = {
--         a = { fg = "#ffffff", bg = "none", gui = "bold" },
--       },
--       inactive = {
--         a = { fg = "#888888", bg = "none" },
--         b = { fg = "#888888", bg = "none" },
--         c = { fg = "#888888", bg = "none" },
--       },
--     },
--     section_separators = '',
--     component_separators = '',
--   },
-- })

  {
    'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function ()
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = {
     [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
     [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
     [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
     [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
     [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
     [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
    }

    dashboard.section.buttons.val = {
      dashboard.button("n", "  New file", ":ene <BAR> startinsert<CR>"),
      dashboard.button("d", "  New folder", ":mkdir "),
      dashboard.button("o", "  Open folder", function() require('telescope.builtin').find_files({ cwd = vim.fn.expand("~"), hidden = true }) end),
      dashboard.button("f", "  File Tree", ":NvimTreeToggle<CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
    }
    -- list of random quotes
    local quotes = {
    "A programmer is a tool that converts caffeine into code.",
    "It's not a bug, it's a feature.",
    "Weeks of programming can save you hours of planning.",
    "To understand what recursion is, you must first understand recursion.",
    "There is no Ctrl+Z in production.",
    "It works on my machine.",
    "Deleted code is debugged code.",
    "In case of fire: git commit, git push, leave building.",
    "Programming: turning pizza and caffeine into software.",
  }
    -- Random quotes picker
    math.randomseed(os.time()) -- seed randomness
    local random_quote = quotes[math.random(#quotes)]
    
    -- TOP PADDING PICKER FOR VERTICAL CENTERING
    local function get_padding()
    local height = vim.fn.winheight(0)
    local content_height = 6 + 5 + 2 -- header lines + buttons + spacing
    return math.max(0, math.floor((height - content_height) / 2))
    end

    dashboard.section.footer.val = {
      "“" .. random_quote .. "”",
    }
    dashboard.section.header.opts = { 
	    position = "center",
	    hl = "AlphaHeader",
	    spacing = 1
    }
    dashboard.section.buttons.opts = { 
      position = "center",
	    hl = "AlphaButtons",
      spacing = 1
    }
    dashboard.section.footer.opts = { 
      position = "center",
	    hl = "AlphaFooter",
      spacing = 1
    }
    dashboard.section.footer.opts = {
      position = "center",
      hl = "AlphaFooter",
    }
    dashboard.config.layout = {
      { type = "padding", val = get_padding()-3 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 2 },
      dashboard.section.footer,
    }
    -- COLORS
    vim.cmd[[highlight AlphaHeader guifg=#b940ff]]
    vim.cmd[[highlight AlphaButtons guifg=#894aff]]
    vim.cmd[[highlight AlphaFooter guifg=#894aff]]
    require("alpha").setup(dashboard.config)
  end
  },
  -- Mason + LSP
{
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  config = function()
    require("mason").setup()
  end,
},
{
  "williamboman/mason-lspconfig.nvim",
  dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "ts_ls", "pyright", "clangd", "html", "cssls", "jsonls", "bashls" },
      automatic_installation = true,
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
          })
        end,
      },
    })
  end,
},

-- Autocompletion
{
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }),
    })
  end,
},

-- Auto-pairing
{
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup({
      check_ts = true,
      ts_config = {
        lua = {"string", "source"},
        javascript = {"string", "source"},
        html = {"string", "source"},
        css = {"string", "source"},
        cpp = {"string", "source"},
        bash = {"string", "source"},
      },
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      con_check_filetype = true,
    })
  end,
},
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
  { "mattn/emmet-vim" },
  {
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup()
  end,
},
{
  'nvim-lua/plenary.nvim',
},

{
  'nvim-telescope/telescope.nvim',
  tag = '0.1.6',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    require('telescope').setup{}
  end,
},
{
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = { 'c', 'cpp', 'lua', 'vim', 'vimdoc', 'query', 'javascript', 'json', 'css', 'html', 'bash' },
      auto_install = true,
      highlight = { enable = true },
    })
  end,
}
})
