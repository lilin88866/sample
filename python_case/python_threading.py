import threading
import os,time,random
class Counter:
	def __init__(self):
		self.lock = threading.Lock()
		self.value = 0
	def increment(self):
		self.lock.acquire() # critical section
		self.value = value = self.value + 1
		self.lock.release()
		return value

class Worker(threading.Thread):
	def run(self):
		for i in range(4):
		# pretend we're doing something that takes 10?00 ms
			value = counter.increment() # increment global counter
			time.sleep(random.randint(1, 1))
			print self.getName(), "-- task", i, "finished", value

if __name__ == '__main__':
	counter = Counter()
	print counter.value
	for i in range(3):
		Worker().start() 