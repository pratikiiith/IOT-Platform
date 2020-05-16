from kafka import KafkaProducer
from random import randrange
import time
import sys

def main():
	topic = sys.argv[1]
	producer = KafkaProducer(bootstrap_servers=['127.0.0.1:9092'])
	while True:
		num = randrange(10,150)
		msg = 'GJ-' + str(num%30) + ' Warangal ' + str(num)
		print(msg)
		producer.send("speed1_out",bytes(str(msg),"utf-8"))
		time.sleep(30)
main()
