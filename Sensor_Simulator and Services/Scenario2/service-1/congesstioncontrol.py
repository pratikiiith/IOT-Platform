from kafka import KafkaProducer
from kafka.errors import KafkaError
from kafka import KafkaConsumer
import sys

def main():
	temp_topic = sys.argv[1]
	output_topic = sys.argv[2]
	consumer = KafkaConsumer(str(temp_topic),bootstrap_servers=['127.0.0.1:9092'],auto_offset_reset = "latest")
	producer = KafkaProducer(bootstrap_servers=['127.0.0.1:9092'])
	for message in consumer:
		s = message.value.decode('utf-8')
		no_of_people = int(s.split(' ')[1])
		print(s)
		if(no_of_people > 80):
			producer.send(output_topic, bytes(str(message),"utf-8"))

main()
