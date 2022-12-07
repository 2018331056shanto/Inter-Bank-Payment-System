#!/bin/bash

cd docker

docker-compose -f docker-compose-ca.yaml up -d --remove-orphans
cd ..

source createCertificate.sh