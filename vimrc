" Use Vim settings, not Vi settings.
" This must be first to prevent side effects.
set nocompatible

" ========== General Config ==========

set number                     " Line numbers
set numberwidth=4              " Columns for line nums
set backspace=indent,eol,start " Backspace in insert mode
set history=1000               " :cmdline history
set showcmd                    " Show incomplete cmds
set showmode                   " Show current mode
set showmatch                  " Show matching brackets
set ruler                      " Show line and column
set nomodeline                 " Display mode
set wildmenu                   " enhanced command completion
set gcr=a:blinkon0             " Disable cursor blink
set visualbell                 " No sounds
set t_vb=                      " No flashing
set autoread                   " Reload files changed outside vim
set hidden                     " Buffers in background
set pastetoggle=<F2>           " F2 for paste mode
nmap <F3> :set invnumber<CR>   " F3 toggle line numbers
syntax on                      " Syntax highlighting
let python_highlight_all = 1
let g:rustfmt_autosave = 1     " rustfmt on save
let g:zig_fmt_autosave = 1     " fmt on save

" ========== No Swap Files ==========

set noswapfile        " Do not write .swp files
set nobackup          " Do not write backup files
set nowb              " No automatic backups

" ========== Indentation ==========

set autoindent        " Automatically indent
set smartindent       " Be smart when indenting
set cindent           " Stricter rules for C
set smarttab          " Be smart when using tabs
set shiftwidth=8      " Spaces per indent
set softtabstop=8     " Spaces per tab when editing
set tabstop=8         " Spaces per tab
set noexpandtab       " Tabs equal spaces
set textwidth=0       " Don't wrap lines (insert)
set nowrap            " Don't wrap lines (view)
set linebreak         " Wrap lines at convenient points

filetype plugin on    " Enable filetype plugin
filetype indent on    " load filetype specific indent files

" ========== Autocommands ==========

" c files
au BufRead,BufNewFile *.c setfiletype c
au BufRead,BufNewFile *.h setfiletype c
au FileType c setlocal noexpandtab shiftwidth=8 tabstop=8 softtabstop=8

" Go files
au BufRead,BufNewFile *.go setfiletype go
au FileType go setlocal noexpandtab shiftwidth=8 tabstop=8 softtabstop=8

" Makefiles
au BufRead,BufNewFile Makefile* set noexpandtab shiftwidth=8 tabstop=8 softtabstop=8

" yml files
au BufRead,BufNewFile *.yml setfiletype yaml
au BufRead,BufNewFile *.yaml setfiletype yaml
au FileType yaml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" ========== Folds ==========

set foldmethod=indent " Fold based on indent
set foldnestmax=9     " X nested fold max
set nofoldenable      " Do not fold by default

" ========== Search ==========

set hlsearch          " Highlight searches
set ignorecase        " Ignore case
set smartcase         " Use case if capital typed

" ========== Scrolling ==========

set scrolloff=8       " Start scrolling at 8 lines from top/bottom
set sidescrolloff=10  " Keep 5 lines at the side

" ========== Normal Mode Key Maps ==========

" ,/ to unhighlight search
nmap <silent> ,/ :nohlsearch<CR>

" ========== Trailing Whitespace ===========
highlight ExtraWhitespace ctermbg=green guibg=green
match ExtraWhitespace /\s\+$/

" ========== Listchars ==========
set list
set listchars=tab:>-
hi SpecialKey ctermfg=lightgrey guifg=grey93

" ========== Visual Mode Key Maps ==========

" ========== Insert Mode Key Maps ==========

" ========== Command Line Mode Key Maps ==========

" Write when readonly
cnoremap w!! w !sudo tee > /dev/null %
