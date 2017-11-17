" forstubs.vim: stub/abbrevations for fortran

call IMAP("dm`","dimension(<++>)<++>","fortran")
call IMAP("ii`","intent(in)<++>","fortran")
call IMAP("io`","intent(out)<++>","fortran")
call IMAP("iio`","intent(inout)<++>","fortran")
call IMAP("op`","optional<++>","fortran")
call IMAP("al`","allocatable<++>","fortran")
call IMAP("po`","pointer<++>","fortran")
call IMAP("rp`","real(rp)<++>","fortran")
call IMAP("cp`","complex(rp)<++>","fortran")
call IMAP("re`","real<++>","fortran")
call IMAP("r4`","real*4<++>","fortran")
call IMAP("r8`","real*8<++>","fortran")
call IMAP("c8`","complex*8<++>","fortran")
call IMAP("c16`","complex*16<++>","fortran")
call IMAP("co`","complex<++>","fortran")
call IMAP("dp`","double precision<++>","fortran")
call IMAP("dc`","double complex<++>","fortran")
call IMAP("int`","integer<++>","fortran")
call IMAP("i8`","integer*8<++>","fortran")
call IMAP("i16`","integer*16<++>","fortran")
call IMAP("chr`","character(<++>)<++>","fortran")
call IMAP("log`","logical<++>","fortran")
call IMAP("par`","parameter<++>","fortran")
call IMAP("mpr`","module procedure <++>","fortran")
call IMAP("sub`","subroutine <+name+>(<+args+>)\<cr><+body+>\<cr>end subroutine\<cr>","fortran")
call IMAP("fun`","function <+name+>(<+args+>) result(<++>)\<cr><+body+>\<cr>end function\<cr>","fortran")
call IMAP("sel`","select case(<++>)\<cr>case(<++>)\<cr>end select","fortran")
call IMAP("mod`","module <+module name+>\<cr><+use+>\<cr>implicit none\<cr><+declarations+>\<cr>contains\<cr><+subprograms+>\<cr>end module","fortran")
call IMAP("prg`","program <+program name+>\<cr><+body+>\<cr>end program","fortran")
call IMAP("typ`","type <++>\<cr>end type","fortran")

