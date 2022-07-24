vim9script

# save and restore search pattern
augroup navigate_help
  autocmd!
  autocmd BufEnter <buffer> b:old_search_pattern = @/
  autocmd BufLeave <buffer> @/ = get(b:, 'old_search_pattern', '')
augroup END

# Navigate tag references
nnoremap <buffer> <silent> <Tab> /\|\zs\S\{-}\|<cr>
nnoremap <buffer> <silent> <S-Tab> ?\|\zs\S\{-}\|<cr>

# Navigate command references
nnoremap <buffer> <silent> <C-Down> /\`\zs\S\{-}\`<cr>
nnoremap <buffer> <silent> <C-Up> ?\`\zs\S\{-}\`<cr>

# Navigate option references
nnoremap <buffer> <silent> <C-Right> /\'\zs\S\{-}\'<cr>
nnoremap <buffer> <silent> <C-Left> ?\'\zs\S\{-}\'<cr>

# Go to tag|command|option help
nnoremap <buffer> <silent> <CR> <C-]>

# Close help
nnoremap <buffer> <silent> q :q<CR>

