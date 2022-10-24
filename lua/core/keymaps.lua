vim.g.mapleader = ","

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>")

keymap.set("n", "<leader>to", ":tabnew<CR>")
keymap.set("n", "<leader>tx", ":tabclose<CR>")
keymap.set("n", "<leader>tp", ":tabp<CR>")
keymap.set("n", "<leader>tn", ":tabn<CR>")

keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")
keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>")

keymap.set("n", "<leader>e", "<cmd>Telescope find_files<cr>")
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>")
keymap.set("n", "<leader>w", "<cmd>BufExplorer<CR>")

-- my muscle memory
--

-- remove map [*, ]*, because I use keymap [: C-d, ]: C-d
function RemoveMapWithPrefix(prefix)
	local aa = vim.api.nvim_exec(":map", true)
	local aa2 = vim.split(aa, "\n", true)
	for _, v in pairs(aa2) do
		local s = string.gsub(v, "%s+", " ")
		s = vim.split(s, " ", true)
		if s[2] and string.sub(s[2], 1, #prefix) == prefix then
			if #s[2] > #prefix then
				local command = ":unmap " .. s[2]
				vim.api.nvim_exec(command, true)
			end
		end
	end
end

vim.api.nvim_exec(
	[[
autocmd BufEnter * :silent! lua RemoveMapWithPrefix("[")
autocmd BufEnter * :silent! lua RemoveMapWithPrefix("]")
]],
	false
)

keymap.set("n", "]", "<C-d>")
keymap.set("n", "[", "<C-u>")
