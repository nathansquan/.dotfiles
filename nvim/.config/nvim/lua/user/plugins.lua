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

  -- Manage external editor tooling
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  -- Configurations for Nvim LSP
  use 'neovim/nvim-lspconfig'
end)
