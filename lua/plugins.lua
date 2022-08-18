-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

vim.g.mapleader = ','
vim.keymap.set("n", "<leader>w", "<cmd>BufExplorer<CR>")
vim.keymap.set("n", "<leader>e", "<cmd>Files<CR>")
vim.keymap.set("n", "<c-f>f", "<cmd>CtrlSFPrompt<CR>")
vim.keymap.set("n", "<c-f>n", "<cmd>CtrlSFCwordPath<CR>")
vim.keymap.set("n", "<c-f>p", "<cmd>CtrlSFPwordPath<CR>")
vim.keymap.set("n", "<f2>", "<cmd>NERDTree<CR>")
vim.keymap.set("n", "<leader>feR", "<cmd>source ~/AppData/Local/nvim/init.vim<CR>")
vim.keymap.set("n", "<leader>fed", "<cmd>e ~/AppData/Local/nvim/init.vim<CR>")
vim.keymap.set("n", "<leader>r", "<cmd>cd %:p:h<CR>")
vim.opt.mouse = 'a'
vim.keymap.set("t", "<esc>", "<C-\\><C-N>")
vim.keymap.set("n", "\\\\", "<cmd>bel sp | resize 10 | terminal<CR>")


vim.keymap.set("n", "<left>", "<c-w><")
vim.keymap.set("n", "<right>", "<c-w>>")
vim.keymap.set("n", "<down>", "<c-w>-")
vim.keymap.set("n", "<up>", "<c-w>+")
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Use dependency and run lua function after load
  use {
    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  }

  -- You can specify multiple plugins in a single call
  use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}

  -- You can alias plugin names
  use {'dracula/vim', as = 'dracula'}
  use({
	  "glepnir/lspsaga.nvim",
	  branch = "main",
	  config = function()
		  local saga = require("lspsaga")

		  saga.init_lsp_saga({
			  -- your configuration
		  })
		  vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
	  end,
  })
  use 'ray-x/go.nvim'
  use 'preservim/nerdtree'
  use 'dyng/ctrlsf.vim'
  use 'ray-x/guihua.lua' -- recommanded if need floating window support
  use ({'jlanzarotta/bufexplorer', 
  config = function() 
  end,
  })
end)



