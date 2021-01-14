" nnoremap <silent> <Leader>rc :w<CR> :colorscheme demo<CR>

hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "Demo"

let s:red = 9
let s:white = 15
let s:black = 0
let s:grey = 7
let s:blue = 39
let s:orange = 208
let s:darkorange = 166
let s:green = 70
let s:darkgreen = 64
let s:yellow = 3
let s:pink = 203
let s:purple = 134

function! HL(group,ctermfg,ctermbg,cterm)
  let histring  = 'highlight ' . a:group   . ' '
  let histring .= 'ctermbg='   . a:ctermbg . ' '
  let histring .= 'ctermfg='   . a:ctermfg . ' '
  let histring .= 'cterm='     . a:cterm   . ' '

  execute histring
endfunction

set background=dark

call HL("Normal",s:white,s:black,"NONE")

call HL("Statement",s:red,s:black,"NONE")
call HL("Conditional",s:red,s:black,"NONE")
call HL("Function",s:green,s:black,"bold")
call HL("Keyword",s:red,s:black,"NONE")

call HL("Include",s:darkorange,s:black,"NONE")
call HL("PreProc",s:orange,s:black,"NONE")
call HL("Define",s:orange,s:black,"NONE")

call HL("Type",s:orange,s:black,"NONE")
call HL("Structure",s:orange,s:black,"NONE")
call HL("StorageClass",s:orange,s:black,"NONE")
call HL("Typedef",s:red,s:black,"NONE")

call HL("Identifier",s:blue,s:black,"NONE")

call HL("String",s:darkgreen,s:black,"NONE")
call HL("Special",s:darkgreen,s:black,"NONE")
call HL("Constant",s:purple,s:black,"NONE")
call HL("Character",s:purple,s:black,"NONE")
call HL("Boolean",s:purple,s:black,"NONE")
call HL("Number",s:purple,s:black,"NONE")
call HL("Float",s:purple,s:black,"NONE")

call HL("Comment",s:grey,s:black,"NONE")
call HL("SpecialComment",s:grey,s:black,"NONE")
call HL("Delimiter",s:grey,s:black,"NONE")

call HL("LineNr",s:grey,s:black,"NONE")

hi link Operator Normal

" C specific
call HL("cStructure",s:darkorange,s:black,"NONE")
call HL("cIncluded",s:darkgreen,s:black,"NONE")
