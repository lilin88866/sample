from multiprocessing import Process, Queue
import os, time, random
def write(q):
    for value in ['A', 'B', 'C','D','E']:
        print 'Put %s to queue...' % value
        q.put(value)
        time.sleep(3)


def read(q):
    while True:
        if not q.empty():
            value = q.get(True)
            print 'Get %s from queue.' % value
            time.sleep(2)
        else:
            break

if __name__=='__main__':

    q = Queue()
    pw = Process(target=write, args=(q,))
    pr = Process(target=read, args=(q,))

    pw.start()    

    pw.join()

    pr.start()
    pr.join()
