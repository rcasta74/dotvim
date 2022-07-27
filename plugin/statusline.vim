vim9script

scriptencoding utf-8

import 'colors.vim'

set laststatus=2

colors.AddStatuslineHighlight()

var mode_map = {
  n:        [ 'NORMAL',   'normal' ],
  i:        [ 'INSERT',   'insert' ],
  R:        [ 'REPLACE',  'replace' ],
  v:        [ 'VISUAL',   'visual' ],
  V:        [ 'V-LINE',   'visual' ],
  "\<C-v>": [ 'V-BLOCK',  'visual' ],
  c:        [ 'COMMAND',  'normal' ],
  s:        [ 'SELECT',   'select' ],
  S:        [ 'S-LINE',   'select' ],
  "\<C-s>": [ 'S-BLOCK',  'select' ],
  t:        [ 'TERMINAL', 'terminal' ],
  }

var icons = {
  dos:  "\ue70f", # 
  unix: "\ue712", # 
  mac:  "\ue711", # 
}


def g:StatuslineFileFormat(): string
  return get(icons, &fileformat, &fileformat)
enddef

def g:StatuslineFileType(): string
  return get(icons, &filetype, &filetype)
enddef

def g:StatuslineMode(): string
  return get(mode_map, mode(), mode_map['n'])[0]
enddef


def ChangeMode()
  if v:event.old_mode[0] == v:event.new_mode[0]
    return
  endif
  var mode = get(mode_map, v:event.new_mode[0], mode_map['n'])[1]
  exec printf('hi! link Statusline_active_0 Statusline_%s_0', mode)
  exec printf('hi! link Statusline_active_0_bold Statusline_%s_0_bold', mode)
  exec printf('hi! link Statusline_active_0_1 Statusline_%s_0_1', mode)
enddef

var sepLeft = "\ue0b0"
var sepRight = "\ue0b2"
var sepSubLeft = "\ue0b1"
var sepSubRight = "\ue0b3"

def GetStlSimple(pattern: string): dict<string>
  return {
    active: '%#Statusline_active_0_bold# %{winnr()} %#Statusline_active_0_1#' .. sepLeft
         .. '%#Statusline_active_1# ' .. pattern .. ' %#Statusline_active_1_2#' .. sepLeft,
    inactive: '%#Statusline_inactive_0_bold# %{winnr()} %#Statusline_inactive_0_1#' .. sepLeft
           .. '%#Statusline_inactive_1# ' .. pattern .. ' %#Statusline_inactive_1_1#' .. sepSubLeft,
  }
enddef

var stl_map = {
  default: {
    active: '%#Statusline_active_0_bold# %{g:StatuslineMode()} %{winnr()} %#Statusline_active_0_1#' .. sepLeft
         .. '%{%&modified?"%#Statusline_active_1_mod#":(&readonly?"%#Statusline_active_1_ro#":"%#Statusline_active_1#")%} %t %#Statusline_active_1_2#' .. sepLeft
         .. '%#Statusline_active_2#%{%!empty(&filetype)?" %{g:StatuslineFileType()} ":""%}%#Statusline_active_2_3#' .. sepLeft
         .. '%=%#Statusline_active_2_3#' .. sepRight
         .. '%#Statusline_active_2# %{&encoding} | %{g:StatuslineFileFormat()} %#Statusline_active_1_2#' .. sepRight
         .. '%#Statusline_active_1# %3.l:%3.v %#Statusline_active_1_1#' .. sepSubRight
         .. '%#Statusline_active_1# %P ',
    inactive: '%#Statusline_inactive_0_bold# %{winnr()} %#Statusline_inactive_0_1#' .. sepLeft
           .. '%#Statusline_inactive_1# %t %#Statusline_inactive_1_1#' .. sepSubLeft
           .. '%{%!empty(&filetype)?"%#Statusline_inactive_1# %{g:StatuslineFileType()} %#Statusline_active_1_1#' .. sepSubLeft .. '":""%}'
           .. '%=%#Statusline_inactive_1_1#' .. sepSubRight
           .. '%#Statusline_inactive_1# %{&encoding} | %{&fileformat} %#Statusline_inactive_1_1#' .. sepSubRight
           .. '%#Statusline_inactive_1# %P ',
  },
  help: {
    active: '%#Statusline_active_0_bold# %{winnr()} %#Statusline_active_0_1#' .. sepLeft
         .. '%{%&modified?"%#Statusline_active_1_mod#":(&readonly?"%#Statusline_active_1_ro#":"%#Statusline_active_1#")%} %t %#Statusline_active_1_2#' .. sepLeft
         .. '%#Statusline_active_2# %{&filetype} %#Statusline_active_2_3#' .. sepLeft
         .. '%=%#Statusline_active_2_3#' .. sepRight
         .. '%#Statusline_active_2# %3.l:%3.v %#Statusline_active_1_2#' .. sepRight
         .. '%#Statusline_active_1# %P ',
    inactive: '%#Statusline_inactive_0_bold# %{winnr()} %#Statusline_inactive_0_1#' .. sepLeft
           .. '%#Statusline_inactive_1# %t %#Statusline_inactive_1_1#' .. sepSubLeft
           .. '%#Statusline_inactive_1# %{&filetype} %#Statusline_inactive_1_1#' .. sepSubLeft
           .. '%=%#Statusline_inactive_1_1#' .. sepSubRight
           .. '%#Statusline_inactive_1# %P ',
  },
  terminal: GetStlSimple('Terminal'),
  startify: GetStlSimple('Startify'),
  netrw: GetStlSimple('Explorer'),
}

def GetStl(active: bool): string
  var key = stl_map->has_key(&buftype)
            ? &buftype
            : stl_map->has_key(&filetype)
              ? &filetype
              : 'default'
  return stl_map->get(key)->get(active ? 'active' : 'inactive')
enddef


augroup statusline
  autocmd!
  autocmd BufWinEnter,WinEnter,TerminalWinOpen * setwinvar(winnr(), '&statusline', GetStl(true))
  # Sometime filetype is set after entering the window
  autocmd FileType * setwinvar(winnr(), '&statusline', GetStl(true))
  autocmd WinLeave * setwinvar(winnr(), '&statusline', GetStl(false))
  # Different color for different mode
  autocmd ModeChanged * ChangeMode()
augroup END

