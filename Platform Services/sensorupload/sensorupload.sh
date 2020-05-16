#!/bin/bash
sudo docker build -t sensorupload:v1 .
#sleep 10
sudo docker run -d  -v ${HOME}:/home --name sensorupload --net=host sensorupload:v1
