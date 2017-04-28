" *========================================================================================*
"                         Using Vim-Plug to manage my NeoVim Plugins
" *========================================================================================*

call plug#begin('~/.local/share/nvim/plugged')

" Required dependencies
Plug 'kana/vim-textobj-user'
Plug 'tpope/vim-repeat'

" Fancy start screen for vim
Plug 'mhinz/vim-startify'

" Easily align lines arbitrarily (github.com/junegunn/vim-easy-align) for README
Plug 'godlygeek/tabular'

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

" Support for icon glyphs for filetypes
Plug 'ryanoasis/vim-devicons'

" Automatically add pairs to curly brackets, etc
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-characterize'

" Show colors for hexadecimal codes in CSS files
Plug 'ap/vim-css-color'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Raimondi/delimitMate'
Plug 'editorconfig/editorconfig-vim'

" Material Design color scheme
Plug 'NLKNguyen/papercolor-theme'

" Use visual character indent guides instead
Plug 'Yggdroot/indentLine'

" Syntax highlighting for TMUX config
Plug 'tmux-plugins/vim-tmux'

" *=========================*
"    Vim for Prose plugins
" *=========================*
  
" Goyo centers the text for writing
Plug 'junegunn/goyo.vim'

" Vim-Pencil soft wraps lines
Plug 'reedes/vim-pencil'

" Vim-Wordy checks for misused/abused/overused words or phrases*
" *according to 'usuage experts' (take it with a grain of salt
Plug 'reedes/vim-wordy'

" Better spellcheck for vim
Plug 'reedes/vim-lexical'

" Typographic quotes for prose
Plug 'reedes/vim-textobj-quote'

" Improve on Vim's sentance text object and motion for prose
Plug 'reedes/vim-textobj-sentence'

" *=========================*

" Lightweight Powerline
Plug 'itchyny/lightline.vim'

" Dark powered neo-completion (asynchronous keyboard completion)
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

" *========================================================================================*
"                              	         Lightline settings
" *========================================================================================*

" Lightline colors and characters
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

" Check words with Wordy
map <F7> :NextWordy<CR>

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

" Enable LaTeX math for markdown
let g:vim_markdown_math = 1

" PaperColor theme, make terminal 256 bit, enable syntax highlighting, 
" and use the light theme
syntax enable
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

" Turn on Ditto's autocmds
au FileType markdown,text,tex DittoOn

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

" Spellcheck dictionaries and languages (English and Spanish)
let g:lexical#spellang = ['en_us', 'es_mx']

" Specify lexical file locations
let g:lexical#dictionary = ['~/.config/nvim/dict/words']
let g:lexical#spellfile = ['~/.config/nvim/spell/en.utf-8.add','~/.config/nvim/spell/es.utf-8.add']

" Vimtex settings
let g:vimtex_enabled = 1

" Enable indentline by default
let g:indentLine_enabled = 1

" Set indentLin character
let g:indentLine_char = ''

" Set indentLine color
let g:indentLine_color_term = 249

" Use evince-synctex aur package
let g:vimtex_view_general_viewer = 'evince-synctex'
