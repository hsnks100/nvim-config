vim.keymap.set("n", "<leader>w", "<cmd>BufExplorer<CR>")
vim.keymap.set("n", "<leader>e", "<cmd>Files<CR>")
-- vim.keymap.set("n", "<c-f>f", "<cmd>CtrlSF<CR>")
vim.keymap.set("n", "<c-f>n", "<cmd>CtrlSFCwordPath<CR>")
vim.keymap.set("n", "<c-f>p", "<cmd>CtrlSFPwordPath<CR>")
vim.keymap.set("n", "<leader>n", "<cmd>NERDTree<CR>")
vim.keymap.set("n", "<leader>feR", "<cmd>source ~/.config/nvim/init.vim<CR>")
vim.keymap.set("n", "<leader>fed", "<cmd>e ~/.config/nvim/<CR>")
vim.keymap.set("n", "<leader>r", "<cmd>cd %:p:h<CR>")
vim.opt.mouse = 'a'
vim.keymap.set("t", "<esc>", "<C-\\><C-N>")
vim.keymap.set("n", "\\\\", "<cmd>bel sp | resize 10 | terminal<CR>")


vim.keymap.set("n", "<left>", "<c-w><")
vim.keymap.set("n", "<right>", "<c-w>>")
vim.keymap.set("n", "<down>", "<c-w>-")
vim.keymap.set("n", "<up>", "<c-w>+")
vim.keymap.set("n", "<leader>gr", "<cmd>Lspsaga rename<CR>", { silent = true })
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	}
})


