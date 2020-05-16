#!/bin/bash
sudo docker build -t requestmanager:v1 .
sleep 10
sudo docker run -d -v ${HOME}:/home --name requestmanager --net=host requestmanager:v1
