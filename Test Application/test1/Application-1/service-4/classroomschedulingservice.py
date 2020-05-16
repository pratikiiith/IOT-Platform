from kafka import KafkaProducer
from kafka.errors import KafkaError
from kafka import KafkaConsumer
import time
import random
import threading 
import sys

def main():
	temp_topic = sys.argv[1]
	output_topic = sys.argv[2]
	producer = KafkaProducer(bootstrap_servers=['127.0.0.1:9092'])
	consumer = KafkaConsumer(str(temp_topic),bootstrap_servers=['127.0.0.1:9092'],auto_offset_reset = "latest")
	
	for message in consumer:
		s = message.value.decode('utf-8')

		temp = s.split()
		room = temp[0]
		strength = int(temp[1])
		seat = int(temp[2])
		empty = seat - strength
		print(f'{room} : Strength of class is {strength} ,Number of Seat is {seat} ,Empty Seat is {empty}')
		if(empty > 50):
			msg = 'Msg Proff class strength is ' + str(strength) + ' in room ' + str(room)
			msg1 = 'Msg Acad Office empty seats were '  + str(seat) + ' in room ' + str(room)
			msg2 = 'Change classroom to nilgiri_roomno:102'
			if(room == 'nilgiri_roomno:100'):
				msg2 = 'Change classroom to nilgiri_roomno:101'
			else:
				msg2 = 'Change classroom to nilgiri_roomno:100'

			producer.send(str(output_topic), bytes(str(msg),"utf-8"))
			producer.flush() 
			time.sleep(5)
			producer.send(str(output_topic), bytes(str(msg1),"utf-8"))
			producer.flush() 
			time.sleep(5)
			producer.send(str(output_topic), bytes(str(msg2),"utf-8"))
			producer.flush() 
			time.sleep(5)

if __name__ == '__main__':
	main()
