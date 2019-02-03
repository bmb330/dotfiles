" Taken from the following sources:
" https://dougblack.io/words/a-good-vimrc.html
" https://www.youtube.com/watch?v=XA2WjJbmmoM&t=408s
" https://github.com/amix/vimrc/blob/44dca49794b3cc3c1ee8d331ee0a56a68a063263/vimrcs/basic.vim

" Dein {{{
if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  "call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#add('junegunn/fzf',
    \ { 'build': './install --all', 'merged': 0 })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
  call dein#add('neoclide/coc.nvim',
    \ { 'build': 'yarn install' })

  call dein#add('itchyny/lightline.vim')
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('morhetz/gruvbox')

  call dein#add('jiangmiao/auto-pairs')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('sjl/gundo.vim')

  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-endwise')

  if dein#check_install()
    call dein#install()
  endif

  call dein#end()
  call dein#save_state()
endif
" }}}

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

set noshowmode
set laststatus=2
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" }}}

" Completion {{{
" if hidden not set, TextEdit might fail.
set hidden

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.

"let g:endwise_no_mappings = 1
"https://github.com/roxma/nvim-completion-manager/issues/49#issuecomment-285923119
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB>
      \ pumvisible() ? "\<C-p>" :
      \ "\<C-h>"


function! s:check_back_space() abort
 let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
"inoremap <silent><expr> <c-space> coc#refresh()
imap <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr>
      \ pumvisible() ? "\<C-y>" :
      \ "\<C-g>u\<CR>\<Plug>DiscretionaryEnd"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Close preview window when completion done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Add diagnostic info for https://github.com/itchyny/lightline.vim
" For icons: https://github.com/ryanoasis/vim-devicons/wiki/usage
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \   'component': {
      \     'lineinfo': ' %3l:%-2v',
      \   },
      \ 'component_function': {
      \     'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status',
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat',
      \ },
      \ }
let g:lightline.separator = {
	\   'left': '', 'right': ''
  \}
let g:lightline.subseparator = {
	\   'left': '', 'right': '' 
  \}
let g:lightline.tabline = {
  \   'left': [ ['tabs'] ],
  \   'right': [ ['close'] ]
  \ }
set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction



" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
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
    autocmd BufEnter *.lua setlocal filetype=lua
    autocmd BufEnter *.ruby setlocal filetype=ruby
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

set modelines=1
" vim:foldmethod=marker:foldlevel=0
