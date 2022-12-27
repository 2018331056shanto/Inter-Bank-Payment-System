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
    export CORE_PEER_ADDRESS=peer0.bdbank:1050
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
createChannel