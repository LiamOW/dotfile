" Vim-plug plugins
call plug#begin()

"" Language support
Plug 'rust-lang/rust.vim', {'for': 'rust'}        " Rustlang langauge support
Plug 'Shougo/echodoc.vim'                         " Show function signature + inline doc
Plug 'pangloss/vim-javascript',                   " Javascript syntax highlighting, indentation
    \ {'for':'javascript'}
Plug 'leafgarland/typescript-vim',                " Typescript syntax highlighting
    \ {'for':'typescript'}
Plug 'HerringtonDarkholme/yats.vim',              " Typescript syntax highlighting
    \ {'for':'typescript'}
Plug 'Vimjas/vim-python-pep8-indent'              " Python PEP8 compliant indentation
    \ {'for':'python'}
Plug 'wlangstroth/vim-racket'                     " Racket support
Plug 'jez/vim-better-sml'                         " SML support
" Plug 'kovisoft/slimv'                             " 'SLIME for Vim'
" Plug 'numirias/semshi'                            " Python semantic syntax highlighting
"     \ {'for':'python'}
" Plug 'let-def/ocp-indent-vim', {'for': 'ocaml'}   " Ocaml indentation
" Plug 'ziglang/zig.vim', {'for': 'zig'}            " Zig language support
" Plug 'tikhomirov/vim-glsl'                        " GLSL syntax highlighting

" Editing plugins
Plug 'tomtom/tcomment_vim'                        " Commenting operator
                                                  " gcc to comment, gc comment operator,
                                                  " gcgc to uncomment lines
" Plug 'junegunn/vim-easy-align'                    " Allows easy aligning of data
Plug 'tpope/vim-surround'                         " Deal with parantheses, quotes, etc
Plug 'justinmk/vim-sneak'                         " Find matching 2 character sequences

" LSP
Plug 'neovim/nvim-lspconfig'                      " Collection of common configurations for the Nvim LSP client
Plug 'tjdevries/lsp_extensions.nvim'              " Extensions to built-in LSP, for example, providing type inlay hints
Plug 'nvim-lua/completion-nvim'                   " Autocompletion framework for built-in LSP

" Linting
Plug 'w0rp/ale'                                   " Ale async lint engine
Plug 'maximbaz/lightline-ale'                     " Ale indicator in lightline bar

" Ctags
Plug 'ludovicchabant/vim-gutentags'               " Manages tag file in project root

" GUI enhancements
Plug 'itchyny/lightline.vim'                      " Status line
Plug 'morhetz/gruvbox'                            " Gruvbox

" Fuzzy finding
Plug 'junegunn/fzf',
    \{ 'dir': '~/.fzf',
     \ 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Writing
" Plug 'junegunn/goyo.vim'                        " Distraction free writing
" Plug 'reedes/vim-pencil'                        " Make Vim a good writing environment
Plug 'plasticboy/vim-markdown'                    " Markdown enhancements
Plug 'lervag/vimtex'                              " Latex support
  \ { 'for': 'tex' }

" Convenience
Plug 'christoomey/vim-tmux-navigator'             " easy vim-tmux navigation
Plug 'airblade/vim-rooter'
" Plug 'gko/vim-coloresque'                         " Highlight color codes as color
" Plug 'guns/xterm-color-table.vim'                 " Get XTERM Color Table

" Vimwiki
" Plug 'vimwiki/vimwiki'
" Plug 'tbabej/taskwiki'                            " Taskwarrior integration

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

autocmd BufEnter * set concealcursor-=n " Don't conceal if we are on the line

filetype plugin on              " Enable filetype-specific plugins
" Set pwd to location of file on buffer enter
autocmd BufEnter * silent! lcd %:p:h

" Indents
" Turn off annoying filetype autoindent length
filetype indent off             " Disable filetype-specific indentation
filetype plugin indent on       " Enable plugin-based autoidentation

set tabstop=4                   " Set tab-stop to 2 spaces
set shiftwidth=4                " Width for autoindents
set scrolloff=8                 " Always leave some lines at the bottom of the screen
set expandtab                   " Converts tabs to whitespace
" set autoindent                " Indent a new line the same amount as a line just typed

set splitright                  " Split right when vertical splitting
set splitbelow                  " Split below when horizontal splitting

" Searching
set ignorecase                  " Do case-insensitive matching
set smartcase                   " Make searches case sensitive if it contains a capital letter
" set nohlsearch                  " Disable search highlighting

" Permanent undo
set undodir=~/.vimdid           " Maintain all the actions for a file for undo between editing sessions
set undofile

" Code folds
set nofoldenable
" set foldlevelstart=0 " don't automatically FOLD EVERYTHING
" set foldmethod=indent
" set foldlevel=99

" Save folds
" autocmd BufWinLeave *.* silent mkview
" autocmd BufWinEnter *.* silent loadview

" -----------------------------------------------------------------------------------------------
" GUI Configuration

" Colorscheme
colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_dark='hard'
highlight Normal ctermbg=none

if !has('gui-running')
  set t_Co=256
endif

" Lightline configuration

" Initialise lightline empty config
let g:lightline = {'active':{'left':[], 'right':[]}}

" Set colorscheme
let g:lightline.colorscheme = 'gruvbox'

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
  \   ['gutentags'],
  \ ]

" Ale lightline status
let g:lightline.component_expand = {
  \  'linter_checking': 'lightline#ale#checking',
  \  'linter_warnings': 'lightline#ale#warnings',
  \  'linter_errors': 'lightline#ale#errors',
  \  'linter_ok': 'lightline#ale#ok',
  \  'gutentags': 'gutentags#statusline',
  \ }

let g:lightline.component_type = {
  \ 'linter_checking': 'left',
  \ 'linter_warnings': 'warning',
  \ 'linter_errors': 'error',
  \ 'linter_ok': 'left',
  \ }

" FZF Colorscheme - match vim colorscheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" -----------------------------------------------------------------------------------------------
" Vimwiki

let g:vimwiki_list = [{'path': '~/vimwiki/'}]

" Don't treat every .md file as a wiki
let g:vimwiki_global_ext = 0

" -----------------------------------------------------------------------------------------------
" Latex

" Use Zathura for live preview
" let g:livepreview_previewer = 'zathura'

" Vimtex config
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0

set conceallevel=1
let g:tex_conceal='abdmg'

" Since we are using neovim
" Note: this relies on neovim-remote, which can be installed with
"       `let g:vimtex_compiler_progname = 'nvr'`
let g:vimtex_compiler_progname = 'nvr'

" -----------------------------------------------------------------------------------------------
" Gutentags

" Refresh status line on gutentags update
augroup GutentagsStatusLineRefresher
  autocmd!
  autocmd User GutentagsUpdating call lightline#update()
  autocmd User GutentagsUpdated call lightline#update()
augroup END

" -----------------------------------------------------------------------------------------------
" ALE

" Ale configuration
let g:ale_open_list = 0
let g:ale_lint_on_enter = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1
let g:ale_list_window_size = 4
let g:ale_fix_on_save = 1

let g:ale_linters = {
  \ 'c': ['clang'],
  \ 'clojure': ['clj-kondo', 'joker'],
  \ 'cpp': ['clang'],
  \ 'java': ['javac'],
  \ 'ocaml': ['merlin'],
  \ 'python': ['flake8', 'pylint'],
  \ 'rust': ['cargo'],
  \ 'typescript': ['tsc'],
  \ }

let g:ale_fixers = {
  \   '*': [
  \     'trim_whitespace',
  \     'remove_trailing_lines',
  \   ],
  \   'rust': [
  \     'rustfmt',
  \   ],
  \ }

let g:ale_rust_cargo_use_clippy = 1
let g:ale_rust_cargo_check_tests = 1
let g:ale_rust_cargo_check_examples = 1
let g:ale_rust_cargo_use_check = 0
let g:ale_rust_cargo_clippy_options = ""
let g:rustfmt_commmand = "rustfmt"

let g:ale_c_gcc_options = '-Wall -std=c99'
let g:ale_c_clang_options = '-Wall -std=c99'
let g:ale_c_parse_makefile = 1

let g:ale_cpp_gcc_options = '-Wall -std=c++17'
let g:ale_cpp_clang_options = '-Wall -std=c++17'

" -----------------------------------------------------------------------------------------------
" LSP

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Configure LSP
" https://github.com/neovim/nvim-lspconfig#rust_analyzer
lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })
-- Enable ccls
nvim_lsp.ccls.setup{}

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = true,
  }
)
EOF

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment" }

" -----------------------------------------------------------------------------------------------
" MISC Plugin Configuration

" Vim easy align
" Start interactive EasyAlign in visual mode (e.g. vipga)
" xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
" nmap ga <Plug>(EasyAlign)
" Add -> support
" if !('g:easy_align_delimiters')
"   let g:easy_align_delimiters = {}
" endif
" let g:easy_align_delimiters['>'] = { 'pattern': '->', 'ignore_groups': ['String'] }
"
" " Disable paranthese balancing
" let g:sexp_enable_insert_mode_mappings = 0

" -----------------------------------------------------------------------------------------------
" Commands

" Open help files in a rightside vertical split by default
" autocmd FileType help wincmd L

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
nnoremap <C-p> :Files<cr>
nnoremap <C-s> :Rg<cr>
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
nnoremap <leader>ev :edit ~/.vimrc<cr>
nnoremap <leader>sv :source ~/.vimrc<cr>

" Jump to next ale error and cycle around
nmap <silent> <C-e> <Plug>(ale_next_wrap)

" Jump to definition
" nnoremap <silent> <C-[> <Plug>(ale_go_to_definition)

" Toggle ale error/warning list at bottom of screen
nnoremap <silent> <leader>l :call AleErrorListToggle()<cr>

" Bind :term and open in a new window in the CWD
nnoremap <silent> <leader>t :call OpenTermV()<cr>
nnoremap <silent> <leader>tw :call OpenTermW()<cr>
" Go to the terminal window in insert mode when a new one is created
autocmd BufWinEnter,WinEnter term://* startinsert

" When pressing enter after open brace, insert closing brace on line below
inoremap {<CR>  {<CR>}<Esc>O

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
" Racket

augroup racket
    autocmd!
    autocmd BufRead,BufNewFile *.rkt,*.rktl set filetype=racket
    autocmd BufRead,BufNewFile *.scrbl set filetype=scribble
    autocmd Filetype racket set lisp
    autocmd Filetype racket set autoindent
augroup END

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

" -----------------------------------------------------------------------------------------------
" LANGUAGE SPECIFIC SETUP

" Python
augroup python_files
  autocmd!
  autocmd FileType python set tabstop=4
  autocmd FileType python set softtabstop=4
  autocmd FileType python set shiftwidth=4
  autocmd FileType python set expandtab
  autocmd FileType python set autoindent
augroup END

augroup assembler
    autocmd!
    autocmd FileType asm set filetype=nasm
    autocmd BufRead,BufNewFile *.nasm set filetype=nasm
augroup END

augroup javascript
    autocmd!
    autocmd BufRead,BufNewFile *.js.liquid set filetype=javascript
    autocmd Filetype javascript,typescript set tabstop=2
    autocmd Filetype javascript,typescript set softtabstop=2
    autocmd Filetype javascript,typescript set shiftwidth=2
augroup END

" -----------------------------------------------------------------------------------------------
" Markdown

" augroup Markdown
"   autocmd!
"   autocmd FileType markdown set wrap linebreak nolist tw=100
" augroup END

" -----------------------------------------------------------------------------------------------
" Goyo / Writing

function! s:goyo_enter()
    au! numbertoggle
    set nonumber
    set norelativenumber
    set nocursorcolumn nocursorline
    set wrap
    set linebreak
    set spell
    inoremap <C-L> <C-G>u<Esc>[s1z=`]a<C-G>u
endfunction

" No config for when you leave, because you won't often enter Goyo and then
" want to edit, say, code, without exiting vim.
augroup writing
    autocmd!
    autocmd! User GoyoEnter nested call <SID>goyo_enter()
augroup END

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

function! OpenTermV() abort
  execute 'vsplit | terminal'
endfunction

function! OpenTermW() abort
  execute 'split | terminal'
endfunction

" nmap <C-S-p> :call <SID>SynStack()<CR>
" function! <SID>SynStack()
"   if !exists("*synstack")
"     return
"   endif
"   echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
" endfunc
