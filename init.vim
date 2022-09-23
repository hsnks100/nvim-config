let g:mapleader="," 
set encoding=UTF8
set background=dark " or light if you want light mode
set termguicolors
colorscheme darkblue


lua << EOF
require "plugins"
EOF
call plug#begin()

Plug 'tomtom/tcomment_vim' 
nmap _ :TComment<CR>
vmap _ :TComment<CR>
Plug 'junegunn/vim-easy-align'
Plug 'ryanoasis/vim-devicons'



Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vista.vim'

Plug 'f-person/git-blame.nvim'



" Use release branch (recommend)
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1 

call plug#end()
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting


"autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
nnoremap j gj
nnoremap k gk
nnoremap <c-k> <C-w>k
nnoremap <c-j> <C-w>j
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
vnoremap <F7> "ay
vnoremap <F8> c<C-r>a<esc>

"nnoremap <leader>feR :source ~/.config/nvim/init.vim<CR>
"inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
"                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

lua << EOF
require "set"
require "lsp"
EOF


autocmd filetype go   nnoremap <leader>bd :GoBuild<CR>

autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()
lua <<EOF
  function OrgImports(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
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
EOF
autocmd BufWritePre *.go lua OrgImports(1000)

set ignorecase
set nu

nnoremap <C-f>f :CtrlSF 
syntax match myMatch "\v\.\zs\w+\ze\(" 
highlight link myMatch Function

set nobackup
set nowritebackup
vnoremap <leader>y "+y
vnoremap <leader>p "+p
nnoremap Q <c-w>q
let g:loaded_matchit=0
nnoremap [ <c-u>
nnoremap ] <c-d>
vnoremap [ <c-u>
vnoremap ] <c-d>
set noswapfile


let g:go_textobj_enabled = 0
let g:go_highlight_methods = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_function_calls = 1
au BufRead,BufNewFile *.go set filetype=go

nnoremap <leader>E :e %:p:h<CR>

augroup ScrollbarInit
  autocmd!
  autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
  autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
  autocmd WinLeave,BufLeave,BufWinLeave,FocusLost            * silent! lua require('scrollbar').clear()
augroup end

hi IncSearch	guifg=#000000 guibg=#2050d0							ctermfg=darkblue ctermbg=gray
let HlUnderCursor=1
autocmd CursorMoved * exe exists("HlUnderCursor")?HlUnderCursor?printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\')):'match none':""
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()



