set shell=zsh
" Vundle vimrc
set nocompatible
syntax on
filetype plugin indent on

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
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'reedes/vim-pencil'
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'
Plugin 'lervag/vimtex'
Plugin 'itchyny/lightline.vim'

" Disable folding for markdown documents
let g:vim_markdown_folding_disabled = 1

" Enable LaTeX math for markdown
let g:vim_markdown_math = 1

" End config for vundle
filetype plugin indent on

" PaperColor theme
syntax enable
set t_Co=256
colorscheme PaperColor
set background=light

" Indent guides theme
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=254
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=255
autocmd VimEnter * IndentGuidesEnable

" Add line numbers by default
set number

" Set Vim-Pencil options
let g:pencil#wrapModeDefault = 'hard'
augroup pencil
	autocmd!
	autocmd FileType markdown,mkd call pencil#init()
	autocmd FileType text         call pencil#init()
augroup END

" Set it so :q quits Goyo and Vim
function! s:goyo_enter()
	let b:quitting = 0
	let b:quitting_bang = 0
	autocmd QuitPre <buffer> let b:quitting = 1
	cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
	" Quit Vim if this is the only remaining buffer
	if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
		if b:quitting_bang
			qa!
		else
			qa
		endif
	endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

" lightline settings
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'PaperColor',
      \ 'component': {
      \   'readonly': '%{&readonly?"":""}',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

" vimtex settings
let g:vimtex_view_general_viewer = 'qpdfview'
let g:vimtex_view_general_options = '--unique @pdf\#src:@tex:@line:@col'
let g:vimtex_view_general_options_latexmk = '--unique'

" Key mappings
set pastetoggle=<F3>
map <F10> :Pencil <CR>
map <F5> :setlocal spell! spelllang=en_us<CR>
map <F11> :Goyo <bar>:Limelight <CR>
