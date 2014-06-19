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
endif

map <C-n> :NERDTreeToggle<CR>
nmap <C-V> "+gP
imap <C-V> <ESC><C-V>a 
vmap <C-C> "+y
