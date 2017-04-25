" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set backup
set backupdir=~/backup
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching


 " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  au BufRead,BufNewFile *.py set shiftwidth=4
  au BufRead,BufNewFile *.html set shiftwidth=2
  au BufRead,BufNewFile *.java set shiftwidth=4
  au BufRead,BufNewFile *.m set filetype=octave
  au BufRead,BufNewFile *.gpl set filetype=gnuplot
  au BufRead,BufNewFile *.vav set filetype=xml 
  
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
" set hlsearch
endif

let g:changelog_username="PelicanHPC user"

if has("gui_running")
	set guifont=Courier\ 13
	set columns=110
	set lines=32
endif
