export PATH=${PWD}/bin:$PATH
export FABRIC_CFG_PATH=${PWD}/config
export ORDERER_CA=${PWD}/consortium/crypto-config/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem

export CORE_PEER_TLS_ROOTCERT_FILE_ABBANK=${PWD}/consortium/crypto-config/peerOrganizations/abbank/peers/peer0.abbank/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE_BDBANK=${PWD}/consortium/crypto-config/peerOrganizations/bdbank/peers/peer0.bdbank/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE_DBBANK=${PWD}/consortium/crypto-config/peerOrganizations/dbbank/peers/peer0.dbbank/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE_ISLAMIBANK=${PWD}/consortium/crypto-config/peerOrganizations/islamibank/peers/peer0.islamibank/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE_KRISHIBANK=${PWD}/consortium/crypto-config/peerOrganizations/krishibank/peers/peer0.krishibank/tls/ca.crt


CHANNEL_NAME="netting-channel"
CHAINCODE_NAME="netting_cc"
CHAINCODE_VERSION="1.0"
CHAINCODE_PATH="./chaincode/test/go"
CHAINCODE_LABEL="netting"
CHAINCODE_LANG="golang"

setEnvForBdbank() {
    export CORE_PEER_TLS_ENABLED=true
    export CORE_PEER_LOCALMSPID=bdbankMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/consortium/crypto-config/peerOrganizations/bdbank/peers/peer0.bdbank/tls/ca.crt
    export CORE_PEER_MSPCONFIGPATH=${PWD}/consortium/crypto-config/peerOrganizations/bdbank/users/Admin@bdbank/msp
    export CORE_PEER_ADDRESS=localhost:1050
}

setEnvForAbbank() {
    export CORE_PEER_TLS_ENABLED=true
    export CORE_PEER_LOCALMSPID=abbankMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/consortium/crypto-config/peerOrganizations/abbank/peers/peer0.abbank/tls/ca.crt
    export CORE_PEER_MSPCONFIGPATH=${PWD}/consortium/crypto-config/peerOrganizations/abbank/users/Admin@abbank/msp
    export CORE_PEER_ADDRESS=localhost:2050
}

setEnvForDbbank() {
    export CORE_PEER_TLS_ENABLED=true
    export CORE_PEER_LOCALMSPID=dbbankMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/consortium/crypto-config/peerOrganizations/dbbank/peers/peer0.dbbank/tls/ca.crt
    export CORE_PEER_MSPCONFIGPATH=${PWD}/consortium/crypto-config/peerOrganizations/dbbank/users/Admin@dbbank/msp
    export CORE_PEER_ADDRESS=localhost:4050
}

setEnvForIslamibank() {
    export CORE_PEER_TLS_ENABLED=true
    export CORE_PEER_LOCALMSPID=islamibankMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/consortium/crypto-config/peerOrganizations/islamibank/peers/peer0.islamibank/tls/ca.crt
    export CORE_PEER_MSPCONFIGPATH=${PWD}/consortium/crypto-config/peerOrganizations/islamibank/users/Admin@islamibank/msp
    export CORE_PEER_ADDRESS=localhost:3050
}

setEnvForKrishibank() {
    export CORE_PEER_TLS_ENABLED=true
    export CORE_PEER_LOCALMSPID=krishibankMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/consortium/crypto-config/peerOrganizations/krishibank/peers/peer0.krishibank/tls/ca.crt
    export CORE_PEER_MSPCONFIGPATH=${PWD}/consortium/crypto-config/peerOrganizations/krishibank/users/Admin@krishibank/msp
    export CORE_PEER_ADDRESS=localhost:5050
}

packageChaincode() {
    rm -rf ${CHAINCODE_NAME}.tar.gz
    setEnvForAbbank
    echo Green "========== Packaging Chaincode on Peer0 ABbank =========="
    peer lifecycle chaincode package ${CHAINCODE_NAME}.tar.gz --path ${CHAINCODE_PATH} --lang ${CHAINCODE_LANG} --label ${CHAINCODE_LABEL}
    echo ""
    echo Green "========== Packaging Chaincode on Peer0 ABbank Successful =========="
    echo ""
}

installChaincode() {
    setEnvForAbbank
    echo "========== Installing Chaincode on Peer0 ABbank =========="
    # peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz 
    echo Green "========== Installed Chaincode on Peer0 ABbank =========="
    echo ""

    setEnvForBdbank
    echo Green "========== Installing Chaincode on Peer0 BDbank =========="
    # peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:9051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz
    echo Green "========== Installed Chaincode on peer0 BDbank =========="
    echo ""

    setEnvForDbbank
    echo Green "========== Installing Chaincode on Peer0 Org3 =========="
    # peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:11051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz
    echo Green "========== Installed Chaincode on Peer0 DBbank =========="
    echo ""

    setEnvForIslamibank
    echo "========== Installing Chaincode on Peer0 Islamibank =========="
    # peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz 
    echo Green "========== Installed Chaincode on Peer0 Islamibank =========="
    echo ""

    setEnvForKrishibank
    echo Green "========== Installing Chaincode on Peer0 Krishibank =========="
    # peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:9051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz
    echo Green "========== Installed Chaincode on peer0 Krishibank =========="
    echo ""
}


queryInstalledChaincode() {
    setEnvForAbbank
    echo Green "========== Querying Installed Chaincode on Peer0 org1=========="
    peer lifecycle chaincode queryinstalled --peerAddresses localhost:2050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE} >&log.txt
    cat log.txt
    PACKAGE_ID=$(sed -n "/${CHAINCODE_LABEL}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
    echo Yellow "PackageID is ${PACKAGE_ID}"
    echo Green "========== Query Installed Chaincode Successful on Peer0 ABbank=========="
    echo ""
}

approveChaincodeByBDbank() {
    setEnvForBdbank
    echo Green "========== Approve Installed Chaincode by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed Chaincode Successful by Peer0 org1 =========="
    echo ""
}

checkCommitReadynessForBDbank() {
    setEnvForBdbank
    echo Green "========== Check Commit Readiness of Installed Chaincode on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed Chaincode Successful on Peer0 org1 =========="
    echo ""
}


approveChaincodeByABbank() {
    setEnvForAbbank
    echo Green "========== Approve Installed Chaincode by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed Chaincode Successful by Peer0 org1 =========="
    echo ""
}

checkCommitReadynessForABbank() {
    setEnvForAbbank
    echo Green "========== Check Commit Readiness of Installed Chaincode on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed Chaincode Successful on Peer0 org1 =========="
    echo ""
}
approveChaincodeByDBbank() {
    setEnvForDbbank
    echo Green "========== Approve Installed Chaincode by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed Chaincode Successful by Peer0 org1 =========="
    echo ""
}

checkCommitReadynessForDBbank() {
    setEnvForDbbank
    echo Green "========== Check Commit Readiness of Installed Chaincode on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed Chaincode Successful on Peer0 org1 =========="
    echo ""
}

approveChaincodeByIslamibank() {
    setEnvForIslamibank
    echo Green "========== Approve Installed Chaincode by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed Chaincode Successful by Peer0 org1 =========="
    echo ""
}

checkCommitReadynessForIslamibank() {
    setEnvForIslamibank
    echo Green "========== Check Commit Readiness of Installed Chaincode on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed Chaincode Successful on Peer0 org1 =========="
    echo ""
}

approveChaincodeByKrishibank() {
    setEnvForKrishibank
    echo Green "========== Approve Installed Chaincode by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed Chaincode Successful by Peer0 org1 =========="
    echo ""
}

checkCommitReadynessForKrishibank() {
    setEnvForKrishibank
    echo Green "========== Check Commit Readiness of Installed Chaincode on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed Chaincode Successful on Peer0 org1 =========="
    echo ""
}

commitChaincode() {
    setEnvForBdbank
    echo Green "========== Commit Installed Chaincode on ${CHANNEL_NAME} =========="
    peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME} --name ${CHAINCODE_NAME} --peerAddresses localhost:1050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_BDBANK} --peerAddresses localhost:2050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ABBANK} --peerAddresses localhost:3050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ISLAMIBANK}  --peerAddresses localhost:4050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_DBBANK} --peerAddresses localhost:5050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_KRISHIBANK} --version ${CHAINCODE_VERSION} --sequence 1 --init-required
    echo Green "========== Commit Installed Chaincode on ${CHANNEL_NAME} Successful =========="
    echo ""
}


queryCommittedChaincode() {
    setEnvForBdbank
    echo Green "========== Query Committed Chaincode on ${CHANNEL_NAME} =========="
    peer lifecycle chaincode querycommitted --channelID ${CHANNEL_NAME} --name ${CHAINCODE_NAME}
    echo Green "========== Query Committed Chaincode on ${CHANNEL_NAME} Successful =========="
    echo ""
}

getInstalledChaincode() {
    setEnvForBdbank
    echo Green "========== Get Installed Chaincode from Peer0 org1 =========="
    peer lifecycle chaincode getinstalledpackage --package-id ${PACKAGE_ID} --output-directory . --peerAddresses localhost:1050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    echo Green "========== Get Installed Chaincode from Peer0 org1 Successful =========="
    echo ""
}

queryApprovedChaincode() {
    setEnvForBdbank
    echo Green "========== Query Approved of Installed Chaincode on Peer0 org1 =========="
    peer lifecycle chaincode queryapproved -C ${CHANNEL_NAME} -n ${CHAINCODE_NAME} --sequence 1 
    echo Green "========== Query Approved of Installed Chaincode on Peer0 org1 Successful =========="
    echo ""
}
initChaincode() {
    setEnvForBdbank
    echo Green "========== Init Chaincode on Peer0 org1 ========== "
    peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} -C ${CHANNEL_NAME} -n ${CHAINCODE_NAME} --peerAddresses localhost:1050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_BDBANK} --peerAddresses localhost:2050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ABBANK} --peerAddresses localhost:3050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ISLAMIBANK}  --peerAddresses localhost:4050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_DBBANK}  --peerAddresses localhost:5050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_KRISHIBANK} --isInit -c '{"Args":[]}'
    echo Green "========== Init Chaincode on Peer0 org1 Successful ========== "
    echo ""
}

chaincodeInvoke() {

    echo "-------------------- Chaincode Invoke --------------------"

    setEnvForBdbank

    ## Init ledger
    peer chaincode invoke -o localhost:7050 \
        --ordererTLSHostnameOverride orderer.example.com \
        --tls ${CORE_PEER_TLS_ENABLED} \
        --cafile ${ORDERER_CA} \
        -C ${CHANNEL_NAME} -n ${CHAINCODE_NAME} \
        --peerAddresses localhost:1050 \
        --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_BDBANK} \
        --peerAddresses localhost:2050 \
        --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ABBANK} \
        --peerAddresses localhost:3050 \
        --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ISLAMIBANK} \
          --peerAddresses localhost:4050 \
        --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_DBBANK} \
        --peerAddresses localhost:5050 \
        --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_KRISHIBANK} \
        -c '{"function": "initLedger","Args":[]}'
    echo " -- : Done : --"
    echo ""
}


chaincodeQuery() {

    echo "-------------------- Chaincode Query --------------------"
    setEnvForBdbank

    peer chaincode query -C ${CHANNEL_NAME} -n ${CHAINCODE_NAME} \
    -c '{"function": "queryPersonInfo","Args":["01"]}'

    echo " -- : Done : --"
    echo ""
    

}
hello() {

    echo "------------------------new invokation-------------------"
      setEnvForBdbank
    peer chaincode query -C ${CHANNEL_NAME} -n ${CHAINCODE_NAME} \
    -c '{"function":"addPersonInfo","Args":["03","Rahim","Dhaka","approved"]}'


    echo " -- : Done : --"
    echo ""
}



packageChaincode
installChaincode
queryInstalledChaincode
approveChaincodeByBDbank
checkCommitReadynessForBDbank
approveChaincodeByABbank
checkCommitReadynessForABbank
approveChaincodeByDBbank
checkCommitReadynessForDBbank
approveChaincodeByIslamibank
checkCommitReadynessForIslamibank
approveChaincodeByKrishibank
checkCommitReadynessForKrishibank
commitChaincode
queryCommittedChaincode
getInstalledChaincode
queryApprovedChaincode
initChaincode
sleep 5
chaincodeInvoke
sleep 5
chaincodeQuery
sleep 5
hello