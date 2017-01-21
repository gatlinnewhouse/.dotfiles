" Vundle vimrc
set nocompatible
filetype off

" I use Vundle https://github.com/gmarik/Vundle.vim as my
" preferred plugin manager.... never got the hang of
" vim-pathogen (no offence to the pathogen community)

set rtp+=$HOME/.vim/bundle/Vundle.vim
let path='$HOME/.vim/bundle'
call vundle#rc('$HOME/.vim/bundle')
" Let vundle manage itself
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'nathanaelkane/vim-indent-guides'

" End config for vundle
filetype plugin indent on

syntax enable
set t_Co=256
set background=light
colorscheme PaperColor
