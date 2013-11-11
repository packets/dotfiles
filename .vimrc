" This must be first, because it changes other options as side effect
set nocompatible

" Change the mapleader from \ to ,
let mapleader=","

set hidden 	" hides buffers instead of closing them
set nowrap	" don't wrap lines
set expandtab " use spaces instead of tabs
set tabstop=4	" a tab is 4 spaces
set backspace=indent,eol,start
		" allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set clipboard+=unnamed  " Yanks go on clipboard instead.
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set nobackup
set noswapfile

" Fish compatability
set shell=/bin/zsh

set showmatch  " Show matching brackets.
set matchtime=5  " Bracket blinking.
set novisualbell  " No blinking
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.
" We're using the powerline plugin now so no need for the status line
" statusline {{{
" " cf the default statusline: %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
" " format markers:
" "   %< truncation point
" "   %n buffer number
" "   %f relative path to file
" "   %m modified flag [+] (modified), [-] (unmodifiable) or nothing
" "   %r readonly flag [RO]
" "   %y filetype [ruby]
" "   %= split point for left and right justification
" "   %-35. width specification
" "   %l current line number
" "   %L number of lines in buffer
" "   %c current column number
" "   %V current virtual column number (-n), if different from %c
" "   %P percentage through buffer
" "   %) end of width specification
" }}}
"set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%))
set vb t_vb= " disable any beeps or flashes on error
set ruler  " Show ruler
set showcmd " Display an incomplete command in the lower right corner of the Vim window
set shortmess=atI " Shortens messages"

set fo+=o " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
set fo-=r " Do not automatically insert a comment leader after an enter
set fo-=t " Do no auto-wrap text using textwidth (does not apply to comments)"

" Folding
set foldenable " Turn on folding
set foldmethod=marker " Fold on the marker
set foldlevel=100 " Don't autofold anything (but I can still fold manually)
set foldopen=block,hor,mark,percent,quickfix,tag " what movements open folds "

" Mouse
set mouse-=a   " Disable mouse
set mousehide  " Hide mouse after chars typed

" Hilights
filetype plugin indent on
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
" If python, use spaces instead of tabs
" if has('autocmd')
	" autocmd filetype python set expandtab
" endif

" Hilights whitespaces
"set list listchars=tab:>.,trail:.,extends:#,nbsp:.
" Paste mode for pasting large amounts of text
set pastetoggle=<F2>

" Shortcut mappings
nnoremap ; :


" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

nnoremap j gj
nnoremap k gk

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Cleans hilighted text after search
nmap <silent> ,/ :nohlsearch<CR>

" Lets you to :w!! if you forgot to sudo into a file
cmap w!! w !sudo tee % >/dev/null


" GUI
if has("gui_running")
	set guioptions-=m  "remove menu bar
	set guioptions-=T  "remove toolbar
	set guioptions-=r  "remove right-hand scroll bar"
	set guioptions-=l
	set guioptions-=b
	set guioptions-=L
	set lines=60 columns=120
endif

" ctags
set tags+=./tags;$HOME " walk directory tree upto $HOME looking for tags"

"" Plugins

" let Vundle manage Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

Bundle 'tpope/vim-fugitive'

Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}

Bundle 'Raimondi/delimitMate.git'

Bundle 'docunext/closetag.vim.git'

Bundle 'fholgado/minibufexpl.vim'
let g:miniBufExplorerAutoStart = 1

Bundle 'Shougo/neocomplcache.vim'
" let g:neocomplcache_enable_at_startup = 1

" General 
Bundle 'SirVer/ultisnips'
Bundle 'godlygeek/tabular'

" Python
Bundle 'klen/python-mode'

" Go
Bundle 'Blackrush/vim-gocode'

" Syntax
Bundle 'scrooloose/syntastic'

" Utility
Bundle 'repeat.vim'
Bundle 'surround.vim'
Bundle 'Lokaltog/vim-easymotion'

" tComment
Bundle "tComment"
nnoremap // :TComment<CR>
vnoremap // :TComment<CR>

Bundle 'scrooloose/nerdtree'
nnoremap <F3> :NERDTreeToggle<CR>
if has('autocmd')
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
endif

Bundle 'majutsushi/tagbar.git'
let g:tagbar_usearrows = 1
nnoremap <leader>l :TagbarToggle<CR>

" A plugin that replaces CtrlP, ACK, LustyJuggler and YankRing
Bundle 'Shougo/unite.vim'
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#set_profile('files', 'smartcase', 1)
call unite#custom#source('line,outline','matchers','matcher_fuzzy')

let g:unite_data_directory='~/.vim/cache/unite'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
let g:unite_source_rec_max_cache_files=5000
let g:unite_prompt='» '

nnoremap <space>t   :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
nnoremap <space>f   :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <C-p>      :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <space>o   :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
nnoremap <space>y   :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <space>b   :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>

let g:unite_source_grep_command='ack'
let g:unite_source_grep_default_opts='--no-heading --no-color -a'
let g:unite_source_grep_recursive_opt=''

function! s:unite_settings()
	nmap <buffer> Q     <plug>(unite_exit)
	nmap <buffer> <esc> <plug>(unite_exit)
	imap <buffer> <esc> <plug>(unite_exit)
	let b:SuperTabDisabled=1
	imap <buffer> <C-j>   <Plug>(unite_select_next_line)
	imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction
autocmd FileType unite call s:unite_settings()

" Monokai
Bundle 'sickill/vim-monokai'
colorscheme monokai

Bundle 'Lokaltog/vim-powerline'

" Supertab - always keep last for the autocomplete plugins
Bundle 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = 'context'
set omnifunc=syntaxcomplete#Complete