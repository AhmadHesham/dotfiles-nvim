call plug#begin()
Plug 'ayu-theme/ayu-vim'
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
Plug 'numToStr/Comment.nvim'
Plug 'chrisbra/csv.vim'
Plug 'vim-autoformat/vim-autoformat'
Plug 'lervag/vimtex'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'tzachar/local-highlight.nvim'
" Plug 'rcarriga/nvim-notify'
Plug 'MunifTanjim/nui.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'tomasiser/vim-code-dark'
Plug 'akinsho/toggleterm.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'lewis6991/gitsigns.nvim'
" Might break stuff
Plug 'folke/noice.nvim'
Plug 'goolord/alpha-nvim'
Plug 'simrat39/symbols-outline.nvim'

call plug#end()

"------------ Configs ------------
let mapleader = ","
set encoding=UTF-8
set ts=4 sw=4
set mouse=a

set number
syntax on

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
nnoremap <leader>w :bd<cr>

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


"Lualine Configs
lua << EOF
require('lualine').setup()
EOF

" Indent Line Configs
let g:identLine_conceallevel=0


" Comment Plugin Configs
lua << EOF
require('Comment').setup()
EOF

" Custom Keyboard shortcuts
" Open a new Tab
nnoremap <silent> <leader>sc <cmd> vs <cr>
nnoremap <silent> <leader>nt <cmd> vnew <cr>

" Terminal Configs
:tnoremap <Esc> <C-\><C-n>

" Vim autoformat
let g:python3_host_prog="/usr/local/bin/python3"
noremap <silent> <leader>cf :Autoformat <CR>

" VimTex Configs
" This is necessary for VimTeX to load properly. The "indent" is optional.
" Note that most plugin managers will do this automatically.
filetype plugin on

" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
let g:vimtex_view_method = 'zathura'

" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
let g:vimtex_compiler_method = 'latexmk'

" Latex Live Preview Configs
let g:livepreview_previewer = 'zathura'

" Local-Highlight Configs
lua << EOF
require('local-highlight').setup({
file_types = {'python', 'cpp', 'vim'}
})
EOF

" Notify Configs
" lua << EOF
" require('notify').setup({
" background_colour = '#000000',
" stages = 'static'
" })
" EOF


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

" toggle term configs
lua << EOF
require("toggleterm").setup {
	open_mapping = [[<c-`>]],
	insert_mappings = true,
	start_in_insert = false,
	size = 15
}
EOF

" indent-blankline configs
lua << EOF
require("indent_blankline").setup {}
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

" alpha-vim configs
lua << EOF
local logo = {
	"    |\\__/,|   (`\\ ",
	"  _.|o o  |_   ) )",
	"-(((---(((--------"
	}

local function pick_color()
	local colors = {"String", "Identifier", "Keyword", "Number"}
	return colors[math.random(#colors)]
end

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.opts.hl = pick_color()
dashboard.section.header.val = logo
dashboard.section.buttons.val = {
	dashboard.button("<Leader>ff", "  Find File"),
	dashboard.button("<Leader>fw", "  Find Word"),
}

alpha.setup(dashboard.opts)

vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])
EOF

" Vim outline configs
lua << EOF
require("symbols-outline").setup()
EOF
