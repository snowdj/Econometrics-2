" Vim filetype plugin file
" Language:	Octave
" Maintainer:	Jaroslav Hajek
" Last Changed: 2006 Jan 12

if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpo
set cpo-=C

" define match pairs for matchit
if exists("loaded_matchit")
	let s:statEnd = '^\s*\<end\>'
	let b:match_words = '\<while\>:' . s:statEnd .'\|\<endwhile\>' 
				\ . ',\<for\>:' . s:statEnd . '\|\<endfor\>' 
				\ . ',\<do\>:' . s:statEnd .'\|\<until\>'  
				\ . ',\<function\>:' . s:statEnd .'\|\<endfunction\>' 
				\ . ',\<switch\>:\<case\>:\<otherwise\>:' 
				\ . s:statEnd .'\|\<endswitch\>' 
				\ . ',\<unwind_protect\>:\<unwind_protect_cleanup\>:' 
				\ . s:statEnd .'\|\<end_unwind_protect\>' 
				\ . ',\<if\>:\<elseif\>:\<else\>:' 
				\ . s:statEnd . '\|\<endif\>'
endif

setlocal suffixesadd=.m

let b:undo_ftplugin = "setlocal suffixesadd< suffixes< "
	\ . "| unlet! b:match_words"

let &cpo = s:save_cpo

" get stubs plugin
runtime! ftplugin/octave_stubs.vim

