
	def getVnfIp(self):
		groovy_script="""
def Offline=[]
def running=[]
def free=[]
for (aSlave in hudson.model.Hudson.instance.slaves) {
  if (aSlave.getComputer().isOffline()){
    Offline.add(aSlave.name);
  } else if (aSlave.getComputer().countBusy()== 1){
    running.add(aSlave.name);
  } else {
    free.add(aSlave.name);
  }
}
println "free:"+free
println "Offline:"+Offline
println "running:"+running
"""
	pingStdout=subprocess.Popen("curl --insecure -u l11li:Nokia1705 -d \"script\"=\"%s\" http://10.97.122.57:8080/scriptText" %(groovy_script) ,shell=True,stdout=subprocess.PIPE)
	free,offline,running= pingStdout.stdout.read().rstrip("\n").split("\n")
	freelist = free.strip("[|]").split(",")
	offlinelist = offline.strip("[|]").split(",")
	runninglist= running.strip("[|]").split(",")