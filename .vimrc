syntax on
set number
set cursorline
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set mouse=a
set clipboard=unnamed

call plug#begin()

" Colorscheme
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.x' }

" File explorer
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'

" Tree sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'mrjones2014/nvim-ts-rainbow'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

" autopair
Plug 'windwp/nvim-autopairs'

" Markdown plugin
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

" jupyter notebook
Plug 'dccsillag/magma-nvim', { 'do': ':UpdateRemotePlugins' }

" Remote SSH
Plug 'chipsenkbeil/distant.nvim', { 'branch': 'v0.3' }

" Terminal
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

" LSP Signature
Plug 'ray-x/lsp_signature.nvim'

" Copilot
Plug 'CopilotC-Nvim/CopilotChat.nvim'
call plug#end()

" ------------------------------------

" ------------------------------------
" COLORSCHEME
set termguicolors
colorscheme catppuccin-mocha

" ------------------------------------

" ------------------------------------
" KEY MAPPINGS
let mapleader=" "

nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fs <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>

nnoremap <leader>e <cmd>NvimTreeToggle<CR>

" Split creation
nnoremap <leader>sv <cmd>vsplit<CR>
nnoremap <leader>sh <cmd>split<CR>
nnoremap <leader>sx <cmd>close<CR>

" buffer navigation
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bp :bp<CR>
nnoremap <leader>bd :bdelete<CR>

" MarkDown
nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle

nnoremap <silent><expr> <LocalLeader>r  :MagmaEvaluateOperator<CR>
nnoremap <silent>       <LocalLeader>rr :MagmaEvaluateLine<CR>
xnoremap <silent>       <LocalLeader>r  :<C-u>MagmaEvaluateVisual<CR>
nnoremap <silent>       <LocalLeader>rc :MagmaReevaluateCell<CR>
nnoremap <silent>       <LocalLeader>rd :MagmaDelete<CR>
nnoremap <silent>       <LocalLeader>ro :MagmaShowOutput<CR>

let g:magma_automatically_open_output = v:false
let g:magma_image_provider = "ueberzug"

" set
autocmd TermEnter term://*toggleterm#*
      \ tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>

" By applying the mappings this way you can pass a count to your
" mapping to open a specific window.
" For example: 2<C-t> will open terminal 2
nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>

" Copilot chat
nnoremap <leader>ce <cmd>CopilotChatExplain<cr>
nnoremap <leader>ct <cmd>CopilotChatTests<cr>
nnoremap <leader>cv <cmd>CopilotChatVisual<cr>
nnoremap <leader>cx <cmd>CopilotChatInPlace<cr>

" ------------------------------------

" ------------------------------------
" Autopair settings
lua << EOF
require("nvim-autopairs").setup {}
EOF

" ------------------------------------

" ------------------------------------
" Terminal settings
lua << EOF
require("toggleterm").setup()
EOF

" ------------------------------------

" ------------------------------------
" NvimTree settings

lua << EOF

require("nvim-tree").setup({
	actions = {
		open_file = {
			quit_on_open = true,
			window_picker = {
				enable = false,
			},
		},
	},
	sort_by = "extension",
	on_attach = on_attach,
	git = {
		ignore = false,
	},
	filters = {
		custom = {".DS_Store"}
	},
	view = {
		preserve_window_proportions = true
	}
})

require("nvim-web-devicons").setup()

EOF

" ------------------------------------

" ------------------------------------
" Treesitter config
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
    ensure_installed = {
        "bash",
        "c",
        "cpp",
        "dockerfile",
		"java",
        "json",
        "jsonc",
        "lua",
        "make",
        "python",
        "verilog",
        "vim",
		"rust",
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        disable = {},

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = true,
    },
    rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        colors = {
            "#feb868",
            "#cd64ce",
            "#85c7f2"
        } -- table of hex strings
    }
}
EOF

" ------------------------------------

" ------------------------------------
" Airline config
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#alt_sep = 0
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 0
:hi airline_c  ctermbg=NONE guibg=NONE
:hi airline_tabfill ctermbg=NONE guibg=NONE

"-----------------------------------------------------------------------------------

"-----------------------------------------------------------------------------------
" Buffer tabs
lua << EOF
require("bufferline").setup{}
EOF

" LSP Signature
lua << EOF
require("lsp_signature").setup{}
EOF

"-----------------------------------------------------------------------------------

"-----------------------------------------------------------------------------------
" Copilot 
"
lua << EOF
local copilot_chat = require("CopilotChat")
copilot_chat.setup({
  debug = true,
  show_help = "yes",
  prompts = {
    Explain = "Explain how it works.",
    Review = "Review the following code and provide concise suggestions.",
    Tests = "Briefly explain how the selected code works, then generate unit tests.",
    Refactor = "Refactor the code to improve clarity and readability.",
  },
  build = function()
    vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
  end,
  event = "VeryLazy",
})
EOF
