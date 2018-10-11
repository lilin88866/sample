def getSCFDirBySSH(self,vnf_ip):

		local_ip="10.97.122.59"
		os.mkdir(vnf_ip)

		ssh_cmd=r"""
expect -c "
           spawn ssh %s@%s -p 22;
           expect {
           	\"Password: \" {send \"%s\r\";}}
           expect {
           	\"Please enter the root password*
Password*\" {send \"%s\r\";exp_continue;}}

            expect { 
            \"#*\" {send \"scp /opt/nokia/SS_MzOam/cloud-siteoam/siteoam/site_conf/*.xml ute@%s:/home/ute/lilin/%s\r\";}}
            expect {
            \"Are you sure you want to continue connecting (yes/no)?\" {send \"yes\r\";}}
            expect {
            \"'s password:\" {send \"ute\r\";}}
            expect { 
            \"#*\" {send \"exit\r\";}}

"
"""%(self.vnf_ssh_username,vnf_ip,self.vnf_ssh_firstpassword,self.vnf_ssh_secondpassword,local_ip,vnf_ip)

		print "============================="		
		scpStdout=subprocess.Popen(ssh_cmd,shell=True,stdou


 expect -c "spawn scp -r ${tempDir} ${remote_username}@${remote_ip}:${tempRemoteDir}
            set timeout 600
            expect {
            \"*assword\" {send \"${remote_psw}\r\";}
            \"yes/no\" {send \"yes\r\"; exp_continue;}
            \"*No route to host*\" {exit 1;}
            \"*Host key verification failed*\" {exit 1;}
            timeout {exit 1;}
            }
            expect eof
            "