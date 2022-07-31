vim9script

scriptencoding utf-8

if !get(g:, "coc_enabled", 0)
  finish
endif

g:coc_global_extensions = [
  'coc-json',
  'coc-fzf-preview',
]

call coc#config('outline.splitCommand', 'topleft 30vs')
call coc#config('outline.checkBufferSwitch', false)
call coc#config('coc.preferences.currentFunctionSymbolAutoUpdate', true)


# Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

# Use `[g` and `]g` to navigate diagnostics
# Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

# GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call CocActionAsync('doHover')<cr>

# Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

# Show signature help when jumping to placeholder.
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

# Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

# Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup coc_user
  autocmd!
  # Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setlocal formatexpr=CocAction('formatSelected')
  # Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


# Applying codeAction to the selected region.
# Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

# Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
# Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

# Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)


# Use CTRL-S for selections ranges.
# Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

# Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

# Add `:Fold` command to fold current buffer.
command! -nargs=? Fold   :call CocAction('fold', <f-args>)

# Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR     :call CocActionAsync('runCommand', 'editor.action.organizeImport')


# Mappings for CoCList
# Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
# Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
# Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
# Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
# Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
# Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
# Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
# Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

def g:ToggleOutline()
  var winid: number
  winid = coc#window#find('cocViewId', 'OUTLINE')
  if winid == -1
    call g:CocActionAsync('showOutline', 0)
  else
    coc#window#close(winid)
  endif
enddef
nnoremap <silent><nowait> <F2>  :call g:ToggleOutline()<CR>

