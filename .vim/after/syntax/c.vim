syn match cType "\<[ui]\d\+\>"
syn match cType "\<[a-zA-Z_][a-zA-Z0-9_]*_[t]\>"
syn match cType "\<[A-Z][a-zA-Z0-9_]*\>"

" Function highlighting
syn match cCustomParen "(" contains=cParen,cCppParen
syn match cCustomFunc  "\w\+\s*(" contains=cCustomParen
syn match cCustomScope "::"
syn match cCustomClass "\w\+\s*::" contains=cCustomScope

hi def link cCustomFunc  Function
hi def link cCustomClass Function
