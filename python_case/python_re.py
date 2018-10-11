import re
import sys
print sys.version

# '2.5.1 (r251:54863, Apr 18 2007, 08:51:08) [MSC v.1310 32 bit (Intel)]' 

text = "The Attila the Hun Show"

match=re.match(r"\w+",text)
print match.group(0)


match=re.search(r"\w+",text)
print match.group(0)


code = "for i in range(0, 10): print i"
cmpcode = compile(code, '', 'exec')
exec cmpcode


patten=re.compile(r"\w+")
compiles=patten.findall(text)
print compiles
reNamedGroupTestStr = u'tag:<a href="/tag/wwww/">wwww</a>';

foundTagA = re.search(u'.+?<a href="/tag/(?P<tagName>.+?)/">(?P=tagName)</a>', reNamedGroupTestStr);
print "foundTagA=",foundTagA.group("tagName"),foundTagA.group(0),foundTagA.group(1); #foundTagA= <_sre.SRE_Match object at 0x00876D60>

substitutedStr = re.sub(u'.+?<a href="/tag/(?P<tagName>.+?)/">(?P=tagName)</a>', u'tag:\g<tagName>', reNamedGroupTestStr)
print "Original string=%s, after substituted=%s"%(reNamedGroupTestStr, substitutedStr)

reLookaheadTestStr = """
fake html begin
 
out of src, normal content include pic url:
some sohu blog pic url is something like this:
"http://1802.img.pp.sohu.com.cn/images/blog/2012/4/12/16/20/u173669005_13766a912eag214.jpg"
which use img.pp.sohu.com.cn as its image server.
 
in end, include quote mark:
<img style="text-align:center;margin:0px auto 10px;zoom:1;display:block" border="0" src="http://1821.img.pp.sohu.com.cn/images/blog/2012/4/12/16/19/u173669005_13766a7cbebg214.jpg">
 
in end, NOT include quote mark:
<img style="text-align:center;margin:0px auto 10px;zoom:1;display:block" border="0" src="http://1811.img.pp.sohu.com.cn/images/blog/2012/4/12/16/15/u173669005_13766a48e19g213.jpg>
 
fake html end
"""
 
#lookahead assertion 
# 
foundAllSrcJpgUrl_lookbehind = re.findall(u'(?<=src=")(http://[\w\./]+\.jpg)', reLookaheadTestStr);
print "foundAllSrcJpgUrl_lookbehind=",foundAllSrcJpgUrl_lookbehind; #foundAllSrcJpgUrl_lookbehind= ['http://1821.img.pp.sohu.com.cn/images/blog/2012/4/12/16/19/u173669005_13766a7cbebg214.jpg', 'http://1811.img.pp.sohu.com.cn/images/blog/2012/4/12/16/15/u173669005_13766a48e19g213.jpg']
 
# 
foundAllSrcJpgUrl_lookbehind_alsoLookahead = re.findall(u'(?<=src=")(http://[\w\./]+\.jpg)(?=")', reLookaheadTestStr);
print "foundAllSrcJpgUrl_lookbehind_alsoLookahead=",foundAllSrcJpgUrl_lookbehind_alsoLookahead

import re;
 
txt ="bn','dd_ff');xm_a([1,'zhangming',0,2,'yuwenjige','lishijige',1,0,3,1,0,0.999,1,1,0,0]);xm_a([2,'wangmeng',0,2,'shuxuejige','dilijige',1,0,3,1,0,0.999,1,1,1,0]);xm_a([3,'wangli',0,2,'shuxuejige','dilijige',1,0,2,0,0,0.999,1,1,1,0]);zuobi(6,3,'4:5');fg_gh('xxx','vb_4');xm_a([4,'dashan',0,2,'huaxuejige','yingyujige',1,0,3,1,1,0.999,0,1,0,0]);";
 

allJigeIncludeZuobi = re.findall("xm_a\(\[\d+,'(\w+)',[^\(\)\[\]]+\]\);", txt);
print allJigeIncludeZuobi; #['zhangming', 'wangmeng', 'wangli', 'dashan']

allJigeNoZuobi = re.findall("xm_a\(\[\d+,'(\w+)',[^\(\)\[\]]+\]\);(?!zuobi)", txt);
print allJigeNoZuobi; #['zhangming', 'wangmeng', 'dashan']

testNumStrList = {
    #illagle
    '12.34',
    '123.4',
    '1234',
     
    #unillagle
    '1.234',
    '12.',
    '12.ab',
    '12.3a',
    '123abc',
    '123abc456',
}
for eachNumStr in testNumStrList:

    foundValidNumStr = re.search("^(?P<integerPart>\d+)(?P<foundPoint>\.)?(?P<decimalPart>(?(foundPoint)\d{1,2}))$", eachNumStr);
    #oe this pattern
    #foundValidNumStr = re.search("^(?P<integerPart>\d+)(\.)?(?P<decimalPart>(?(2)\d{1,2}))$", eachNumStr);
     
    #print "foundValidNumStr=",foundValidNumStr;
    if(foundValidNumStr):
        integerPart = foundValidNumStr.group("integerPart");
        decimalPart = foundValidNumStr.group("decimalPart");
        print "eachNumStr=%s\tis valid numebr ^_^, integerPart=%s, =%s"%(eachNumStr, integerPart, decimalPart);
    else:
        print "eachNumStr=%s\tis invalid number !!!"%(eachNumStr);decimalPart

 
txt ="bn','dd_ff');xm_a([1,'zhangming',0,2,'yuwenjige','lishijige',1,0,3,1,0,0.999,1,1,0,0]);xm_a([2,'wangmeng',0,2,'shuxuejige','dilijige',1,0,3,1,0,0.999,1,1,1,0]);xm_a([3,'wangli',0,2,'shuxuejige','dilijige',1,0,2,0,0,0.999,1,1,1,0]);zuobi(6,3,'4:5');fg_gh('xxx','vb_4');xm_a([4,'dashan',0,2,'huaxuejige','yingyujige',1,0,3,1,1,0.999,0,1,0,0]);";

allJigeIncludeZuobi = re.findall("xm_a\(\[\d+,'(\w+)',[^\(\)\[\]]+\]\);", txt);
print allJigeIncludeZuobi; #['zhangming', 'wangmeng', 'wangli', 'dashan']

allJigeNoZuobi = re.findall("xm_a\(\[\d+,'(\w+)',[^\(\)\[\]]+\]\);(?!zuobi)", txt);
print allJigeNoZuobi; #['zhangming', 'wangmeng', 'dashan']


import re;
# http://www.crifan.com/detailed_explanation_about_python_regular_express_named_group/
 
searchVsFindallStr = """
pic url test 1 http://1821.img.pp.sohu.com.cn/images/blog/2012/3/7/23/28/u121516081_136ae35f9d5g213.jpg
pic url test 2 http://1881.img.pp.sohu.com.cn/images/blog/2012/3/7/23/28/u121516081_136ae35ee46g213.jpg
pic url test 2 http://1802.img.pp.sohu.com.cn/images/blog/2012/3/7/23/28/u121516081_136ae361ac6g213.jpg
"""
 
singlePicUrlP_noGroup = "http://\w+\.\w+\.\w+.+?/\w+?.jpg"; 
singlePicUrlP_nonCapturingGroup = "http://(?:\w+)\.(?:\w+)\.(?:\w+).+?/(?:\w+?).jpg"; 
singlePicUrlP_namedGroup = "http://(?P<field1>\w+)\.(?P<field2>\w+)\.(?P<field3>\w+).+?/(?P<filename>\w+?).jpg"; 
singlePicUrlP_unnamedGroup = "http://(\w+)\.(\w+)\.(\w+).+?/(\w+?).jpg"; 
 
# 1. re.search

foundSinglePicUrl = re.search(singlePicUrlP_namedGroup, searchVsFindallStr);
print "foundSinglePicUrl=",foundSinglePicUrl; #foundSinglePicUrl= <_sre.SRE_Match object at 0x01F75230>
print "type(foundSinglePicUrl)=",type(foundSinglePicUrl); #type(foundSinglePicUrl)= <type '_sre.SRE_Match'>
if(foundSinglePicUrl):
    field1 = foundSinglePicUrl.group("field1");
    field2 = foundSinglePicUrl.group("field2");
    field3 = foundSinglePicUrl.group("field3");
    filename = foundSinglePicUrl.group("filename");
     
    group1 = foundSinglePicUrl.group(1);
    group2 = foundSinglePicUrl.group(2);
    group3 = foundSinglePicUrl.group(3);
    group4 = foundSinglePicUrl.group(4);
    print "field1=%s, filed2=%s, field3=%s, filename=%s"%(field1, field2, field3, filename);
    print "group1=%s, group2=%s, group3=%s, group4=%s"%(group1, group2, group3, group4); 
 
# 2. re.findall - no group
foundAllPicUrl = re.findall(singlePicUrlP_noGroup, searchVsFindallStr);
print "foundAllPicUrl=",foundAllPicUrl; #foundAllPicUrl= ['http://1821.img.pp.sohu.com.cn/images/blog/2012/3/7/23/28/u121516081_136ae35f9d5g213.jpg', 'http://1881.img.pp.sohu.com.cn/images/blog/2012/3/7/23/28/u121516081_136ae35ee46g213.jpg', 'http://1802.img.pp.sohu.com.cn/images/blog/2012/3/7/23/28/u121516081_136ae361ac6g213.jpg']
print "type(foundAllPicUrl)=",type(foundAllPicUrl); #type(foundAllPicUrl)= <type 'list'>
if(foundAllPicUrl):
    for eachPicUrl in foundAllPicUrl:
        print "eachPicUrl=",eachPicUrl; # eachPicUrl= http://1821.img.pp.sohu.com.cn/images/blog/2012/3/7/23/28/u121516081_136ae35f9d5g213.jpg
        foundEachPicUrl = re.search(singlePicUrlP_namedGroup, eachPicUrl);
        print "type(foundEachPicUrl)=",type(foundEachPicUrl); #type(foundEachPicUrl)= <type '_sre.SRE_Match'>
        print "foundEachPicUrl=",foundEachPicUrl; #foundEachPicUrl= <_sre.SRE_Match object at 0x025D45F8>
        if(foundEachPicUrl):
            field1 = foundEachPicUrl.group("field1");
            field2 = foundEachPicUrl.group("field2");
            field3 = foundEachPicUrl.group("field3");
            filename = foundEachPicUrl.group("filename");
            print "field1=%s, filed2=%s, field3=%s, filename=%s"%(field1, field2, field3, filename);
 
# 3. re.findall - non-capturing group
foundAllPicUrlNonCapturing = re.findall(singlePicUrlP_nonCapturingGroup, searchVsFindallStr);
print "foundAllPicUrlNonCapturing=",foundAllPicUrlNonCapturing; #foundAllPicUrlNonCapturing= ['http://1821.img.pp.sohu.com.cn/images/blog/2012/3/7/23/28/u121516081_136ae35f9d5g213.jpg', 'http://1881.img.pp.sohu.com.cn/images/blog/2012/3/7/23/28/u121516081_136ae35ee46g213.jpg', 'http://1802.img.pp.sohu.com.cn/images/blog/2012/3/7/23/28/u121516081_136ae361ac6g213.jpg']
print "type(foundAllPicUrlNonCapturing)=",type(foundAllPicUrlNonCapturing); #type(foundAllPicUrlNonCapturing)= <type 'list'>
if(foundAllPicUrlNonCapturing):
    for eachPicUrlNonCapturing in foundAllPicUrlNonCapturing:
        print "eachPicUrlNonCapturing=",eachPicUrlNonCapturing; #eachPicUrlNonCapturing= http://1821.img.pp.sohu.com.cn/images/blog/2012/3/7/23/28/u121516081_136ae35f9d5g213.jpg

 
# 4. re.findall - named group
foundAllPicGroups = re.findall(singlePicUrlP_namedGroup, searchVsFindallStr);
print "type(foundAllPicGroups)=",type(foundAllPicGroups); #type(foundAllPicGroups)= <type 'list'>
print "foundAllPicGroups=",foundAllPicGroups; #foundAllPicGroups= [('1821', 'img', 'pp', 'u121516081_136ae35f9d5g213'), ('1881', 'img', 'pp', 'u121516081_136ae35ee46g213'), ('1802', 'img', 'pp', 'u121516081_136ae361ac6g213')]
if(foundAllPicGroups):
    for eachPicGroups in foundAllPicGroups:
        print "eachPicGroups=",eachPicGroups; #eachPicGroups= ('1821', 'img', 'pp', 'u121516081_136ae35f9d5g213')
        print "type(eachPicGroups)=",type(eachPicGroups); #type(eachPicGroups)= <type 'tuple'>

# 5. re.findall - unnamed group
foundAllPicGroupsUnnamed = re.findall(singlePicUrlP_unnamedGroup, searchVsFindallStr);
print "type(foundAllPicGroupsUnnamed)=",type(foundAllPicGroupsUnnamed); #type(foundAllPicGroupsUnnamed)= <type 'list'>
print "foundAllPicGroupsUnnamed=",foundAllPicGroupsUnnamed; #foundAllPicGroupsUnnamed= [('1821', 'img', 'pp', 'u121516081_136ae35f9d5g213'), ('1881', 'img', 'pp', 'u121516081_136ae35ee46g213'), ('1802', 'img', 'pp', 'u121516081_136ae361ac6g213')]
if(foundAllPicGroupsUnnamed):
    for eachPicGroupsUnnamed in foundAllPicGroupsUnnamed:
        print "type(eachPicGroupsUnnamed)=",type(eachPicGroupsUnnamed); #type(eachPicGroupsUnnamed)= <type 'tuple'>
        print "eachPicGroupsUnnamed=",eachPicGroupsUnnamed; #eachPicGroupsUnnamed= ('1821', 'img', 'pp', 'u121516081_136ae35f9d5g213')