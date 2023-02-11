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

  branch: "\ue725", # 

  sh: "\ufcb5", # ﲵ
  c: "\ufb70", # ﭰ
  cpp: "\ufb71", # ﭱ
  java: "\uf4e4", # 
  #java: "\ue738", # 
  #java: "\ue256", # 
  javascript: "\ue60c", # 
  #javascript: "\ue74e", # 
  json: "\ue60b", # 
  #json: "\uf668", # 
  #json: "\ueb0f", # 
  vim: "\ue7c5", # 
  #vim: "\ue62b", # 
  html: "\ue60e", # 
  #xml: "\ue618", # 
  #xml: "\uf44f", # 
  #xml: "\uf673", # 
  xml: "\ufabf", # 謹
  #xml: "\uf121", # 
  #markdown: "\uf60f", # 
  markdown: "\ueb1d", # 
  python: "\uf81f", #  
  #python: "\ue606", #  
  #python: "\uf820", # 
  # \ue628  
  # \ue615  
  # \ue614  

  ascii: "\uf825", # 
  # ascii: "\u24b6", # Ⓐ
  'utf-8': "\uf8ba", # 
  #'utf-8': "\u2467", # ⑧
  #'utf-8': "\u247b", # ⑻
  #'utf-8': "\u249c", # ⒜
}


def g:StatuslineFileFormat(): string
  return get(icons, &fileformat, &fileformat)
enddef

def g:StatuslineFileType(): string
  return get(icons, &filetype, &filetype)
enddef

def g:StatuslineEncoding(): string
  return get(icons, &encoding, &encoding)
enddef

def g:StatuslineMode(): string
  return get(mode_map, mode(), mode_map['n'])[0]
enddef

def g:StatuslineGitHunk(sep: string): string
  var [a,m,r] = g:GitGutterGetHunkSummary()
  var stl = ''
  if (a + m + r) > 0
    stl ..= sep
         .. (a > 0 ? '+' .. a .. ' ' : '')
         .. (m > 0 ? '~' .. m .. ' ' : '')
         .. (r > 0 ? '-' .. r .. ' ' : '')
   endif
  return stl
enddef

def g:StatuslineIsGitDir(): bool
  if get(g:, 'loaded_gina', false)
    return !empty(gina#component#repo#name())
  endif
  if get(g:, 'loaded_fugitive', false)
    return g:FugitiveIsGitDir()
  endif
  return false
enddef

def g:StatuslineGitHead(): string
  if get(g:, 'loaded_gina', false)
    return gina#component#repo#branch()
  endif
  if get(g:, 'loaded_fugitive', false)
    return g:FugitiveHead()
  endif
  return ''
enddef

def g:StatuslineStatus(sep: string): string
  var info = get(b:, "coc_diagnostic_info", {})
  var msg: string
  if !empty(info) && get(info, "error", 0) > 0
    msg ..= " %1*\u25cf " .. info["error"]
  endif
  if !empty(info) && get(info, "warning", 0) > 0
    msg ..= " %2*\u25cf " .. info["warning"]
  endif
  if !empty(msg)
    msg ..= " " .. sep
  endif
  return msg .. get(g:, "coc_status", "")
enddef


def ChangeMode()
  # skip if popup
  if win_gettype() == 'popup'
    return
  endif
  if v:event.old_mode[0] == v:event.new_mode[0]
    return
  endif
  var mode = get(mode_map, v:event.new_mode[0], mode_map['n'])[1]
  exec printf('hi! link Statusline_active_0 Statusline_%s_0', mode)
  exec printf('hi! link Statusline_active_0_bold Statusline_%s_0_bold', mode)
  exec printf('hi! link Statusline_active_0_1 Statusline_%s_0_1', mode)
enddef

var sepLeft = "\ue0b0" # 
var sepRight = "\ue0b2" # 
var sepSubLeft = "\ue0b1" # 
var sepSubRight = "\ue0b3" # 

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
         .. '%{%g:StatuslineIsGitDir() '
            .. '? "%#Statusline_active_2# ' .. icons['branch'] .. ' " .. g:StatuslineGitHead() .. " " .. g:StatuslineGitHunk("%#Statusline_active_2_2#' .. sepSubLeft .. ' %#Statusline_active_2#") '
            .. ': ""'
         .. '%}%#Statusline_active_2_3#' .. sepLeft
         .. '%= %#Statusline_active_2_3#' .. sepRight
         .. '%#Statusline_active_2#%{%!empty(&filetype)'
            .. '?" %{g:StatuslineFileType()} |"'
            .. ':""'
         .. '%} %{g:StatuslineEncoding()} | %{g:StatuslineFileFormat()} %#Statusline_active_1_2#' .. sepRight
         .. '%#Statusline_active_1# %3.l:%3.v %#Statusline_active_1_1#' .. sepSubRight .. '%#Statusline_active_1# %P ',
    inactive: '%#Statusline_inactive_0_bold# %{winnr()} %#Statusline_inactive_0_1#' .. sepLeft
           .. '%#Statusline_inactive_1# %t %#Statusline_inactive_1_1#' .. sepSubLeft
           .. '%#Statusline_inactive_1#%{%g:StatuslineIsGitDir()?" %{g:StatuslineGitHead()} ":""%}%#Statusline_inactive_1_1#' .. sepSubLeft
           .. '%=%#Statusline_inactive_1_1#' .. sepSubRight
           .. '%#Statusline_inactive_1#%{!empty(&filetype)?" " .. &filetype .. " |":""} %{&encoding} | %{&fileformat} %#Statusline_inactive_1_1#' .. sepSubRight
           .. '%#Statusline_inactive_1# %P ',
  },
  help: {
    active: '%#Statusline_active_0_bold# %{winnr()} %#Statusline_active_0_1#' .. sepLeft
         .. '%{%&modified?"%#Statusline_active_1_mod#":(&readonly?"%#Statusline_active_1_ro#":"%#Statusline_active_1#")%} %t %#Statusline_active_1_2#' .. sepLeft
         .. '%#Statusline_active_2# help %#Statusline_active_2_3#' .. sepLeft
         .. '%=%#Statusline_active_2_3#' .. sepRight
         .. '%#Statusline_active_2# %3.l:%3.v %#Statusline_active_1_2#' .. sepRight
         .. '%#Statusline_active_1# %P ',
    inactive: '%#Statusline_inactive_0_bold# %{winnr()} %#Statusline_inactive_0_1#' .. sepLeft
           .. '%#Statusline_inactive_1# %t %#Statusline_inactive_1_1#' .. sepSubLeft
           .. '%#Statusline_inactive_1# help %#Statusline_inactive_1_1#' .. sepSubLeft
           .. '%=%#Statusline_inactive_1_1#' .. sepSubRight
           .. '%#Statusline_inactive_1# %P ',
  },
  terminal: GetStlSimple('Terminal'),
  startify: GetStlSimple('Startify'),
  netrw: GetStlSimple('Explorer'),
}

def g:GetStatusline(): string
  var status = g:statusline_winid == win_getid(winnr()) ? 'active' : 'inactive'
  var prop = getwinvar(g:statusline_winid, '&buftype')
  if stl_map->has_key(prop)
    return stl_map->get(prop)->get(status)
  endif
  prop = getwinvar(g:statusline_winid, '&filetype')
  if stl_map->has_key(prop)
    return stl_map->get(prop)->get(status)
  endif
  return stl_map->get('default')->get(status)
enddef

set statusline=%!g:GetStatusline()

augroup statusline
  autocmd!
  # Different color for different mode
  autocmd ModeChanged * ChangeMode()
augroup END

