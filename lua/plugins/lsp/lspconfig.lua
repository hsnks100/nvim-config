-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

-- import typescript plugin safely
local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
	return
end

local keymap = vim.keymap -- for conciseness

require("lsp-format").setup({})
-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
	require("lsp-format").on_attach(client)

	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- set keybinds
	keymap.set("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
	keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
	keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
	keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
	keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side

	-- typescript specific keymaps (e.g. rename file and update imports)
	if client.name == "tsserver" then
		keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
		keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
		keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
	end
	local cfg = {
		debug = false, -- set to true to enable debug logging
		log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
		-- default is  ~/.cache/nvim/lsp_signature.log
		verbose = false, -- show debug line number
		bind = true, -- This is mandatory, otherwise border config won't get registered.
		-- If you want to hook lspsaga or other signature handler, pls set to false
		doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
		-- set to 0 if you DO NOT want any API comments be shown
		-- This setting only take effect in insert mode, it does not affect signature help in normal
		-- mode, 10 by default

		max_height = 20, -- max height of signature floating_window
		max_width = 80, -- max_width of signature floating_window
		wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long

		floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

		floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
		-- will set to true when fully tested, set to false will use whichever side has more space
		-- this setting will be helpful if you do not want the PUM and floating win overlap

		floating_window_off_x = 1, -- adjust float windows x position.
		floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines

		close_timeout = 4000, -- close floating window after ms when laster parameter is entered
		fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
		hint_enable = true, -- virtual hint enable
		hint_prefix = "???? ", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
		hint_scheme = "String",
		hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
		handler_opts = {
			border = "double", -- double, rounded, single, shadow, none
		},

		always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

		auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
		extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
		zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

		padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc

		transparency = nil, -- disabled by default, allow floating win transparent value 1~100
		shadow_blend = 36, -- if you using shadow as border use this set the opacity
		shadow_guibg = "Black", -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
		timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
		toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'

		select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
		move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
	}
	require("lsp_signature").on_attach(cfg, bufnr) -- Note: add in lsp client on-attach
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = "??? ", Warn = "??? ", Hint = "??? ", Info = "??? " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure html server
lspconfig["html"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure typescript server with plugin
typescript.setup({
	server = {
		capabilities = capabilities,
		on_attach = on_attach,
	},
})

-- configure css server
lspconfig["cssls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure tailwindcss server
lspconfig["tailwindcss"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure lua server (with special settings)
lspconfig["sumneko_lua"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = { -- custom settings for lua
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

lspconfig["rust_analyzer"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		-- to enable rust-analyzer settings visit:
		-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
		["rust-analyzer"] = {
			-- enable clippy on save
			checkOnSave = {
				command = "clippy",
			},
		},
	},
})

-- Get the value of the module name from go.mod in PWD
-- see if the file exists
function FileExists(file)
	local f = io.open(file, "rb")
	if f then
		f:close()
	end
	return f ~= nil
end

function GetGoModuleName()
	if not FileExists("go.mod") then
		return nil
	end
	for line in io.lines("go.mod") do
		if vim.startswith(line, "module") then
			local items = vim.split(line, " ")
			local module_name = vim.trim(items[2])
			return module_name
		end
	end
	return nil
end

local goModule = GetGoModuleName()
util = require("lspconfig/util")
lspconfig["gopls"].setup({
	on_attach = on_attach,
	cmd = { "gopls", "serve" },
	filetypes = { "go", "gomod" },
	root_dir = util.root_pattern("go.mod", ".golangci.yaml", ".git"),
	single_file_support = true,

	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			["local"] = goModule, -- "gameserver", --"game",
		},
	},
})

function OrgImports(wait_ms)
	local params = vim.lsp.util.make_range_params()
	params.context = { only = { "source.organizeImports" } }
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
	for _, res in pairs(result or {}) do
		for _, r in pairs(res.result or {}) do
			if r.edit then
				vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
			else
				vim.lsp.buf.execute_command(r.command)
			end
		end
	end
end

require("go").setup()

-- require("go.format").goimport() -- goimport + gofmt
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').gofmt() ]], false)

-- vim.cmd([[
-- autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()
-- autocmd BufWritePre *.go lua OrgImports(1000)
-- ]])
