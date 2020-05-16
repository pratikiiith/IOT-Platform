import kafka
import random
import time
import sys

def main():
	topic = sys.argv[1]
	producer = kafka.KafkaProducer(bootstrap_servers=['127.0.0.1:9092'])
	while True:
		ppm = random.randrange(1,100)
		data = "Nalgonda " + str(ppm)
		producer.send('airquality2_out', bytearray(data,"utf-8"))
		time.sleep(30)

main()
