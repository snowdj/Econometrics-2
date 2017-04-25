" forstubs.vim: stub/abbrevations for Octave

call IMAP("fr`","for <++>\<cr><++>\<cr>endfor\<cr><++>","octave")
call IMAP("if`","if (<++>)\<cr><++>\<cr>endif\<cr><++>","octave")
call IMAP("ie`","if (<++>)\<cr><++>\<cr>else\<cr>\<cr>endif\<cr><++>","octave")
call IMAP("sw`","switch (<++>)\<cr>case <++>\<cr><++>\<cr>otherwise\<cr><++>\<cr>endswitch\<cr><++>","octave")
call IMAP("uwp`","unwind_protect\<cr><++>\<cr>unwind_protect_cleanup\<cr><++>\<cr>end_unwind_protect\<cr><++>","octave")
call IMAP("tc`","try\<cr><++>\<cr>catch\<cr><++>\<cr>end_try_catch\<cr><++>","octave")
call IMAP("wh`","while (<++>)\<cr><++>\<cr>endwhile\<cr><++>","octave")
call IMAP("do`","do\<cr><++>\<cr>until (<++>)\<cr><++>","octave")
call IMAP("fun`","function <++> = <++>(<++>)\<cr><++>\<cr>endfunction\<cr><++>","octave")

