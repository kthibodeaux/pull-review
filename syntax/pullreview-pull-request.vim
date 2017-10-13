if exists("b:current_syntax")
    finish
endif
let b:current_syntax = "prpr"

syn match prprMinus /^-.*$/
syn match prprPlus /^+.*$/
hi prprPlus ctermfg=2
hi prprMinus ctermfg=1
