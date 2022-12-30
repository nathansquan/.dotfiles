-------------------------------------------------------------------------------
-- Neovim API aliases
-------------------------------------------------------------------------------
local cmd = vim.cmd -- execute Vim commands
local exec = vim.api.nvim_exec -- execute Vimscript
local fn = vim.fn -- execute Vim functions
local g = vim.g -- global variables
local opt = vim.opt -- global/buffer/windows-scoped options

-------------------------------------------------------------------------------
-- General
-------------------------------------------------------------------------------
g.mapleader = " " -- change leader to <SPACE>
opt.mouse = "a" -- enable mouse support
opt.clipboard = "unnamedplus" -- copy/paste to system clipboard
opt.swapfile = false -- don't use swapfile
opt.backup = false -- no backup files
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
-- disable netrw at the very start of your init.lua for nvim-tree (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-------------------------------------------------------------------------------
-- Neovim UI
-------------------------------------------------------------------------------
opt.number = true -- show line number
opt.relativenumber = true -- show relative number
opt.errorbells = false -- no error bell
opt.scrolloff = 8 -- Keep lines below cursor when scrolling
opt.signcolumn = "yes" -- sign column on
opt.textwidth = 80 -- set textwidth to 80 characters
opt.colorcolumn = "80" -- set color column at 80 characters
-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"
-- Highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])
-------------------------------------------------------------------------------
-- Tabs, indent
-------------------------------------------------------------------------------
opt.tabstop = 4 -- 1 tab == 4 spaces
opt.shiftwidth = 4 -- shift 4 spaces when tab
opt.softtabstop = 4
opt.expandtab = true -- use spaces instead of tabs
opt.smarttab = true
opt.smartindent = true -- autoindent new lines

-- 2 spaces for selected filetypes
vim.cmd([[
  autocmd FileType lua,yaml setlocal shiftwidth=2 tabstop=2
]])

-------------------------------------------------------------------------------
-- Memory, CPU
-------------------------------------------------------------------------------
opt.hidden = true -- enable background buffers

-------------------------------------------------------------------------------
-- Search
-------------------------------------------------------------------------------
opt.hlsearch = false -- no highlight search
opt.incsearch = true -- use incremental search

-------------------------------------------------------------------------------
-- Colorscheme
-------------------------------------------------------------------------------
opt.termguicolors = true -- enable 24-bit RGB colors
-- colorscheme option go before setting the colorscheme
opt.background = "dark" -- set background to dark
cmd([[
    highlight ColorColumn ctermbg=0 guibg=grey
]])
