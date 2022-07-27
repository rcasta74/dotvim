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

g:startify_fortune_use_unicode = 1
g:banner = [
  '  __    _______   __    __   _____ ______    _____',
  '  ) )  ( (_   _)  \ \  / /  (_   _|_  __ \  / ___/',
  ' ( (    ) )| |    () \/ ()    | |   ) ) \ \( (__  ',
  '  \ \  / / | |    / _  _ \    | |  ( (   ) )) __) ',
  '   \ \/ /  | |   / / \/ \ \   | |   ) )  ) | (    ',
  '    \  /  _| |__/_/      \_\ _| |__/ /__/ / \ \___',
  '     \/  /_____(/          \)_____(______/   \____\',
  ''
]
g:startify_custom_header = 'startify#pad(g:banner)'
g:startify_custom_footer = 'startify#pad(startify#fortune#boxed())'

g:netrw_banner = 0
g:netrw_liststyle = 3
g:netrw_winsize = -35
nmap <unique> <F3> <Cmd>Lexplore!<CR>
