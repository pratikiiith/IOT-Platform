from flask import Flask,request,jsonify
import requests
import sys 
import json
import os
from pymongo import MongoClient

app = Flask(__name__)

#filter sensor incoming request

registry_ip = 'localhost'
registry_port = 27017
collection_name = 'final1'

def filter(d):
	for i in d:
		if(d[i]['sensor_geolocation']['lat'] == "None" or d[i]['sensor_geolocation']['long'] == "None"):
			del d[i]['sensor_geolocation']

	for i in d:
		for j in d[i]:
			if(j=='data_dump'):
				if((d[i][j]['kafka']['broker_ip'] =="None" or d[i][j]['kafka']['topic'] =="None") and (d[i][j]['mongo_db']['ip'] =="None"  or d[i][j]['mongo_db']['passwd'] =="None" or d[i][j]['mongo_db']['document_name'] =="None")):
					print("Data_dump information not given")
				else:
					if(d[i][j]['kafka']['broker_ip'] == "None"):
						del d[i][j]['kafka']
					elif(d[i][j]['mongo_db']['ip'] == "None"):
						del d[i][j]['mongo_db']
			
			elif(j=='sensor_host'):
				if((d[i][j]['socket']['ip'] =="None" or d[i][j]['socket']['port'] =="None") and (d[i][j]['kafka']['kafka_topic'] =="None" or d[i][j]['kafka']['kafka_topic'] =="None")):
					print("sensor_host information not given")
				else:
					if(d[i][j]['socket']['ip'] == "None"):
						del d[i][j]['socket']
					elif(d[i][j]['kafka']['kafka_broker_ip'] == "None"):
						del d[i][j]['kafka']
	return d


@app.route('/getsensordata' ,methods=['GET','POST'])
def fun1():

	global registry_port
	global registry_ip


	data=request.get_json()
	user_id  = data['username']

	client = MongoClient(registry_ip ,registry_port,maxPoolSize=50)
	db = client[collection_name]
	d = list(db['sensor'].find({'user_id':user_id}))
	

	for i in d:
		del i['_id']
		del i['data_dump']
		del i['sensor_data_type']
		del i['sensor_host']
		del i['user_id']

	result= {}
	for i in d:
		key = result.keys()
		if(i['sensor_name'] in key):
			result[i['sensor_name']].append(i['sensor_address'])
		else:
			result[i['sensor_name']] = []
			result[i['sensor_name']].append(i['sensor_address'])
	
	# print(result)

	return jsonify(result)

@app.route('/sensorregistration' ,methods=['GET','POST'])
def fun():
	global registry_port
	global registry_ip


	data=request.get_json()
	d = data['config_file']
	user_id  = data['username']

	for i in d:
		d[i]['user_id'] = user_id
	
	#filter data, if subsection value is none entry will be deleted
	d = filter(d)

	# registry path
	client = MongoClient(registry_ip ,registry_port)

	mydb = client[collection_name]
	mycol = mydb["sensor"]

	print(d)
	for i in d:
		mycol.insert_one(d[i])
	
	ack={'msg':'Sensor Registered'}
	return ack

if __name__ == '__main__':
	app.run(host="0.0.0.0",port=5051)
