import kafka
import sys
import datetime
import matplotlib.pyplot as plt


def insert_val(val):
	global ppm_level
	if len(ppm_level) < size:
		ppm_level.append(val)
	else:
		ppm_level.pop(0)
		ppm_level.append(val)

def plot_graph(filepath):
	global ppm_level,size
	plt.figure(figsize=(18,6))
	plt.grid(True)
	plt.margins(x=0, y=0)
	intrvl = [-(i)*interval for i in range(len(ppm_level))]
	intrvl.reverse()
	plt.plot(intrvl, ppm_level ,marker='s', label='CO level')
	plt.fill_between([min(intrvl),0], 80, max(ppm_level)+30, facecolor='r', alpha=0.7)
	plt.fill_between([min(intrvl),0], 60, 80, facecolor='orange', alpha=0.7)
	plt.fill_between([min(intrvl),0], 0, 60, facecolor='g', alpha=0.4)
	plt.xticks(intrvl)
	plt.xlabel("Time (in seconds)")
	plt.ylabel("CO level (in PPM)")
	now = datetime.datetime.now()
	plt.text(-8*interval*len(intrvl)//size, 5, "Note : time 0 refers to timestamp given in title.", fontsize=12)
	plt.title("CO level plot:"+" "+now.strftime("%H:%M:%S %d-%m-%Y"))
	plt.legend()
	plt.savefig(filepath)

def main():
	global cnt
	input_topic = sys.argv[1]
	output_topic = sys.argv[2]
	consumer = kafka.KafkaConsumer(str(input_topic), bootstrap_servers=['127.0.0.1:9092'], auto_offset_reset = "latest")
	producer = kafka.KafkaProducer(bootstrap_servers=['127.0.0.1:9092'])
	for message in consumer:
		data = message.value.decode('utf-8')
		ppm = int(data.split(' ')[1])
		print(data)
		insert_val(ppm)
		producer.send(output_topic, bytes(str(data),"utf-8"))
		if(ppm > 80):
			plot_graph('/home/smit/CO_level_'+str(cnt))
			cnt += 1


ppm_level = []
size = 25
interval = 2
cnt = 1
main()
