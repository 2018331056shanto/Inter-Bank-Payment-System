#!/bin/bash

cd docker
echo "================Bringing up Fabric CA container ===================="
docker-compose -f docker-compose-ca.yaml up -d --remove-orphans
cd ..
echo "===================== Fbric CA Completed===================="
echo " "
sleep 5
echo "==================Generating Certificates================"
source createCertificate.sh
echo "==============Certificate Creation Completed======================"
sleep 5
echo " "
echo "================Generating Channel Artifacts ================="
source createArtifacts.sh
echo "================Channel Artifacts Generation Completed ================="
sleep 5
echo " "
cd docker
echo "===============Bringing up the Network containrs ================"
docker-compose -f docker-compose-net.yaml up -d --remove-orphans

echo "=============Network Container Brought up Successfully======================"
echo " "
cd ..

sleep 5
echo "========================Generating Common Connection Profile ========================"
echo " "
source ccp-generate.sh

echo "=======================CPP generation Successfull================================="
sleep 5
echo "=====================Creating Channel======================================================"
source createChannel.sh
echo "==============================Channel Generation Successfull======================================"
sleep 5



