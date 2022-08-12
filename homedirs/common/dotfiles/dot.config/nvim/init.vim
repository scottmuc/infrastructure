" This configuration is intended to be overexplained :-)

" I've chosen vim-plug as my plugin manager for the time being. It feels like
" it hasn't annoyed me too much. More information can be found at:
"
" https://github.com/junegunn/vim-plug
"
" Becuase I am using this plugin manager, it's easy to vendor (meaning I can
" check it into my repository) in my ~/.config/nvim/autoload/plug.vim path.
"
" As you can see, I prefer to provide the absolute path to the plugin. Why? I
" just prefer to not hide the fact that github.com is implied. It's not like I
" have to type this in all the time so I'm content to have this configuration
" be a bit more verbose.
call plug#begin()
Plug 'https://github.com/ctrlpvim/ctrlp.vim'
Plug 'https://github.com/scrooloose/nerdtree'
Plug 'https://github.com/tpope/vim-sensible'

" Sleuth integrates https://editorconfig.org/ config files so we can leave the
" things like shiftwidth, expandtab, tabstop, textwidth, endofline, fileformat,
" fileencoding, and bomb out of our nvim configuration.
Plug 'https://github.com/tpope/vim-sleuth'

Plug 'https://github.com/hashivim/vim-terraform'

Plug 'https://github.com/altercation/vim-colors-solarized'

call plug#end()

" don't need to be vi compatible. We're not in the 60's anymore
set nocompatible

" not sure why I wouldn't ever want syntax on
syntax on

" https://github.com/toggle-corp/alacritty-colorscheme#sync-with-vimneo-vim
" The above tool makes the configuration below unnecessary. Keeping it here
" and commented out for reference.
"
" Settling with a built in color scheme. Most of the time the default does a
" fine job of highlighting the appropriate things. To list available color
" schemes run:
"
" :colorscheme <TAB>
" colorscheme slate
"
" I am not managing ~/.vimrc_background in WSL so I need to specify a default
if !filereadable(expand("~/.vimrc_background"))
  colorscheme slate
endif

" Enable line numbers. This is off by default
set number

" allows modified buffers to be hidden
set hidden

set nostartofline

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
" TODO determine if vim-sleuth can make these disappear
autocmd BufRead,BufNewFile *.md set wm=2 tw=120
autocmd BufRead,BufNewFile *.markdown set wm=2 tw=120
autocmd BufRead,BufNewFile *.go set tabstop=4 shiftwidth=4

" toggle NERD Tree with CTRL N
nmap <silent> <c-n> :NERDTreeToggle<cr>

imap jk <esc>

nmap j gj
nmap k gk

" TODO determine if vim-sleuth can make this disappear
scriptencoding utf-8

"----------------------------------------------------------
" status line stuff
"----------------------------------------------------------

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

" The following is to encourage use of the hjkl keys to navigate. It makes it
" feel natural relatively quickly.
map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Down> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
