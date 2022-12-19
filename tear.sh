#!/bin/bash

docker stop $( docker ps -aq )
docker rm $( docker ps -aq )
docker volume  rm $( docker volume ls )
cd consortium
sudo rm -rf fabric-ca
sudo rm -rf crypto-config
cd ..

sudo rm -rf channel-artifacts

