set shell=zsh

" *========================================================================================*
"                         Using Vim-Plug to manage my NeoVim Plugins
" *========================================================================================*

call plug#begin('~/.local/share/nvim/plugged')

Plug 'mhinz/vim-startify'

" Easily align lines arbitrarily (github.com/junegunn/vim-easy-align) for README
Plug 'junegunn/vim-easy-align'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-repeat'

" Automatic formatting of files with command :Neoformat
Plug 'sbdchd/neoformat'

" Git wrapper for Vim
Plug 'tpope/vim-fugitive'

" Syntax support and latexmk support for LaTeX files
Plug 'lervag/vimtex', { 'for': 'tex' }

" Syntax support for Puppet files
Plug 'voxpupuli/vim-puppet', { 'for': 'puppet' }

" Syntax support for Python2 and Python3 files
Plug 'mitsuhiko/vim-python-combined', { 'for': 'python' }

" Syntax support for i3 config file
Plug 'PotatoesMaster/i3-vim-syntax', { 'for': 'i3' }

" Syntax support for CSS files
Plug 'JulesWang/css.vim', { 'for': 'css' }

" Syntax support for systemd files
Plug 'kurayama/systemd-vim-syntax', { 'for': 'systemd' }

" Syntax support for SCSS (SASS CSS) files
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }

" Syntax support for HTML5 files
Plug 'othree/html5.vim'

" Syntax support for Markdown files
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

" Syntax support for PHP files
Plug 'StanAngeloff/php.vim', { 'for': 'php' }

" Syntax support for git files
Plug 'tpope/vim-git', { 'for': ['gitconfig','gitcommit','gitrebase','gitsendemail', 'git'] }

Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-characterize'
Plug 'ap/vim-css-color'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Raimondi/delimitMate'
Plug 'editorconfig/editorconfig-vim'

" Material Design color scheme
Plug 'NLKNguyen/papercolor-theme'

" Add shading to indents in code as visual guides
Plug 'nathanaelkane/vim-indent-guides'
Plug 'reedes/vim-pencil'
Plug 'junegunn/limelight.vim'

" Lightweight Powerline
Plug 'itchyny/lightline.vim'

" Dark powered neo-completion (asynchronous keyboard completion)
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

" *========================================================================================*
"                                        End Vim-Plug
" *========================================================================================*


" Disable folding for markdown documents
let g:vim_markdown_folding_disabled = 1

" Enable LaTeX math for markdown
let g:vim_markdown_math = 1

" PaperColor theme, make terminal 256 bit, enable syntax highlighting, 
" and use the light theme
syntax enable
set t_Co=256
colorscheme PaperColor
set background=light
filetype plugin indent on

" Enable indent guides
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=254
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=255
autocmd VimEnter * IndentGuidesEnable

" Add line numbers by default
set number

" ****************************************************************************
"                              Lightline settings
"
" ****************************************************************************
let g:lightline = { 
      \ 'colorscheme': 'PaperColor',
      \ 'active': {
      \    'left': [ [ 'mode', 'paste' ],
      \              [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'readonly': 'LightlineReadonly',
      \   'modified': 'LightlineModified',
      \   'filename': 'LightlineFilename'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

" Check if the file is modified
function! LightlineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

" Check if the file is read only
function! LightlineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction

" Check if the file is part of a git repo
function! LightlineFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

" Check for the filename
function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

" Check if the file is apart of a git repo and a branch
function! LightlineFugitive()
  if exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction
" ****************************************************************************
"                              End Lightline settings
"
" ****************************************************************************

" No word wrapping
set nowrap

" Use spaces for tabs
set expandtab

" Set tabs equal to two spaces
set tabstop=2

" ****************************************************************************
"                          Set it so :q quits Goyo and Vim
"
" ****************************************************************************
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
" ****************************************************************************

" Set Vim-Pencil options
let g:pencil#wrapModeDefault = 'soft'
augroup pencil
	autocmd!
	autocmd FileType markdown,mkd call pencil#init()
	autocmd FileType text         call pencil#init()
augroup END

" Vimtex settings
let g:vimtex_enabled = 1
" Use evince-synctex aur package, UNTESTED
let g:vimtex_view_general_viewer = 'evince-synctex'

" Key mappings
set pastetoggle=<F3>
map <F10> :Pencil <CR>
map <F5> :setlocal spell! spelllang=en_us<CR>
map <F11> :Goyo <bar>:Limelight <CR>
