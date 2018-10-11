#!/usr/bin/python

import socket,time,datetime
from threading import Thread
from threading import Lock

class Log(Thread):
    def __init__(self,sock):
        self.Lock=Lock()
        self.sock=sock
        self.test=True
        print "start: ",self.sock.getsockname()[1]
        super(Log, self).__init__()

    def run(self):
        while(1):
            with self.Lock:
                if not self.test:
                    break
            try:
                data=self.sock.recv(4096)
            except socket.error:
                continue
            t = str(datetime.datetime.now().strftime('%H:%M:%S'))
            for log in data.splitlines(False) :
                if log.find('AaSysTime:')<0 and len(log)>2:
                    print t,' : ',self.sock.getsockname()[1],' : ', log.replace('\x00','')
    
    def stop(self):
        with self.Lock:
            self.test=False

ports=[51001,51000,50011,51003]
backupPorts=[52000,53000]

socks=[]
for port in ports + backupPorts:
    try:
        s=socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.bind(('', port))
        s.setblocking(0)
        s.settimeout(0.1)
        socks.append(s)
        if (len(socks)==4) or (port in backupPorts):
            break
    except:
        print ""
        print "Port " + str(port) + " in use!"
        print ""

if not socks:
    print "Nothing to log ... "
    exit(-1)

LogThreads=[];
for sock in socks:
    LogThreads.append(Log(sock))
    LogThreads[-1].start()

while(1):
    try:
        time.sleep(1000)
    except :
        break

map(lambda x:x.stop(),LogThreads)

for LogThread in LogThreads:
    LogThread.join()
    LogThread.sock.close()







