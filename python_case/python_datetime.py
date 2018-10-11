# python_datetime.py
import datetime
print datetime.datetime.today(),datetime.datetime.today().strftime('%Y-%m-%d-%b-%c-%a-%j')
print (datetime.datetime.today()-datetime.timedelta(3)).strftime("%Y-%m-%d")
print datetime.datetime.today().strftime('%Y%m%d_%H%M%S')


import datetime
with open ("logname","w") as lognameHandle:
  lognameHandle.write("logname="+datetime.datetime.today().strftime('%Y%m%d_%H%M%S'))