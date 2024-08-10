vim.g.dap_virtual_text = true
vim.opt.colorcolumn = "80"

-- Disable persistent undo for files in /private directory
vim.api.nvim_create_autocmd("BufReadPre", { pattern = "/private/*", command = "set noundofile" })
-- vim.lsp.inlay_hint.enable(true)

-- Enable persistent undo for other files
vim.opt.undofile = true
vim.o.shell = "/bin/zsh"
vim.opt.clipboard = ""

-- Use Lua to set up the key mapping
vim.api.nvim_set_keymap("n", "y", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "y", '"+y', { noremap = true, silent = true })

vim.cmd([[
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
    let @/ = ''
    if exists('#auto_highlight')
        au! auto_highlight
        augroup! auto_highlight
        setl updatetime=4000
        echo 'Highlight current word: off'
        return 0
    else
        augroup auto_highlight
            au!
            au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
        augroup end
        setl updatetime=10
        echo 'Highlight current word: ON'
        return 1
    endif
endfunction
]])
