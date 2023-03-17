vim9script

g:LspOptionsSet({
  #autoHighlight: true,
  noNewlineInCompletion: true,
  snippetSupport: true,
  usePopupInCodeAction: true,
})

g:LspAddServer(g:MyLspServers)


inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>    pumvisible() ? "\<C-y>" : "\<CR>"

# Use `[g` and `]g` to navigate diagnostics
# Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
noremap <silent> [g <Cmd>LspDiagNext<CR>
noremap <silent> ]g <Cmd>LspDiagPrev<CR>

# GoTo code navigation.
noremap <silent> gD <Cmd>LspGotoDeclaration<CR>
noremap <silent> gd <Cmd>LspGotoDefinition<CR>
noremap <silent> gi <Cmd>LspGotoImpl<CR>
noremap <silent> gt <Cmd>LspGotoTypeDef<CR>

noremap <silent> gr <Cmd>LspPeekReferences<CR>
noremap <silent> K <Cmd>LspHover<CR>

