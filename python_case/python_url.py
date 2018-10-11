import urllib2
from urllib import urlencode
import cookielib
fileName="PR_info.html"

def loginIn1():
	# posturl='https://pronto.inside.nsn.com/pronto/home.html?usrname=l11li&passwd=Nokia1234f&isCookieEnable=0&action=on&wrong_passwd=%3C%21--invalid_passwd_flag--%3E'
	# posturl='https://pronto.inside.nsn.com/pronto/problemReport.html?prid=NA05865543&status=Open&startPage=1&sortOrder=Asc&sortField=state&view=Assigned%20to%20NIHZSPHYUL&viewName=Assigned%20to%20NIHZSPHYUL&viewState=Open&parentTab=pr_report_list&Usrname=l11li&Password=Nokia1234f&isCookieEnable=0&action=on&wrong_passwd=%3C%21--invalid_passwd_flag--%3E'
	posturl='https://bi.emea.nsn-net.net/BOE/OpenDocument/opendoc/openDocument.jsp?sIDType=CUID&iDocID=Fihw_1a9nQIAkRsAAECJkVUV2J1najtp'
	try:

		password="usrname=tinzhou&passwd=NSNzt201601&isCookieEnable=0&action=on&wrong_passwd=%3C%21--invalid_passwd_flag--%3E"
		req = urllib2.Request(posturl)
		response = urllib2.urlopen(req,password) 
		text = response.read()
		open(fileName,"w").write(text) 
		print text
	except Exception, e:
		raise e
def loginIn():
	# posturl='https://pronto.inside.nsn.com/pronto/home.html?usrname=l11li&passwd=Nokia1234f&isCookieEnable=0&action=on&wrong_passwd=%3C%21--invalid_passwd_flag--%3E'
	posturl='https://pronto.inside.nsn.com/pronto/problemReport.html;jsessionid=aoLx2kzV1K8IVoyDI7cGtKDb.7a538764-57d5-33e8-9006-073e1c881187?prid=NA05865543&status=Open&startPage=1&sortOrder=Asc&sortField=state&view=Assigned+to+NIHZSPHYUL&viewName=Assigned+to+NIHZSPHYUL&viewState=Open&parentTab=pr_report_list&HomeFlag=true'
	try:
		homeurl=" https://wam.inside.nsn.com?usrname=l11li&passwd=Nokia1234f"
		password="usrname=l11li&passwd=Nokia1234f&isCookieEnable=1"
		# req = urllib2.Request(posturl)
		urllib2.urlopen(homeurl)
		response = urllib2.urlopen(posturl,password) 
		text = response.read()
		open(fileName,"w").write(text) 
		print text
	except Exception, e:
		raise e

def httplib():
	import httplib

	url='https://pronto.inside.nsn.com/pronto/problemReport.html?prid=NA05865543&status=Open&startPage=1&sortOrder=Asc&sortField=state&view=Assigned%20to%20NIHZSPHYUL&viewName=Assigned%20to%20NIHZSPHYUL&viewState=Open&parentTab=pr_report_list'
	# url='http://tdswmetrics.china.nsn-net.net/pages/9'
	# password="usrname=l11li&passwd=Nokia1234f&isCookieEnable=0&action=on&wrong_passwd=%3C%21--invalid_passwd_flag--%3E"
	password={"usrname":"l11li","passwd":"Nokia1234f"}
	conn = httplib.HTTPConnection("pronto.inside.nsn.com")
	conn.request(method="GET",url=url) 

	response = conn.getresponse()
	res= response.read()
	print res
	open(fileName,"w").write(res) 
	print res
def hand_cookie():
	import urllib, urllib2, sys, cookielib, re, os, json

	cj = cookielib.CookieJar()
	opener = urllib2.build_opener(urllib2.HTTPCookieProcessor(cj))
	url_login='https://pronto.inside.nsn.com/pronto/problemReport.html?prid=NA05865543&status=Open&startPage=1&sortOrder=Asc&sortField=state&view=Assigned%20to%20NIHZSPHYUL&viewName=Assigned%20to%20NIHZSPHYUL&viewState=Open&parentTab=pr_report_list&Username=l11li&passwd=Nokia1234f'

	# url_login = 'https://wam.inside.nsn.com'
	body = (('Username', 'l11li'),
	        ('Password', 'Nokia1234f'),
	        ('action', 'login'),)

	print 'login to get cookies'
	openurl=opener.open(url_login, urllib.urlencode(body))
	data= openurl.read()  
	print data 
	open(fileName,"w").write(data) 
	return data  

import cookielib    
def Brower(url): 
	login_page='https://pronto.inside.nsn.com/pronto/problemReport.html?prid=NA05865543&status=Open&startPage=1&sortOrder=Asc&sortField=state&view=Assigned%20to%20NIHZSPHYUL&viewName=Assigned%20to%20NIHZSPHYUL&viewState=Open&parentTab=pr_report_list'


	login_data="usrname=l11li&passwd=Nokia1234f&isCookieEnable=0&action=on&wrong_passwd=%3C%21--invalid_passwd_flag--%3E" 
 
	try:    
	    cj = cookielib.CookieJar()    
	    opener=urllib2.build_opener(urllib2.HTTPCookieProcessor(cj))    
	    opener.open(login_page,login_data)    
	    op=opener.open(url)    
	    data= op.read()    
	    return data    
	except Exception,e:   
	    print str(e)    
  #the URL you want to browser 

def function2():

	username= "l11li"
	password= "Nokia1234f"
	top_level_url = "https://wam.inside.nsn.com"
	posturl='https://pronto.inside.nsn.com/pronto/problemReport.html?prid=NA05865543&status=Open&startPage=1&sortOrder=Asc&sortField=state&view=Assigned%20to%20NIHZSPHYUL&viewName=Assigned%20to%20NIHZSPHYUL&viewState=Open&parentTab=pr_report_list?usrname=l11li&passwd=Nokia1234f&isCookieEnable=0&action=on&wrong_passwd=%3C%21--invalid_passwd_flag--%3E'

	password_mgr = urllib2.HTTPPasswordMgrWithDefaultRealm() 

	password_mgr.add_password(None, top_level_url, username, password) 
	handler = urllib2.HTTPBasicAuthHandler(password_mgr) 

	opener = urllib2.build_opener(handler) 
	urllib2.install_opener(opener)
	cc=opener.open(posturl).read()

	print cc
	open(fileName,"w").write(cc) 
if __name__ == '__main__':
	loginIn()
	# httplib()
	# hand_cookie()
	# print Brower("https://10.64.70.225/cgi-bin/about.cgi")
	# function2()

