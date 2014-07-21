execute pathogen#infect()

nmap <F1> nop
set bg=dark
set ignorecase
set smartcase
set incsearch
set tabstop=2
set shiftwidth=2
set expandtab
set nowrap
set autoindent
set number
set noswapfile

syntax enable

set viminfo='10,\"100,:20,%,n~/.viminfo
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm
$"|endif|endif
set hlsearch

autocmd Filetype python set tabstop=4|set shiftwidth=4|set autoindent
autocmd Filetype tex set tabstop=2|set shiftwidth=2|set autoindent|set spell
autocmd Filetype html set tabstop=2|set shiftwidth=2|set autoindent

filetype plugin on
filetype plugin indent on

if has('gui_running')
  colorscheme torte
  set lines=55 columns=185
  set guioptions-=T  "remove toolbar

  vmap <C-c> "+yi
  vmap <C-x> "+c
  vmap <C-v> c<ESC>"+p
  imap <C-v> <C-r><C-o>+
endif

map <C-n> :NERDTreeToggle<CR>
"nmap <C-S-V> "+gP
"imap <C-S-V> <ESC><C-S-V>a
"vmap <C-S-C> "+y


" strip trailing whitespace when saving a file
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType c,cpp,java,php,ruby,python,coffee,js autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
