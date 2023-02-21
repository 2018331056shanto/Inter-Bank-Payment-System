#!/bin/bash

cd ./docker/
docker-compose -f docker-compose-ca.yaml stop
docker-compose stop
docker-compose -f docker-compose-ca.yaml down -v

docker-compose -f docker-compose-net.yaml down -v

docker container stop $( docker container ls -aq )
docker volume  rm $( docker volume ls -aq )
cd ..
cd consortium
sudo rm -rf fabric-ca
sudo rm -rf crypto-config
cd ..
sudo rm -rf api/networkConfig/*
sudo rm -rf channel-artifacts
sudo rm -rf api/abbank-wallet/*
sudo rm -rf api/dbbank-wallet/*
sudo rm -rf api/bdbank-wallet/*
sudo rm -rf api/islamibank-wallet/*
sudo rm -rf api/krishibank-wallet/*

