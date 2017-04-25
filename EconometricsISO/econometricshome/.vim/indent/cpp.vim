" Vim indent file
" Language:	C++
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2001 Jun 12

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
   finish
endif
let b:did_indent = 1

"function MyCPPGetIndent()
"  let ind = cindent(v:lnum)
"  return ind
"endfunction


" C++ indenting is built-in, thus this is very simple
setlocal cindent
setlocal shiftwidth=2
setlocal cino={1s>2sn-1sf^-1s(0u0U1t0

let b:undo_indent = "setl cin<"
