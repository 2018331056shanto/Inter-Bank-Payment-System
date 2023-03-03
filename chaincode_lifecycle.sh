export PATH=${PWD}/bin:$PATH
export FABRIC_CFG_PATH=${PWD}/config
export ORDERER_CA=${PWD}/consortium/crypto-config/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem

export CORE_PEER_TLS_ROOTCERT_FILE_ABBANK=${PWD}/consortium/crypto-config/peerOrganizations/abbank/peers/peer0.abbank/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE_BDBANK=${PWD}/consortium/crypto-config/peerOrganizations/bdbank/peers/peer0.bdbank/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE_DBBANK=${PWD}/consortium/crypto-config/peerOrganizations/dbbank/peers/peer0.dbbank/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE_ISLAMIBANK=${PWD}/consortium/crypto-config/peerOrganizations/islamibank/peers/peer0.islamibank/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE_KRISHIBANK=${PWD}/consortium/crypto-config/peerOrganizations/krishibank/peers/peer0.krishibank/tls/ca.crt


CHANNEL_NAME1="netting-channel"
CHAINCODE_NAME1="netting_cc"
# CHAINCODE_PATH1="./chaincode1/nettingchannel"
CHAINCODE_PATH1="./chaincode/test/go"
CHAINCODE_LABEL1="netting"

CHANNEL_NAME2="funding-channel"
CHAINCODE_NAME2="funding_cc"
# CHAINCODE_PATH2="./chaincode1/fundingchannel"
CHAINCODE_PATH2="./chaincode/test/go"

CHAINCODE_LABEL2="funding"

CHAINCODE_NAME3="bilateral_cc"
# CHAINCODE_PATH3="./chaincode1/bilateralchannel"
CHAINCODE_PATH3="./chaincode/test/go"

CHAINCODE_LABEL3="bilateral"


CHAINCODE_LANG="golang"
CHAINCODE_VERSION1="1.0"
CHAINCODE_VERSION2="2.0"
CHAINCODE_VERSION3="3.0"




CHANNEL_NAME3="islamibank-abbank-channel"
CHANNEL_NAME4="islamibank-dbbank-channel"
CHANNEL_NAME5="islamibank-krishibank-channel"
CHANNEL_NAME6="abbank-dbbank-channel"
CHANNEL_NAME7="abbank-krishibank-channel"
CHANNEL_NAME8="dbbank-krishibank-channel"




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
    rm -rf ${CHAINCODE_NAME1}.tar.gz
    rm -rf ${CHAINCODE_NAME2}.tar.gz
    rm -rf ${CHAINCODE_NAME3}.tar.gz
    setEnvForAbbank
    echo Green "========== Packaging ${CHAINCODE_NAME1} on Peer0 ABbank =========="
    peer lifecycle chaincode package ${CHAINCODE_NAME1}.tar.gz --path ${CHAINCODE_PATH1} --lang ${CHAINCODE_LANG} --label ${CHAINCODE_LABEL1}
    echo ""
    echo Green "========== Packaging ${CHAINCODE_NAME1} on Peer0 ABbank Successful =========="
    echo ""


    setEnvForAbbank
    echo Green "========== Packaging ${CHAINCODE_NAME2} on Peer0 ABbank =========="
    peer lifecycle chaincode package ${CHAINCODE_NAME2}.tar.gz --path ${CHAINCODE_PATH2} --lang ${CHAINCODE_LANG} --label ${CHAINCODE_LABEL2}
    echo ""
    echo Green "========== Packaging ${CHAINCODE_NAME2} on Peer0 ABbank Successful =========="
    echo ""

    setEnvForAbbank
    echo Green "========== Packaging ${CHAINCODE_NAME3} on Peer0 ABbank =========="
    peer lifecycle chaincode package ${CHAINCODE_NAME3}.tar.gz --path ${CHAINCODE_PATH3} --lang ${CHAINCODE_LANG} --label ${CHAINCODE_LABEL3}
    echo ""
    echo Green "========== Packaging ${CHAINCODE_NAME3} on Peer0 ABbank Successful =========="
    echo ""
}

installChaincode() {
    setEnvForAbbank
    echo "========== Installing ${CHAINCODE_NAME1} on Peer0 ABbank =========="
    # peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    peer lifecycle chaincode install ${CHAINCODE_NAME1}.tar.gz 
    echo Green "========== Installed ${CHAINCODE_NAME1} on Peer0 ABbank =========="
    echo ""

    setEnvForAbbank
    echo "========== Installing ${CHAINCODE_NAME2} on Peer0 ABbank =========="
    # peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    peer lifecycle chaincode install ${CHAINCODE_NAME2}.tar.gz 
    echo Green "========== Installed ${CHAINCODE_NAME2} on Peer0 ABbank =========="
    echo ""

    setEnvForAbbank
    echo "========== Installing ${CHAINCODE_NAME3} on Peer0 ABbank =========="
    # peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    peer lifecycle chaincode install ${CHAINCODE_NAME3}.tar.gz 
    echo Green "========== Installed ${CHAINCODE_NAME3} on Peer0 ABbank =========="
    echo ""

    setEnvForBdbank
    echo Green "========== Installing ${CHAINCODE_NAME1} on Peer0 BDbank =========="
    # peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:9051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    peer lifecycle chaincode install ${CHAINCODE_NAME1}.tar.gz
    echo Green "========== Installed ${CHAINCODE_NAME1} on peer0 BDbank =========="
    echo ""

     setEnvForBdbank
    echo Green "========== Installing ${CHAINCODE_NAME2} on Peer0 BDbank =========="
    # peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:9051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    peer lifecycle chaincode install ${CHAINCODE_NAME2}.tar.gz
    echo Green "========== Installed ${CHAINCODE_NAME2} on peer0 BDbank =========="
    echo ""

     setEnvForBdbank
    echo Green "========== Installing ${CHAINCODE_NAME3} on Peer0 BDbank =========="
    # peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:9051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    peer lifecycle chaincode install ${CHAINCODE_NAME3}.tar.gz
    echo Green "========== Installed ${CHAINCODE_NAME3} on peer0 BDbank =========="
    echo ""

    setEnvForDbbank
    echo Green "========== Installing ${CHAINCODE_NAME1} on Peer0 Org3 =========="
    # peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:11051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    peer lifecycle chaincode install ${CHAINCODE_NAME1}.tar.gz
    echo Green "========== Installed ${CHAINCODE_NAME1} on Peer0 DBbank =========="
    echo ""

     setEnvForDbbank
    echo Green "========== Installing ${CHAINCODE_NAME2} on Peer0 Org3 =========="
    # peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:11051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    peer lifecycle chaincode install ${CHAINCODE_NAME2}.tar.gz
    echo Green "========== Installed ${CHAINCODE_NAME2} on Peer0 DBbank =========="
    echo ""

     setEnvForDbbank
    echo Green "========== Installing ${CHAINCODE_NAME3} on Peer0 Org3 =========="
    # peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:11051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    peer lifecycle chaincode install ${CHAINCODE_NAME3}.tar.gz
    echo Green "========== Installed ${CHAINCODE_NAME3} on Peer0 DBbank =========="
    echo ""

    setEnvForIslamibank
    echo "========== Installing ${CHAINCODE_NAME1} on Peer0 Islamibank =========="
    # peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    peer lifecycle chaincode install ${CHAINCODE_NAME1}.tar.gz 
    echo Green "========== Installed ${CHAINCODE_NAME1} on Peer0 Islamibank =========="
    echo ""

     setEnvForIslamibank
    echo "========== Installing ${CHAINCODE_NAME2} on Peer0 Islamibank =========="
    # peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    peer lifecycle chaincode install ${CHAINCODE_NAME2}.tar.gz 
    echo Green "========== Installed ${CHAINCODE_NAME2} on Peer0 Islamibank =========="
    echo ""

     setEnvForIslamibank
    echo "========== Installing ${CHAINCODE_NAME3} on Peer0 Islamibank =========="
    # peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    peer lifecycle chaincode install ${CHAINCODE_NAME3}.tar.gz 
    echo Green "========== Installed ${CHAINCODE_NAME3} on Peer0 Islamibank =========="
    echo ""

    setEnvForKrishibank
    echo Green "========== Installing ${CHAINCODE_NAME1} on Peer0 Krishibank =========="
    # peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:9051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    peer lifecycle chaincode install ${CHAINCODE_NAME1}.tar.gz
    echo Green "========== Installed ${CHAINCODE_NAME1} on peer0 Krishibank =========="
    echo ""

     setEnvForKrishibank
    echo Green "========== Installing ${CHAINCODE_NAME2} on Peer0 Krishibank =========="
    # peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:9051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    peer lifecycle chaincode install ${CHAINCODE_NAME2}.tar.gz
    echo Green "========== Installed ${CHAINCODE_NAME2} on peer0 Krishibank =========="
    echo ""

     setEnvForKrishibank
    echo Green "========== Installing ${CHAINCODE_NAME3} on Peer0 Krishibank =========="
    # peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:9051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    peer lifecycle chaincode install ${CHAINCODE_NAME3}.tar.gz
    echo Green "========== Installed ${CHAINCODE_NAME3} on peer0 Krishibank =========="
    echo ""
}


queryInstalledChaincode() {
    setEnvForAbbank
    echo Green "========== Querying Installed Chaincode on Peer0 org1=========="
    peer lifecycle chaincode queryinstalled --peerAddresses localhost:2050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE} >&log.txt
    cat log.txt
    PACKAGE_ID=$(sed -n "/${CHAINCODE_LABEL1}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
    echo Yellow "PackageID is ${PACKAGE_ID}"
    echo Green "========== Query Installed Chaincode Successful on Peer0 ABbank=========="
    echo ""

      setEnvForAbbank
    echo Green "========== Querying Installed Chaincode on Peer0 org1=========="
    peer lifecycle chaincode queryinstalled --peerAddresses localhost:2050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE} >&log.txt
    cat log.txt
    PACKAGE_ID=$(sed -n "/${CHAINCODE_LABEL2}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
    echo Yellow "PackageID is ${PACKAGE_ID}"
    echo Green "========== Query Installed Chaincode Successful on Peer0 ABbank=========="
    echo ""

      setEnvForAbbank
    echo Green "========== Querying Installed Chaincode on Peer0 org1=========="
    peer lifecycle chaincode queryinstalled --peerAddresses localhost:2050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE} >&log.txt
    cat log.txt
    PACKAGE_ID=$(sed -n "/${CHAINCODE_LABEL3}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
    echo Yellow "PackageID is ${PACKAGE_ID}"
    echo Green "========== Query Installed Chaincode Successful on Peer0 ABbank=========="
    echo ""
    echo "==============================Query installed BDBANK==============================="

     setEnvForBbbank
    echo Green "========== Querying Installed Chaincode on Peer0 org1=========="
    peer lifecycle chaincode queryinstalled --peerAddresses localhost:2050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE} >&log.txt
    cat log.txt
    PACKAGE_ID=$(sed -n "/${CHAINCODE_LABEL1}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
    echo Yellow "PackageID is ${PACKAGE_ID}"
    echo Green "========== Query Installed Chaincode Successful on Peer0 ABbank=========="
    echo ""

      setEnvForBbbank
    echo Green "========== Querying Installed Chaincode on Peer0 org1=========="
    peer lifecycle chaincode queryinstalled --peerAddresses localhost:2050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE} >&log.txt
    cat log.txt
    PACKAGE_ID=$(sed -n "/${CHAINCODE_LABEL2}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
    echo Yellow "PackageID is ${PACKAGE_ID}"
    echo Green "========== Query Installed Chaincode Successful on Peer0 ABbank=========="
    echo ""

      setEnvForBbbank
    echo Green "========== Querying Installed Chaincode on Peer0 org1=========="
    peer lifecycle chaincode queryinstalled --peerAddresses localhost:2050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE} >&log.txt
    cat log.txt
    PACKAGE_ID=$(sed -n "/${CHAINCODE_LABEL3}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
    echo Yellow "PackageID is ${PACKAGE_ID}"
    echo Green "========== Query Installed Chaincode Successful on Peer0 ABbank=========="
    echo ""
}

approveChaincodeByBDbank() {
    setEnvForBdbank
    echo Green "========== Approve Installed ${CHAINCODE_NAME1} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME1} --name ${CHAINCODE_NAME1} --version ${CHAINCODE_VERSION1} --package-id ${PACKAGE_ID} --sequence 1 --init-required 
    # --signature-policy "OR('abbankMSP.member','bdbankMSP.member','dbbankMSP.member','islamibankMSP.member','krishibankMSP.member')" --collections-config ./collections_config.json
    echo Green "========== Approve Installed ${CHAINCODE_NAME1} Successful by Peer0 org1 =========="
    echo ""   

    setEnvForBdbank
    echo Green "========== Approve Installed ${CHAINCODE_NAME2} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME2} --name ${CHAINCODE_NAME2} --version ${CHAINCODE_VERSION2} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHAINCODE_NAME2} Successful by Peer0 org1 =========="
    echo ""  

    setEnvForBdbank
    echo Green "========== Approve Installed ${CHANNEL_NAME3} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME3} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHAINCODE_NAME3} Successful by Peer0 org1 =========="
    echo "" 

   setEnvForBdbank
    echo Green "========== Approve Installed ${CHANNEL_NAME4} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME4} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHANNEL_NAME4} Successful by Peer0 org1 =========="
    echo ""

    setEnvForBdbank
    echo Green "========== Approve Installed ${CHANNEL_NAME5} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME5} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHANNEL_NAME5} Successful by Peer0 org1 =========="
    echo ""

    setEnvForBdbank
    echo Green "========== Approve Installed ${CHANNEL_NAME6} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME6} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHANNEL_NAME6} Successful by Peer0 org1 =========="
    echo ""

    setEnvForBdbank
    echo Green "========== Approve Installed ${CHANNEL_NAME7} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME7} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHANNEL_NAME7} Successful by Peer0 org1 =========="
    echo ""

    setEnvForBdbank
    echo Green "========== Approve Installed ${CHANNEL_NAME8} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME8} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHANNEL_NAME8} Successful by Peer0 org1 =========="
    echo ""

  
}

checkCommitReadynessForBDbank() {
    setEnvForBdbank
    echo Green "========== Check Commit Readiness of Installed ${CHAINCODE_NAME1} on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME1} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME1} --version ${CHAINCODE_VERSION1} --sequence 1 --output json --init-required 
    # --signature-policy "OR('abbankMSP.member','bdbankMSP.member','dbbankMSP.member','islamibankMSP.member','krishibankMSP.member')" --collections-config ./collections_config.json

    echo Green "========== Check Commit Readiness of Installed ${CHAINCODE_NAME1} Successful on Peer0 org1 =========="
    echo ""

     setEnvForBdbank
    echo Green "========== Check Commit Readiness of Installed ${CHAINCODE_NAME2} on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME2} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME2} --version ${CHAINCODE_VERSION2} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed ${CHAINCODE_NAME2} Successful on Peer0 org1 =========="
    echo ""

}


approveChaincodeByABbank() {
    setEnvForAbbank
    echo Green "========== Approve Installed ${CHAINCODE_NAME1} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME1} --name ${CHAINCODE_NAME1} --version ${CHAINCODE_VERSION1} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHAINCODE_NAME1} Successful by Peer0 org1 =========="
    echo ""

    setEnvForAbbank
    echo Green "========== Approve Installed ${CHAINCODE_NAME2} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME2} --name ${CHAINCODE_NAME2} --version ${CHAINCODE_VERSION2} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHAINCODE_NAME2} Successful by Peer0 org1 =========="
    echo ""

    setEnvForAbbank
    echo Green "========== Approve Installed ${CHAINCODE_NAME3} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME3} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHAINCODE_NAME3} Successful by Peer0 org1 =========="
    echo ""

    setEnvForAbbank
    echo Green "========== Approve Installed ${CHANNEL_NAME6} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME6} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHANNEL_NAME6} Successful by Peer0 org1 =========="
    echo ""


    setEnvForAbbank
    echo Green "========== Approve Installed ${CHANNEL_NAME7} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME7} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHANNEL_NAME7} Successful by Peer0 org1 =========="
    echo ""

    
}

checkCommitReadynessForABbank() {
    setEnvForAbbank
    echo Green "========== Check Commit Readiness of Installed ${CHAINCODE_NAME1} on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME1} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME1} --version ${CHAINCODE_VERSION1} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed ${CHAINCODE_NAME1} Successful on Peer0 org1 =========="
    echo ""

    setEnvForAbbank
    echo Green "========== Check Commit Readiness of Installed ${CHAINCODE_NAME2} on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME2} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME2} --version ${CHAINCODE_VERSION2} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed ${CHAINCODE_NAME2} Successful on Peer0 org1 =========="
    echo ""

    setEnvForAbbank
    echo Green "========== Check Commit Readiness of Installed ${CHAINCODE_NAME3} on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME3} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed ${CHAINCODE_NAME3} Successful on Peer0 org1 =========="
    echo ""

    setEnvForAbbank
    echo Green "========== Check Commit Readiness of Installed ${CHANNEL_NAME6} on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME6} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed ${CHANNEL_NAME6} Successful on Peer0 org1 =========="
    echo ""

    setEnvForAbbank
    echo Green "========== Check Commit Readiness of Installed ${CHANNEL_NAME7} on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME7} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed ${CHANNEL_NAME7} Successful on Peer0 org1 =========="
    echo ""

}
approveChaincodeByDBbank() {
    setEnvForDbbank
    echo Green "========== Approve Installed ${CHAINCODE_NAME1} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME1} --name ${CHAINCODE_NAME1} --version ${CHAINCODE_VERSION1} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHAINCODE_NAME1} Successful by Peer0 org1 =========="
    echo ""

    setEnvForDbbank
    echo Green "========== Approve Installed ${CHAINCODE_NAME2} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME2} --name ${CHAINCODE_NAME2} --version ${CHAINCODE_VERSION2} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHAINCODE_NAME2} Successful by Peer0 org1 =========="
    echo ""

    setEnvForDbbank
    echo Green "========== Approve Installed ${CHAINCODE_NAME4} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME4} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHAINCODE_NAME4} Successful by Peer0 org1 =========="
    echo ""

     setEnvForDbbank
    echo Green "========== Approve Installed ${CHANNEL_NAME6} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME6} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHANNEL_NAME6} Successful by Peer0 org1 =========="
    echo ""

     setEnvForDbbank
    echo Green "========== Approve Installed ${CHANNEL_NAME8} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME8} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHANNEL_NAME8} Successful by Peer0 org1 =========="
    echo ""

}

checkCommitReadynessForDBbank() {
    setEnvForDbbank
    echo Green "========== Check Commit Readiness of Installed ${CHAINCODE_NAME1} on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME1} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME1} --version ${CHAINCODE_VERSION1} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed ${CHAINCODE_NAME1} Successful on Peer0 org1 =========="
    echo ""

    setEnvForDbbank
    echo Green "========== Check Commit Readiness of Installed ${CHAINCODE_NAME2} on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME2} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME2} --version ${CHAINCODE_VERSION2} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed ${CHAINCODE_NAME2} Successful on Peer0 org1 =========="
    echo ""

     setEnvForDbbank
    echo Green "========== Check Commit Readiness of Installed ${CHANNEL_NAME4} on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME4} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed ${CHANNEL_NAME4} Successful on Peer0 org1 =========="
    echo ""

     setEnvForDbbank
    echo Green "========== Check Commit Readiness of Installed ${CHANNEL_NAME6} on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME6} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed ${CHANNEL_NAME6} Successful on Peer0 org1 =========="
    echo ""

    setEnvForDbbank
    echo Green "========== Check Commit Readiness of Installed ${CHANNEL_NAME8} on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME8} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed ${CHANNEL_NAME8} Successful on Peer0 org1 =========="
    echo ""
}

approveChaincodeByIslamibank() {
    setEnvForIslamibank
    echo Green "========== Approve Installed ${CHAINCODE_NAME1} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME1} --name ${CHAINCODE_NAME1} --version ${CHAINCODE_VERSION1} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHAINCODE_NAME1} Successful by Peer0 org1 =========="
    echo ""

    setEnvForIslamibank
    echo Green "========== Approve Installed ${CHAINCODE_NAME2} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME2} --name ${CHAINCODE_NAME2} --version ${CHAINCODE_VERSION2} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHAINCODE_NAME2} Successful by Peer0 org1 =========="
    echo ""


    setEnvForIslamibank
    echo Green "========== Approve Installed ${CHANNEL_NAME3} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME3} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHANNEL_NAME3} Successful by Peer0 org1 =========="
    echo ""
    
    setEnvForIslamibank
    echo Green "========== Approve Installed ${CHANNEL_NAME4} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME4} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHANNEL_NAME4} Successful by Peer0 org1 =========="
    echo ""

    setEnvForIslamibank
    echo Green "========== Approve Installed ${CHANNEL_NAME5} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME5} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHANNEL_NAME5} Successful by Peer0 org1 =========="
    echo ""
}

checkCommitReadynessForIslamibank() {
    setEnvForIslamibank
    echo Green "========== Check Commit Readiness of Installed ${CHAINCODE_NAME1} on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME1} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME1} --version ${CHAINCODE_VERSION1} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed ${CHAINCODE_NAME1} Successful on Peer0 org1 =========="
    echo ""

    setEnvForIslamibank
    echo Green "========== Check Commit Readiness of Installed ${CHAINCODE_NAME2} on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME2} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME2} --version ${CHAINCODE_VERSION2} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed ${CHAINCODE_NAME2} Successful on Peer0 org1 =========="
    echo ""

    setEnvForIslamibank
    echo Green "========== Check Commit Readiness of Installed ${CHANNEL_NAME3} on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME3} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed ${CHANNEL_NAME3} Successful on Peer0 org1 =========="
    echo ""

    setEnvForIslamibank
    echo Green "========== Check Commit Readiness of Installed ${CHANNEL_NAME4} on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME4} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed ${CHANNEL_NAME4} Successful on Peer0 org1 =========="
    echo ""

    setEnvForIslamibank
    echo Green "========== Check Commit Readiness of Installed ${CHANNEL_NAME5} on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME5} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed ${CHANNEL_NAME5} Successful on Peer0 org1 =========="
    echo ""
}

approveChaincodeByKrishibank() {
    setEnvForKrishibank
    echo Green "========== Approve Installed ${CHAINCODE_NAME1} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME1} --name ${CHAINCODE_NAME1} --version ${CHAINCODE_VERSION1} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHAINCODE_NAME1} Successful by Peer0 org1 =========="
    echo ""

    setEnvForKrishibank
    echo Green "========== Approve Installed ${CHAINCODE_NAME2} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME2} --name ${CHAINCODE_NAME2} --version ${CHAINCODE_VERSION2} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHAINCODE_NAME2} Successful by Peer0 org1 =========="
    echo ""

    setEnvForKrishibank
    echo Green "========== Approve Installed ${CHANNEL_NAME5} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME5} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHAINCODE_NAME5} Successful by Peer0 org1 =========="
    echo ""

    setEnvForKrishibank
    echo Green "========== Approve Installed ${CHANNEL_NAME7} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME7} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHAINCODE_NAME7} Successful by Peer0 org1 =========="
    echo ""

    setEnvForKrishibank
    echo Green "========== Approve Installed ${CHANNEL_NAME8} by Peer0 org1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME8} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    echo Green "========== Approve Installed ${CHAINCODE_NAME8} Successful by Peer0 org1 =========="
    echo ""
}

checkCommitReadynessForKrishibank() {
    setEnvForKrishibank
    echo Green "========== Check Commit Readiness of Installed ${CHAINCODE_NAME1} on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME1} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME1} --version ${CHAINCODE_VERSION1} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed ${CHAINCODE_NAME1} Successful on Peer0 org1 =========="
    echo ""

    setEnvForKrishibank
    echo Green "========== Check Commit Readiness of Installed ${CHAINCODE_NAME2} on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME2} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME2} --version ${CHAINCODE_VERSION2} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed ${CHAINCODE_NAME2} Successful on Peer0 org1 =========="
    echo ""

    setEnvForKrishibank
    echo Green "========== Check Commit Readiness of Installed ${CHANNEL_NAME5} on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME5} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed ${CHANNEL_NAME5} Successful on Peer0 org1 =========="
    echo ""

    setEnvForKrishibank
    echo Green "========== Check Commit Readiness of Installed ${CHANNEL_NAME7} on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME7} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed ${CHANNEL_NAME7} Successful on Peer0 org1 =========="
    echo ""

    setEnvForKrishibank
    echo Green "========== Check Commit Readiness of Installed ${CHANNEL_NAME8} on Peer0 org1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME8} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME3} --version ${CHAINCODE_VERSION3} --sequence 1 --output json --init-required
    echo Green "========== Check Commit Readiness of Installed ${CHANNEL_NAME8} Successful on Peer0 org1 =========="
    echo ""

    
}

commitChaincode() {
    setEnvForBdbank
    echo Green "========== Commit Installed Chaincode on ${CHANNEL_NAME1} =========="
    peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME1} --name ${CHAINCODE_NAME1} --peerAddresses localhost:1050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_BDBANK} --peerAddresses localhost:2050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ABBANK} --peerAddresses localhost:3050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ISLAMIBANK}  --peerAddresses localhost:4050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_DBBANK} --peerAddresses localhost:5050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_KRISHIBANK} --version ${CHAINCODE_VERSION1} --sequence 1 --init-required 
    # --signature-policy "OR('abbankMSP.peer','bdbankMSP.peer','dbbankMSP.peer','islamibankMSP.peer','krishibankMSP.peer')" --collections-config ./collections_config.json

    echo Green "========== Commit Installed Chaincode on ${CHANNEL_NAME1} Successful =========="
    echo ""

    setEnvForBdbank
    echo Green "========== Commit Installed Chaincode on ${CHANNEL_NAME2} =========="
    peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME2} --name ${CHAINCODE_NAME2} --peerAddresses localhost:1050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_BDBANK} --peerAddresses localhost:2050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ABBANK} --peerAddresses localhost:3050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ISLAMIBANK}  --peerAddresses localhost:4050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_DBBANK} --peerAddresses localhost:5050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_KRISHIBANK} --version ${CHAINCODE_VERSION2} --sequence 1 --init-required
    echo Green "========== Commit Installed Chaincode on ${CHANNEL_NAME2} Successful =========="
    echo ""

    setEnvForBdbank
    echo Green "========== Commit Installed Chaincode on ${CHANNEL_NAME3} =========="
    peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME3} --name ${CHAINCODE_NAME3} --peerAddresses localhost:1050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_BDBANK} --peerAddresses localhost:2050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ABBANK} --peerAddresses localhost:3050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ISLAMIBANK}  --version ${CHAINCODE_VERSION3} --sequence 1 --init-required
    echo Green "========== Commit Installed Chaincode on ${CHANNEL_NAME3} Successful =========="
    echo ""

    setEnvForBdbank
    echo Green "========== Commit Installed Chaincode on ${CHANNEL_NAME4} =========="
    peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME4} --name ${CHAINCODE_NAME3} --peerAddresses localhost:1050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_BDBANK}   --peerAddresses localhost:3050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ISLAMIBANK}  --peerAddresses localhost:4050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_DBBANK}  --version ${CHAINCODE_VERSION3} --sequence 1 --init-required
    echo Green "========== Commit Installed Chaincode on ${CHANNEL_NAME4} Successful =========="
    echo ""

    setEnvForBdbank
    echo Green "========== Commit Installed Chaincode on ${CHANNEL_NAME5} =========="
    peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME5} --name ${CHAINCODE_NAME3} --peerAddresses localhost:1050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_BDBANK}  --peerAddresses localhost:3050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ISLAMIBANK} --peerAddresses localhost:5050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_KRISHIBANK} --version ${CHAINCODE_VERSION3} --sequence 1 --init-required
    echo Green "========== Commit Installed Chaincode on ${CHANNEL_NAME5} Successful =========="
    echo ""

    setEnvForBdbank
    echo Green "========== Commit Installed Chaincode on ${CHANNEL_NAME6} =========="
    peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME6} --name ${CHAINCODE_NAME3} --peerAddresses localhost:1050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_BDBANK} --peerAddresses localhost:2050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ABBANK} --peerAddresses localhost:4050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_DBBANK}  --version ${CHAINCODE_VERSION3} --sequence 1 --init-required
    echo Green "========== Commit Installed Chaincode on ${CHANNEL_NAME6} Successful =========="
    echo ""

    setEnvForBdbank
    echo Green "========== Commit Installed Chaincode on ${CHANNEL_NAME7} =========="
    peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME7} --name ${CHAINCODE_NAME3} --peerAddresses localhost:1050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_BDBANK} --peerAddresses localhost:2050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ABBANK} --peerAddresses localhost:5050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_KRISHIBANK} --version ${CHAINCODE_VERSION3} --sequence 1 --init-required
    echo Green "========== Commit Installed Chaincode on ${CHANNEL_NAME7} Successful =========="
    echo ""

    setEnvForBdbank
    echo Green "========== Commit Installed Chaincode on ${CHANNEL_NAME8} =========="
    peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME8} --name ${CHAINCODE_NAME3} --peerAddresses localhost:1050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_BDBANK}   --peerAddresses localhost:4050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_DBBANK} --peerAddresses localhost:5050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_KRISHIBANK} --version ${CHAINCODE_VERSION3} --sequence 1 --init-required
    echo Green "========== Commit Installed Chaincode on ${CHANNEL_NAME8} Successful =========="
    echo ""
}


queryCommittedChaincode() {
    setEnvForBdbank
    echo Green "========== Query Committed Chaincode on ${CHANNEL_NAME1} =========="
    peer lifecycle chaincode querycommitted --channelID ${CHANNEL_NAME1} --name ${CHAINCODE_NAME1}
    echo Green "========== Query Committed Chaincode on ${CHANNEL_NAME1} Successful =========="
    echo ""

    setEnvForBdbank
    echo Green "========== Query Committed Chaincode on ${CHANNEL_NAME2} =========="
    peer lifecycle chaincode querycommitted --channelID ${CHANNEL_NAME2} --name ${CHAINCODE_NAME2}
    echo Green "========== Query Committed Chaincode on ${CHANNEL_NAME2} Successful =========="
    echo ""

    setEnvForBdbank
    echo Green "========== Query Committed Chaincode on ${CHANNEL_NAME3} =========="
    peer lifecycle chaincode querycommitted --channelID ${CHANNEL_NAME3} --name ${CHAINCODE_NAME3}
    echo Green "========== Query Committed Chaincode on ${CHANNEL_NAME3} Successful =========="
    echo ""

     setEnvForBdbank
    echo Green "========== Query Committed Chaincode on ${CHANNEL_NAME4} =========="
    peer lifecycle chaincode querycommitted --channelID ${CHANNEL_NAME4} --name ${CHAINCODE_NAME3}
    echo Green "========== Query Committed Chaincode on ${CHANNEL_NAME4} Successful =========="
    echo ""

     setEnvForBdbank
    echo Green "========== Query Committed Chaincode on ${CHANNEL_NAME5} =========="
    peer lifecycle chaincode querycommitted --channelID ${CHANNEL_NAME5} --name ${CHAINCODE_NAME3}
    echo Green "========== Query Committed Chaincode on ${CHANNEL_NAME5} Successful =========="
    echo ""

     setEnvForBdbank
    echo Green "========== Query Committed Chaincode on ${CHANNEL_NAME6} =========="
    peer lifecycle chaincode querycommitted --channelID ${CHANNEL_NAME6} --name ${CHAINCODE_NAME3}
    echo Green "========== Query Committed Chaincode on ${CHANNEL_NAME6} Successful =========="
    echo ""

     setEnvForBdbank
    echo Green "========== Query Committed Chaincode on ${CHANNEL_NAME7} =========="
    peer lifecycle chaincode querycommitted --channelID ${CHANNEL_NAME7} --name ${CHAINCODE_NAME3}
    echo Green "========== Query Committed Chaincode on ${CHANNEL_NAME7} Successful =========="
    echo ""

     setEnvForBdbank
    echo Green "========== Query Committed Chaincode on ${CHANNEL_NAME8} =========="
    peer lifecycle chaincode querycommitted --channelID ${CHANNEL_NAME8} --name ${CHAINCODE_NAME3}
    echo Green "========== Query Committed Chaincode on ${CHANNEL_NAME8} Successful =========="
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
    echo Green "========== Query Approved of Installed ${CHAINCODE_NAME1} on Peer0 org1 =========="
    peer lifecycle chaincode queryapproved -C ${CHANNEL_NAME1} -n ${CHAINCODE_NAME1} --sequence 1 
    echo Green "========== Query Approved of Installed ${CHAINCODE_NAME1} on Peer0 org1 Successful =========="
    echo ""

    setEnvForBdbank
    echo Green "========== Query Approved of Installed ${CHAINCODE_NAME2} on Peer0 org1 =========="
    peer lifecycle chaincode queryapproved -C ${CHANNEL_NAME2} -n ${CHAINCODE_NAME2} --sequence 1 
    echo Green "========== Query Approved of Installed ${CHAINCODE_NAME2} on Peer0 org1 Successful =========="
    echo ""

    setEnvForBdbank
    echo Green "========== Query Approved of Installed ${CHANNEL_NAME3} on Peer0 org1 =========="
    peer lifecycle chaincode queryapproved -C ${CHANNEL_NAME3} -n ${CHAINCODE_NAME3} --sequence 1 
    echo Green "========== Query Approved of Installed ${CHANNEL_NAME3} on Peer0 org1 Successful =========="
    echo ""

    setEnvForBdbank
    echo Green "========== Query Approved of Installed ${CHANNEL_NAME4} on Peer0 org1 =========="
    peer lifecycle chaincode queryapproved -C ${CHANNEL_NAME4} -n ${CHAINCODE_NAME3} --sequence 1 
    echo Green "========== Query Approved of Installed ${CHANNEL_NAME4} on Peer0 org1 Successful =========="
    echo ""

    setEnvForBdbank
    echo Green "========== Query Approved of Installed ${CHANNEL_NAME5} on Peer0 org1 =========="
    peer lifecycle chaincode queryapproved -C ${CHANNEL_NAME5} -n ${CHAINCODE_NAME3} --sequence 1 
    echo Green "========== Query Approved of Installed ${CHANNEL_NAME5} on Peer0 org1 Successful =========="
    echo ""

    setEnvForBdbank
    echo Green "========== Query Approved of Installed ${CHANNEL_NAME6} on Peer0 org1 =========="
    peer lifecycle chaincode queryapproved -C ${CHANNEL_NAME6} -n ${CHAINCODE_NAME3} --sequence 1 
    echo Green "========== Query Approved of Installed ${CHANNEL_NAME6} on Peer0 org1 Successful =========="
    echo ""

    setEnvForBdbank
    echo Green "========== Query Approved of Installed ${CHANNEL_NAME7} on Peer0 org1 =========="
    peer lifecycle chaincode queryapproved -C ${CHANNEL_NAME7} -n ${CHAINCODE_NAME3} --sequence 1 
    echo Green "========== Query Approved of Installed ${CHANNEL_NAME7} on Peer0 org1 Successful =========="
    echo ""

    setEnvForBdbank
    echo Green "========== Query Approved of Installed ${CHANNEL_NAME8} on Peer0 org1 =========="
    peer lifecycle chaincode queryapproved -C ${CHANNEL_NAME8} -n ${CHAINCODE_NAME3} --sequence 1 
    echo Green "========== Query Approved of Installed ${CHANNEL_NAME8} on Peer0 org1 Successful =========="
    echo ""
}
initChaincode() {
    setEnvForBdbank
    echo Green "========== Init ${CHAINCODE_NAME1} on Peer0 org1 ========== "
    peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} -C ${CHANNEL_NAME1} -n ${CHAINCODE_NAME1} --peerAddresses localhost:1050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_BDBANK} --peerAddresses localhost:2050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ABBANK} --peerAddresses localhost:3050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ISLAMIBANK}  --peerAddresses localhost:4050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_DBBANK}  --peerAddresses localhost:5050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_KRISHIBANK} --isInit -c '{"Args":[]}'
    echo Green "========== Init ${CHAINCODE_NAME1} on Peer0 org1 Successful ========== "
    echo ""

    setEnvForBdbank
    echo Green "========== Init ${CHAINCODE_NAME2} on Peer0 org1 ========== "
    peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} -C ${CHANNEL_NAME2} -n ${CHAINCODE_NAME2} --peerAddresses localhost:1050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_BDBANK} --peerAddresses localhost:2050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ABBANK} --peerAddresses localhost:3050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ISLAMIBANK}  --peerAddresses localhost:4050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_DBBANK}  --peerAddresses localhost:5050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_KRISHIBANK} --isInit -c '{"Args":[]}'
    echo Green "========== Init ${CHAINCODE_NAME2} on Peer0 org1 Successful ========== "
    echo ""

    setEnvForBdbank
    echo Green "========== Init ${CHAINCODE_NAME3} on Peer0 org1 ========== "
    peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} -C ${CHANNEL_NAME3} -n ${CHAINCODE_NAME3} --peerAddresses localhost:1050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_BDBANK} --peerAddresses localhost:2050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ABBANK} --peerAddresses localhost:3050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ISLAMIBANK}   --isInit -c '{"Args":[]}'
    echo Green "========== Init ${CHAINCODE_NAME3} on Peer0 org1 Successful ========== "
    echo ""

    setEnvForBdbank
    echo Green "========== Init ${CHANNEL_NAME4} on Peer0 org1 ========== "
    peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} -C ${CHANNEL_NAME4} -n ${CHAINCODE_NAME3} --peerAddresses localhost:1050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_BDBANK}  --peerAddresses localhost:3050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ISLAMIBANK}  --peerAddresses localhost:4050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_DBBANK}   --isInit -c '{"Args":[]}'
    echo Green "========== Init ${CHANNEL_NAME4} on Peer0 org1 Successful ========== "
    echo ""

    setEnvForBdbank
    echo Green "========== Init ${CHAINCODE_NAME5} on Peer0 org1 ========== "
    peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} -C ${CHANNEL_NAME5} -n ${CHAINCODE_NAME3} --peerAddresses localhost:1050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_BDBANK}  --peerAddresses localhost:3050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ISLAMIBANK}  --peerAddresses localhost:5050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_KRISHIBANK} --isInit -c '{"Args":[]}'
    echo Green "========== Init ${CHAINCODE_NAME5} on Peer0 org1 Successful ========== "
    echo ""

    setEnvForBdbank
    echo Green "========== Init ${CHAINCODE_NAME6} on Peer0 org1 ========== "
    peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} -C ${CHANNEL_NAME6} -n ${CHAINCODE_NAME3} --peerAddresses localhost:1050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_BDBANK} --peerAddresses localhost:2050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ABBANK}   --peerAddresses localhost:4050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_DBBANK}   --isInit -c '{"Args":[]}'
    echo Green "========== Init ${CHAINCODE_NAME6} on Peer0 org1 Successful ========== "
    echo ""

    setEnvForBdbank
    echo Green "========== Init ${CHAINCODE_NAME7} on Peer0 org1 ========== "
    peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} -C ${CHANNEL_NAME7} -n ${CHAINCODE_NAME3} --peerAddresses localhost:1050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_BDBANK} --peerAddresses localhost:2050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ABBANK}   --peerAddresses localhost:5050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_KRISHIBANK} --isInit -c '{"Args":[]}'
    echo Green "========== Init ${CHAINCODE_NAME7} on Peer0 org1 Successful ========== "
    echo ""

    setEnvForBdbank
    echo Green "========== Init ${CHAINCODE_NAME8} on Peer0 org1 ========== "
    peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} -C ${CHANNEL_NAME8} -n ${CHAINCODE_NAME3} --peerAddresses localhost:1050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_BDBANK}   --peerAddresses localhost:4050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_DBBANK}  --peerAddresses localhost:5050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_KRISHIBANK} --isInit -c '{"Args":[]}'
    echo Green "========== Init ${CHAINCODE_NAME8} on Peer0 org1 Successful ========== "
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
        -C ${CHANNEL_NAME1} -n ${CHAINCODE_NAME1} \
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

chaincodeInvoke1(){

     echo "-------------------- Chaincode Invoke --------------------"

    setEnvForBdbank

    ## Init ledger
    peer chaincode invoke -o localhost:7050 \
        --ordererTLSHostnameOverride orderer.example.com \
        --tls ${CORE_PEER_TLS_ENABLED} \
        --cafile ${ORDERER_CA} \
        -C ${CHANNEL_NAME2} -n ${CHAINCODE_NAME2} \
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

maketransaction(){

    setEnvForAbbank
    peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com \
    --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} -C ${CHANNEL_NAME7} -n ${CHAINCODE_NAME3} \
    --peerAddresses localhost:1050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_BDBANK} \
    --peerAddresses localhost:2050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ABBANK} \
    --peerAddresses localhost:5050 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_KRISHIBANK} \
    -c  '{"Args":["makeTransaction", "abbank","140040","abbank","krishibank","323fhsdsa"]}'

}

chaincodeQuery() {

    echo "-------------------- Chaincode Query --------------------"
    setEnvForBdbank

    peer chaincode query -C  ${CHANNEL_NAME1} -n ${CHAINCODE_NAME1} -c '{"Args":["queryAccount", "abbank"]}'


    echo " -- : Done : --"
    echo ""
    
}
chaincodeQuery1(){
    setEnvForAbbank
    peer chaincode query -C  ${CHANNEL_NAME7} -n ${CHAINCODE_NAME3} -c  '{"Args":["getTransactionHistory", "abbank"]}'


}
hello() {

     echo "------------------------new invokation-------------------"
         setEnvForBdbank

    peer chaincode invoke -C ${CHANNEL_NAME1} -n ${CHAINCODE_NAME1} \ peer chaincode invoke -o localhost:7050 \
        --ordererTLSHostnameOverride orderer.example.com \
        --tls ${CORE_PEER_TLS_ENABLED} \
        --cafile ${ORDERER_CA} \
        -C ${CHANNEL_NAME2} -n ${CHAINCODE_NAME2} \
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
        -c '{"function":"addPersonInfo","Args":["03","Rahim","Dhaka","approved"]}'


    echo " -- : Done : --"
    echo ""
}



# packageChaincode
# installChaincode
# queryInstalledChaincode
# approveChaincodeByBDbank
# checkCommitReadynessForBDbank
# approveChaincodeByABbank
# checkCommitReadynessForABbank
# approveChaincodeByDBbank
# checkCommitReadynessForDBbank
# approveChaincodeByIslamibank
# checkCommitReadynessForIslamibank
# approveChaincodeByKrishibank
# checkCommitReadynessForKrishibank
# commitChaincode
# queryCommittedChaincode
# getInstalledChaincode
# queryApprovedChaincode
# initChaincode
# sleep 5
# chaincodeInvoke
# sleep 5
# chaincodeInvoke1
# sleep 5
# chaincodeQuery
# sleep 5
# hello
# chaincodeQuery
maketransaction
sleep 4
chaincodeQuery1