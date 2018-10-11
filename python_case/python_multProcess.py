from multiprocessing import Process  
import os  
import time
import subprocess  
import sys
import MySQLdb as testReportDb
def subprocesscall():

    cmd = "C:/mysql/bin/mysql.exe -uroot -proot -h 10.97.125.163 -P 3306 -D test_report" 
    
    retcode = subprocess.call(cmd,shell=True)
    print retcode
   
def sleeper1(name, seconds):  
    print "Process ID# %s" % (os.getpid())  
    print "Parent Process ID# %s" % (os.getpid())  
    print "%s will sleep for %s seconds" % (name, seconds)  
    time.sleep(seconds) 
def newF():
    child_proc = Process(target=sleeper1, args=('bob', 3))  
    child_proc.start()  
    print "in parent process after child process start"  
    print "parent process abount to join child process"  
    child_proc.join()  
    print "in parent process after child process join"  
    print "the parent's parent process: %s" % (os.getpid())  


##########################################################
# the following is the begain
##########################################################
def updateSw(testline_name,swRev):
    pybotCmd="python test.py" 
    retCode = os.system("python test.py")
    print "test.py %s %s %s" %(testline_name,swRev,retCode)

def updateAllTestLine(testline_name_list,swRev):
    processPool = multiprocessing.Pool(len(testline_name_list))
    for testline_name in testline_name_list:
        processPool.apply_async(updateSw, args=(testline_name[0],swRev))
    processPool.close()
    processPool.join()

##########################################################
# the following is the end
##########################################################


##########################################################
# the following is the strat ,this one have the return value
##########################################################
# apply_async()本身就可以返回被进程调用的函数的返回值。上一个创建多个子进程的代码中，如果在函数func中返回一个值，那么pool.apply_async(func, (msg, ))的结果就是返回pool中所有进程的值的对象（注意是对象，不是值本身）。

import multiprocessing
import time

def func(msg):
    return multiprocessing.current_process().name + '-' + msg

if __name__ == "__main__":
    pool = multiprocessing.Pool(processes=4) # 创建4个进程
    results = []
    for i in xrange(10):
        msg = "hello %d" %(i)
        results.append(pool.apply_async(func, (msg, )))
    pool.close() # 关闭进程池，表示不能再往进程池中添加进程，需要在join之前调用
    pool.join() # 等待进程池中的所有进程执行完毕
    print ("Sub-process(es) done.")

    for res in results:
        print (res.get())




##########################################################
# the following is the end
##########################################################







if __name__ == "__main__":  
    # child_proc = Process(target=sleeper, args=('bob', 5))  
    # child_proc.start()  
    # print "in parent process after child process start"  
    # print "parent process abount to join child process"  
    # child_proc.join()  
    # print "in parent process after child process join"  
    # print "the parent's parent process: %s" % (os.getpid())  
    newF()
    testline_name_list=[('CBTS31',), ('CBTS1',), ('CBTS2',), ('CBTS3',), ('CBTS4',)]
    updateAllTestLine(testline_name_list,"swRev")
    # subprocesscall()



