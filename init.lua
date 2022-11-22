require("core.options")
require("core.keymaps")
require("core.colorscheme")
require("plugins.plugin-setup")
require("plugins.comment")
require("plugins.nvim-tree")
require("plugins.lualine")
require("plugins.telescope")
require("plugins.nvim-cmp")

require("plugins.lsp.mason")
require("plugins.lsp.lspsaga")
require("plugins.lsp.lspconfig")
require("plugins.lsp.null-ls")
require("plugins.lsp.rust")

require("plugins.treesitter")
require("plugins.ctrlsf")

local prevTab = 0
function KsooTab()
	print("kt")
	return "<Tab>"
	-- return vim.fn.getcmdline()
end

local keymap = vim.keymap
keymap.set("c", "<CR>", function()
	if vim.fn.wildmenumode() == 1 then
		return "<C-y>"
	else
		return "<CR>"
	end
end, { expr = true, remap = true, noremap = true })
