#!/bin/bash
# Common Connection Profiles are a file format by which all 
# the Hyperledger Fabric SDKs can use to connect to a Hyperledger Fabric Network

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    local PP1=$(one_line_pem $6)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        -e "s#\${PEERPEM1}#$PP1#" \
        -e "s#\${P1PORT}#$7#" \
        ./ccp-template.json
}


function yaml_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    local PP1=$(one_line_pem $6)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        -e "s#\${PEERPEM1}#$PP1#" \
        -e "s#\${P1PORT}#$7#" \
        ./ccp-template.yaml | sed -e $'s/\\\\n/\\\n          /g'
}
ORG="bdbank"
P0PORT=1050
CAPORT=1000
P1PORT=1055
PEERPEM=./consortium/crypto-config/peerOrganizations/bdbank/peers/peer0.bdbank/tls/tlscacerts/tls-localhost-1000-ca-bdbank.pem
PEERPEM1=./consortium/crypto-config/peerOrganizations/bdbank/peers/peer1.bdbank/tls/tlscacerts/tls-localhost-1000-ca-bdbank.pem
CAPEM=./consortium/crypto-config/peerOrganizations/bdbank/tlsca/tlsca.bdbank-cert.pem
echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $PEERPEM1 $P1PORT)" > ./api/networkConfig/connection-bdbank.json
# echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $PEERPEM1 $P1PORT)" > ./api/networkConfig/connection-bdbank.yaml

ORG="abbank"
P0PORT=2050
CAPORT=2000
P1PORT=2055
PEERPEM=./consortium/crypto-config/peerOrganizations/abbank/peers/peer0.abbank/tls/tlscacerts/tls-localhost-2000-ca-abbank.pem
PEERPEM1=./consortium/crypto-config/peerOrganizations/abbank/peers/peer1.abbank/tls/tlscacerts/tls-localhost-2000-ca-abbank.pem
CAPEM=./consortium/crypto-config/peerOrganizations/abbank/tlsca/tlsca.abbank-cert.pem
echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $PEERPEM1 $P1PORT)" > ./api/networkConfig/connection-abbank.json
# echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $PEERPEM1 $P1PORT)" > ./api/networkConfig/connection-abbank.yaml

ORG="dbbank"
P0PORT=4050
CAPORT=4000
P1PORT=4055
PEERPEM=./consortium/crypto-config/peerOrganizations/dbbank/peers/peer0.dbbank/tls/tlscacerts/tls-localhost-4000-ca-dbbank.pem
PEERPEM1=./consortium/crypto-config/peerOrganizations/dbbank/peers/peer1.dbbank/tls/tlscacerts/tls-localhost-4000-ca-dbbank.pem
CAPEM=./consortium/crypto-config/peerOrganizations/dbbank/tlsca/tlsca.dbbank-cert.pem
echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $PEERPEM1 $P1PORT)" > ./api/networkConfig/connection-dbbank.json
# echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $PEERPEM1 $P1PORT)" > ./api/networkConfig/connection-dbbank.yaml



ORG="islamibank"
P0PORT=3050
CAPORT=3000
P1PORT=3055
PEERPEM=./consortium/crypto-config/peerOrganizations/islamibank/peers/peer0.islamibank/tls/tlscacerts/tls-localhost-3000-ca-islamibank.pem
PEERPEM1=./consortium/crypto-config/peerOrganizations/islamibank/peers/peer1.islamibank/tls/tlscacerts/tls-localhost-3000-ca-islamibank.pem
CAPEM=./consortium/crypto-config/peerOrganizations/islamibank/tlsca/tlsca.islamibank-cert.pem
echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $PEERPEM1 $P1PORT)" > ./api/networkConfig/connection-islamibank.json
# echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $PEERPEM1 $P1PORT)" > ./api/networkConfig/connection-islamibank.yaml


ORG="krishibank"
P0PORT=5050
CAPORT=5000
P1PORT=5055
PEERPEM=./consortium/crypto-config/peerOrganizations/krishibank/peers/peer0.krishibank/tls/tlscacerts/tls-localhost-5000-ca-krishibank.pem
PEERPEM1=./consortium/crypto-config/peerOrganizations/krishibank/peers/peer1.krishibank/tls/tlscacerts/tls-localhost-5000-ca-krishibank.pem
CAPEM=./consortium/crypto-config/peerOrganizations/krishibank/tlsca/tlsca.krishibank-cert.pem
echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $PEERPEM1 $P1PORT)" > ./api/networkConfig/connection-krishibank.json
# echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $PEERPEM1 $P1PORT)" > ./api/networkConfig/connection-krishibank.yaml


