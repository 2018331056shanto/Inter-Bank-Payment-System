export PATH=${PWD}/bin:$PATH 
export FABRIC_CFG_PATH=${PWD}/config/
export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/consortium/crypto-config/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem

export NET_CHANNEL=netting-channel
export FUND_CHANNEL=funding-channel
export CHANNEL_THREE=islamibank-abbank-channel
export CHANNEL_FOUR=islamibank-dbbank-channel
export CHANNEL_FIVE=islamibank-krishibank-channel
export CHANNEL_SIX=abbank-dbbank-channel
export CHANNEL_SEVEN=abbank-krishibank-channel
export CHANNEL_EIGHT=dbbank-krishibank-channel

setEnvForPeer0Bdbank() {
    export PEER0_BDBANK_CA=${PWD}/consortium/crypto-config/peerOrganizations/bdbank/tlsca/tlsca.bdbank-cert.pem
    export CORE_PEER_LOCALMSPID=bdbankMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_BDBANK_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/consortium/crypto-config/peerOrganizations/bdbank/users/Admin@bdbank/msp
    export CORE_PEER_ADDRESS=localhost:1050
}

setEnvForPeer1Bdbank() {
    export PEER1_BDBANK_CA=${PWD}/consortium/crypto-config/peerOrganizations/bdbank/tlsca/tlsca.bdbank-cert.pem
    export CORE_PEER_LOCALMSPID=bdbankMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_BDBANK_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/consortium/crypto-config/peerOrganizations/bdbank/users/Admin@bdbank/msp
    export CORE_PEER_ADDRESS=localhost:1055
}


setEnvForPeer0Abbank() {
    export PEER0_ABBANK_CA=${PWD}/consortium/crypto-config/peerOrganizations/abbank/tlsca/tlsca.abbank-cert.pem
    export CORE_PEER_LOCALMSPID=abbankMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ABBANK_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/consortium/crypto-config/peerOrganizations/abbank/users/Admin@abbank/msp
    export CORE_PEER_ADDRESS=localhost:2050
}

setEnvForPeer1Abbank() {
    export PEER1_ABBANK_CA=${PWD}/consortium/crypto-config/peerOrganizations/abbank/tlsca/tlsca.abbank-cert.pem
    export CORE_PEER_LOCALMSPID=abbankMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_ABBANK_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/consortium/crypto-config/peerOrganizations/abbank/users/Admin@abbank/msp
    export CORE_PEER_ADDRESS=localhost:2055
}



setEnvForPeer0Dbbank() {
    export PEER0_DBBANK_CA=${PWD}/consortium/crypto-config/peerOrganizations/dbbank/tlsca/tlsca.dbbank-cert.pem
    export CORE_PEER_LOCALMSPID=dbbankMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_DBBANK_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/consortium/crypto-config/peerOrganizations/dbbank/users/Admin@dbbank/msp
    export CORE_PEER_ADDRESS=localhost:4050
}

setEnvForPeer1Dbbank() {
    export PEER1_DBBANK_CA=${PWD}/consortium/crypto-config/peerOrganizations/dbbank/tlsca/tlsca.dbbank-cert.pem
    export CORE_PEER_LOCALMSPID=dbbankMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_DBBANK_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/consortium/crypto-config/peerOrganizations/dbbank/users/Admin@dbbank/msp
    export CORE_PEER_ADDRESS=localhost:4055
}



setEnvForPeer0Islamibank() {
    export PEER0_ISLAMIBANK_CA=${PWD}/consortium/crypto-config/peerOrganizations/islamibank/tlsca/tlsca.islamibank-cert.pem
    export CORE_PEER_LOCALMSPID=islamibankMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ISLAMIBANK_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/consortium/crypto-config/peerOrganizations/islamibank/users/Admin@islamibank/msp
    export CORE_PEER_ADDRESS=localhost:3050
}

setEnvForPeer1Islamibank() {
    export PEER1_ISLAMIBANK_CA=${PWD}/consortium/crypto-config/peerOrganizations/islamibank/tlsca/tlsca.islamibank-cert.pem
    export CORE_PEER_LOCALMSPID=islamibankMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_ISLAMIBANK_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/consortium/crypto-config/peerOrganizations/islamibank/users/Admin@islamibank/msp
    export CORE_PEER_ADDRESS=localhost:3055
}



setEnvForPeer0Krishibank() {
    export PEER0_KRISHIBANK_CA=${PWD}/consortium/crypto-config/peerOrganizations/krishibank/tlsca/tlsca.krishibank-cert.pem
    export CORE_PEER_LOCALMSPID=krishibankMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_KRISHIBANK_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/consortium/crypto-config/peerOrganizations/krishibank/users/Admin@krishibank/msp
    export CORE_PEER_ADDRESS=localhost:5050
}
setEnvForPeer1Krishibank() {
    export PEER1_KRISHIBANK_CA=${PWD}/consortium/crypto-config/peerOrganizations/krishibank/tlsca/tlsca.krishibank-cert.pem
    export CORE_PEER_LOCALMSPID=krishibankMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_KRISHIBANK_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/consortium/crypto-config/peerOrganizations/krishibank/users/Admin@krishibank/msp
    export CORE_PEER_ADDRESS=localhost:5055
}



createChannel(){

    setEnvForPeer0Bdbank
    echo "===========creating  nettingChannel Channel========="

    peer channel create -o localhost:7050 -c ${NET_CHANNEL}  \
    --ordererTLSHostnameOverride orderer.example.com \
    -f ./channel-artifacts/$NET_CHANNEL.tx \
    --outputBlock ./channel-artifacts/${NET_CHANNEL}.block \
    --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA 

    echo "==========Finished nettingChannel=================="
    echo " "

   

    echo "===========creating  ${FUND_CHANNEL} Channel========="

     peer channel create -o localhost:7050 -c $FUND_CHANNEL \
    --ordererTLSHostnameOverride orderer.example.com \
    -f ./channel-artifacts/$FUND_CHANNEL.tx \
    --outputBlock ./channel-artifacts/${FUND_CHANNEL}.block \
    --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA 

    echo "==========Finished ${FUND_CHANNEL}=================="
    echo " "



    echo "===========creating  ${CHANNEL_THREE} Channel========="

     peer channel create -o localhost:7050 -c $CHANNEL_THREE \
    --ordererTLSHostnameOverride orderer.example.com \
    -f ./channel-artifacts/$CHANNEL_THREE.tx \
    --outputBlock ./channel-artifacts/${CHANNEL_THREE}.block \
    --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA 

    echo "==========Finished ${CHANNEL_TRHEE}=================="
    echo " "


    

    echo "===========creating  ${CHANNEL_FOUR} Channel========="

    peer channel create -o localhost:7050 -c $CHANNEL_FOUR \
    --ordererTLSHostnameOverride orderer.example.com \
    -f ./channel-artifacts/$CHANNEL_FOUR.tx \
    --outputBlock ./channel-artifacts/${CHANNEL_FOUR}.block \
    --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA 

    echo "==========Finished ${CHANNEL_FOUR}=================="
    echo " "
     echo "===========creating  ${CHANNEL_FIVE} Channel========="

     peer channel create -o localhost:7050 -c $CHANNEL_FIVE \
    --ordererTLSHostnameOverride orderer.example.com \
    -f ./channel-artifacts/$CHANNEL_FIVE.tx \
    --outputBlock ./channel-artifacts/${CHANNEL_FIVE}.block \
    --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA 

    echo "==========Finished ${CHANNEL_FIVE}=================="
    echo " "
     echo "===========creating  ${CHANNEL_SIX} Channel========="

     peer channel create -o localhost:7050 -c $CHANNEL_SIX \
    --ordererTLSHostnameOverride orderer.example.com \
    -f ./channel-artifacts/$CHANNEL_SIX.tx \
    --outputBlock ./channel-artifacts/${CHANNEL_SIX}.block \
    --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA 

    echo "==========Finished ${CHANNEL_SIX}=================="
    echo " "
     echo "===========creating  ${CHANNEL_SEVEN} Channel========="

     peer channel create -o localhost:7050 -c $CHANNEL_SEVEN \
    --ordererTLSHostnameOverride orderer.example.com \
    -f ./channel-artifacts/$CHANNEL_SEVEN.tx \
    --outputBlock ./channel-artifacts/${CHANNEL_SEVEN}.block \
    --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA 

    echo "==========Finished ${CHANNEL_SEVEN}=================="
    echo " "
     echo "===========creating  ${CHANNEL_EIGHT} Channel========="

     peer channel create -o localhost:7050 -c $CHANNEL_EIGHT \
    --ordererTLSHostnameOverride orderer.example.com \
    -f ./channel-artifacts/$CHANNEL_EIGHT.tx \
    --outputBlock ./channel-artifacts/${CHANNEL_EIGHT}.block \
    --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA 

    echo "==========Finished ${CHANNEL_EIGHT}=================="
    echo " "


}

joinChannel(){
echo "################################################################################"
echo " "
echo "==============Joining to ${NET_CHANNEL}===================="
echo " "
echo "################################################################################"


echo "=============joining Peer0 BDbank======================"

setEnvForPeer0Bdbank

peer channel join -b ./channel-artifacts/$NET_CHANNEL.block

echo "=======Joined Peer0 BDbank successfull=============== "
echo " "
echo "=============joining Peer1 BDbank======================"

setEnvForPeer1Bdbank

peer channel join -b ./channel-artifacts/$NET_CHANNEL.block

echo "=======Joined Peer1 BDbank successfull=============== "

echo "-------------------------------------------------------------------"
echo " "
echo "=============joining Peer0 ABbank======================"

setEnvForPeer0Abbank

peer channel join -b ./channel-artifacts/$NET_CHANNEL.block

echo "=======Joined Peer0 ABbank successfull=============== "

echo " "
echo "=============joining Peer1 ABbank======================"

setEnvForPeer1Abbank

peer channel join -b ./channel-artifacts/$NET_CHANNEL.block

echo "=======Joined Peer1 ABbank successfull=============== "

echo "--------------------------------------------------------------------------"
echo " "
echo "=============joining Peer0 DBbank======================"

setEnvForPeer0Dbbank

peer channel join -b ./channel-artifacts/$NET_CHANNEL.block

echo "=======Joined Peer0 DBbank successfull=============== "

echo " "
echo "=============joining Peer1 DBbank======================"

setEnvForPeer1Dbbank

peer channel join -b ./channel-artifacts/$NET_CHANNEL.block

echo "=======Joined Peer1 DBbank successfull=============== "
echo "--------------------------------------------------------------------------"

echo " "
echo "=============joining Peer0 Islamibank======================"

setEnvForPeer0Islamibank

peer channel join -b ./channel-artifacts/$NET_CHANNEL.block

echo "=======Joined Peer0 Islamibank successfull=============== "


echo " "
echo "=============joining Peer1 Islamibank======================"

setEnvForPeer1Islamibank

peer channel join -b ./channel-artifacts/$NET_CHANNEL.block

echo "=======Joined Peer1 Islamibank successfull=============== "
echo " "
echo "------------------------------------------------------------------------"
echo " "
echo "=============joining Peer0 Krishiibank======================"

setEnvForPeer0Krishibank

peer channel join -b ./channel-artifacts/$NET_CHANNEL.block

echo "=======Joined Peer0 Krishibank successfull=============== "

echo " "
echo "=============joining Peer1 Krishiibank======================"

setEnvForPeer1Krishibank

peer channel join -b ./channel-artifacts/$NET_CHANNEL.block

echo "=======Joined Peer1 Krishibank successfull=============== "

echo "--------------------------------------------------------------------------"




echo "################################################################################"
echo " "
echo "==============Joining to ${FUND_CHANNEL}===================="
echo " "
echo "################################################################################"


echo "=============joining Peer0 BDbank======================"

setEnvForPeer0Bdbank

peer channel join -b ./channel-artifacts/$FUND_CHANNEL.block

echo "=======Joined Peer0 BDbank successfull=============== "
echo " "
echo "=============joining Peer1 BDbank======================"

setEnvForPeer1Bdbank

peer channel join -b ./channel-artifacts/$FUND_CHANNEL.block

echo "=======Joined Peer1 BDbank successfull=============== "

echo "------------------------------------------------------------------------"
echo " "
echo "=============joining Peer0 ABbank======================"

setEnvForPeer0Abbank

peer channel join -b ./channel-artifacts/$FUND_CHANNEL.block

echo "=======Joined Peer0 ABbank successfull=============== "

echo " "
echo "=============joining Peer1 ABbank======================"

setEnvForPeer1Abbank

peer channel join -b ./channel-artifacts/$FUND_CHANNEL.block

echo "=======Joined Peer1 ABbank successfull=============== "

echo "--------------------------------------------------------------------"
echo " "
echo "=============joining Peer0 DBbank======================"

setEnvForPeer0Dbbank

peer channel join -b ./channel-artifacts/$FUND_CHANNEL.block

echo "=======Joined Peer0 DBbank successfull=============== "

echo " "
echo "=============joining Peer1 DBbank======================"

setEnvForPeer1Dbbank

peer channel join -b ./channel-artifacts/$FUND_CHANNEL.block

echo "=======Joined Peer1 DBbank successfull=============== "
echo " "
echo "------------------------------------------------------------------------"

echo " "
echo "=============joining Peer0 Islamibank======================"

setEnvForPeer0Islamibank

peer channel join -b ./channel-artifacts/$FUND_CHANNEL.block

echo "=======Joined Peer0 Islamibank successfull=============== "


echo " "
echo "=============joining Peer1 Islamibank======================"

setEnvForPeer1Islamibank

peer channel join -b ./channel-artifacts/$FUND_CHANNEL.block

echo "=======Joined Peer1 Islamibank successfull=============== "

echo "----------------------------------------------------------------------------"
echo " "
echo "=============joining Peer0 Krishiibank======================"

setEnvForPeer0Krishibank

peer channel join -b ./channel-artifacts/$FUND_CHANNEL.block

echo "=======Joined Peer0 Krishibank successfull=============== "

echo " "
echo "=============joining Peer1 Krishiibank======================"

setEnvForPeer1Krishibank

peer channel join -b ./channel-artifacts/$FUND_CHANNEL.block

echo "=======Joined Peer1 Krishibank successfull=============== "
echo " "
echo "---------------------------------------------------------------------------------"




echo "################################################################################"
echo " "
echo "==============Joining to ${CHANNEL_THREE}===================="
echo " "
echo "################################################################################"

echo "=============joining Peer0 BDbank======================"

setEnvForPeer0Bdbank

peer channel join -b ./channel-artifacts/$CHANNEL_THREE.block

echo "=======Joined Peer0 BDbank successfull=============== "
echo " "
echo "=============joining Peer1 BDbank======================"

setEnvForPeer1Bdbank

peer channel join -b ./channel-artifacts/$CHANNEL_THREE.block

echo "=======Joined Peer1 BDbank successfull=============== "

echo "------------------------------------------------------------------------------"

echo " "
echo "=============joining Peer0 Islamibank======================"

setEnvForPeer0Islamibank

peer channel join -b ./channel-artifacts/$CHANNEL_THREE.block

echo "=======Joined Peer0 Islamibank successfull=============== "
echo " "
echo "=============joining Peer1 Islamibank======================"

setEnvForPeer1Islamibank

peer channel join -b ./channel-artifacts/$CHANNEL_THREE.block

echo "=======Joined Peer1 Islamibank successfull=============== "
echo "--------------------------------------------------------------------------"
echo "=============joining Peer0 ABbank======================"

setEnvForPeer0Abbank

peer channel join -b ./channel-artifacts/$CHANNEL_THREE.block

echo "=======Joined Peer0 ABbank successfull=============== "
echo " "
echo "=============joining Peer1 ABbank======================"

setEnvForPeer1Abbank

peer channel join -b ./channel-artifacts/$CHANNEL_THREE.block

echo "=======Joined Peer1 ABbank successfull=============== "





echo " "
echo "==============Joining to ${CHANNEL_FOUR}===================="
echo " "
echo "################################################################################"

echo "=============joining Peer0 BDbank======================"

setEnvForPeer0Bdbank

peer channel join -b ./channel-artifacts/$CHANNEL_FOUR.block

echo "=======Joined Peer0 BDbank successfull=============== "
echo " "
echo "=============joining Peer1 BDbank======================"

setEnvForPeer1Bdbank

peer channel join -b ./channel-artifacts/$CHANNEL_FOUR.block

echo "=======Joined Peer1 BDbank successfull=============== "

echo " "
echo " -----------------------------------------------------------------------"

echo " "

echo "=============joining Peer0 Islamibank======================"

setEnvForPeer0Islamibank

peer channel join -b ./channel-artifacts/$CHANNEL_FOUR.block

echo "=======Joined Peer0 Islamibank successfull=============== "
echo " "
echo "=============joining Peer1 Islamibank======================"

setEnvForPeer1Islamibank

peer channel join -b ./channel-artifacts/$CHANNEL_FOUR.block

echo "=======Joined Peer1 Islamibank successfull=============== "

echo " "
echo " -----------------------------------------------------------------------"


echo " "

echo "=============joining Peer0 DBbank======================"

setEnvForPeer0Dbbank

peer channel join -b ./channel-artifacts/$CHANNEL_FOUR.block

echo "=======Joined Peer0 DBbank successfull=============== "
echo " "
echo "=============joining Peer1 DBbank======================"

setEnvForPeer1Dbbank

peer channel join -b ./channel-artifacts/$CHANNEL_FOUR.block

echo "=======Joined Peer1 DBbank successfull=============== "

echo " "
echo " -----------------------------------------------------------------------"











echo " "
echo "==============Joining to ${CHANNEL_FIVE}===================="
echo " "
echo "################################################################################"

echo " "
echo "=============joining Peer0 BDbank======================"

setEnvForPeer0Bdbank

peer channel join -b ./channel-artifacts/$CHANNEL_FIVE.block

echo "=======Joined Peer0 BDbank successfull=============== "
echo " "
echo "=============joining Peer1 BDbank======================"

setEnvForPeer1Bdbank

peer channel join -b ./channel-artifacts/$CHANNEL_FIVE.block

echo "=======Joined Peer1 BDbank successfull=============== "
echo " "
echo "-------------------------------------------------------------------------------"

echo " "
echo "=============joining Peer0 Islamibank======================"

setEnvForPeer0Islamibank

peer channel join -b ./channel-artifacts/$CHANNEL_FIVE.block

echo "=======Joined Peer0 Islamibank successfull=============== "
echo " "
echo "=============joining Peer1 Islamibank======================"

setEnvForPeer1Islamibank

peer channel join -b ./channel-artifacts/$CHANNEL_FIVE.block

echo "=======Joined Peer1 Islamibank successfull=============== "
echo " "
echo "-------------------------------------------------------------------------------"


echo " "
echo "=============joining Peer0 Krishibank======================"

setEnvForPeer0Krishibank

peer channel join -b ./channel-artifacts/$CHANNEL_FIVE.block

echo "=======Joined Peer0 Krishibank successfull=============== "
echo " "
echo "=============joining Peer1 Krishibank======================"

setEnvForPeer1Krishibank

peer channel join -b ./channel-artifacts/$CHANNEL_FIVE.block

echo "=======Joined Peer1 Krishibank successfull=============== "
echo " "
echo "-------------------------------------------------------------------------------"





echo " "
echo "==============Joining to ${CHANNEL_SIX}===================="
echo " "
echo "################################################################################"

echo " "
echo "=============joining Peer0 BDbank======================"

setEnvForPeer0Bdbank

peer channel join -b ./channel-artifacts/$CHANNEL_SIX.block

echo "=======Joined Peer0 BDbank successfull=============== "
echo " "
echo "=============joining Peer1 BDbank======================"

setEnvForPeer1Bdbank

peer channel join -b ./channel-artifacts/$CHANNEL_SIX.block

echo "=======Joined Peer1 BDbank successfull=============== "
echo " "
echo "---------------------------------------------------------------------------"


echo " "
echo "=============joining Peer0 ABbank======================"

setEnvForPeer0Abbank

peer channel join -b ./channel-artifacts/$CHANNEL_SIX.block

echo "=======Joined Peer0 ABbank successfull=============== "
echo " "
echo "=============joining Peer1 ABbank======================"

setEnvForPeer1Abbank

peer channel join -b ./channel-artifacts/$CHANNEL_SIX.block

echo "=======Joined Peer1 ABbank successfull=============== "
echo " "
echo "---------------------------------------------------------------------------"

echo " "
echo "=============joining Peer0 DBbank======================"

setEnvForPeer0Dbbank

peer channel join -b ./channel-artifacts/$CHANNEL_SIX.block

echo "=======Joined Peer0 DBbank successfull=============== "
echo " "
echo "=============joining Peer1 DBbank======================"

setEnvForPeer1Dbbank

peer channel join -b ./channel-artifacts/$CHANNEL_SIX.block

echo "=======Joined Peer1 DBbank successfull=============== "
echo " "
echo "---------------------------------------------------------------------------"






echo " "
echo "==============Joining to ${CHANNEL_SEVEN}===================="
echo " "
echo "################################################################################"

echo " "
echo "=============joining Peer0 BDbank======================"

setEnvForPeer0Bdbank

peer channel join -b ./channel-artifacts/$CHANNEL_SEVEN.block

echo "=======Joined Peer0 BDbank successfull=============== "
echo " "
echo "=============joining Peer1 BDbank======================"

setEnvForPeer1Bdbank

peer channel join -b ./channel-artifacts/$CHANNEL_SEVEN.block

echo "=======Joined Peer1 BDbank successfull=============== "
echo " "
echo "------------------------------------------------------------------------------"

echo " "
echo "=============joining Peer0 ABbank======================"

setEnvForPeer0Abbank

peer channel join -b ./channel-artifacts/$CHANNEL_SEVEN.block

echo "=======Joined Peer0 ABbank successfull=============== "
echo " "
echo "=============joining Peer1 ABbank======================"

setEnvForPeer1Abbank

peer channel join -b ./channel-artifacts/$CHANNEL_SEVEN.block

echo "=======Joined Peer1 ABbank successfull=============== "
echo " "
echo "------------------------------------------------------------------------------"

echo " "
echo "=============joining Peer0 Krishibank======================"

setEnvForPeer0Krishibank

peer channel join -b ./channel-artifacts/$CHANNEL_SEVEN.block

echo "=======Joined Peer0 Krishibank successfull=============== "
echo " "
echo "=============joining Peer1 Krishibank======================"

setEnvForPeer1Krishibank

peer channel join -b ./channel-artifacts/$CHANNEL_SEVEN.block

echo "=======Joined Peer1 Krishibank successfull=============== "
echo " "
echo "------------------------------------------------------------------------------"







echo " "
echo "==============Joining to ${CHANNEL_EIGHT}===================="
echo " "
echo "################################################################################"

echo " "
echo "=============joining Peer0 BDbank======================"

setEnvForPeer0Bdbank

peer channel join -b ./channel-artifacts/$CHANNEL_EIGHT.block

echo "=======Joined Peer0 BDbank successfull=============== "
echo " "
echo "=============joining Peer1 BDbank======================"

setEnvForPeer1Bdbank

peer channel join -b ./channel-artifacts/$CHANNEL_EIGHT.block

echo "=======Joined Peer1 BDbank successfull=============== "
echo " "
echo "------------------------------------------------------------------------"

echo " "
echo "=============joining Peer0 DBbank======================"

setEnvForPeer0Dbbank

peer channel join -b ./channel-artifacts/$CHANNEL_EIGHT.block

echo "=======Joined Peer0 DBbank successfull=============== "
echo " "
echo "=============joining Peer1 DBbank======================"

setEnvForPeer1Dbbank

peer channel join -b ./channel-artifacts/$CHANNEL_EIGHT.block

echo "=======Joined Peer1 DBbank successfull=============== "
echo " "
echo "------------------------------------------------------------------------"

echo " "
echo "=============joining Peer0 Krishibank======================"

setEnvForPeer0Krishibank

peer channel join -b ./channel-artifacts/$CHANNEL_EIGHT.block

echo "=======Joined Peer0 Krishibank successfull=============== "
echo " "
echo "=============joining Peer1 Krishibank======================"

setEnvForPeer1Krishibank

peer channel join -b ./channel-artifacts/$CHANNEL_EIGHT.block

echo "=======Joined Peer1 Krishibank successfull=============== "
echo " "
echo "------------------------------------------------------------------------"


}



updateAnchorPeers(){

echo " #########################################################################"
echo " "
echo "===============Anchor Peers for ${NET_CHANNEL}============="
echo " "
echo "###########################################################################"

echo " "
echo "========Updating anchor peer for BDbank==============="

setEnvForPeer0Bdbank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $NET_CHANNEL -f ./channel-artifacts/bdbankAnchor_${NET_CHANNEL}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer Bdbank ================="


echo " "
echo "========Updating anchor peer for ABbank==============="

setEnvForPeer0Abbank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $NET_CHANNEL -f ./channel-artifacts/abbankAnchor_${NET_CHANNEL}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer ABbank ================="

echo " "

echo "========Updating anchor peer for DBbank==============="

setEnvForPeer0Dbbank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $NET_CHANNEL -f ./channel-artifacts/dbbankAnchor_${NET_CHANNEL}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer DBbank ================="


echo " "
echo "========Updating anchor peer for Islamibank==============="

setEnvForPeer0Islamibank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $NET_CHANNEL -f ./channel-artifacts/islamibankAnchor_${NET_CHANNEL}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer Islamibank ================="

echo " "
echo "========Updating anchor peer for Krishibank==============="

setEnvForPeer0Krishibank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $NET_CHANNEL -f ./channel-artifacts/krishibankAnchor_${NET_CHANNEL}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer Krishibank ================="

echo " "




echo " #########################################################################"
echo " "
echo "===============Anchor Peers for ${FUND_CHANNEL}============="
echo " "
echo "###########################################################################"

echo " "
echo "========Updating anchor peer for BDbank==============="

setEnvForPeer0Bdbank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $FUND_CHANNEL -f ./channel-artifacts/bdbankAnchor_${FUND_CHANNEL}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer Bdbank ================="


echo " "
echo "========Updating anchor peer for ABbank==============="

setEnvForPeer0Abbank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $FUND_CHANNEL -f ./channel-artifacts/abbankAnchor_${FUND_CHANNEL}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer ABbank ================="

echo " "

echo "========Updating anchor peer for DBbank==============="

setEnvForPeer0Dbbank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $FUND_CHANNEL -f ./channel-artifacts/dbbankAnchor_${FUND_CHANNEL}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer DBbank ================="


echo " "
echo "========Updating anchor peer for Islamibank==============="

setEnvForPeer0Islamibank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $FUND_CHANNEL -f ./channel-artifacts/islamibankAnchor_${FUND_CHANNEL}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer Islamibank ================="

echo " "
echo "========Updating anchor peer for Krishibank==============="

setEnvForPeer0Krishibank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $FUND_CHANNEL -f ./channel-artifacts/krishibankAnchor_${FUND_CHANNEL}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer Krishibank ================="

echo " "




echo " #########################################################################"
echo " "
echo "===============Anchor Peers for ${CHANNEL_THREE}============="
echo " "
echo "###########################################################################"

echo " "
echo "========Updating anchor peer for BDbank==============="

setEnvForPeer0Bdbank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_THREE -f ./channel-artifacts/bdbankAnchor_${CHANNEL_THREE}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer Bdbank ================="


echo " "
echo "========Updating anchor peer for ABbank==============="

setEnvForPeer0Abbank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_THREE -f ./channel-artifacts/abbankAnchor_${CHANNEL_THREE}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer ABbank ================="

echo " "
echo "========Updating anchor peer for Islamibank==============="

setEnvForPeer0Islamibank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_THREE -f ./channel-artifacts/islamibankAnchor_${CHANNEL_THREE}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer Islamibank ================="
echo " "

echo " #########################################################################"
echo " "
echo "===============Anchor Peers for ${CHANNEL_FOUR}============="
echo " "
echo "###########################################################################"

echo " "
echo "========Updating anchor peer for BDbank==============="

setEnvForPeer0Bdbank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_FOUR -f ./channel-artifacts/bdbankAnchor_${CHANNEL_FOUR}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer Bdbank ================="

echo " "

echo "========Updating anchor peer for DBbank==============="

setEnvForPeer0Dbbank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_FOUR -f ./channel-artifacts/dbbankAnchor_${CHANNEL_FOUR}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer DBbank ================="


echo " "
echo "========Updating anchor peer for Islamibank==============="

setEnvForPeer0Islamibank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_FOUR -f ./channel-artifacts/islamibankAnchor_${CHANNEL_FOUR}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer Islamibank ================="

echo " "
echo " #########################################################################"
echo " "
echo "===============Anchor Peers for ${CHANNEL_FIVE}============="
echo " "
echo "###########################################################################"

echo " "
echo "========Updating anchor peer for BDbank==============="

setEnvForPeer0Bdbank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_FIVE -f ./channel-artifacts/bdbankAnchor_${CHANNEL_FIVE}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer Bdbank ================="


echo " "
echo "========Updating anchor peer for Islamibank==============="

setEnvForPeer0Islamibank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_FIVE -f ./channel-artifacts/islamibankAnchor_${CHANNEL_FIVE}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer Islamibank ================="

echo " "
echo "========Updating anchor peer for Krishibank==============="

setEnvForPeer0Krishibank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_FIVE -f ./channel-artifacts/krishibankAnchor_${CHANNEL_FIVE}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer Krishibank ================="

echo " "


echo " #########################################################################"
echo " "
echo "===============Anchor Peers for ${CHANNEL_SIX}============="
echo " "
echo "###########################################################################"

echo " "
echo "========Updating anchor peer for BDbank==============="

setEnvForPeer0Bdbank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_SIX -f ./channel-artifacts/bdbankAnchor_${CHANNEL_SIX}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer Bdbank ================="


echo " "
echo "========Updating anchor peer for ABbank==============="

setEnvForPeer0Abbank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_SIX -f ./channel-artifacts/abbankAnchor_${CHANNEL_SIX}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer ABbank ================="

echo " "

echo "========Updating anchor peer for DBbank==============="

setEnvForPeer0Dbbank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_SIX -f ./channel-artifacts/dbbankAnchor_${CHANNEL_SIX}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer DBbank ================="


echo " "

echo " #########################################################################"
echo " "
echo "===============Anchor Peers for ${CHANNEL_SEVEN}============="
echo " "
echo "###########################################################################"

echo " "
echo "========Updating anchor peer for BDbank==============="

setEnvForPeer0Bdbank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_SEVEN -f ./channel-artifacts/bdbankAnchor_${CHANNEL_SEVEN}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer Bdbank ================="


echo " "
echo "========Updating anchor peer for ABbank==============="

setEnvForPeer0Abbank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_SEVEN -f ./channel-artifacts/abbankAnchor_${CHANNEL_SEVEN}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer ABbank ================="

echo " "
echo "========Updating anchor peer for Krishibank==============="

setEnvForPeer0Krishibank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_SEVEN -f ./channel-artifacts/krishibankAnchor_${CHANNEL_SEVEN}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer Krishibank ================="

echo " "

echo " #########################################################################"
echo " "
echo "===============Anchor Peers for ${CHANNEL_EIGHT}============="
echo " "
echo "###########################################################################"

echo " "
echo "========Updating anchor peer for BDbank==============="

setEnvForPeer0Bdbank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_EIGHT -f ./channel-artifacts/bdbankAnchor_${CHANNEL_EIGHT}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer Bdbank ================="

echo " "

echo "========Updating anchor peer for DBbank==============="

setEnvForPeer0Dbbank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_EIGHT -f ./channel-artifacts/dbbankAnchor_${CHANNEL_EIGHT}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer DBbank ================="

echo " "
echo "========Updating anchor peer for Krishibank==============="

setEnvForPeer0Krishibank

peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_EIGHT -f ./channel-artifacts/krishibankAnchor_${CHANNEL_EIGHT}.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

echo "======updated achor peer Krishibank ================="

echo " "


}

#
createChannel
joinChannel
updateAnchorPeers