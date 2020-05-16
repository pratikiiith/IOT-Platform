from flask import Flask ,jsonify,request
import json
from pymongo import MongoClient
import threading
from kafka import KafkaProducer
from kafka import KafkaConsumer
import time
import smtplib
import sys

registry_ip = 'localhost'
registry_port = 27017
sensor_client = 'final1'
sensor_document = 'sensor'
kafka_platform_ip = 'localhost:9092'

app = Flask(__name__)
	

def send_data_to_sensor(host_topic,service_id):
	
	consumer = KafkaConsumer(str(service_id),group_id='action_module',bootstrap_servers=[kafka_platform_ip],auto_offset_reset = "latest")
	print("send_data_to_sensor , action manager reading from ",service_id)
	
	for message in consumer:
		msg = message.value.decode('utf-8')
		# print("msg on algo output ",msg)

		for i in host_topic:
			temp = i.split(' ')
			ip = temp[0]
			topic = temp[1]
			producer = KafkaProducer(bootstrap_servers=[ip])
			producer.send(topic, bytes(msg,"utf-8"))    
			producer.flush()
			time.sleep(1)

def SendEmail(to,subject,text,serviceid):
	#read data from serviceinstance topic
	consumer = KafkaConsumer(str(serviceid),group_id='action_module2',bootstrap_servers=[kafka_platform_ip],auto_offset_reset = "latest")
	print("SendEmail ,action manager reading from ",serviceid)

	for msg in consumer:
		msg = msg.value.decode('utf-8')
		msg = msg.split(' ')
		classroom = msg[0]

		s = smtplib.SMTP('smtp.gmail.com', 587) 
		s.starttls() 
		text = classroom + " " + text
		
		message = 'Subject: {}\n\n{}'.format(subject, text)
		s.login("iastiwari123@gmail.com", "jimmyjimmy")
		to1 = to.split(',')
		for i in to1:
			print("mail sent to ",str(i))
			s.sendmail("iastiwari123@gmail.com", str(i), message) 
		s.quit() 
		print("Mail sent")


def Sendsms(number,message,serviceid):
	consumer = KafkaConsumer(str(serviceid),group_id='action_module2',bootstrap_servers=[kafka_platform_ip],auto_offset_reset = "latest")
	print("Sendsms , action manager reading from ",serviceid)
	for msg in consumer:
		#incoming msg format classroom 1
		msg = msg.value.decode('utf-8')
		msg = msg.split(' ')
		classroom = msg[0]
		message = message + " " + classroom
		print(f'SMS Sent to {number} and msg is {message}')

def getactionmodule(d,servicename):
	l = d['Application']['services'].keys()
	print(l)
	for i in l:
		if(d['Application']['services'][i]['servicename'] == servicename):
			d = d['Application']['services'][i]['action']
			break

	return d

def filter(d):
	for i in d:
		if(d[i]['sensor_name'] == "None"):
			del d[i]['sensor_name']
		if(d[i]['sensor_geolocation']['lat'] == "None" or d[i]['sensor_geolocation']['long'] == "None"):
			del d[i]['sensor_geolocation']
		if(d[i]['sensor_address']['area'] == "None" or d[i]['sensor_address']['building'] == "None" or d[i]['sensor_address']['room_no'] == "None"):
			del d[i]['sensor_address']
	return d

@app.route('/actionmanager' ,methods=['GET' ,'POST'])
def fun():

	#get userid , config file as a request
	data = request.get_json()
	user_id = data['username']
	servicename = data['servicename']
	d = data['config_file']
	serviceid = data['serviceid']
	host_topic = data['sensor_host']

	print(servicename)
	d = getactionmodule(d,servicename)

	for i in d:
		if(i == 'send_output_to_sensor' and d[i]['value'] != "None"):
			
			#get sensor host topic
			sensor_host=[]

			client = MongoClient('localhost' ,27017)
			mydb = client[sensor_client]
			mycol = mydb[sensor_document]
			query = d[i]['sensor']
			query = filter(query)
			for i in query:
				docs = mycol.find(query[i])
				for j in docs:
					sensor_host.append(str(j['sensor_host']['kafka']['kafka_broker_ip']) + " " + str(j['sensor_host']['kafka']['kafka_topic']))
			
			#pass it to thread
			t = threading.Thread( target = send_data_to_sensor, args=(sensor_host,serviceid,))
			t.start()
		
		if(i == 'Output_display_to_user' and d[i] != "None"):
			pass
		
		if(i == 'Send_Email' and d[i]['From'] != "None"):
			to = d['Send_Email']['To']
			subject = d['Send_Email']['Subject']
			text = d['Send_Email']['Text']
			t = threading.Thread( target = SendEmail, args=(to,subject,text,serviceid,))
			t.start()

		if(i == "Send_SMS" and d[i]['number'] != "None"):
			t = threading.Thread( target = Sendsms, args=(d['Send_SMS']['number'],d['Send_SMS']['message'],serviceid,))
			t.start()

	# send temp topic to deployer
	temp = {'ack': 'OK'}
	return temp

if __name__ == '__main__':
   app.run(host="0.0.0.0",port = 5052)
