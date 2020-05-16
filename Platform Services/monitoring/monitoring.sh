#!/bin/bash
sudo docker build -t monitoring:v1 .
#sleep 10
sudo docker run -d -v ${HOME}:/home --name monitoring --net=host monitoring:v1
