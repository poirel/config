set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" Jinja syntax for Vim: https://github.com/lepture/vim-jinja
Bundle "lepture/vim-jinja"

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"set fileformats=unix,dos

nmap <F1> nop
set bg=dark
set ignorecase
set smartcase
set incsearch
set tabstop=2
set shiftwidth=2
set nowrap
set autoindent
set number
set noswapfile
set paste
set expandtab

syntax enable

set viminfo='10,\"100,:20,%,n~/.viminfo
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm
$"|endif|endif
set hlsearch


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

" highlight trailing whitespace in red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" strip trailing whitespace when saving a file
fun! StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call StripTrailingWhitespaces()
"autocmd FileType c,cpp,java,php,ruby,python,coffee,js autocmd BufWritePre <buffer> :call StripTrailingWhitespaces()
