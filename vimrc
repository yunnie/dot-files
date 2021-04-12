
set nocompatible		" required
filetype off			" required

" set the runtime path to include Plug and initialize
call plug#begin('~/.vim/plugged')

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" Install CoC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Install SimpylFold
Plug 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1

" Install python indent
Plug 'vim-scripts/indentpython.vim'

" Syntax Checking/Highlighting
Plug 'vim-syntastic/syntastic'

" PEP 8 Checking                
Plug 'nvie/vim-flake8'       

" Color schemes
Plug 'jnurmine/Zenburn'
Plug 'altercation/vim-colors-solarized'

" File browsing
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

" Search
Plug 'kien/ctrlp.vim'

" Pass code from VIM to tmux and scheme
Plug 'sjl/tslime.vim'

" TypeScript Syntax for VIM
Plug 'leafgarland/typescript-vim'

" All of your Plugins must be added before the following line
call plug#end()

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

" Toogle NERDTree
map <F2> :NERDTreeToggle<CR>

" Python indentation and C
au BufNewFile,BufRead *.py,*.c,*.h 
    \ set tabstop=4       |
    \ set softtabstop=4   |
    \ set shiftwidth=4    |
    \ set textwidth=79    |
    \ set expandtab       |
    \ set autoindent      |
    \ set fileformat=unix

" JavaScript TypeScript HTML and CSS
au BufNewFile,BufRead *.js,*.ts,*.html,*.css
    \ set tabstop=2       |
    \ set softtabstop=2   |
    \ set shiftwidth=2    |
    \ set textwidth=79    |
    \ set expandtab       |
    \ set autoindent      |

" Haskell
au BufNewFile,BufRead *.hs
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


" Python syntax highlighting
let python_highlight_all=1
syntax on


" File browsing with Nerd Tree
let NERDTreeIgnore=['\.pyc$', '\~$'] " ignore files in NERDTree

" number lines
set nu

" CoC configurations
" Set internal encoding of vim, not needed on neovim, since coc.vim
" using unicode characters in hte file autoload/float.vim

set encoding=utf-8

" TextEdit might fail if hidden is not set
set hidden

" Some server have issues with backup files 
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer update time (default is 4000 ms = 4 s) leads to noticable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|
set shortmess+=c

" Always show the signcolumn, otherwise it would sift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" user tab to trigger completion with characters ahead and navigate.
" Note: Use command: ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" : 
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-defintion)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
noremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetypes(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signiture help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf <Plug>(coc-fix-current)

" Map function and class text objects
" Note:Requires 'textDocument.documentSymbol' support from lang server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvom-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float@scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float@scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selection ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call  CocAction('fold', <f-args>)

" Add `:OR` command for organizing imports of the current buffer
command! -nargs=0 OR  :call  CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" Note: Please see `:h coc-status` for integration with external plugins
" that provide custom statusline lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extension
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
