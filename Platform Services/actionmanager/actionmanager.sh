#!/bin/bash
sudo docker build -t actionmanager:v1 .
sudo docker run -d -v ${HOME}:/home --name actionmanager --net=host actionmanager:v1
