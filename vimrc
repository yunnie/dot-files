
set nocompatible		" required
filetype off			" required

" set teh runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/path/here/')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" ...

" Install SimpylFold
Plugin 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1

" Install python indent
Plugin 'vim-scripts/indentpython.vim'

" Auto-complete
Bundle 'Valloric/YouCompleteMe'

" Syntax Checking/Highlighting
Plugin 'vim-syntastic/syntastic'

" PEP 8 Checking                
Plugin 'nvie/vim-flake8'       

" Color schemes
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'

" File browsing
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'

" Search
Plugin 'kien/ctrlp.vim'

" Pass code from VIM to tmux and scheme
Plugin 'sjl/tslime.vim'


" All of your Plugins must be added before the following line
call vundle#end()  		" required
filetype plugin indent on 	" required


" Other VIM configurations

" Screen split
set splitbelow
set splitright

" Screen split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" Python indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4       |
    \ set softtabstop=4   |
    \ set shiftwidth=4    |
    \ set textwidth=79    |
    \ set expandtab       |
    \ set autoindent      |
    \ set fileformat=unix

" JavaScript HTML and CSS
au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2       |
    \ set softtabstop=2   |
    \ set shiftwidth=2    |
    \ set textwidth=79    |
    \ set expandtab       |
    \ set autoindent      |

" Flag unncessary whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" UTF-8 Support
set encoding=utf-8

" You Complete Me Config
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


" Python syntax highlighting
let python_highlight_all=1
syntax on


" File browsing with Nerd Tree
let NERDTreeIgnore=['\.pyc$', '\~$'] " ignore files in NERDTree




" number lines
set nu
