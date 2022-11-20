local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

-- Nvimtree
keymap("n", "<leader>t", ":NvimTreeToggle<cr>", opts)
