# python_try.py
import sys   

def sys_exc_info():
	try:   
		a=b   
		b=c   
	except Exception as e:
		info=sys.exc_info()   
		print info[0],":",info[1]
		raise e  

	return 


def main():
	print sys_exc_info()

if __name__ == '__main__':
	main()
