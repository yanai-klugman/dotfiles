" Basic settings
set nocompatible                " Disable Vi compatibility mode
set encoding=utf-8              " Use UTF-8 encoding
set backspace=indent,eol,start  " Enable backspace in insert mode
set history=1000                " Store more command and search history
set hidden                      " Allow switching buffers without saving

" Set leader key
let mapleader=" "               " Use space as the leader key

" Interface improvements
set number                      " Show line numbers
set relativenumber              " Show relative line numbers
set cursorline                  " Highlight the current line
set showcmd                     " Show partial commands in the bottom bar
set wildmenu                    " Enhanced command line completion
set showmatch                   " Highlight matching parentheses
set scrolloff=8                 " Keep 8 lines visible when scrolling
set laststatus=2                " Always show the status line
set splitbelow                  " Horizontal splits go below
set splitright                  " Vertical splits go to the right
set termguicolors               " Enable true color support

" Search settings
set ignorecase                  " Case insensitive searching
set smartcase                   " Case-sensitive if uppercase letters are used
set incsearch                   " Incremental search
set hlsearch                    " Highlight search results

" Indentation
set autoindent                  " Copy indent from current line when starting a new line
set smartindent                 " Smart autoindenting when starting a new line
set expandtab                   " Convert tabs to spaces
set shiftwidth=4                " Number of spaces to use for autoindent
set tabstop=4                   " Number of spaces that a <Tab> in the file counts for

" Clipboard
set clipboard=unnamedplus       " Use the system clipboard

" Backup and swap files
set noswapfile                  " Disable swap files
set nobackup                    " Disable backup files
set nowritebackup               " Disable backup before overwriting a file

" Faster key repeat
set timeoutlen=500              " Faster key timeout for leader key

" Filetype and syntax
filetype on                     " Enable filetype detection
filetype plugin on              " Enable filetype-specific plugins
filetype indent on              " Enable filetype-specific indenting
syntax on
set termguicolors
colorscheme desert

" Other useful settings
set undofile                    " Enable persistent undo
set updatetime=300              " Faster completion (default is 4000ms)
