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

set autoindent
set autoread
set display=lastline
set cursorline

set tabstop=4
set shiftwidth=4
set expandtab

set wildmenu
set wildmode=longest:full
set wildoptions=pum
set timeout timeoutlen=1000 ttimeoutlen=100

set writebackup
set undofile

set dir=~/.cache/vim/swap
set backupdir=~/.cache/vim/backup
set undodir=~/.cache/vim/undo

augroup vimStartup
  au!
  # When editing a file, always jump to the last known cursor position.
  # Don't do it when the position is invalid, when inside an event handler
  # (happens when dropping a file on gvim) and for a commit message (it's
  # likely a different one than last time).
  autocmd BufReadPost * {
      if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        exe "normal! g`\""
      endif
    }
augroup END

set number
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

set termguicolors
&t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
&t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

# Open help in vertical split
cnoreabbrev H vert bo h

set background=dark
colorscheme gruvbox
$BAT_THEME = 'gruvbox-dark'
$FZF_PREVIEW_PREVIEW_BAT_THEME = 'gruvbox-dark'

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

$FZF_DEFAULT_OPTS = ""
   .. "--preview-window 'right:57%' "
   .. "--bind ctrl-y:preview-up,ctrl-e:preview-down,"
          .. "ctrl-b:preview-page-up,ctrl-f:preview-page-down,"
          .. "ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down,"
          .. "shift-up:preview-top,shift-down:preview-bottom,"
          .. "alt-up:half-page-up,alt-down:half-page-down"

packadd fugitive
#packadd gina
packadd coc

g:xml_syntax_folding = 1
au FileType xml setlocal foldmethod=syntax

