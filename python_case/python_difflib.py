import difflib
print "ok"

text1 = "http://www.vpsee.com is a website "
text1_lines = text1.splitlines() 
text2 = "http://VPSee.com is a website" 
text2_lines = text2.splitlines() 
d = difflib.Differ() 
diff = d.compare(text1_lines, text2_lines) 
print '\n'.join(list(diff)) 