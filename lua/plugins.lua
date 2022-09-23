-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

vim.g.mapleader = ','
--vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {
	  "ray-x/lsp_signature.nvim",
  }
  -- use 'fatih/vim-go'

  -- Use dependency and run lua function after load
  -- use {
	--   'lewis6991/gitsigns.nvim',
	--   config = function() require('gitsigns').setup{ 
	-- 	  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
	--   }
  -- end
  -- }

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
  -- use 'ellisonleao/gruvbox.nvim'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'ray-x/go.nvim'
  vim.g.NERDTreeFileLines = 1
  use 'hsnks100/nerdtree'
  use 'dyng/ctrlsf.vim'
  use 'ray-x/guihua.lua' -- recommanded if need floating window support
  use ({'jlanzarotta/bufexplorer', 
  config = function() 
  end,
  })
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'xuyuanp/scrollbar.nvim'
  use 'preservim/tagbar'

end)




