# python_textwrap.py
import textwrap
text="123456789123456789123456789"
print "fill",textwrap.fill(text, width=5),type(textwrap.fill(text, width=5))

print "wrap",textwrap.wrap(text, width=5),type(textwrap.wrap(text, width=5))
print "shorten",textwrap.shorten(text, width=5),type(textwrap.shorten(text, width=5))