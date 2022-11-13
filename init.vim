call plug#begin()
Plug 'ayu-theme/ayu-vim'
Plug 'Yggdroot/indentLine'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'krfl/fleetish-vim'
Plug 'ellisonleao/glow.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-tree/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'romgrk/barbar.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'nvim-lualine/lualine.nvim'
Plug 'doums/darcula'
Plug 'briones-gabriel/darcula-solid.nvim'
Plug 'rktjmp/lush.nvim'
" Add maktaba and codefmt to the runtimepath.
" (The latter must be installed before it can be used.)
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plug 'google/vim-glaive'

call plug#end()

"------------ Configs ------------
let mapleader = ","
set encoding=UTF-8

set number
syntax on

set termguicolors
set background=dark
"colorscheme fleetish
"let ayucolor="dark"   " for dark version of theme
"colorscheme ayu
colorscheme darcula
"colorscheme darcula-solid
"CHADTree Configs
nnoremap <leader>v <cmd>CHADopen<cr>
nnoremap <leader>w :bd<cr>

"Telescope Configs
nnoremap <leader>ff <cmd>Telescope find_files<cr>

"Coc Configs
nnoremap <leader>b :call CocActionAsync('jumpDefinition')<cr>
nnoremap <leader>r <Plug>(coc-references)
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Rename symbol
nmap <leader>rn <Plug>(coc-rename)

"Barbar configs
nnoremap <silent>    <leader>1 <Cmd>BufferGoto 1<CR>
nnoremap <silent>    <leader>2 <Cmd>BufferGoto 2<CR>
nnoremap <silent>    <leader>3 <Cmd>BufferGoto 3<CR>
nnoremap <silent>    <leader>4 <Cmd>BufferGoto 4<CR>
nnoremap <silent>    <leader>5 <Cmd>BufferGoto 5<CR>
nnoremap <silent>    <leader>6 <Cmd>BufferGoto 6<CR>
nnoremap <silent>    <leader>7 <Cmd>BufferGoto 7<CR>
nnoremap <silent>    <leader>8 <Cmd>BufferGoto 8<CR>
nnoremap <silent>    <leader>9 <Cmd>BufferGoto 9<CR>

"Tree-Sitter configs
lua << EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = { "cpp" },
	highlight = { enable = true }
}
EOF


"Lualine Configs
lua << EOF
require('lualine').setup()
EOF

" google/codefmt
call glaive#Install()
nnoremap <leader>cf <cmd>FormatCode<cr>
