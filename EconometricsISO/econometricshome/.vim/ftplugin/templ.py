import vim
import re
#get current line
cls = vim.current.line
mtch = re.match("!\\s*INSTANCE\\s+(\\w+)\\s*\\((.*)\)",cls)
# if matches
if mtch :
    tmpl_name = mtch.expand("\\1")
    inst_args = mtch.expand("\\2").split(",")
    # regex to match template
    tmpl_re = "!\\s*TEMPLATE\\s+"+tmpl_name+"\\s*\\(([a-zA-z0-9,]*)\)"
    ln_start = None
    for i in range(len(vim.current.buffer)) :
	mtch = re.match(tmpl_re,vim.current.buffer[i])
	if mtch :
	    # at start of template
	    print "matched template at line",i+1
	    ln_start = i
	    tmpl_args = mtch.expand("\\1").split(",")
	if ln_start :
	    if re.match("!\\s*END TEMPLATE",vim.current.buffer[i]) :
		# at end of template
		ln_end = i
		break
		
    # if a template was found
    if ln_start :
	intext = []
	for line in vim.current.buffer[ln_start+1:ln_end] :
	    for i in range(len(inst_args)) :
		line = line.replace(tmpl_args[i],inst_args[i])
	    # strip leading comment
	    line = line[1:]
	    intext.append(line)
	intext.append("! END INSTANCE")
	vbuf = vim.current.buffer[:]
	intext.reverse()
	# get current line number
	cln = int(vim.eval("line(\".\")"))
	for line in intext :
	    vbuf.insert(cln,line)
	vim.current.buffer[:] = vbuf[:]
	    
    else :
	print "Could not find template"

