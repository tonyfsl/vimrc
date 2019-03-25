" ---------------------------------------------------------------------------
"  Author:tonyfsl   <tonyviper at gmail.com>
"  The primary version was completed on May 27th 2018
"
"  Some functions were copied from dofy/7th-vim, Derek Wyatt and amix/vimrc
" ---------------------------------------------------------------------------


" ---------------------------------------------------------------------------
"  Sections:
"     -> Plugin Management
"     -> General
"     -> Keymapping and Some Useful Tricks
"     -> Visual Setting
" ---------------------------------------------------------------------------


" >>>>>>> COMMON AND NECESSARY SETTINGS <<<<<<< {{{1

set nocompatible

syntax on                      " 开启语法高亮

set encoding=utf-8
scriptencoding utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936

" Use Unix as the standard file type
set fileformats=unix,dos,mac
 	
filetype plugin indent on 

let mapleader=','         

" }}}1


" >>>>>>> PLUGIN MANAGEMENT <<<<<<< {{{1

if filereadable(expand("~/vim_plugins"))
    source ~/vim_plugins
endif
" }}}1


" >>>>>>> GENERAL SETTINGS <<<<<<< {{{1

set clipboard+=unnamed         " 可以直接粘贴剪贴板内容

set foldenable                 " 默认开启代码折叠
set foldmethod=marker          " 折叠类型
" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

set backspace=indent,eol,start " 智能回删
set whichwrap+=h,l,<,>,[,]     " 光标循环
set virtualedit=block,onemore  " 允许光标出现在最后一个字符的后面

set number                     " 显示行号
set relativenumber             " 显示相对行号
set ruler                      " 显示标尺信息

" Tab and indent
set expandtab                  " Tab 替换为空格
set smartindent                " 智能缩进
set softtabstop=4              " Tab 缩进单位
set shiftwidth=4               " 自动缩进单位

set t_Co=256                   " 开启256色(若终端支持)

set ignorecase                 " 搜索忽略大小写
set incsearch                  " 搜索实时高亮
set hlsearch
set smartcase

set linebreak                  " 自动折行
set scrolloff=5                " 屏幕顶/底部保持 5 行文本
set laststatus=2               " 显示状态栏
set noshowmode                 " 不显示当前状态
set showcmd                    " 显示输入的命令
set history=200                " 历史命令保存条数
set autoread                   " 自动加载外部修改
set confirm                    " 弹出文件未保存确认

set wildmenu                   " Vim 命令行提示
" Types of files to ignore when autocompleting things
set wildignore+=*.o,*.class,*.git,*.svn

" Switch between buffers without having to save first
set hidden
set timeoutlen=700             " 操作符待决等待时间

" Reload the vim settings immediately after the changing has been made
" Seems not working perfect while having more than one vimrc files
" if has("autocmd")
"     autocmd! bufwritepost .vimrc source ~\.vimrc
" endif
" }}}1	


" >>>>>>> KEY MAPPING <<<<<<< {{{1

" Change the basic save and quit keys
nmap <Leader>q :q<CR>
nmap <Leader>w :w<CR>
nmap <Leader>WQ :wa<CR>:q<CR>
nmap <Leader>Q :qa!<CR>

" Navigation Between Windows
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=1
catch
endtry

" Make it easy to open/reload vimrc file
nmap <silent> <leader>ev :e ~/.vimrc<CR>
nmap <silent> <leader>sv :so ~/.vimrc<CR>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

" }}}1	


" >>>>>>> VISUAL SETTINGS <<<<<<< {{{1

try
    colorscheme gruvbox
catch
endtry
set background=dark

set textwidth=84

" Hide GUI scroll bars
set guioptions-=T
set guioptions-=m
set guioptions-=L 
set guioptions-=r
set guioptions-=b

" Use the non-GUI tab pages line
set guioptions-=e

" Config the windows visual setting
if has("win32")
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    language messages zh_CN.utf-8
    set guifont=MesloLGM_NF:h12
    set guifontwide=YaHei\ Consolas\ Hybrid:h12
    set lines=35 columns=88
endif

" Avoid garbled characters in Chinese language windows OS
" let $LANG='en_US.utf-8' 
" set langmenu=zh_CN

" Set up the GUI cursor to look nice
set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

" }}}1	
