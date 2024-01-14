call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'feline-nvim/feline.nvim'
" Barbar
Plug 'lewis6991/gitsigns.nvim' " OPTIONAL: for git status
Plug 'nvim-tree/nvim-web-devicons' " OPTIONAL: for file icons
Plug 'romgrk/barbar.nvim'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }

Plug 'folke/noice.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'tzachar/local-highlight.nvim'

Plug 'vim-autoformat/vim-autoformat'

" Theme
Plug 'tomasiser/vim-code-dark'

" Icons
Plug 'nvim-tree/nvim-web-devicons' " Recommended (for coloured icons)

" Dashboard
Plug 'goolord/alpha-nvim'

" Comments
Plug 'numToStr/Comment.nvim'

" Auto bracket close
Plug 'windwp/nvim-autopairs'

call plug#end()

" ----- Configs -----
let mapleader = ","
set encoding=UTF-8
set ts=4 sw=4
set mouse=a

set number
syntax on

" Shortcuts
nnoremap <silent> <leader>sw <C-w>w

" Making the background transparent
augroup user_colors
	autocmd!
	autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
augroup END

set background=dark
set termguicolors

" Vscode theme configs
" If you don't like many colors and prefer the conservative style of the standard Visual Studio
" let g:codedark_conservative=1
" Make the background transparent
let g:codedark_transparent=1
colorscheme codedark

"CHADTree Configs
nnoremap <leader>v <cmd>CHADopen<cr>
nnoremap <silent> <leader>w :bd<cr>

"Telescope Configs
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fw <cmd>Telescope live_grep<cr>

"Coc Configs
nnoremap <silent> <leader>b :call CocActionAsync('jumpDefinition')<cr>
nnoremap <silent> <leader>r <Plug>(coc-references)
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

" Feline
lua << EOF
require('feline').setup()
EOF

" Noice Configs
lua << EOF
require("noice").setup({
lsp = {
	messages = { enabled = false },
	-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
	override = {
		["vim.lsp.util.convert_input_to_markdown_lines"] = true,
		["vim.lsp.util.stylize_markdown"] = true,
		["cmp.entry.get_documentation"] = true,
		},
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
		},
})
EOF

" Comment Plugin Configs
lua << EOF
require('Comment').setup()
EOF

" Vim autoformat
let g:python3_host_prog="/usr/local/bin/python3"
" noremap <silent> <leader>cf :Autoformat <CR>
" au BufWrite * :Autoformat

" Local-Highlight Configs
lua << EOF
require('local-highlight').setup({
file_types = {'python', 'cpp', 'vim'}
})
EOF

" Git signs configs
lua << EOF
require('gitsigns').setup({
current_line_blame = true,
current_line_blame_opts = {
	delay = 500
}
})
EOF

lua << EOF
 local alpha = require'alpha'
 local dashboard = require'alpha.themes.dashboard'
 dashboard.section.header.val = {
	 [[                               __                ]],
	 [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
	 [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
	 [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
	 [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
	 [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
 }
 dashboard.section.buttons.val = {
	dashboard.button("ff", "  Find File", ",ff"),
	dashboard.button("fw", "  Find Word", ",fw"),
 }
 local handle = io.popen('fortune')
 local fortune = handle:read("*a")
 handle:close()
 dashboard.section.footer.val = fortune

 dashboard.config.opts.noautocmd = true

 vim.cmd[[autocmd User AlphaReady echo 'ready']]

 alpha.setup(dashboard.config)
EOF

" auto-pairs configs
lua << EOF
require("nvim-autopairs").setup({})
EOF
