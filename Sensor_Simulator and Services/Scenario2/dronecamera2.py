from kafka import KafkaProducer
from random import randrange
import time
import sys

def main():
	topic = sys.argv[1]
	producer = KafkaProducer(bootstrap_servers=['127.0.0.1:9092'])
	while True:
		num = randrange(1,100)
		msg = "Nalgonda "+str(num)
		producer.send("drone2_out",bytes(str(msg),"utf-8"))
		producer.flush()
		time.sleep(30)

main()
