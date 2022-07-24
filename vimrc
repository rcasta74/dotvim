vim9script

set encoding=utf-8
setglobal fileencoding=utf-8
scriptencoding utf-8
filetype plugin indent on
syntax on

set nocompatible

set hidden
set updatetime=2000
set shortmess+=c

set backspace=indent,eol,start
set nrformats-=octal
set listchars=tab:→\ ,eol:↵,trail:·,extends:↷,precedes:↶
set fillchars=eob:\ ,vert:│,fold:·

set termguicolors
&t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
&t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set background=dark
colorscheme gruvbox

