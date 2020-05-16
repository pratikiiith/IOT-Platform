#!/bin/bash
sudo docker build -t scheduler:v1 .
#sleep 10
sudo docker run -d -v ${HOME}:/home --name scheduler --net=host scheduler:v1
