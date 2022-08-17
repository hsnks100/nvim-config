let g:mapleader="," 

lua << EOF
require "plugins"
EOF
let g:mapleader="," 

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'

Plug 'williamboman/mason.nvim'
Plug 'preservim/nerdtree'
nnoremap <F2> :NERDTree<CR>
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
nmap <leader>e :Files<CR>
" Use release branch (recommend)
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jlanzarotta/bufexplorer'
nmap <leader>w :BufExplorer<CR>
let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1 

Plug 'dyng/ctrlsf.vim'
nmap     <C-F>f <Plug>CtrlSFPrompt                  
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath

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
nnoremap <leader>feR :source ~/AppData/Local/nvim/init.vim<CR>
nnoremap <leader>fed :e ~/AppData/Local/nvim/init.vim<CR>
nnoremap <leader>r :cd %:p:h<CR>
"inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
"                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
set background=dark " or light if you want light mode
colorscheme gruvbox

lua << EOF
require "set"
EOF


autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()
