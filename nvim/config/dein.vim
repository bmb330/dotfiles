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

  call dein#add('mileszs/ack.vim')
  call dein#add('junegunn/fzf',
    \ { 'build': './install --all', 'merged': 0 })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
  call dein#add('neoclide/coc.nvim',
    \ { 'build': 'yarn install' })

  call dein#add('itchyny/lightline.vim')
  call dein#add('taohexxx/lightline-buffer')
  call dein#add('scrooloose/nerdtree')
  call dein#add('Xuyuanp/nerdtree-git-plugin')
  call dein#add('morhetz/gruvbox')

  call dein#add('jiangmiao/auto-pairs')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('junegunn/gv.vim')
  call dein#add('sjl/gundo.vim')

  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-endwise')

  call dein#add('ryanoasis/vim-devicons')

  if dein#check_install()
    call dein#install()
  endif

  call dein#end()
  call dein#save_state()
endif
