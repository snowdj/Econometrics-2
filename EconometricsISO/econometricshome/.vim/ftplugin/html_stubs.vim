" htmlstubs.vim: abbreviations for HTML

call IMAP("p`","<p>\<cr><++>\<cr></p><++>","html")
call IMAP("pre`","<pre>\<cr><++>\<cr></pre><++>","html")
call IMAP("b`","<b><++></b><++>","html")
call IMAP("i`","<i><++></i><++>","html")
call IMAP("co`","<code><++></code><++>","html")

call IMAP("html`","<html>\<cr><head>\<cr><title><++></title>\<cr><++>\<cr></head>\<cr><body>\<cr><+body+>\<cr></body>\<cr></html>","html")

