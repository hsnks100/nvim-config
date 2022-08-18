-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

vim.g.mapleader = ','
--vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
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
	  end,
  })
  use 'ellisonleao/gruvbox.nvim'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'ray-x/go.nvim'
  use 'preservim/nerdtree'
  use 'dyng/ctrlsf.vim'
  use 'ray-x/guihua.lua' -- recommanded if need floating window support
  use ({'jlanzarotta/bufexplorer', 
  config = function() 
  end,
  })
end)



