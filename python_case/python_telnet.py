def telnetdo(HOST=None, USER=None, PASS=None, COMMAND=None): #define a function
    import telnetlib, sys
    
    msg = ['Debug messages:\n'] #
    COMMAND = r'python D:\C_Test\PHY_UL_Robot_TestENV\autoRun.py -A:args_sct_qtlist_8pipe3dsp.txt'
    tn = telnetlib.Telnet() #

    try:
    	tn.open(HOST)
    except Exception, e:
    	raise e
    #msg.append(tn.expect(['login:'], 5)) #
    tn.read_until("login:")
    tn.write(USER + '\n')
    if PASS:
        #msg.append(tn.expect(['Password:'], 5))
        tn.read_until("Password:")
        tn.write(PASS + '\n')
    #msg.append(tn.expect([USER], 5))
    tn.write(COMMAND + '\n')
    tn.write("exit\n")
    #msg.append(tn.expect(['#'], 5))
    tmp = tn.read_all()
    tn.close()
    del tn
    return tmp
     
if __name__ == '__main__':
    telnetdo("10.68.184.53","tdlte-tester","ltetest")