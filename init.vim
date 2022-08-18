let g:mapleader="," 

lua << EOF
require "plugins"
EOF

call plug#begin()
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'

Plug 'williamboman/mason.nvim'
Plug 'junegunn/vim-easy-align'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Use release branch (recommend)
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1 


Plug 'ellisonleao/gruvbox.nvim'

Plug 'neovim/nvim-lspconfig'

call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting


"autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
nnoremap <c-k> <C-U>
nnoremap <c-j> <C-D>
vnoremap <c-k> <C-U>
vnoremap <c-j> <C-D>
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
vnoremap <F7> "ay
vnoremap <F8> c<C-r>a<esc>

"nnoremap <leader>feR :source ~/.config/nvim/init.vim<CR>
"inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
"                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
set background=dark " or light if you want light mode
colorscheme gruvbox

lua << EOF
require "set"
require "lsp"
EOF


autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()
