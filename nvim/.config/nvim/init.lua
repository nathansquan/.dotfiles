-------------------------------------------------------------------------------
-- Import Lua Modules
-------------------------------------------------------------------------------

require("user.options")
require("user.keymaps")
require("user.plugins")
require("user.nvim-tree")
require("user.mason")
require("user.nvim-lspconfig")
-- Compile Packer each time init.lua is written
vim.cmd([[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]])
