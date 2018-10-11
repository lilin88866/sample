import threading
import os, time

def runThread(val):
    time.sleep(2)
    print val

def threads():
    threadList = []
    index = 0
    for i in range(10):
        t1 = threading.Thread(target=runThread, args=(i,))
        threadList.append(t1)

    for t in threadList:
        t.setDaemon(True)
        t.start()

    for t in threadList:
         t.join()

if __name__=="__main__":
    threads()