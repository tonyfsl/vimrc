" ---------------------------------------------------------------------------
"  Auther:tonyfsl
"  The primary version was completed on May 27th 2018
"
"  Some ideas was generated from dofy/7th-vim and amix/vimrc
" ---------------------------------------------------------------------------
" Sections:
"    -> General
"    -> Keymapping
"    -> Visual setting
"    -> Plugins
" ---------------------------------------------------------------------------
"
" ---------------------------------------------------------------------------
" GENERAL SETTINGS
" ---------------------------------------------------------------------------
set nocompatible
filetype plugin indent on 
syntax on               
set nofoldenable          

set backspace=indent,eol,start  
set whichwrap+=h,l,<,>,[,]      
set virtualedit=block,onemore   
set textwidth=78

set number                
set relativenumber        
set ruler                 

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
set fo+=mB

set ignorecase            
set incsearch             
set hlsearch              
set smartcase

set scrolloff=5           
set laststatus=2          
set noshowmode            
set showcmd               
set wildmenu              
set autoread              
set autowrite             
set confirm               
set timeoutlen=700        
let mapleader=','         

" Reload the vim settings immediately after the changing has been made
if has("autocmd")
    autocmd! bufwritepost .vimrc source ~\.vimrc
endif


" ---------------------------------------------------------------------------
" KEY MAPPING
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

" make it easy to open vimrc file
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
" VISUAL SETTINGS
" ---------------------------------------------------------------------------
" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set tw=84

" GUI 
set guioptions+=T
set guioptions-=m
set guioptions-=L
set guioptions-=r
set guioptions-=b

" Encoding
if has("gui_running") || has("unix")
    set encoding=utf-8 
    lang messages zh_CN.UTF-8 " fix consle garbled characters
    set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
    set guifont=MesloLGM\ NF:h14
    set guifontwide=YaHei\ Consolas\ Hybrid:h14
    set lines=35 columns=100
else
    set encoding=chinese 
    set termencoding=chinese     
endif

" Colors and fonts
" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

try
    colorscheme molokai
catch
endtry

" ---------------------------------------------------------------------------
" PLUGIN SETTINGS
" ---------------------------------------------------------------------------
" 此处规定Vundle的路径
set rtp+=$VIM/vimfiles/bundle/vundle.vim

call vundle#begin()

" 此处规定插件的安装路径
call vundle#rc('$VIM/vimfiles/bundle/')

Plugin 'VundleVim/Vundle.vim'
Plugin 'godlygeek/tabular'
Plugin 'kien/ctrlp.vim'
Plugin 'plasticboy/vim-markdown'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'shougo/neocomplete.vim'
Plugin 'raimondi/delimitmate' 
Plugin 'ryanoasis/vim-devicons'     
Plugin 'tpope/vim-surround'
Plugin 'bufexplorer.zip'
call vundle#end()    

" NERDTree
nnoremap <Leader>nn :NERDTreeToggle<CR>
let NERDTreeChDirMode=2
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let NERDTreeShowLineNumbers=1
let g:NERDTreeWinSize=35
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1         " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

 	
" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#left_sep = '|'
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_left_sep = '|'
let g:airline_left_alt_sep = '|'
let g:airline_right_sep = '|'
let g:airline_right_alt_sep = '|'

" vim-airline-themes 
let g:airline_theme='molokai'


" delimitmate
let delimitMate_matchpairs = "(:),[:],{:}"

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'rc'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ 'link': 'some_bad_symbolic_links',
    \ }

"bufexplorer
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
nmap <leader>o :BufExplorer<cr>
