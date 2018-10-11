import ldap
ldap_server = "ldap://10.135.55.17:389"

def search_people_ldap(search_regex):    
    return L_handle.search_s('o=NSN',ldap.SCOPE_SUBTREE,search_regex)

def get_user_information(uid='', employeeNumber='', mail=''):
    if uid != '':
        search_regex = '(uid=%s)' % (uid)
    elif employeeNumber != '':
        search_regex = '(employeeNumber=%s)' % (employeeNumber)
    elif mail != '':
        search_regex = '(mail=%s)' % (mail)

    return search_people_ldap(search_regex)

def try_regex_ldap(search_info):
    try:    
        result = get_user_information(search_regex)
        print result[0][1]['mail'][0]
        print "%s is OK for request" % (search_regex)
    except:
        print "%s exception" % (search_regex)



L_handle = ldap.initialize(ldap_server)

result = get_user_information(uid="l11li1")
print result[0][1]['mail'][0]
result = get_user_information(employeeNumber="61393463")
print result[0][1]['uid'][0]
result = get_user_information(mail="lin.2.li@nokia-sbell.com")
print result[0][1]['employeeNumber'][0]
