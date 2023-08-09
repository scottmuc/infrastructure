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

" https://github.com/scottmuc/infrastructure/issues/55#issuecomment-1522968698
" The above comment showed that vim colorscheme switching somehow got borked.
" I honestly don't know why. Switching to NeoSolarized along with some
" configuration adjustments led to a working colorscheme switcher.
Plug 'https://github.com/overcache/NeoSolarized'

call plug#end()

:silent! colorscheme NeoSolarized

" Adds a bit of complexity, but the `background` tool reads the OS level theme
" and returns "light" or "dark" accordingly.
let output=system("background")
execute "set background=".escape(output, ' ')

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

source $HOME/.config/nvim/future.init.lua
