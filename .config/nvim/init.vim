" *========================================================================================*
"                         Using Vim-Plug to manage my NeoVim Plugins
" *========================================================================================*

call plug#begin('~/.local/share/nvim/plugged')

" ***** Required dependencies *****

" Create your own Vim text objects (used for Prose plugins)
Plug 'kana/vim-textobj-user'

" Enable repeating supported plugin maps with '.' command
Plug 'tpope/vim-repeat'

" Asynchronus unite all interfaces
Plug 'Shougo/denite.nvim'

" Asynchronus :make command
Plug 'neomake/neomake'

" ***** Actual plugins *****

" Vim Find And Replace (https://github.com/brooth/far.vim)
Plug 'brooth/far.vim'

" Fancy start screen for vim
Plug 'mhinz/vim-startify'

" Easily align lines arbitrarily (github.com/junegunn/vim-easy-align) for README
Plug 'godlygeek/tabular'

" Automatic formatting of files with command :Neoformat
Plug 'sbdchd/neoformat'

" Git wrapper for Vim
Plug 'tpope/vim-fugitive'

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
Plug 'othree/html5.vim', { 'for': 'html'}

" Syntax support for Markdown files
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

" Syntax support for git files
Plug 'tpope/vim-git', { 'for': ['gitconfig','gitcommit','gitrebase','gitsendemail', 'git'] }

" Support for icon glyphs for filetypes
Plug 'ryanoasis/vim-devicons'

" Automatically add pairs to curly brackets, etc
Plug 'tpope/vim-surround'

" Heuristically set buffer options 'shiftwidth' and 'expandtab'
Plug 'tpope/vim-sleuth'

" Quickly comment stuff out
Plug 'scrooloose/nerdcommenter'

" Show colors for hexadecimal codes in CSS files
Plug 'ap/vim-css-color', { 'for': ['i3', 'css', 'html', 'svg', 'Xresources']}

" Insert mode auto-completion for quotes, parenthesis, brackets, and more!
Plug 'Raimondi/delimitMate'

" Use Neovim to edit encrypted files
Plug 'jamessan/vim-gnupg', { 'for': ['gpg', 'pgp', 'asc']}

" Plugin for using EditorConfig files to maintain consistent coding styles
Plug 'editorconfig/editorconfig-vim'

" Material Design color scheme
Plug 'NLKNguyen/papercolor-theme'

" Use visual character indent guides instead
Plug 'Yggdroot/indentLine'

" Encryption
Plug 'jamessan/vim-gnupg'

" Tab completion for Neovim
Plug 'ervandew/supertab'

" *=========================*
"    Vim for Prose plugins
" *=========================*
  
" Goyo centers the text for writing
Plug 'junegunn/goyo.vim'

" Vim-Pencil soft wraps lines
Plug 'reedes/vim-pencil'

" Better spellcheck for vim
Plug 'reedes/vim-lexical'

" Typographic quotes for prose
Plug 'reedes/vim-textobj-quote'

" Improve on Vim's sentance text object and motion for prose
Plug 'reedes/vim-textobj-sentence'

" Live preview for LaTeX
Plug 'donRaphaco/neotex', { 'for': 'tex' }

" *=========================*

" Browse commits
Plug 'junegunn/gv.vim'

" Manage tag files in Vim
Plug 'ludovicchabant/vim-gutentags'

" Keep edit state in Vim
Plug 'kopischke/vim-stay'

" Get rid of pesky folding
Plug 'konfekt/fastfold'

" Interactive command execution in Vim
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" Color picker
Plug 'KabbAmine/vCoolor.vim'

" Lightweight Powerline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Local wiki plugin
Plug 'vimwiki/vimwiki'

call plug#end()

" *========================================================================================*
"                          Set it so :q quits Goyo and Vim
" *========================================================================================*

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

" *========================================================================================*
"                                       Key mappings
" *========================================================================================*

" Enable pasting
set pastetoggle=<F3>

" Spellcheck with Vim's built in spellchecker
map <F4> :setlocal spell! spelllang=en_gb<CR>

" Spellcheck with lexical
map <F5> \s<CR>

" Thesaurus with lexical
map <F6> \t<CR>

" Turn on LaTeX live compilation
map <F10> :NeoTex<CR>

" Enable Goyo and Vim-Pencil 
map <F11> :Goyo <bar> %:PencilToggle<CR>

" Clear all comment markers (one rule for all languages) using "_" key
map _ :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:nohlsearch<CR>

function! s:MyCSettings()
  " Insert comments markers
  map - :s/^/\/\//<CR>:nohlsearch<CR>
endfunction

function! s:MyVimSettings()
  " Insert comments markers
  map - :s/^/\"/<CR>:nohlsearch<CR>
endfunction

" *========================================================================================*
"                         	General NeoVim Settings
" *========================================================================================*

" Set not compatible with vi
set nocompatible

" Set shell to zsh
set shell=zsh

" Disable folding for markdown documents
let g:vim_markdown_folding_disabled = 1

" Set Airline to use PaperColor theme
let g:airline_theme='papercolor'

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Enable LaTeX math for markdown
let g:vim_markdown_math = 1

" Use the GPG Agent for encrypted files
let g:GPGUseAgent = 1

" PaperColor theme, make terminal 256 bit, enable syntax highlighting, 
" and use the light theme
syntax on
set t_Co=256
colorscheme PaperColor
set background=light
filetype plugin indent on

" Add line numbers by default
set number

" No word wrapping
set nowrap

" Use spaces for tabs
set expandtab

" Set tabs equal to two spaces
set tabstop=2

" Set Vim-Pencil options for prose files
let g:pencil#wrapModeDefault = 'soft'
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd  call pencil#init()
  autocmd FileType textile       call pencil#init()
  autocmd FileType text          call pencil#init()
augroup END

" Quick comment out lines or uncomment them
augroup vimrc_filetype
  autocmd!
  autocmd FileType c    call s:MyCSettings()
  autocmd FileType vim  call s:MyVimSettings()
augroup end

" Spellcheck/Thesaurus for prose files
augroup lexical
  autocmd!
  autocmd FileType markdown,mkd  call lexical#init()
  autocmd FileType textile       call lexical#init()
  autocmd FileType text          call lexical#init({ 'spell': 0 })
augroup END

" Enable typographic quotes for prose files
augroup textobj_quote
  autocmd!
  autocmd FileType markdown  call textobj#quote#init()
  autocmd FileType textile   call textobj#quote#init()
  autocmd FileType text      call textobj#quote#init({'educate': 0})
augroup END

" Enable textobj sentences for prose files
augroup textobj_sentence
  autocmd!
  autocmd FileType markdown call textobj#sentence#init()
  autocmd FileType textile call textobj#sentence#init()
augroup END

" Enable goyo for prose files
augroup goyo
  autocmd!
  autocmd FileType markdown call SetUpGoyo()
  autocmd FileType textile call SetUpGoyo()
  autocmd FileType text call SetUpGoyo()
augroup END

" Function to enable goyo
function! SetUpGoyo()
  if !exists('#goyo')
    Goyo
  endif
endfunction

" STOP HIDING STUFF
set conceallevel=0

" Spellcheck dictionaries and languages (English and Spanish)
let g:lexical#spellang = ['en_us', 'es_mx']

" Specify lexical file locations
let g:lexical#dictionary = ['~/.config/nvim/dict/words']
let g:lexical#spellfile = ['~/.config/nvim/spell/en.utf-8.add','~/.config/nvim/spell/es.utf-8.add']

" Enable indentline by default
let g:indentLine_enabled = 1

" Set indentLin character
let g:indentLine_char = ''

" Set indentLine color
let g:indentLine_color_term = 249

" NeoTex settings
let g:neotex_enabled = 1
let g:neotex_latexdiff = 0
" Live compile every 5 seconds
let g:neotex_delay = 5000

" Disable blinking cursor
let g:guicorsor=''
