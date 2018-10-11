# python_lxml.py
# http://lxml.de/api/lxml-module.html
import lxml,urllib
from lxml import etree
from lxml.builder import E
from lxml.html.builder import A, B, FONT, TABLE, TH, TR, TD
from lxml.html import builder as E
from lxml.html.soupparser import parse
# from lxml import etree, cssselect #select = cssselect.CSSSelector("a tag > child")
def createTable(tableTrlist,cols,casetype):
	
	table = TABLE(border="1", cellspacing="0",
	                          cellpadding="4",
	                          id=casetype,
	                          style="border: 1px solid black; \
	                                 border-collapse: \
	                                 collapse;empty-cells: show;margin: 0px 1px; ")
	tr = TR()
	for col in cols:
		tr.append(TH(col, style="border: 1px solid black;\
		                         padding: 1px 4px;\
		                         margin: 0px;"))
	table.append(tr)

	for trlist in tableTrlist:
		if len(trlist)==0:continue
		tr = TR()
		for td in trlist:
			tr.append(TD(td))
		table.append(tr)

	return table
def selectFromTable():
	import urllib
	Urlcontent = urllib.urlopen("lxml.html").read()
	htmlElement = etree.HTML(Urlcontent)
	trnodelist=htmlElement.xpath("//table//tr//td")
	print trnodelist

	tdtextlist=[tdtext.text for tdtext in trnodelist]
	
	return tdtextlist
if __name__ == '__main__':
	th=["1","2","3"]
	casetype="test"
	tableTrlist=[["1","2","3"],["3","2","3"]]
	table= createTable(tableTrlist,th,casetype)
	with open ("lxml.html","w") as reghtml:
		html = E.HTML(table)
		reghtml.write(lxml.html.tostring(html))
	print selectFromTable()

