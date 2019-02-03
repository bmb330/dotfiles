" Taken from the following sources:
" https://dougblack.io/words/a-good-vimrc.html
" https://www.youtube.com/watch?v=XA2WjJbmmoM&t=408s
" https://github.com/amix/vimrc/blob/44dca49794b3cc3c1ee8d331ee0a56a68a063263/vimrcs/basic.vim

" General {{{

set nocompatible
set enc=utf-8

syntax enable
filetype indent on
filetype plugin on

set autoread

set showmatch
set mat=2

set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" }}}

" Color {{{
"colorscheme solarized
set background=dark
set t_Co=256
let &t_ut=''
"
"" General colors
"if has('gui_running') || has('nvim')
"    hi Normal 		guifg=#f6f3e8 guibg=#242424
"else
"    " Set the terminal default background and foreground colors, thereby
"    " improving performance by not needing to set these colors on empty cells.
"    hi Normal guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE
"    let &t_ti = &t_ti . "\033]10;#839496\007\033]11;#002b36\007"
"    let &t_te = &t_te . "\033]110\007\033]111\007"
"endif

"colorscheme codedark
" If you have vim-airline, you can also enable the provided theme:
" let g:airline_theme = 'codedark'

colorscheme gruvbox

" }}}

" Spaces, Tabs, Lines {{{

set tabstop=4
set softtabstop=2
set shiftwidth=2
set expandtab

set ai
set si
set wrap

" }}}


" UI Layout {{{

set number
set relativenumber
set showcmd
set cursorline

set lazyredraw
set showmatch

set laststatus=2
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" }}}

" Airline {{{

"let g:airline_solarized_bg='dark'
let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline_detect_modified=1
let g:airline#extensions#bufferline#enabled=1
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline#extensions#ale#enabled = 1

" }}}

" Tab completion {{{
set path+=**
set wildmenu
" }}}

" Omni complete {{{
set omnifunc=syntaxcomplete#Complete
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" }}}

" Searching {{{

set ignorecase
set smartcase
set incsearch
set hlsearch

set tags=tags;/

" }}}

" Folding {{{
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
" }}}

" Buffers {{{

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" }}}

" File Browsing {{{

let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3

" }}}

" Remap keys {{{

let mapleader=','
inoremap jk <esc>
nnoremap j gj
nnoremap k gk
nnoremap <space> za

" }}}

" Shortcuts {{{

nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>eb :vsp ~/.bashrc<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

nnoremap gV `[v`]
nnoremap <leader><space> :nohlsearch<CR>
nnoremap <leader>s :mksession<CR>
nnoremap <leader>a :Ack
nnoremap <leader>f :FZF<CR>
nnoremap <leader>u :GundoToggle<CR>
" run ruby code using leader-r only when inside a .rb file
au BufRead, *.rb nmap <leader>r :!ruby %<cr>

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

set rtp+=/usr/bin/fzf

" }}}

" Linting {{{
let g:ale_linter_aliases = {
    \ 'jsx': ['css', 'javascript'],
    \ }

let g:ale_linters = {
    \ 'awk': ['gawk'],
    \ 'c': ['gcc'],
    \ 'cpp': ['gcc'],
    \ 'css': ['stylelint', 'prettier'],
    \ 'gitcommit': ['gitlint'],
    \ 'html': ['HTMLHint', 'tidy', 'prettier'],
    \ 'javasript': ['prettier', 'stylelint', 'eslint'],
    \ 'json': ['prettier'],
    \ 'jsx': ['stylelint', 'eslint'],
    \ 'less': ['prettier', 'stylelint'],
    \ 'markdown': ['prettier'],
    \ 'ruby': ['solargraph', 'rubocop', 'ruby'],
    \ 'sass': ['prettier', 'stylelint'],
    \ 'scss': ['prettier', 'stylelint'],
    \ 'sh': ['language_server', 'shell', 'shellcheck', 'shfmt'],
    \ 'sql': ['sqlint'],
    \ 'typescript': ['prettier', 'eslint'],
    \ 'yaml': ['prettier'],
    \ }

let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'css': ['prettier', 'tidy'],
    \ 'html': ['prettier', 'tidy'],
    \ 'javascript': ['prettier', 'eslint'],
    \ 'ruby': ['rubocop'],
    \}

let g:ale_completion_enabled = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=172

" }}}

" Tmux {{{
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" }}}

" AutoGroups {{{
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md call <SID>StripTrailingWhitespaces()
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal! g'\"" |
      \ endif
augroup END

augroup loadpacks
    autocmd FileType javascript packadd vim-javascript
    autocmd FileType ruby packadd vim-ruby
    autocmd FileType ruby packadd vim-rails
augroup END
" }}}

" Backups {{{
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
" }}}

" Snippets {{{

nnoremap <leader>html :-1read $HOME/.vim/snippets/skeleton.html<CR>4jwf>a

" }}}

" Custum Functions {{{

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

" }}}

" Load 
" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL

set modelines=1
" vim:foldmethod=marker:foldlevel=0
