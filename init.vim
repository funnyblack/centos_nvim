call plug#begin()

" Go Plugin
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" 主题配色
Plug 'morhetz/gruvbox'

" 状态栏插件，包括显示行号，列号，文件类型，文件名，以及Git状态
Plug 'vim-airline/vim-airline'
" 状态栏目插件的主题，使用后可以使颜色看起来更加突出一点
Plug 'vim-airline/vim-airline-themes'

" 用来提供一个导航目录的侧边栏
Plug 'preservim/nerdtree'
" nerdtree 中显示 git 状态
Plug 'Xuyuanp/nerdtree-git-plugin'

" 可以在文档中显示 git 信息
Plug 'airblade/vim-gitgutter'

" markdown 预览
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" markdown 中 latex 数学公式支持
" Plug 'iamcco/mathjax-support-for-mkdp'

" 下面两个插件要配合使用，可以自动生成代码块
" B
" Plug 'SirVer/ultisnips'   " 插件本身， 使用 coc-snippets 替换了
Plug 'honza/vim-snippets' " 代码片段仓库

" 代码自动完成插件
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" Indentation
set shiftwidth=4
set softtabstop=4
set expandtab

" Line numbers
set number

set mouse=a
set selection=exclusive
vnoremap <C-c> "+y
inoremap <C-v> <Esc>"+pa

" Highlight search results
set hlsearch

" Syntax highlighting
syntax on

" Auto-indent
filetype plugin indent on

" Disable backup files
set nobackup
set noswapfile
set undodir=~/.vim/undodir
set undofile

" 打开 24 位真彩色支持
set termguicolors
" 搜索的时候忽略大小字字母
set ignorecase
" 若搜索内容中有大写字母，则不再忽略大小写
set smartcase
" 高亮第80列
set colorcolumn=80
" 高亮光标所在行
set cursorline

" Go debugger
let g:go_debug_breakpoint_sign = 'o'
let g:go_list_type = "quickfix"
let g:go_list_map = "<leader>l"
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1

" Syntax highlighting
syntax on
set background=dark
colorscheme gruvbox

" 设置ripgrep的规则
set grepprg=rg\ --vimgrep\ --hidden\ --follow\ --ignore-file=.rgignore\ -w\ $*

" 将 <leader> 键设置为分号
let mapleader = ";"
nnoremap <leader>e :NERDTreeToggle<cr>
nnoremap <leader>f :FZF<CR>
nnoremap <leader>k :Rg<CR>

let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1

let g:airline_theme='light'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
 nmap <leader>1 <Plug>AirlineSelectTab1
 nmap <leader>2 <Plug>AirlineSelectTab2
 nmap <leader>3 <Plug>AirlineSelectTab3
 nmap <leader>4 <Plug>AirlineSelectTab4
 nmap <leader>5 <Plug>AirlineSelectTab5
 nmap <leader>6 <Plug>AirlineSelectTab6
 nmap <leader>7 <Plug>AirlineSelectTab7
 nmap <leader>8 <Plug>AirlineSelectTab8
 nmap <leader>9 <Plug>AirlineSelectTab9
 nmap <leader>0 <Plug>AirlineSelectTab0
 nmap <leader>h <Plug>AirlineSelectPrevTab
 nmap <leader>l <Plug>AirlineSelectNextTab

" coc
set nobackup
set nowritebackup
set updatetime=300
set cmdheight=2
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')
nmap <leader>rn <Plug>(coc-rename)
inoremap <silent><expr> <c-l> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <M-k> "\<C-p>"
inoremap <silent><expr> <M-j> "\<C-n>"

xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <silent> <M-k> <Plug>(coc-diagnostic-prev)
nmap <silent> <M-j> <Plug>(coc-diagnostic-next)

autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
