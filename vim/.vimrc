" Vim-plug plugins
call plug#begin()

" Language support
Plug 'rust-lang/rust.vim', {'for': 'rust'}   " Rustlang langauge support
Plug 'ElmCast/elm-vim', {'for': 'elm'}       " Elm language support
Plug 'Shougo/echodoc.vim'                    " Show function signature + inline doc

Plug 'guns/vim-sexp'                              " Parenthese manipulation utilities
Plug 'tpope/vim-sexp-mappings-for-regular-people' " Parenthese manipulation utilities
Plug 'guns/vim-clojure-static'                    " Clojure syntax hl + indentation
Plug 'tpope/vim-fireplace'                        " Clojure Repl support
Plug 'tpope/vim-salve'                            " Assorted clojure support

" Commenting extension
Plug 'tomtom/tcomment_vim'             " Commenting operator
                                       " gcc to comment, gc comment operator,
                                       " gcgc to uncomment lines
Plug 'junegunn/vim-easy-align'         " Allows easy aligning of data
Plug 'tpope/vim-surround'              " Deal with parantheses, quotes, etc
Plug 'tpope/vim-abolish'
Plug 'machakann/vim-swap'              " Swap delimited items

" Linting
Plug 'w0rp/ale'                        " Ale async lint engine
Plug 'maximbaz/lightline-ale'          " Ale indicator in lightline bar

" GUI enhancements
Plug 'itchyny/lightline.vim'           " Cool colored bar at bottom of vim
Plug 'morhetz/gruvbox'                 " Gruvbox

" Fuzzy finding
" Plug 'airblade/vim-rooter'             " Changes CWD to project root
Plug 'junegunn/fzf', 
  \{ 'dir': '~/.fzf', 
   \ 'do': './install --all' }
Plug 'junegunn/fzf.vim'                " FZF fuzzy finder

" Writing
Plug 'junegunn/goyo.vim'               " Distraction free writing
Plug 'reedes/vim-pencil'               " Make Vim a good writing environment
Plug 'plasticboy/vim-markdown'         " Markdown enhancements

" Convenience
" Plug 'godlygeek/tabular'               " Align pieces of code
Plug 'christoomey/vim-tmux-navigator'  " easy vim-tmux naviatgation
Plug 'luochen1990/rainbow'             " Rainbow parantheses

call plug#end()

" -----------------------------------------------------------------------------------------------

" General settings
syntax on                       " Turn on syntax highlighting
set nocompatible                " Disable vi compatilibity
set showmatch                   " Show matching brackets
set number                      " Add line numbers
set number relativenumber       " Set relative number line numbers
set wildmode=longest,list       " Get bash-like autocompletions
" set cc=80                     " set an 80-column border to enforce good coding style

filetype plugin on              " Enable filetype-specific plugins
" Set pwd to location of file on buffer enter
autocmd BufEnter * silent! lcd %:p:h
  
" Indents
" Turn off annoying filetype autoindent length
filetype indent off             " Disable filetype-specific indentation
filetype plugin indent on       " Enable plugin-based autoidentation

set tabstop=2                   " Set tab-stop to 2 spaces
set shiftwidth=2                " Width for autoindents
set scrolloff=5                 " Always leave some lines at the bottom of the screen
set expandtab                   " Converts tabs to whitespace
" set autoindent                " Indent a new line the same amount as a line just typed

set splitright                  " Split right when vertical splitting

" Searching
set ignorecase                  " Do case-insensitive matching
set nohlsearch                  " Disable search highlighting

" Permanent undo
set undodir=~/.vimdid           " Maintain all the actions for a file for undo between editing sessions
set undofile

" Code folds
set foldmethod=indent
set foldlevel=99

" Save folds
" autocmd BufWinLeave *.* mkview
" autocmd BufWinEnter *.* silent loadview

" -----------------------------------------------------------------------------------------------

" GUI Configuration

" Colorscheme
colorscheme gruvbox
set background=dark
highlight Normal ctermbg=none

if !has('gui-running')
  set t_Co=256
endif

" Lightline configuration

" Initialise lightline empty config
let g:lightline = {'active':{'left':[], 'right':[]}}

" Set colorscheme
let g:lightline.colorscheme = 'jellybeans'

" Left side components
let g:lightline.active.left = [
  \   ['mode'],
  \   ['readonly', 'filename', 'modified'],
  \   ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok'],
  \ ]

" Right side components
let g:lightline.active.right = [
  \   ['percent', 'lineinfo'],
  \   ['fileformat', 'fileencoding', 'filetype'],
  \ ]

" Ale lightline status
let g:lightline.component_expand = {
  \  'linter_checking': 'lightline#ale#checking',
  \  'linter_warnings': 'lightline#ale#warnings',
  \  'linter_errors': 'lightline#ale#errors',
  \  'linter_ok': 'lightline#ale#ok',
  \ }

let g:lightline.component_type = {
  \ 'linter_checking': 'left',
  \ 'linter_warnings': 'warning',
  \ 'linter_errors': 'error',
  \ 'linter_ok': 'left',
  \ }

" -----------------------------------------------------------------------------------------------
" Plugin configuration

" Ale configuration
let g:ale_open_list = 0
let g:ale_lint_on_enter = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1
let g:ale_list_window_size = 4

let g:ale_linters = {
  \ 'python': ['flake8'],
  \ 'clojure': ['clj-kondo', 'joker']
  \ }

" Vim easy align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" Add -> support
if !('g:easy_align_delimiters')
  let g:easy_align_delimiters = {}
endif
let g:easy_align_delimiters['>'] = { 'pattern': '->', 'ignore_groups': ['String'] }

" Vim rooter 
" Default to current dir for nonproject files
" let g:rooter_change_directory_for_non_project_files = ''

" Identify these files as project roots
" let g:rooter_patterns = ['.git/', 'Cargo.toml', 'Makefile', 'project.clj', '.gitignore']

" Turn on rainbow parantheses
let g:rainbow_active = 1

" Disable paranthese balancing
let g:sexp_enable_insert_mode_mappings = 0

" conjure default keybindings
let g:conjure_default_mappings = v:true

" -----------------------------------------------------------------------------------------------
" Commands

" Open help files in a rightside vertical split by default
autocmd FileType help wincmd L

" Turn off auto comment insertion on next lines
au Filetype * setlocal fo-=cro

" RELATIVE LINE NUMBER COMMANDS
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" -----------------------------------------------------------------------------------------------
" Keybindings

let mapleader = "\<Space>"

" Rebind term-mode-exit to something reasonable
tnoremap <Esc> <C-\><C-n>

" Fuzzy finder bindings
nnoremap <C-o> :Files<cr>
nnoremap <C-p> :Rg<cr>
nnoremap <leader>b :Buffers<cr>

" Quicksave
nnoremap <leader>w :w<cr>

" Jump to start and end of line using home row keys
noremap H ^
noremap L $

" Move by line
nnoremap j gj
nnoremap k gk

" Rebind split movements
nmap <silent> <C-h> :wincmd h<cr>
nmap <silent> <C-l> :wincmd l<cr>
nmap <silent> <C-k> :wincmd k<cr>
nmap <silent> <C-j> :wincmd j<cr>

" Open .vimrc in a split to allow quick edits and reload
nnoremap <leader>ev :vsplit ~/.vimrc<cr>
nnoremap <leader>sv :source ~/.vimrc<cr>

" Jump to next ale error and cycle around
nmap <silent> <C-e> <Plug>(ale_next_wrap)

" Jump to definition
nnoremap <silent> <C-[> <Plug>(ale_go_to_definition)

" Toggle ale error/warning list at bottom of screen
nnoremap <silent> <leader>l :call AleErrorListToggle()<cr>

" Bind :term and open in a new window in the CWD
nnoremap <silent> <leader>t :call OpenTerm()<cr>
" Go to the terminal window in insert mode when a new one is created
autocmd BufWinEnter,WinEnter term://* startinsert

" -----------------------------------------------------------------------------------------------
" Rust 

" Cargo build, run, and test shortcuts
au FileType rust nnoremap <leader>ct :Ctest<cr>
au FileType rust nnoremap <leader>cb :Cbuild<cr>
au FileType rust nnoremap <leader>cr :Crun<cr>

" set syntax highlighting to Rust for .lalrpop files
au BufReadPost *.lalrpop set syntax=rust

autocmd FileType rust setlocal commentstring=//\ %s

" -----------------------------------------------------------------------------------------------
" Ocaml

" Ocaml merlin setup
" let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
" execute "set rtp+=" . g:opamshare . "/merlin/vim"

" actually update documentation
" :execute "helptags " . substitute(system('opam config var share'),'\n$','','''') .  "/merlin/vim/doc"

" -----------------------------------------------------------------------------------------------
" Haskell

" Haskell-vim syntax highlighting
" let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
" let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
" let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
" let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
" let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
" let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
" let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

" Use stack ghci as default repl
" let g:intero_backend = {
"   \ 'command': 'stack ghci',
"   \ 'cwd': expand('%:p:h'),
"   \ }
"
" " Automatically reload on save
" au BufWritePost *.hs InteroReload
"
" " Show info about expression or type under the cursor
" au FileType haskell nnoremap <silent> <leader>i :InteroInfo<CR>
"
" " Open/Close the Intero terminal window
" au FileType haskell nnoremap <silent> <leader>nn :InteroOpen<CR>
" au FileType haskell nnoremap <silent> <leader>nh :InteroHide<CR>
"
" " Reload the current file into REPL
" au FileType haskell nnoremap <silent> <leader>nf :InteroLoadCurrentFile<CR> :InteroOpen<CR>
"
" " Start/Stop Intero
" au FileType haskell nnoremap <silent> <leader>ns :InteroStart<CR>
" au FileType haskell nnoremap <silent> <leader>nk :InteroKill<CR>
"
" " Reboot Intero, for when dependencies are added
" au FileType haskell nnoremap <silent> <leader>nr :InteroKill<CR> :InteroOpen<CR>
"
" " Managing targets
" " Prompts you to enter targets (no silent):
" au FileType haskell nnoremap <leader>nt :InteroSetTargets<CR>
"
" -----------------------------------------------------------------------------------------------
" Python

augroup python_files
  autocmd!
  autocmd FileType python set tabstop=4
  autocmd FileType python set softtabstop=4
  autocmd FileType python set shiftwidth=4
  autocmd FileType python set expandtab
  autocmd FileType python set autoindent
augroup END

" -----------------------------------------------------------------------------------------------
" Writing mode

" Toggle writing mode
command! ProseMode call ProseMode()
nnoremap <silent> <leader>P :ProseMode<cr>

" -----------------------------------------------------------------------------------------------

" Custom Functions
function! AleErrorListToggle()
  if g:ale_open_list
    lclose
    let g:ale_open_list = 0
  else 
    lopen
    let g:ale_open_list = 1
  endif
endfunction

function! OpenTerm() abort
  execute 'vsplit | terminal'
endfunction

function! ProseMode()
  call goyo#execute(0, [])
  set spell noci nosi noai nolist noshowmode noshowcmd nonumber norelativenumber
  set complete+=s
  set bg=dark
  call pencil#init({'wrap': 'soft'})
  au! numbertoggle
endfunction
