vim.g.mapleader = ","

local keymap = vim.keymap

keymap.set("n", "<s-space>", "i<space><esc>")
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

keymap.set("n", "S", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })

-- grw: replace until next word
vim.cmd([[
nmap <leader>gr <Plug>ReplaceWithRegisterOperator
nmap <leader>grr <Plug>ReplaceWithRegisterLine
xmap <leader>gr <Plug>ReplaceWithRegisterVisual
]])

-- my muscle memory
--

-- remove map [*, ]*, because I use keymap [: C-d, ]: C-d
function RemoveMapWithPrefix(prefix)
	local aa = vim.api.nvim_exec(":map", true)
	local aa2 = vim.split(aa, "\n", true)
	for _, v in pairs(aa2) do
		local s = string.gsub(v, "%s+", " ")
		print(s)
		s = vim.split(s, " ", true)
		if s[2] and string.sub(s[2], 1, #prefix) == prefix then
			if #s[2] > #prefix then
				local command = ":unmap <buffer>" .. s[2]
				print(command)
				vim.api.nvim_exec(command, true)
				-- command = ":unmap " .. s[2]
				-- vim.api.nvim_exec(command, true)
			end
		end
	end
end

vim.api.nvim_exec(
	[[
"autocmd BufEnter *.rs :silent! lua RemoveMapWithPrefix("[")
"autocmd BufEnter *.rs :silent! lua RemoveMapWithPrefix("]")
"autocmd BufEnter *.go :silent! lua RemoveMapWithPrefix("[")
"autocmd BufEnter *.go :silent! lua RemoveMapWithPrefix("]")
]],
	false
)

local function get_visual_selection()
	local s_start = vim.fn.getpos("'<")
	local s_end = vim.fn.getpos("'>")
	local n_lines = math.abs(s_end[2] - s_start[2]) + 1
	local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
	lines[1] = string.sub(lines[1], s_start[3], -1)
	if n_lines == 1 then
		lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
	else
		lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
	end
	return table.concat(lines, "\n")
end

keymap.set("n", "8", "<C-u>zz")
keymap.set("n", "9", "<C-d>zz")

vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>feR", "<cmd>luafile ~/.config/nvim/init.lua<CR>")
vim.keymap.set("n", "<leader>fed", "<cmd>e ~/.config/nvim/<CR>")
vim.keymap.set("n", "<leader>r", "<cmd>cd %:p:h<CR>")
vim.opt.mouse = "a"
vim.opt.updatetime = 1000
-- tnoremap <C-w>j <C-\><C-n><C-w>j

-- tnoremap <C-w>k <C-\><C-n><C-w>k
vim.keymap.set("n", "\\\\", "<cmd>bel sp | resize 10 | terminal<CR>")

vim.keymap.set("n", "<left>", "<c-w><")
vim.keymap.set("n", "<right>", "<c-w>>")
vim.keymap.set("n", "<down>", "<c-w>-")
vim.keymap.set("n", "<up>", "<c-w>+")

vim.keymap.set("t", "<esc>", "<C-\\><C-N>")
vim.keymap.set("t", "<c-k>", "<C-\\><C-n><c-w>k")
vim.keymap.set("t", "<c-j>", "<C-\\><C-n><C-w>j")
