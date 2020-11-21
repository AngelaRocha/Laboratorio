#Author
#!/bin/bash

function py {python -c "$1"}
direction = $1

for email in $(cat $direction)
do
	echo "email $email"
	py "
	from email.mime.multipart import MIMEMultipart
	from email.mime.text import MIMEText
	import smtplib
	import json

	data = {}
	with open('pass.json') as f:
	        data = json.load(f)
	# create message object instance
	msg = MIMEMultipart()

	message = "Ciaoo!"

	# setup the parameters of the message
	msg['From'] = data['user']

	msg['To'] = '$email'
	msg['Subject'] = "Hola"
		
	# add in the message body
	msg.attach(MIMEText(message, 'plain'))

	#create server
	server = smtplib.SMTP('smtp.office365.com:587')
	server.starttls()

	# Login Credentials for sending the mail
	print(data['user'])
	server.login(data['user'], data['pass'])

	# send the message via the server.
	server.sendmail(msg['From'], msg['To'], msg.as_string())

	server.quit()
		"
done 