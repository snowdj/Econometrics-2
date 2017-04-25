" csstubs.vim: abbreviations for C#

call IMAP("{`","{\<cr><+code+>\<cr>}<++>","cs")
call IMAP("pu`","public ","cs")
call IMAP("pr`","private ","cs")
call IMAP("cl`","class ","cs")
call IMAP("st`","struct ","cs")
call IMAP("puc`","public class ","cs")
call IMAP("pus`","public static ","cs")

call IMAP("fori`","for(int i = 0; i < <+bound+>; i++) <+code+>","cs")
call IMAP("sw`","switch(<+expr+>) {\<cr><+cases+>\<cr>}\<cr><++>","cs")
call IMAP("cas`","case <+expr+>:\<cr><+code+>\<cr>break;\<cr><++>","cs")
call IMAP("casd`","case default:\<cr><+code+>\<cr>break;\<cr><++>","cs")
call IMAP("trc`","try {\<cr><+code+>\<cr>}\<cr>catch(<+exception+>) {<+handler+>}\<cr><++>","cs")
call IMAP("trf`","try {\<cr><+code+>\<cr>}\<cr>finally {<+cleanup+>}\<cr><++>","cs")
