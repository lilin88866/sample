@echo off 

if "%1" == "h" goto begin 

mshta vbscript:createobject("wscript.shell").run("%~nx0 h",0)(window.close)&&exit 

:begin 

"C:\Program Files (x86)\Java\jdk1.7.0_51\bin\java.exe" -Dhudson.model.DirectoryBrowserSupport.CSP=  -Xmx512M -Xms512M -XX:PermSize=256m -XX:MaxPermSize=1g -jar d:\jenkins\jenkins.war" >jenkins_console.txt 2>&1