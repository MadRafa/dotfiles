""""""""""""""""""""""
"  General Settings  "
""""""""""""""""""""""
syntax on
filetype plugin on
set nocompatible
set viminfo+=n$HOME/.config/vim/.viminfo
set path+=**
set wildmenu
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set relativenumber
set nohlsearch
set hidden
set noshowmode
set noerrorbells
set smartcase
set noswapfile
set nobackup
set incsearch
set termguicolors
set backspace=indent,eol,start
set completeopt=menuone,longest,noselect
set complete+=kspell
set omnifunc=syntaxcomplete#Complete
set shortmess+=c
set showmatch
set wildmode=full
set scrolloff=10
set updatetime=50
set clipboard=unnamedplus

" jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

""""""""""""""""
"  Statusline  "
""""""""""""""""
set laststatus=2
set statusline=
let g:currentmode={
       \ 'n'  : 'NORMAL ',
       \ 'v'  : 'VISUAL ',
       \ 'V'  : 'V·Line ',
       \ '' : 'V·Block ',
       \ 'i'  : 'INSERT ',
       \ 'R'  : 'R ',
       \ 'Rv' : 'V·Replace ',
       \ 'c'  : 'Command ',
       \}
set statusline+=%1*\ %{toupper(g:currentmode[mode()])}
set statusline+=%#PmenuSel#
set statusline+=%2*\ %f
set statusline+=%m
set statusline+=%=
set statusline+=%y
set statusline+=%3*\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=%3*\[%{&fileformat}\]\ |
set statusline+=%4*\ %p%%
set statusline+=%4*\ %l/%L
set statusline+=%4*\ col:%c\ |

hi User1 guifg=Black guibg=#778c82
hi User2 guifg=#000000 guibg=#a5d194
hi User3 guifg=#000000 guibg=#bd97cb
hi User4 guifg=#000000 guibg=#d88ca8
hi User5 guifg=#000000 guibg=#b7c8c2

highlight Pmenu ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000
highlight PmenuSel ctermfg=15 ctermbg=0 guifg=#ffffff guibg=DarkGrey

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi User1 guibg=White ctermfg=6 guifg=Black ctermbg=0
  else
    hi User1 guibg=DarkRed ctermfg=1 guifg=Black ctermbg=0
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi User1 guibg=#778c82 ctermfg=8 guifg=Black ctermbg=15

"""""""""""""""""""""""
"  Autocomplete Menu  "
"""""""""""""""""""""""
set omnifunc=htmlcomplete#CompleteTags
set omnifunc=csscomplete#CompleteCSS

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Trim any trailing white space
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup MYVIMRC
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

" Tweaks for browsing files
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

let mapleader = " "

"--------------------- Useful Commands -------------------
" AUTOCOMPLETE
" - ^n - autocomplete suggestions (next)
" - ^p - autocomplete suggestions (previous)
" - ^x^f - for filenames
" - ^x^] - tags only

inoremap jk <ESC>
inoremap kj <ESC>
nnoremap Q <Nop>
nmap <leader>w :w<CR>
nmap <leader>q :bdelete<CR>
nnoremap <leader>b :buffers<CR>:buffer<Space>

" Better Window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
