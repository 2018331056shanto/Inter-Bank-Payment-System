export PATH=${PWD}/bin:$PATH 

certificateForBdbank(){

    echo 
    echo "..................Enroll BDBANK CA admin .................."
    echo    
    mkdir -p /consortium/crypto-config/peerOrganizations/bdbank/
    cd consortium
    sudo chmod -R +w crypto-config
    cd ..

    export FABRIC_CA_CLIENT_HOME=${PWD}/consortium/crypto-config/peerOrganizations/bdbank

    fabric-ca-client enroll -u https://admin:adminpw@localhost:1000 --caname ca.bdbank --tls.certfiles ${PWD}/consortium/fabric-ca/bdbank/tls-cert.pem

    echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-1000-ca-bdbank.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-1000-ca-bdbank.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-1000-ca-bdbank.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-1000-ca-bdbank.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/consortium/crypto-config/peerOrganizations/bdbank/msp/config.yaml
 
    echo 
    echo "Register peer0"
    echo 

    fabric-ca-client register --caname ca.bdbank --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/consortium/fabric-ca/bdbank/tls-cert.pem
    echo 
    echo "Register peer1"
    echo
    fabric-ca-client register --caname ca.bdbank --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/consortium/fabric-ca/bdbank/tls-cert.pem
    
    echo
    echo "Register the org admin"
    echo
    
    fabric-ca-client register --caname ca.bdbank --id.name bdbankadmin --id.secret bdbankadminkpw --id.type admin --tls.certfiles ${PWD}/consortium/fabric-ca/bdbank/tls-cert.pem

    echo 
    echo "Register user"
    echo
    
    fabric-ca-client register --caname ca.bdbank --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/consortium/fabric-ca/bdbank/tls-cert.pem

    mkdir -p consortium/crypto-config/peerOrganizations/bdbank/peers
    mkdir -p consortium/crypto-config/peerOrganizations/bdbank/peers/peer0.bdbank



    echo 
    echo "Generate the peer0 msp"
    echo


    

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:1000 --caname ca.bdbank -M ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/peers/peer0.bdbank/msp --csr.hosts peer0.bdbank --tls.certfiles ${PWD}/consortium/fabric-ca/bdbank/tls-cert.pem

    cp ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/msp/config.yaml ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/peers/peer0.bdbank/msp/config.yaml

    echo 
    echo "Generate peer0 tls certificate"
    echo 

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:1000 --caname ca.bdbank -M ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/peers/peer0.bdbank/tls --enrollment.profile tls --csr.hosts localhost --tls.certfiles ${PWD}/consortium/fabric-ca/bdbank/tls-cert.pem
    cp ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/peers/peer0.bdbank/tls/tlscacerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/peers/peer0.bdbank/tls/ca.crt

    cp ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/peers/peer0.bdbank/tls/signcerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/peers/peer0.bdbank/tls/server.crt
    
    cp ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/peers/peer0.bdbank/tls/keystore/*  ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/peers/peer0.bdbank/tls/server.key


     mkdir -p consortium/crypto-config/peerOrganizations/bdbank/msp/tlscacerts

    cp ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/peers/peer0.bdbank/tls/tlscacerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/msp/tlscacerts

     mkdir -p consortium/crypto-config/peerOrganizations/bdbank/tlsca

    cp ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/peers/peer0.bdbank/tls/tlscacerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/tlsca/tlsca.bdbank-cert.pem
    
     mkdir -p consortium/crypto-config/peerOrganizations/bdbank/ca

    cp ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/msp/cacerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/ca/ca.bdbank-cert.pem

    cp  ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/msp/keystore/*  ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/ca/
###########################################################################################################################################################################################################
    
echo 
echo " peer 1"
echo 
    
     mkdir -p consortium/crypto-config/peerOrganizations/bdbank/peers/peer1.bdbank

    echo 
    echo "Generate the peer1 msp"
    echo 

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:1000 --caname ca.bdbank -M ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/peers/peer1.bdbank/msp --csr.hosts peer1.bdbank --tls.certfiles ${PWD}/consortium/fabric-ca/bdbank/tls-cert.pem

    cp ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/msp/config.yaml ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/peers/peer1.bdbank/msp/config.yaml

    echo 
    echo "Generate peer1 tls certificate"
    echo 

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:1000 --caname ca.bdbank -M ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/peers/peer1.bdbank/tls --enrollment.profile tls --csr.hosts localhost --tls.certfiles ${PWD}/consortium/fabric-ca/bdbank/tls-cert.pem

    cp ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/peers/peer1.bdbank/tls/tlscacerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/peers/peer1.bdbank/tls/ca.crt

    cp ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/peers/peer1.bdbank/tls/signcerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/peers/peer1.bdbank/tls/server.crt
    
    cp ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/peers/peer1.bdbank/tls/keystore/*  ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/peers/peer1.bdbank/tls/server.key


    echo 
    echo "Generate the user1 msp"
    echo 
    
     mkdir -p consortium/crypto-config/peerOrganizations/bdbank/users
     mkdir -p consortium/crypto-config/peerOrganizations/bdbank/users/User1


    fabric-ca-client enroll -u https://user1:user1pw@localhost:1000 --caname ca.bdbank -M ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/users/User1/msp --csr.hosts user1.bdbank --tls.certfiles ${PWD}/consortium/fabric-ca/bdbank/tls-cert.pem
    
    cp ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/msp/config.yaml ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/users/User1/msp/config.yaml

     mkdir -p consortium/crypto-config/peerOrganizations/bdbank/users/Admin@bdbank

    echo 
    echo "Generate the org admin msp"
    echo 

    fabric-ca-client enroll -u https://bdbankadmin:bdbankadminkpw@localhost:1000 --caname ca.bdbank  -M ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/users/Admin@bdbank/msp --csr.hosts bdbankadmin.bdbank  --tls.certfiles ${PWD}/consortium/fabric-ca/bdbank/tls-cert.pem
    
    cp ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/msp/config.yaml ${PWD}/consortium/crypto-config/peerOrganizations/bdbank/users/Admin@bdbank/msp/config.yaml


}
certificateForBdbank