export PATH=${PWD}/bin:$PATH 
export FABRIC_CFG_PATH=${PWD}/configtx/

export CHANNEL_ONE_PROFILE=NettingChannel
export CHANNEL_ONE_NAME=netting-channel


export CHANNEL_TWO_PROFILE=FundingChannel
export CHANNEL_TWO_NAME=funding-channel


export CHANNEL_THREE_PROFILE=IslamibankABbankChannel
export CHANNEL_THREE_NAME=islamibank-abbank-channel



export CHANNEL_FOUR_PROFILE=IslamibankDBbankChannel
export CHANNEL_FOUR_NAME=islamibank-dbbank-channel

export CHANNEL_FIVE_PROFILE=IslamibankKrishibankChannel
export CHANNEL_FIVE_NAME=islamibank-krishibank-channel

export CHANNEL_SIX_PROFILE=ABbankDBbank
export CHANNEL_SIX_NAME=abbank-dbbank-channel

export CHANNEL_SEVEN_PROFILE=ABbankKrishibank
export CHANNEL_SEVEN_NAME=abbank-krishibank-channel

export CHANNEL_EIGHT_PROFILE=DBbankKrishibank
export CHANNEL_EIGHT_NAME=dbbank-krishibank-channel






SYS_CHANNEL=ibps


echo "############################################################################################"
echo "========== Generating System Genesis Block =========="
echo ""

configtxgen -configPath ./configtx/ -profile OrdererGenesis -channelID $SYS_CHANNEL -outputBlock ./channel-artifacts/genesis.block

echo "========== System Genesis Block Generated =========="
echo ""


echo "========== Generating Netting Channel Configuration Block =========="
echo ""

configtxgen -profile ${CHANNEL_ONE_PROFILE} -configPath ./configtx/ -outputCreateChannelTx ./channel-artifacts/${CHANNEL_ONE_NAME}.tx -channelID ${CHANNEL_ONE_NAME}

echo "========== Channel Configuration Block Generated =========="
echo ""

echo "========== Generating Anchor Peer Update For BDBank =========="
echo ""

configtxgen -profile ${CHANNEL_ONE_PROFILE} -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/bdbankAnchor_${CHANNEL_ONE_NAME}.tx -channelID ${CHANNEL_ONE_NAME}  -asOrg bdbank
echo "========== Anchor Peer Update For BDBank Sucessful =========="
echo ""
echo "========== Generating Anchor Peer Update For ABBank =========="
echo ""

configtxgen -profile ${CHANNEL_ONE_PROFILE} -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/abbankAnchor_${CHANNEL_ONE_NAME}.tx -channelID ${CHANNEL_ONE_NAME} -asOrg abbank
echo "========== Anchor Peer Update For ABBank Sucessful =========="
echo ""
echo "========== Generating Anchor Peer Update For KrishiBank =========="
echo ""

configtxgen -profile ${CHANNEL_ONE_PROFILE} -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/krishibankAnchor_${CHANNEL_ONE_NAME}.tx -channelID ${CHANNEL_ONE_NAME} -asOrg krishibank
echo "========== Anchor Peer Update For KrishiBank Sucessful =========="
echo ""

echo "========== Generating Anchor Peer Update For DBBank =========="
echo ""

configtxgen -profile ${CHANNEL_ONE_PROFILE} -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/dbbankAnchor_${CHANNEL_ONE_NAME}.tx -channelID ${CHANNEL_ONE_NAME} -asOrg dbbank
echo "========== Anchor Peer Update For DBBank Sucessful =========="
echo ""

echo "========== Generating Anchor Peer Update For IslamiBank =========="
echo ""

configtxgen -profile ${CHANNEL_ONE_PROFILE} -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/islamibankAnchor_${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME -asOrg islamibank
echo "========== Anchor Peer Update For IslamiBank Sucessful =========="
echo ""


echo "####################################################################################################################"



echo "========== Generating Funding Channel Configuration Block =========="
echo ""

configtxgen -profile ${CHANNEL_TWO_PROFILE} -configPath ./configtx/ -outputCreateChannelTx ./channel-artifacts/${CHANNEL_TWO_NAME}.tx -channelID ${CHANNEL_TWO_NAME}

echo "========== Channel Configuration Block Generated =========="
echo ""

echo "========== Generating Anchor Peer Update For BDBank =========="
echo ""

configtxgen -profile ${CHANNEL_TWO_PROFILE} -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/bdbankAnchor_${CHANNEL_TWO_NAME}.tx -channelID ${CHANNEL_TWO_NAME}  -asOrg bdbank
echo "========== Anchor Peer Update For BDBank Sucessful =========="
echo ""
echo "========== Generating Anchor Peer Update For ABBank =========="
echo ""

configtxgen -profile ${CHANNEL_TWO_PROFILE} -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/abbankAnchor_${CHANNEL_TWO_NAME}.tx -channelID ${CHANNEL_TWO_NAME} -asOrg abbank
echo "========== Anchor Peer Update For ABBank Sucessful =========="
echo ""
echo "========== Generating Anchor Peer Update For KrishiBank =========="
echo ""

configtxgen -profile ${CHANNEL_TWO_PROFILE} -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/krishibankAnchor_${CHANNEL_TWO_NAME}.tx -channelID ${CHANNEL_TWO_NAME} -asOrg krishibank
echo "========== Anchor Peer Update For KrishiBank Sucessful =========="
echo ""

echo "========== Generating Anchor Peer Update For DBBank =========="
echo ""

configtxgen -profile ${CHANNEL_TWO_PROFILE} -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/dbbankAnchor_${CHANNEL_TWO_NAME}.tx -channelID ${CHANNEL_TWO_NAME} -asOrg dbbank
echo "========== Anchor Peer Update For DBBank Sucessful =========="
echo ""

echo "========== Generating Anchor Peer Update For IslamiBank =========="
echo ""

configtxgen -profile ${CHANNEL_TWO_PROFILE} -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/islamibankAnchor_${CHANNEL_TWO_NAME}.tx -channelID $CHANNEL_TWO_NAME -asOrg islamibank
echo "========== Anchor Peer Update For IslamiBank Sucessful =========="
echo ""


echo "####################################################################################################################"


echo "===================== Generating  ${CHANNEL_THREE_NAME} =============="
echo " "

configtxgen -profile ${CHANNEL_THREE_PROFILE} -configPath ./configtx/ -outputCreateChannelTx ./channel-artifacts/${CHANNEL_THREE_NAME}.tx -channelID ${CHANNEL_THREE_NAME}

echo "============================ Generated ${CHANNEL_THREE_NAME}==================="

echo " "

echo "========== Generating Anchor Peer Update For ABBank =========="
echo ""

configtxgen -profile ${CHANNEL_THREE_PROFILE} -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/abbankAnchor_${CHANNEL_THREE_NAME}.tx -channelID ${CHANNEL_THREE_NAME} -asOrg abbank
echo "========== Anchor Peer Update For ABBank Sucessful =========="
echo ""

echo "========== Generating Anchor Peer Update For BDBank =========="
echo ""

configtxgen -profile ${CHANNEL_THREE_PROFILE} -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/bdbankAnchor_${CHANNEL_THREE_NAME}.tx -channelID ${CHANNEL_THREE_NAME}  -asOrg bdbank
echo "========== Anchor Peer Update For BDBank Sucessful =========="
echo ""

echo "========== Generating Anchor Peer Update For IslamiBank =========="
echo ""

configtxgen -profile ${CHANNEL_THREE_PROFILE} -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/islamibankAnchor_${CHANNEL_THREE_NAME}.tx -channelID $CHANNEL_THREE_NAME -asOrg islamibank
echo "========== Anchor Peer Update For IslamiBank Sucessful =========="
echo ""

echo "####################################################################################################################"


echo "===================== Generating  ${CHANNEL_FOUR_NAME} =============="
echo " "

configtxgen -profile ${CHANNEL_FOUR_PROFILE} -configPath ./configtx/ -outputCreateChannelTx ./channel-artifacts/${CHANNEL_FOUR_NAME}.tx -channelID ${CHANNEL_FOUR_NAME}

echo "============================ Generated ${CHANNEL_FOUR_NAME}==================="

echo " "

echo "========== Generating Anchor Peer Update For IslamiBank =========="
echo ""

configtxgen -profile ${CHANNEL_FOUR_PROFILE} -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/islamibankAnchor_${CHANNEL_FOUR_NAME}.tx -channelID $CHANNEL_FOUR_NAME -asOrg islamibank
echo "========== Anchor Peer Update For IslamiBank Sucessful =========="
echo ""

echo "========== Generating Anchor Peer Update For BDBank =========="
echo ""

configtxgen -profile ${CHANNEL_FOUR_PROFILE} -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/bdbankAnchor_${CHANNEL_FOUR_NAME}.tx -channelID ${CHANNEL_FOUR_NAME}  -asOrg bdbank
echo "========== Anchor Peer Update For BDBank Sucessful =========="
echo ""

echo "========== Generating Anchor Peer Update For DBBank =========="
echo ""

configtxgen -profile ${CHANNEL_FOUR_PROFILE} -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/dbbankAnchor_${CHANNEL_FOUR_NAME}.tx -channelID ${CHANNEL_FOUR_NAME} -asOrg dbbank
echo "========== Anchor Peer Update For DBBank Sucessful =========="
echo ""
echo "################################################################################################"

echo "===================== Generating  ${CHANNEL_FIVE_NAME} =============="
echo " "

configtxgen -profile ${CHANNEL_FIVE_PROFILE} -configPath ./configtx/ -outputCreateChannelTx ./channel-artifacts/${CHANNEL_FIVE_NAME}.tx -channelID ${CHANNEL_FIVE_NAME}

echo "============================ Generated ${CHANNEL_FIVE_NAME}==================="

echo " "


echo "========== Generating Anchor Peer Update For IslamiBank =========="
echo ""

configtxgen -profile ${CHANNEL_FIVE_PROFILE} -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/islamibankAnchor_${CHANNEL_FIVE_NAME}.tx -channelID $CHANNEL_FIVE_NAME -asOrg islamibank
echo "========== Anchor Peer Update For IslamiBank Sucessful =========="
echo ""


echo "========== Generating Anchor Peer Update For BDBank =========="
echo ""

configtxgen -profile ${CHANNEL_FIVE_PROFILE} -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/bdbankAnchor_${CHANNEL_FIVE_NAME}.tx -channelID ${CHANNEL_FIVE_NAME}  -asOrg bdbank
echo "========== Anchor Peer Update For BDBank Sucessful =========="
echo ""

echo "========== Generating Anchor Peer Update For KrishiBank =========="
echo ""

configtxgen -profile ${CHANNEL_FIVE_PROFILE} -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/krishibankAnchor_${CHANNEL_FIVE_NAME}.tx -channelID ${CHANNEL_FIVE_NAME} -asOrg krishibank
echo "========== Anchor Peer Update For KrishiBank Sucessful =========="
echo ""

echo "####################################################################################"

echo "===================== Generating  ${CHANNEL_SIX_NAME} =============="
echo " "

configtxgen -profile ${CHANNEL_SIX_PROFILE} -configPath ./configtx/ -outputCreateChannelTx ./channel-artifacts/${CHANNEL_SIX_NAME}.tx -channelID ${CHANNEL_SIX_NAME}

echo "============================ Generated ${CHANNEL_SIX_NAME}==================="

echo " "

echo "========== Generating Anchor Peer Update For BDBank =========="
echo ""

configtxgen -profile ${CHANNEL_SIX_PROFILE} -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/bdbankAnchor_${CHANNEL_SIX_NAME}.tx -channelID ${CHANNEL_SIX_NAME}  -asOrg bdbank
echo "========== Anchor Peer Update For BDBank Sucessful =========="
echo ""

echo "========== Generating Anchor Peer Update For DBBank =========="
echo ""

configtxgen -profile ${CHANNEL_SIX_PROFILE} -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/dbbankAnchor_${CHANNEL_SIX_NAME}.tx -channelID ${CHANNEL_SIX_NAME} -asOrg dbbank
echo "========== Anchor Peer Update For DBBank Sucessful =========="
echo ""

echo "========== Generating Anchor Peer Update For ABBank =========="
echo ""

configtxgen -profile ${CHANNEL_SIX_PROFILE} -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/abbankAnchor_${CHANNEL_SIX_NAME}.tx -channelID ${CHANNEL_SIX_NAME} -asOrg abbank
echo "========== Anchor Peer Update For ABBank Sucessful =========="
echo ""


echo "####################################################################################"

echo "===================== Generating  ${CHANNEL_SEVEN_NAME} =============="
echo " "

configtxgen -profile ${CHANNEL_SEVEN_PROFILE} -configPath ./configtx/ -outputCreateChannelTx ./channel-artifacts/${CHANNEL_SEVEN_NAME}.tx -channelID ${CHANNEL_SEVEN_NAME}

echo "============================ Generated ${CHANNEL_SEVEN_NAME}==================="

echo " "


echo "========== Generating Anchor Peer Update For ABBank =========="
echo ""

configtxgen -profile ${CHANNEL_SEVEN_PROFILE} -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/abbankAnchor_${CHANNEL_SEVEN_NAME}.tx -channelID ${CHANNEL_SEVEN_NAME} -asOrg abbank
echo "========== Anchor Peer Update For ABBank Sucessful =========="
echo ""

echo "========== Generating Anchor Peer Update For KrishiBank =========="
echo ""

configtxgen -profile ${CHANNEL_SEVEN_PROFILE} -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/krishibankAnchor_${CHANNEL_SEVEN_NAME}.tx -channelID ${CHANNEL_SEVEN_NAME} -asOrg krishibank
echo "========== Anchor Peer Update For KrishiBank Sucessful =========="
echo ""

echo "################################################################################3"

echo "===================== Generating  ${CHANNEL_EIGHT_NAME} =============="
echo " "

configtxgen -profile ${CHANNEL_EIGHT_PROFILE} -configPath ./configtx/ -outputCreateChannelTx ./channel-artifacts/${CHANNEL_EIGHT_NAME}.tx -channelID $CHANNEL_EIGHT_NAME

echo "============================ Generated ${CHANNEL_EIGHT_NAME}==================="

echo " "


echo "========== Generating Anchor Peer Update For KrishiBank =========="
echo ""

configtxgen -profile ${CHANNEL_EIGHT_PROFILE} -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/krishibankAnchor_${CHANNEL_EIGHT_NAME}.tx -channelID ${CHANNEL_EIGHT_NAME} -asOrg krishibank
echo "========== Anchor Peer Update For KrishiBank Sucessful =========="
echo ""

echo "========== Generating Anchor Peer Update For DBBank =========="
echo ""

configtxgen -profile ${CHANNEL_EIGHT_PROFILE} -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/dbbankAnchor_${CHANNEL_EIGHT_NAME}.tx -channelID ${CHANNEL_EIGHT_NAME} -asOrg dbbank
echo "========== Anchor Peer Update For DBBank Sucessful =========="
echo ""