local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
	return
end

vim.g.loaded = 1
nvimtree.setup({
	respect_buf_cwd = true,

	-- hijack_netrw = false,
})
