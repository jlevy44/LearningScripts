import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
#from APScheduler import *
import openpyxl
import datetime
#from apscheduler.schedulers.background import BackgroundScheduler

# let's read excel file and add multiple emails and change messages...
emailList = openpyxl.load_workbook('EmailXL.xlsx')
emailParse = emailList.active
readEmails = 0
emailRecipients = []
for row in emailParse:
    if readEmails:
        personalizedMessages = []
        if row[3]._value:
            for cell in row[3:]:
                if cell._value:
                    personalizedMessages.append(cell._value)
            print personalizedMessages
            emailRecipients.append((row[0]._value,row[1]._value,row[2]._value,personalizedMessages))#row[3]._value))
        else:
            emailRecipients.append((row[0]._value,row[1]._value,row[2]._value))
    if row[0]._value:
        if 'Date:' in row[0]._value:
            date = row[1].value
        if 'Time:' in row[0]._value:
            time = row[1].value
        if 'Emails' in row[0]._value:
            readEmails = 1
        if 'Main Message:' in row[0]._value:
            mainMessages = []
            for cell in row[1:]:
                if cell._value:
                    mainMessages.append(cell._value + '\n\n')
        if 'Signing:' in row[0]._value:
            signing = '\n%s,\n%s'%(row[1]._value,row[2]._value)

InputDateTime = date + datetime.timedelta(hours=time.hour, minutes=time.minute)

def ChangePersonal(mainmessageParagraph,personalizedMessages):
    print personalizedMessages
    print mainmessageParagraph[mainmessageParagraph.find('PERSONAL')], mainmessageParagraph[mainmessageParagraph.rfind('NAL')+3]
    if personalizedMessages:
        for i in range(len(personalizedMessages)):
            mainmessageParagraph = mainmessageParagraph.replace('PERSONAL%d'%(i+1),personalizedMessages[i])
        print mainmessageParagraph
    return mainmessageParagraph

def sendEmails():


    #fromaddr = raw_input('Enter email: ')
    #password = raw_input('Enter password: ')
    password = 'BeatBox1'
    fromaddr = "joshlish44@gmail.com"

    #sheet_ranges = emailParse['A1:D5']
    #print [cell.value for cell in sheet_ranges]


    signature = """\
<html>
    <head></head>
    <body>
    <p><br>
        <br>
        --<br>
        <font size=5>Moving Minds Initiative</font><br>
        <i><font size=4>"Behind every face there's a story"</font></i><br>
        <a href="ymm.berkeley.edu">You Mean More</a><br>
        Joshua, Kimberly, Leah, Billal, Shellin<br>
        movingmindsucb@gmail.com<br>
        <img src="https://s32.postimg.org/araq0lgk5/MMILogo_Unofficial.png">
    </p>
  </body>
</html>"""

    for recipient in emailRecipients:
        msg = MIMEMultipart()
        msg['From'] = fromaddr
        server = smtplib.SMTP('smtp.gmail.com', 587)
        server.starttls()
        server.login(fromaddr, password)
        if len(recipient) < 4:
            recipient += ('',)
        toaddr = recipient[0]
        msg['To'] = toaddr
        msg['Subject'] = "TEST %s %s"%recipient[1:-1]

        body = """Dear %s %s,

"""%(recipient[1:-1])+ ''.join(ChangePersonal(mainmessage,recipient[3]).replace('NAME',recipient[1]+' '+recipient[2])
                               for mainmessage in mainMessages) + signing
        # FIXME need to add first name option to make even more personal
        # FIXME, please remove all PERSONAL, there should be option to remove personal...
        msg.attach(MIMEText(body, 'plain'))
        msg.attach(MIMEText(signature,'html'))
        text = msg.as_string()
        server.sendmail(fromaddr, toaddr, text)
        msg._payload = []


        server.quit()

# be careful about reply all
while True:
    import datetime
    if datetime.datetime.now() >= InputDateTime:
        sendEmails()
        break
