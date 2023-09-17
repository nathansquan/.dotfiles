-------------------------------------------------------------------------------
-- Plugin manager configuration file
-------------------------------------------------------------------------------

-- Plugin manager: packer.nvim
-- https://github.com/wbthomason/packer.nvim

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- file tree explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {'kyazdani42/nvim-web-devicons'}
  }

  -- Highlight, edit, navigate code using TreeSitter
  use 'nvim-treesitter/nvim-treesitter'

  -- Telescope fuzzy finder
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Git stuff
  use 'tpope/vim-fugitive'

  -- repl
  use 'hkupty/iron.nvim'

  -- LSP
  use {
  'VonHeikemen/lsp-zero.nvim',
  requires = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-path'},
    {'saadparwaiz1/cmp_luasnip'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/cmp-nvim-lua'},

    -- Snippets
    {'L3MON4D3/LuaSnip'},
    {'rafamadriz/friendly-snippets'},
  }
}

  -- DAP
  use 'mfussenegger/nvim-dap'
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  use 'folke/neodev.nvim'

  -- commenting
  use "numToStr/Comment.nvim"

  -- indent guides
  use "lukas-reineke/indent-blankline.nvim"

  -- Colorschemes
  use 'shaunsingh/nord.nvim'
  use 'catppuccin/nvim'
  use 'rose-pine/neovim'
  use 'sainnhe/everforest'

end)
