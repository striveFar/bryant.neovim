vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<Esc>")

vim.keymap.set("n", "<C-b>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- hop configuration

local hop = require('hop')
local directions = require('hop.hint').HintDirection
keymap.set("n", "<leader>hh", "<cmd>HopWordMW<CR>", { desc = "Hop word across windows" })
