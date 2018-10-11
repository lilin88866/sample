import socket
import struct,time,sys
# server
# HOST = "www.google.com"
# 173.194.222.106
# HOST="10.140.27.85"
HOST="127.0.0.1"
PORT=4300
# PORT = 139
host_ip=socket.gethostbyname(HOST)
message = "GET / HTTP/1.1\r\n\r\n"
print host_ip
try:
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	# s.bind((HOST, PORT))
	s.connect((HOST, PORT))
	send=s.send(message)
	print send
	data,addr=s.recvfrom(1024)
	print ('Received:',data,'from',addr)
except Exception, e:
	raise e
s.close()