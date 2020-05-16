#!/bin/bash
sudo docker build -t serverlcm:v1 .
#sleep 10
sudo docker run -d -v ${HOME}:/home --name serverlcm --net=host serverlcm:v1
