#!/bin/bash

cd docker

docker-compose -f docker-compose-ca.yaml up -d --remove-orphans
cd ..
sleep 5
source createCertificate.sh
sleep 5