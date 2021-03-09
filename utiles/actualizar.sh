#!/bin/bash

mkdir /opt/cuentasWhatsapp/$1
docker cp $1:/whatsapp-connector/session.json /opt/cuentasWhatsapp/$1/session.json
docker stop $1
docker rm $1
docker rename $1 $1-b
docker run --restart=unless-stopped -it -d --name $1 -p ${1:0,-4}:8900 gabrieltandil/whatsapp-connector
docker cp /opt/cuentasWhatsapp/config.json $1:/whatsapp-connector/config.json
docker cp /opt/cuentasWhatsapp/$1/session.json $1:/whatsapp-connector/session.json
docker restart $1

#docker attach $1

