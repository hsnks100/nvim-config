vim.cmd([[
let g:ctrlsf_default_root = 'project+fw'
let g:ctrlsf_ignore_dir = ['bower_components', 'npm_modules']
let g:ctrlsf_indent = 2


nmap     <C-F> <Plug>CtrlSFPrompt
vmap     <C-F> <Plug>CtrlSFVwordPath
]])
