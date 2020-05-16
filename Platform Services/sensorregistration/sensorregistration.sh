#!/bin/bash
sudo docker build -t sensorregistration:v1 .
#sleep 10
sudo  docker run -d -v ${HOME}:/home --name sensorregistration --net=host sensorregistration:v1
