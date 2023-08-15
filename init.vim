call plug#begin()
	Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
	Plug 'rcarriga/nvim-notify'

	Plug 'neovim/nvim-lspconfig'
	Plug 'williamboman/mason.nvim'
	Plug 'williamboman/mason-lspconfig.nvim'
	
	Plug 'simrat39/rust-tools.nvim'
	
	Plug 'hrsh7th/cmp-nvim-lsp'
  	Plug 'hrsh7th/cmp-buffer'
  	Plug 'hrsh7th/cmp-path'
  	Plug 'hrsh7th/cmp-cmdline'
  	Plug 'hrsh7th/nvim-cmp'
  	Plug 'hrsh7th/cmp-vsnip'
  	Plug 'hrsh7th/vim-vsnip'
  	Plug 'rafamadriz/friendly-snippets'
  	Plug 'onsails/lspkind-nvim'
  	
  	Plug 'nvim-tree/nvim-web-devicons'
	
call plug#end()

" 顯示列號
set number
" 語法高亮度顯示
syntax on
" 標記搜尋到的字串
set hlsearch
" 自動縮排
set autoindent
" 顯示說明
set ruler
" 顯示編輯狀態
set showmode
" 設定搜尋到的字串顏色
highlight Search term=reverse ctermbg=4 ctermfg=7
exec "nohlsearch"
" 設定 tab 鍵的字元數
" set tabstop=4
set tabstop=4 softtabstop=4 shiftwidth=4

set encoding=utf-8
set scrolloff=5

set background=dark
colorscheme tokyonight-night

" 字體更改
set guifont=Consolas:h15
set guifont=Cousine_Nerd_Font_Mono:h12

" 太長的更新間隔會導致明顯的延遲並降低使用者體驗（預設是 4000 ms = 4s ）
set updatetime=300

" 永遠顯示 signcolumn（行號左邊那個，這我不知道怎麼翻），否則每當有診斷出來時整個程式碼就會被往右移
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " 新的版本可以把 signcolumn 和行號合併（這個我版本不夠沒看過，有人知道會長怎樣可以下面留言嗎？）
  set signcolumn=number
else
  set signcolumn=yes
endif

lua << EOF

require("mason").setup()
require("mason-lspconfig").setup()
require("lsp/setup")
require("lsp/cmp")
require("keybindings")

require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable different highlight colors per icon (default to true)
 -- if set to false all icons will have the default icon's color
 color_icons = true;
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
 -- globally enable "strict" selection of icons - icon will be looked up in
 -- different tables, first by filename, and if not found by extension; this
 -- prevents cases when file doesn't have any extension but still gets some icon
 -- because its name happened to match some extension (default to false)
 strict = true;
 -- same as `override` but specifically for overrides by filename
 -- takes effect when `strict` is true
 override_by_filename = {
  [".gitignore"] = {
    icon = "",
    color = "#f1502f",
    name = "Gitignore"
  }
 };
 -- same as `override` but specifically for overrides by extension
 -- takes effect when `strict` is true
 override_by_extension = {
  ["log"] = {
    icon = "",
    color = "#81e043",
    name = "Log"
  }
 };
}
require'nvim-web-devicons'.get_icon(filename, extension, { default = true })

local rt = require("rust-tools")
rt.setup({
	server = {
		on_attach = function(_, bufnr)
			require'kerbindings'.rt_key(rt, bufnr)
		end,
	},
})

EOF

autocmd BufNew,BufRead *.asm set ft=nasm
