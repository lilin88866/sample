import urllib2
#******************************************************************************
# File                      setupTestLine.py
# Brief                     pybot starting script
#                           collect VNF IP
#							collect RAP IP
#                           check undeploy or unused VNF IP
#                           check used rap ip by read SCF file on VNF
#                           do uncommision when unused RAP not enough
#                           do deploy when needed
#                           change scf by template
#                           do commision
#
# Modification History:
#
# 2018-01.09    Li Lin    First version
#                           
# Copyright (c) Nokia 2018. All rights reserved.
#******************************************************************************


import types
import json
import requests
from requests.packages.urllib3.exceptions import InsecureRequestWarning
from robot.libraries import BuiltIn


# https://10.97.117.158/mz/c/v1/cbts/1/info search bts status
class ParaAPI():
	"""docstring for ClassName"""
	def __init__(self):
		
		# self.ip = ip
		requests.packages.urllib3.disable_warnings(InsecureRequestWarning)
		self.ParaAPI=requests.Session()
		self.scf_error=""
	def rest_log_in(self,ip):

		url="https://"+ip+"/login"
		kwargs={
			'headers': 
				{
					'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
				}, 
			'data': 'username=Nemuadmin&password=nemuuser'
		}
		requests.packages.urllib3.disable_warnings(InsecureRequestWarning)
		try:
			resp=self.ParaAPI.post(url,verify=False,**kwargs)
			if str(resp.status_code) == '200':
				return self.ParaAPI
		except Exception as e:
			return None


	def rest_log_out(self,ip):
		
		url="https://"+ip+"/logout"
		try:
			resp=self.ParaAPI.get(url,verify=False)
			if str(resp.status_code) == '302':
				return True
		except Exception as e:
			return None
		


	def check_scf_parameters(self,resp):
		if str(resp.status_code) == '200':
			return True
		else:
			self.scf_error=resp.json()["error"]["userMessage"]
			return False

	def rest_get_scf_content(self,ip):
		url="https://"+ip
		resp=self.ParaAPI.get(url+"/mz/r/v1/raml?appInfo=Nokia++SBTSElement+Manager&user=WebUI",verify=False)
		scf_content = json.loads(resp.text)["fileContent"]
		return scf_content
	def rest_send_commission(self, commission_file,ip):
		url="https://"+ip
		plan_headers = {"Content-Type": "application/xml; charset=UTF-8"}
		with open(commission_file, 'r') as f:
			commission_content = f.read()
			f.close()
		self.ParaAPI.put(url+"/mz/r/v1/plans/1", data=commission_content, headers=plan_headers,verify=False)
		self.ParaAPI.get(url+"/mz/r/v1/plans/1/info",verify=False)
		resp=self.ParaAPI.get(url+"/mz/r/v1/plans/1/xml",verify=False)

		if str(resp.status_code) == '200':
			plan_headers = {"Content-Type": "application/xml; charset=UTF-8"}
			headers = {"Content-Type": "application/json"}
			self.ParaAPI.get(url+"/mz/p/v1/profiles/lte_pid2",headers=plan_headers,verify=False)
			software_data = {"operation": "activate"}

			software_data = json.dumps(software_data)
			self.ParaAPI.put(url+"/mz/r/v1/plans/1/info", data=software_data,headers=headers,verify=False)
			self.ParaAPI.get(url+"/templates/tabs/site-tab.html",headers=plan_headers,verify=False)


			return True,self.scf_error
		else:
			self.scf_error=resp.json()["error"]["userMessage"]
			return False,self.scf_error


		


	def rest_read_all_cell_ids(self,ip):
		url="https://"+ip
		cell_list = []
		resp = self.ParaAPI.get(url+"/mz/c/v1/cbts/1",verify=False)
		resp_dict = resp.json()

		cell_dict = resp_dict["localCell"]
		if type(cell_dict) is types.DictType:
			for each_cell in cell_dict.values():
				cell_id = str(each_cell["visibleId"])
				if not cell_id.startswith("#"):
					cell_list.append(cell_id)
		cell_list.sort()
		return cell_list


	def rest_read_cell_status(self,ip, cell_id):
		url="https://"+ip
		status_dict = {}
		resp = self.ParaAPI.get(url+"/mz/c/v1/cbts/1",verify=False)
		resp_dict = resp.json()
		cell_dict = resp_dict["localCell"]
		if type(cell_dict) is types.DictType:
			for each_cell in cell_dict.values():
				cid = str(each_cell["visibleId"])
				if not cid.startswith("#"):
					if int(cid) == int(cell_id):
						status_dict["administrativeState"] = (each_cell["administrativeState"])
						status_dict["operationalState"] = (each_cell["operationalState"])
						status_dict["planningStatus"] = (each_cell["planningStatus"])
						status_dict["proceduralStatus"] = (each_cell["proceduralStatus"])
						status_dict["availabilityStatus"] = (each_cell["availabilityStatus"])
					if each_cell.has_key("energySavingState"):
						status_dict["energySavingState"] = (each_cell["energySavingState"])

		else:
			status_dict["energySavingState"] = "Unknown"
		if len(status_dict) == 0:
			raise_cBTSError("AssertionError", "There are no cell found with this cell ID")
		return status_dict

	def RapResetOnline(self,vnf_ip):

		url="https://"+vnf_ip+"/login"
		baseic_url="https://"+vnf_ip
		sessionInst=requests.Session()
		kwargs={
			'headers': 
				{
					'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
				}, 
			'data': 'username=Nemuadmin&password=nemuuser'
		}
		requests.packages.urllib3.disable_warnings(InsecureRequestWarning)
		sessionInst.post(url,verify=False,**kwargs)
		sessionInst.get(baseic_url+"/templates/modals/confirmation-modal.html",verify=False)
		headers = {"Content-Type": "application/json; charset=UTF-8"}
		sessionInst.headers.update(headers)
		sessionInst.put(baseic_url+"/mz/r/v1/accountManagement/keepAliveUser",verify=False)
		reset_resp=sessionInst.put(baseic_url+"/mz/r/v1/reset",verify=False)
		print reset_resp

	def printInfo(self,str):
		info="""
***************************************************************************
%s
***************************************************************************
		"""%(str)
		BuiltIn.logger.console(info)
		# print info

if __name__ == '__main__':
	ParaAPIclass=ParaAPI()
	ParaAPIclass.rest_log_in("10.97.117.158")