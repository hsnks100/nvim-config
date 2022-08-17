-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

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
  use 'ray-x/guihua.lua' -- recommanded if need floating window support
end)


