from kafka import KafkaProducer
from kafka.errors import KafkaError
from kafka import KafkaConsumer
import time
import random
import threading 
import sys

import random
import datetime
import matplotlib.pyplot as plt

temperature = []
size = 25
interval = 30

def insert_temp(val):
    if len(temperature) < size:
        temperature.append(val)
    else:
        temperature.pop(0)
        temperature.append(val)

def plot_graph(filepath):
    plt.figure(figsize=(18,6))
    plt.grid(True)
    plt.margins(x=0, y=0)
    intrvl = [-(i)*interval for i in range(len(temperature))]
    intrvl.reverse()
    plt.plot(intrvl, temperature ,marker='s', label='temperature')
    plt.fill_between([min(intrvl),0], 200, max(temperature)+30, facecolor='r', alpha=0.7)
    plt.fill_between([min(intrvl),0], 150, 200, facecolor='orange', alpha=0.7)
    plt.fill_between([min(intrvl),0], 0, 150, facecolor='g', alpha=0.4)
    plt.xticks(intrvl)
    plt.xlabel("Time (in seconds)")
    plt.ylabel("Temperature ("+u'\N{DEGREE SIGN}'+"F)")
    now = datetime.datetime.now()
    plt.text(-6*interval, 5, "Note : time 0 refers to timestamp given in title.", fontsize=12)
    plt.title("Temperature plot:"+" "+now.strftime("%H:%M:%S %d-%m-%Y"))
    plt.legend()
    plt.savefig(filepath)


def main():
	global insert_temp
	temp_topic = sys.argv[1]
	output_topic = sys.argv[2]
	consumer = KafkaConsumer(str(temp_topic),bootstrap_servers=['127.0.0.1:9092'],auto_offset_reset = "latest")
	producer = KafkaProducer(bootstrap_servers=['127.0.0.1:9092'])
	count = 0
	for message in consumer:
		s = message.value.decode('utf-8')
		temp = s.split(' ')
		temprature = int(temp[1])
		print("fire alaram algo getting ",s)
		insert_temp(int(temprature))
		if int(temprature) > 200:
			count = count + 1
			print('Fire Alarm temperature exceed 200')
			msg = str(temp[0]) + " " + str(temprature)
			producer.send(str(output_topic), bytes(str(msg),"utf-8"))
			producer.flush()
			time.sleep(3)
			path = "/home/" + str(count) + ".png"
			plot_graph(path)


if __name__ == '__main__':
	main()