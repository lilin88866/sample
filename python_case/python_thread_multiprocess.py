import multiprocessing
import threading  

import time,signal
#the function used for thread executd  

class Callable(object):  
    def __init__(self, func, args):  
        self.func = func;  
        self.args = args;  
    def __call__(self):  
    	print "call class"
        apply(self.func, self.args); 

class SubThread(threading.Thread):  
    def __init__(self, name):  
        threading.Thread.__init__(self, name=name);  
  
    def run(self):  
        i = 0;  
        while i < 4:  
            print self.name,'counting...\n';  
            counter(3);  
            print self.name,'finish\n';  
            i += 1;  

def counter(n):  
    cnt = 0;  
    for i in xrange(n):  
        for j in xrange(i):  
            cnt += j;  
    print "call counter",cnt; 
def printTime():
    print "call time",time.time(),"\n" 
def handler(signum, frame):  
    print 'signal', signum; 
def runMultiprocess():
	signal.signal(signal.SIGTERM, handler);  
	signal.signal(signal.SIGINT, handler);  
	i = 0;  
	while i<3:  
	    print 'running';  
	    time.sleep(2);  
	    i += 1


class classMaster(multiprocessing.Process):  
    def __init__(self):  
        super(classMaster,self).__init__();  
        signal.signal(signal.SIGTERM, self.handler) 
        self.live = 1;  
    def handler(self, signum, frame):  
        print 'class signal:',signum;  
        self.live = 0;  
  
    def run(self):  
        print 'PID:',self.pid;  
        while self.live:  
            print 'class living...'  
            time.sleep(2);            
              
if __name__ == '__main__':
########################################################################################
#######################
#######################                  threading
#######################
########################################################################################
	print "############################## style 1 ######################################"
	print "call a function with param\n"
	th = threading.Thread(target=counter, args=(1000,))
	th.start();
	print "call a function without param\n"
	tht = threading.Thread(target=printTime)
	tht.start();

	print "############################## style 2 ######################################"
	print "call a class which param used as funciton\n"
	classcall = threading.Thread(target=Callable(counter,args=(1000,)))
	classcall.start();  
	# the mian thread block and wait for subthread end 
	print "the mian thread block and wait for subthread end\n" 
	th.join();  
	print "the mian thread block and wait for subthread end join\n"

	print "############################## style 3 ######################################"
	th = SubThread('thread-1');  
	th.start();  
	th.join();  
	print 'all done'; 

########################################################################################
#######################
#######################                  multiprocessing
#######################
########################################################################################
	print "###############################multiprocessing -1##########################"
	p = multiprocessing.Process(target=runMultiprocess);  
	p.start();  
	# p.join();  
	print "pid", p.pid;  
	print 'master gone';
	print "###############################multiprocessing -2##########################"
	multiprocessing_call_class = classMaster()

	print "###############################multiprocessing -3##########################"
	pool = multiprocessing.Pool(processes=4)  
	pool.apply(runMultiprocess) 
	pool.apply_async(runMultiprocess)
	pool.close()
	pool.join()
