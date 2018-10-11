from ftplib import FTP
import time
import zipfile
import os
import paramiko
import telnetlib


class ftpTest:
	"""docstring for ftpTest"""
	def __init__(self):
		# pass
		self.ftp = FTP(host = '192.168.255.1',user = 'root',passwd = '')
		self.ftp.cwd('/tmp')

	def upload(self,file):
		print "ftp file"
		self.ftp.storbinary("STOR " + file, open(file, "rb"))
		# zfobj = zipfile.ZipFile(file)
		self.unzip_file(file)
		

	def unzip_file(self,zipfilename):
		ssh = paramiko.SSHClient()  
		ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())	
		# ssh.connect('192.168.255.1', username = 'root', password = 'root')
		ssh.connect('192.168.255.1', username = 'toor4nsn', password = 'oZPS0POrRieRtu')
		stdin, stdout, stderr = ssh.exec_command('unzip /tmp/lilin.zip -d /tmp/')
		result = stdout.channel.recv_exit_status()
		outLines = stdout.readlines()
		errLines = stderr.readlines()
	def uploadFolder(self,file):
		print "ftp folder"
		self.ftp.mkd(file)

	def upload_files(self, localdir):     
		if not os.path.isdir(localdir):     
			return
		print "ftp folder"    
		localnames = os.listdir(localdir)       
		for item in localnames:    
		   	file = os.path.join("lilinde/", item)    
			self.ftp.storbinary("STOR " + file, open(file, "rb"))     
   
	def settime(self,timeFlag):
		print timeFlag,time.strftime('%Y-%H-%M-%S',time.localtime(time.time()))


if __name__ == '__main__':
	ftpTestClass=ftpTest()
	ftpTestClass.settime("start")
	ftpTestClass.upload("lilin.zip")
	ftpTestClass.settime("end")

	ftpTestClass.settime("start")
	ftpTestClass.upload_files("lilinde")
	ftpTestClass.settime("end")

