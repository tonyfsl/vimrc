" ---------------------------------------------------------------------------
"  Author:tonyfsl
"  The primary version was completed on May 27th 2018
"
"  Some ideas was generated from dofy/7th-vim, Derek Wyatt and amix/vimrc
" ---------------------------------------------------------------------------


" ---------------------------------------------------------------------------
"  Sections:
"     -> Plugin Management
"     -> General
"     -> Keymapping and Some Useful Tricks
"     -> Visual Setting
" ---------------------------------------------------------------------------


" ---------------------------------------------------------------------------
"                            PLUGIN MANAGEMENT
" ---------------------------------------------------------------------------
try 
    source ~/vim_plugins
catch
endtry


" ---------------------------------------------------------------------------
"                            GENERAL SETTINGS
" ---------------------------------------------------------------------------

let mapleader=','         

" Set filetype stuff to on
filetype plugin indent on
syntax on               

" Add the unnamed register to the clipboard
set clipboard+=unnamed
set nofoldenable          

" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo
set backspace=indent,eol,start  
set whichwrap+=h,l,<,>,[,]      
set virtualedit=block,onemore   

set number                
set relativenumber        
set ruler                 

" Tab and indent 
set expandtab             
set smartindent           
set autoindent
set smarttab
set softtabstop=4         
set shiftwidth=4          

set encoding=utf-8        
set t_Co=256              
set background=dark
set lbr

set ignorecase            
set incsearch             
set hlsearch              
set smartcase

set scrolloff=5           
set laststatus=2          
set noshowmode            
set showcmd               
set history=100
set wildmenu              

" Types of files to ignore when autocompleting things
set wildignore+=*.o,*.class,*.git,*.svn

" Switch between buffers without having to save first
set hidden
set autoread              
set autowrite             
set confirm               
set timeoutlen=700        

" Reload the vim settings immediately after the changing has been made
if has("autocmd")
    autocmd! bufwritepost .vimrc source ~\.vimrc
endif


" ---------------------------------------------------------------------------
"                            KEY MAPPING
" ---------------------------------------------------------------------------
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

" Make it easy to open vimrc file
nmap <silent> <leader>ev :e ~/.vimrc<CR>

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
" ---------------------------------------------------------------------------
"                            VISUAL SETTINGS
" ---------------------------------------------------------------------------
try
    colorscheme gruvbox
catch
endtry

" Avoid garbled characters in Chinese language windows OS
let $LANG='en_US.uft-8' 
set langmenu=zh_CN

set tw=84

" GUI 
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
    set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
    set guifont=CodeNewRoman\ NF:h14
    set guifontwide=KaiTi:h15
    set lines=35 columns=88
endif


" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Set up the GUI cursor to look nice
set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
	
