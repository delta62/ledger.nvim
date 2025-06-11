if exists("b:current_syntax")
  finish
endif

" ---- General settings ----
syntax case match

" ---- Comments ----
syntax match ledgerComment /^ *[;#].*/
highlight link ledgerComment Comment

" ---- Includes and directives ----
syntax match ledgerDirective /^ *include\>\|^ *account\>\|^ *bucket\>\|^ *payee\>\|^ *tag\>/
highlight link ledgerDirective PreProc

" ---- Transaction header line ----
" Date + optional cleared/pending + description (payee)

" Date
syntax match ledgerDate /^\d\{4}[-/]\d\{2}[-/]\d\{2}/
highlight link ledgerDate Constant

" Cleared or pending flag (* or !)
syntax match ledgerCleared /^\d\{4}[-/]\d\{2}[-/]\d\{2}\s\+\zs[*!]/
highlight link ledgerCleared Statement

" Payee/Description (rest of header line after flag)
syntax match ledgerPayee /^\d\{4}[-/]\d\{2}[-/]\d\{2}\s\+\(*\|!\)\=\s*\zs.*$/
highlight link ledgerPayee String

" ---- Postings ----
" Postings start with at least two spaces
" Match account names first
syntax match ledgerAccount /^\s\{2,\}\zs[^ \t$;#].*/
highlight link ledgerAccount Identifier

" Amount (numbers + currency), typically at end of posting line
syntax match ledgerAmount /[ \t]\{2,\}\zs[-+]\=\$\=\d\+\(\.\d\+\)\?\([ \t]*[A-Za-z]*\)\?\(\s*;.*\)\?$/
highlight link ledgerAmount Number

" Commodity symbols
syntax match ledgerCommodity /\$\|€\|¥\|£/
highlight link ledgerCommodity Special

" ---- Tags ----
syntax match ledgerTag /[@:][^ \t;]*/
highlight link ledgerTag Type

" ---- Automated transactions ----
syntax match ledgerAutomated /^=.*/
highlight link ledgerAutomated Keyword

" ---- Folding support ----
" Fold on transaction header (date line)
syntax region ledgerTransaction start=/^\d\{4}[-/]\d\{2}[-/]\d\{2}/ end=/^\(\s*$\)\@=/
highlight link ledgerTransaction None

" ---- Finalize ----
let b:current_syntax = "ledger"
