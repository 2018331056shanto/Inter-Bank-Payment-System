#!/bin/bash
# Common Connection Profiles are a file format by which all 
# the Hyperledger Fabric SDKs can use to connect to a Hyperledger Fabric Network

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        ./ccp-template.json
}

function yaml_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        ./ccp-template.yaml | sed -e $'s/\\\\n/\\\n          /g'
}
ORG="bdbank"
P0PORT=1050
CAPORT=1000
PEERPEM=./consortium/crypto-config/peerOrganizations/bdbank/tlsca/tlsca.bdbank-cert.pem
CAPEM=./consortium/crypto-config/peerOrganizations/bdbank/ca/ca.bdbank-cert.pem
echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > ./consortium/crypto-config/peerOrganizations/bdbank/connection-bdbank.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > ./consortium/crypto-config/peerOrganizations/bdbank/connection-bdbank.yaml

ORG="abbank"
P0PORT=2050
CAPORT=2000
PEERPEM=./consortium/crypto-config/peerOrganizations/abbank/tlsca/tlsca.abbank-cert.pem
CAPEM=./consortium/crypto-config/peerOrganizations/abbank/ca/ca.abbank-cert.pem
echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > ./consortium/crypto-config/peerOrganizations/abbank/connection-abbank.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > ./consortium/crypto-config/peerOrganizations/abbank/connection-abbank.yaml


ORG="dbbank"
P0PORT=4050
CAPORT=4000
PEERPEM=./consortium/crypto-config/peerOrganizations/dbbank/tlsca/tlsca.dbbank-cert.pem
CAPEM=./consortium/crypto-config/peerOrganizations/dbbank/ca/ca.dbbank-cert.pem
echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > ./consortium/crypto-config/peerOrganizations/dbbank/connection-dbbank.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > ./consortium/crypto-config/peerOrganizations/dbbank/connection-dbbank.yaml



ORG="islamibank"
P0PORT=3050
CAPORT=3000
PEERPEM=./consortium/crypto-config/peerOrganizations/islamibank/tlsca/tlsca.islamibank-cert.pem
CAPEM=./consortium/crypto-config/peerOrganizations/islamibank/ca/ca.islamibank-cert.pem
echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > ./consortium/crypto-config/peerOrganizations/islamibank/connection-islamibank.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > ./consortium/crypto-config/peerOrganizations/islamibank/connection-islamibank.yaml


ORG="krishibank"
P0PORT=5050
CAPORT=5000
PEERPEM=./consortium/crypto-config/peerOrganizations/krishibank/tlsca/tlsca.krishibank-cert.pem
CAPEM=./consortium/crypto-config/peerOrganizations/krishibank/ca/ca.krishibank-cert.pem
echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > ./consortium/crypto-config/peerOrganizations/krishibank/connection-krishibank.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > ./consortium/crypto-config/peerOrganizations/krishibank/connection-krishibank.yaml


