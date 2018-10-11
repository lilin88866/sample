#! /usr/bin/python

import os
import sys
import time
import types
import socket
import binascii 

POWER_OFF_STATUS = '01020100A188'
POWER_ON_STATUS  = '010201016048'
POWER_ON_CODE    = {1: "01050000FF008C3A", 2: "01050001FF00DDFA",
                    3: "01050002FF002DFA", 4: "01050003FF007C3A",
                    5: "01050004FF00CDFB", 6: "01050005FF009C3B",
                    7: "01050006FF006C3B", 8: "01050007FF003DFB"}
POWER_OFF_CODE   = {1: "010500000000CDCA", 2: "0105000100009C0A",
                    3: "0105000200006C0A", 4: "0105000300003DCA",
                    5: "0105000400008C0B", 6: "010500050000DDCB",
                    7: "0105000600002DCB", 8: "0105000700007C0B"}
CHECK_CODE       = {1: "010200000001B9CA", 2: "010200010001E80A",
                    3: "010200020001180A", 4: "01020003000149CA",
                    5: "010200040001F80B", 6: "010200050001A9CB",
                    7: "01020006000159CB", 8: "010200070001080B"}

def printInfo(infoStr):
    print(infoStr)
    sys.stdout.flush()

def printUsage():
    printInfo('*************************************************')
    printInfo('*                                               *')
    printInfo('*  facom $operation      or                     *')
    printInfo('*  facom $operation $PDU_SERVER $PDU_PORT       *')
    printInfo('*  $operation is: restart, poweroff or poweron  *')
    printInfo('*                                               *')
    printInfo('*************************************************')
    sys.stdout.flush()

def readPduConfig(configFile):
    fp = open(configFile, 'r')
    configLines = fp.readlines()
    fp.close()
    for singleLine in configLines:
        lineSplit = singleLine.split('=')
        lineVar = lineSplit[0].strip()
        if lineVar == 'PDU_SERVER':
            pduServer = lineSplit[1].strip()
        if lineVar == 'PDU_PORT':
            pduPort = lineSplit[1].strip()

    return pduServer, pduPort

def getLocalPduConfig():
    homeFolder = os.getenv('HOME')
    if os.path.exists(os.path.join(homeFolder, 'pdu.conf')):
        return readPduConfig(os.path.join(homeFolder, 'pdu.conf'))
    else:
        return readPduConfig('/etc/pdu.conf')

class FacomCommand(object):
    def __init__(self, pduServer, pduPort, serverPort = 4001):
        self.pduPort = int(pduPort)
        self.facomSocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.facomSocket.settimeout(5)
        self.facomSocket.connect((pduServer, serverPort))
        self.isConnect = True

    def closeConnect(self):
        if self.isConnect:
            self.facomSocket.close()
            self.isConnect = False

    def __sendCmd(self, facomCmd):
        cmdHexStr = binascii.a2b_hex(facomCmd)
        marshalled = ""
        for cmdByte in cmdHexStr:
            if isinstance(cmdByte, types.StringTypes):
                marshalled += cmdByte
            else:
                marshalled += struct.pack("l", socket.htonl(cmdByte))
        try:
            self.facomSocket.send(marshalled)
            printInfo('Execute facom command %s success!' % facomCmd)
        except Exception as ex:
            printInfo('Execute facom command %s failed!' % facomCmd)
        
    def __receiveStatus(self):
        facomStatu = ''
        try:
            self.facomSocket.settimeout(5)
            facomStatu, addres = self.facomSocket.recvfrom(4096)
        except Exception as ex:
            printInfo('Receive facom status failed!')

        return binascii.b2a_hex(facomStatu)

    def __remoteBtsCmd(self, oper, intervalTime = 1):
        checkCmd = CHECK_CODE[self.pduPort]
        if oper.upper() == 'ON':
            powerCmd = POWER_ON_CODE[self.pduPort]
            expStatus = POWER_ON_STATUS.upper()
        elif oper.upper() == 'OFF':
            powerCmd = POWER_OFF_CODE[self.pduPort]
            expStatus = POWER_OFF_STATUS.upper()

        self.__sendCmd(powerCmd)
        self.__receiveStatus()
        time.sleep(intervalTime)
        self.__sendCmd(checkCmd)
        resultStatus = str(self.__receiveStatus()).upper()
        if expStatus != resultStatus:
            printInfo('ExpStatus: %s, ResultStatus: %s!' % (expStatus, resultStatus))
            printInfo('Try again!')
            return False

        return True

    def remoteBtsOff(self):
        for tryTimes in range(3):
            if self.__remoteBtsCmd('off', tryTimes + 1):
                time.sleep(5)
                break
        else:
            raise Exception('Power off failed!')

    def remoteBtsOn(self):
        for tryTimes in range(3):
            if self.__remoteBtsCmd('on', tryTimes + 1):
                time.sleep(5)
                break
        else:
            raise Exception('Power on failed!')

def analysisArgv(arguments):
    if len(arguments) == 1 or arguments[1].lower() == '-h' or arguments[1].lower() == '--help':
        printUsage()
        sys.exit(0)
    oper = arguments[1]

    if len(arguments) == 4:
        pduServer, pduPort = arguments[2:]
    else:
        pduServer, pduPort = getLocalPduConfig()
        
    return oper, pduServer, pduPort

def operFacom(oper, pduServer, pduPort):
    printInfo('%s powerstation: %s, port: %s' % (oper, pduServer, pduPort))
    facomControl = FacomCommand(pduServer, pduPort)
    if oper.lower() == 'restart':
        facomControl.remoteBtsOff()
        facomControl.remoteBtsOn()
    elif oper.lower() == 'poweroff':
        facomControl.remoteBtsOff()
    elif oper.lower() == 'poweron':
        facomControl.remoteBtsOn()

if __name__ == "__main__":
    oper, pduServer, pduPort = analysisArgv(sys.argv)
    operFacom(oper, pduServer, pduPort)
。