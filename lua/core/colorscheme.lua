local status, _ = pcall(vim.cmd, "colorscheme darkblue")
if not status then 
    print("Colorscheme not found!")
    return
end
vim.cmd([[colorscheme gruvbox]])
