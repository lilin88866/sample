# -*- coding: utf-8 -*-

from email.mime.text import MIMEText
import smtplib


html = """\
<html>
  <head></head>
  <body>
    <p>Hi!<br>
       How are you?<br>
       Here is the <a href="https://www.python.org">link</a> you wanted.
    </p>
  </body>
</html>
"""

def sendmail(from_addr, to_addrs, subject, content, content_type,smtp_address='mail.emea.nsn-intra.net',
             smtp_port=25):
    '''
    Example:
    sendmail('test@hello.com', 'tester1@nokia.com tester2@nokia.com', 'test subject', html, 'html')
    sendmail('test@hello.com', 'tester1@nokia.com tester2@nokia.com', 'test subject', 'mail content', 'plain')
    '''
    msg = MIMEText(content,_subtype=str(content_type),_charset='gb2312')
    msg['Subject'] = str(subject)
    msg['To'] = to_addrs # this can comment
    server = smtplib.SMTP(smtp_address, smtp_port)
    server.set_debuglevel(1)
    result = server.sendmail(from_addr, to_addrs.split(), msg.as_string())
    print 'result:'
    print result
    server.quit()

if __name__ == '__main__':
    sendmail('test@no.com', 'xing.gao@nokia.com jinbo.yu@nokia.com', 'test subject', html, 'html')

















