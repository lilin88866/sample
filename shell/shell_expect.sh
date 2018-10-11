python的脚本
    uncommissionCmd="""rm -f  /opt/nokia/SS_MzOam/cloud-siteoam/configuration/bim_siteoam.json /opt/nokia/SS_MzOam/cloud-racoam/configuration/cbim_repo.json /opt/nokia/SS_MzOam/cloud-racoam/configuration/pbim_repo.json  /mnt/services/siteoam/config/*.xml
reboot
"""

    ssh_cmd=r"""
expect -c "
spawn ssh %s@%s -p 22;
expect {
  \".*Are you sure you want to continue connecting (yes/no)*\" {send \"yes\r\";}}
expect {
  \"Password: \" {send \"%s\r\";}}
expect {
  \"Please enter the root password*
Password*\" {send \"%s\r\";exp_continue;}}

expect { 
\"#*\" {send \"%s\r\";}}

expect eof;"
"""%(self.vnf_ssh_username,vnf_ip,self.vnf_ssh_firstpassword,self.vnf_ssh_secondpassword,uncommissionCmd)
    print ssh_cmd
    scpStdout=subprocess.Popen(ssh_cmd,shell=True,stdout=subprocess.PIPE)
    ecxceptoutput=scpStdout.stdout.read()

shell的脚本
expect -c "
spawn ssh _nokfsoperator@10.97.117.156 -p 22;
expect {
  \".*Are you sure you want to continue connecting (yes/no)*\" {send \"yes\r\";}}
expect {
  \"Password: \" {send \"nok_pass\r\";}}
expect {
  \"Please enter the root password*
Password*\" {send \"root_pass\r\";exp_continue;}}

expect eof;"  


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