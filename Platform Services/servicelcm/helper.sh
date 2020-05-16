#!/bin/bash

set -euo pipefail
which psql > /dev/null || (echoerr "Please ensure that postgres client is in your PATH" && exit 1)

mkdir -p $HOME/docker/volumes/postgres
rm -rf $HOME/docker/volumes/postgres/data

docker run --rm --name pg-docker --network=host -e POSTGRES_PASSWORD=root -e POSTGRES_DB=ias-db -d -p 5432:5432 -v $HOME/docker/volumes/postgres:/var/lib/postgresql postgres

sleep 15

export PGPASSWORD=root
#psql -U postgres -d dev -h localhost -f schema.sql
#psql -U postgres -d dev -h localhost -f data.sql

psql -U postgres -d ias-db -h localhost -f servicelcm-topology-db.sql

sleep 15

docker run --rm -d --network=host servicelcm-image

sleep 20

docker run --rm -d --network=host -e PYTHONUNBUFFERED=1 topology-image

#docker run -d  -v ${HOME}:/home --name servicelcm --net=host servicelcm-image:latest

#docker run -v ${HOME}:/home  --name topologymanager --net=host topology-image:latest 
