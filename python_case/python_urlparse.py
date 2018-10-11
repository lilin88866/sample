# python_urlparse.py
import urlparse
web=urlparse.urlparse("https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/001375840202368c74be33fbd884e71b570f2cc3c0d1dcf000")


print web
print web.scheme
print web.geturl()
