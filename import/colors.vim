vim9script

scriptencoding utf-8

def GetColor(group: string): list<string>
  return [
    synIDattr(hlID(group), "fg", "cterm"),
    synIDattr(hlID(group), "fg", "gui"),
    ]
enddef

var bg0  = GetColor('GruvboxBg0')
var bg1  = GetColor('GruvboxBg1')
var bg2  = GetColor('GruvboxBg2')
var bg3  = GetColor('GruvboxBg3')
var bg4  = GetColor('GruvboxBg4')
var fg1  = GetColor('GruvboxFg1')
var fg4  = GetColor('GruvboxFg4')

var yellow = GetColor('GruvboxYellow')
var blue   = GetColor('GruvboxBlue')
var aqua   = GetColor('GruvboxAqua')
var orange = GetColor('GruvboxOrange')
var green  = GetColor('GruvboxGreen')
var red    = GetColor('GruvboxRed')

def AddHighlight(name: string, fg: list<string>, bg: list<string>, bold: bool)
  var hi_format: string
  if bold
    hi_format = 'hi %s cterm=bold ctermfg=%s ctermbg=%s gui=bold guifg=%s guibg=%s'
  else
    hi_format = 'hi %s ctermfg=%s ctermbg=%s guifg=%s guibg=%s'
  endif
  exec printf(hi_format, name, fg[0], bg[0], fg[1], bg[1])
enddef

export def AddStatuslineHighlight()
  AddHighlight('Statusline_normal_0', bg0, fg4, false)
  AddHighlight('Statusline_normal_0_bold', bg0, fg4, true)
  AddHighlight('Statusline_normal_0_1', fg4, bg1, false)
  AddHighlight('Statusline_insert_0', bg0, blue, false)
  AddHighlight('Statusline_insert_0_bold', bg0, blue, true)
  AddHighlight('Statusline_insert_0_1', blue, bg1, false)
  AddHighlight('Statusline_replace_0', bg0, aqua, false)
  AddHighlight('Statusline_replace_0_bold', bg0, aqua, true)
  AddHighlight('Statusline_replace_0_1', aqua, bg1, false)
  AddHighlight('Statusline_visual_0', bg0, orange, false)
  AddHighlight('Statusline_visual_0_bold', bg0, orange, true)
  AddHighlight('Statusline_visual_0_1', orange, bg1, false)
  AddHighlight('Statusline_select_0', bg0, yellow, false)
  AddHighlight('Statusline_select_0_bold', bg0, yellow, true)
  AddHighlight('Statusline_select_0_1', yellow, bg1, false)
  AddHighlight('Statusline_terminal_0', bg0, green, false)
  AddHighlight('Statusline_terminal_0_bold', bg0, green, true)
  AddHighlight('Statusline_terminal_0_1', green, bg1, false)

  AddHighlight('Statusline_inactive_0', bg0, bg4, false)
  AddHighlight('Statusline_inactive_0_bold', bg0, bg4, true)
  AddHighlight('Statusline_inactive_0_1', bg4, bg1, false)
  AddHighlight('Statusline_inactive_1', bg3, bg1, false)
  AddHighlight('Statusline_inactive_1_1', bg2, bg1, false)

  hi! link Statusline_active_0 Statusline_normal_0
  hi! link Statusline_active_0_bold Statusline_normal_0_bold
  hi! link Statusline_active_0_1 Statusline_normal_0_1
  AddHighlight('Statusline_active_1', fg4, bg1, false)
  AddHighlight('Statusline_active_1_mod', red, bg1, false)
  AddHighlight('Statusline_active_1_ro', green, bg1, false)
  AddHighlight('Statusline_active_1_1', bg3, bg1, false)
  AddHighlight('Statusline_active_1_2', bg1, bg2, false)
  AddHighlight('Statusline_active_2', fg4, bg2, false)
  AddHighlight('Statusline_active_2_2', bg3, bg2, false)
  AddHighlight('Statusline_active_2_3', bg2, bg3, false)
  AddHighlight('Statusline_active_3', fg4, bg3, false)
  AddHighlight('Statusline_active_3_3', bg4, bg3, false)
  AddHighlight('User1', red, bg3, false)
  AddHighlight('User2', yellow, bg3, false)
  AddHighlight('User3', aqua, bg3, false)
enddef

