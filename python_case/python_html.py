import lxml
from lxml import etree;
from xml.etree.ElementTree import ElementTree
import urllib
# class htmlParser(HTMLParser):   

if __name__ == '__main__':
	# main()

	fileUrl="http://10.140.161.15:8080/userContent/TRUNK/Reports_604998/SCT/Test/supercell/newfeature.html"
	Urlcontent = urllib.urlopen(fileUrl).read()
	htmlElement = etree.HTML(Urlcontent)
	for index,trnode in enumerate(htmlElement.xpath("//table[@id='RunNotReg']//tr//td//font")):
		print index,trnode.text
	newlist=[]
	trnodelist=htmlElement.xpath("//table[@id='RunNotReg']//tr//td//font")
	print len(trnodelist)
	newlist.append(["a",trnodelist[i].text,trnodelist[i+1].text] for i in range(0,len(trnodelist),2))
	# newlist=[[i,i+1] for i in xrange(0,4,4)]
	print newlist