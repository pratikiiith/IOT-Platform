#!/bin/bash
sudo docker build -t sensormanager:v1 .
#sleep 10
sudo docker run -d -v ${HOME}:/home --name sensormanager --net=host sensormanager:v1
