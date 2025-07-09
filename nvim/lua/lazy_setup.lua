local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- or latte, frappe, macchiato
        transparent_background = false,
      })
      vim.cmd.colorscheme "catppuccin"
    end,
  },

  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup()
    end,
  },

  -- Statusline (optional, for visual polish)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup {
        options = { theme = "catppuccin" }
      }
    end,
  },
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
      dashboard.button("o", "  Open folder", ":cd ~/"),
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
    vim.cmd[[highlight AlphaHeader guifg=#89b4fa]]
    vim.cmd[[highlight AlphaButtons guifg=#f38ba8]]
    vim.cmd[[highlight AlphaFooter guifg=#a6e3a1]]
    vim.cmd[[highlight AlphaFooter guifg=#a6e3a1]]
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
})
