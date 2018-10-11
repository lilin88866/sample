puthon_process.py

pingStdout=subprocess.Popen("ping -c 2 -w 3 %s | grep 'packet loss' | awk  '{print $6}' " %(ip) ,shell=True,stdout=subprocess.PIPE)
pingResults= pingStdout.stdout.read().strip("%\n")