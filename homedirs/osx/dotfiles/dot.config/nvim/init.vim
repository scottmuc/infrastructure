"
" Scott Muc's .vimrc file
"
call plug#begin()

" File navigation
Plug 'ctrlpvim/ctrlp.vim'

Plug 'scrooloose/nerdtree'

" Required
call plug#end()

"----------------------------------------------------------
" OS specific configuration
"----------------------------------------------------------

" don't need to be vi compatible. We're not in the 60's anymore
set nocompatible

" not sure why I wouldn't ever want syntax on
syntax on

colorscheme elflord

" enable file type detection
filetype plugin indent on

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

" allows modified buffers to be hidden
set hidden

set nostartofline
set scrolloff=6
set listchars=trail:.,tab:\|\ 

" Paste Toggle (stops <Command>-V paste from having indentation added)
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" show invisible characters like tabstops
set list

set wildmode=list:longest "make tab completion complete with common chars

" stop the creation of swap and backup files. will wait until I get bitten
" by this before re-enabling them
set noswapfile
set nobackup
set nowritebackup

" regex stuff. show the matches and search without case sensitivity
set showmatch
set ignorecase

let mapleader=","
let maplocalleader=","

" set custom file types I've configured
autocmd BufRead,BufNewFile *.md set wm=2 tw=120
autocmd BufRead,BufNewFile *.markdown set wm=2 tw=120

"----------------------------------------------------------
" Line numbers
"----------------------------------------------------------
set relativenumber      "use relative numbers by default

function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-l> :call NumberToggle()<cr>


"----------------------------------------------------------
" NERD Tree plugin settings
"----------------------------------------------------------

" toggle NERD Tree with CTRL N
nmap <silent> <c-n> :NERDTreeToggle<cr>

imap jk <esc>

nmap j gj
nmap k gk

scriptencoding utf-8

"----------------------------------------------------------
" status line stuff 
"----------------------------------------------------------

set laststatus=2 
if has("statusline") 
  set statusline=%<%f\ %h%m%r%=%k[%{(&fenc\ ==\ \"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]\ %-12.(%l,%c%V%)\ %P 
endif 

"""""""""""
" Multi purpose tab key stolen from ghb
""""""""""
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Down> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
