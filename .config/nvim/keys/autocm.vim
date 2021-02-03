" Trim any trailing white space
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup RAFA
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()

    " jump to the last position when reopening a file
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    " EJS
    au BufNewFile,BufRead *.ejs set filetype=html

    "Markdown
    autocmd FileType markdown let g:indentLine_enabled=0
augroup END