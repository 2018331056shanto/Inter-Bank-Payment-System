export PATH=${PWD}/bin:$PATH 
   sudo mkdir -p /consortium/crypto-config/peerOrganizations/bdbank/

    cd consortium
    sudo chmod -R +w crypto-config
    cd ..

certificateForBdbank(){
    
    echo 
    echo "..................Enroll BDBANK CA admin .................."
    echo    
 

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

certificateForABbank(){
  
    echo 
    echo "..................Enroll ABBANK CA admin .................."
    echo    
    sudo mkdir -p /consortium/crypto-config/peerOrganizations/abbank/
    # cd consortium
    # sudo chmod -R +w crypto-config
    # cd ..

    export FABRIC_CA_CLIENT_HOME=${PWD}/consortium/crypto-config/peerOrganizations/abbank

    fabric-ca-client enroll -u https://admin:adminpw@localhost:2000 --caname ca.abbank --tls.certfiles ${PWD}/consortium/fabric-ca/abbank/tls-cert.pem

    echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-2000-ca-abbank.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-2000-ca-abbank.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-2000-ca-abbank.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-2000-ca-abbank.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/consortium/crypto-config/peerOrganizations/abbank/msp/config.yaml
 
    echo 
    echo "Register peer0"
    echo 

    fabric-ca-client register --caname ca.abbank --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/consortium/fabric-ca/abbank/tls-cert.pem
    echo 
    echo "Register peer1"
    echo
    fabric-ca-client register --caname ca.abbank --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/consortium/fabric-ca/abbank/tls-cert.pem
    
    echo
    echo "Register the org admin"
    echo
    
    fabric-ca-client register --caname ca.abbank --id.name abbankadmin --id.secret abbankadminkpw --id.type admin --tls.certfiles ${PWD}/consortium/fabric-ca/abbank/tls-cert.pem

    echo 
    echo "Register user"
    echo
    
    fabric-ca-client register --caname ca.abbank --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/consortium/fabric-ca/abbank/tls-cert.pem

    mkdir -p consortium/crypto-config/peerOrganizations/abbank/peers
    mkdir -p consortium/crypto-config/peerOrganizations/abbank/peers/peer0.abbank



    echo 
    echo "Generate the peer0 msp"
    echo


    

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:2000 --caname ca.abbank -M ${PWD}/consortium/crypto-config/peerOrganizations/abbank/peers/peer0.abbank/msp --csr.hosts peer0.abbank --tls.certfiles ${PWD}/consortium/fabric-ca/abbank/tls-cert.pem

    cp ${PWD}/consortium/crypto-config/peerOrganizations/abbank/msp/config.yaml ${PWD}/consortium/crypto-config/peerOrganizations/abbank/peers/peer0.abbank/msp/config.yaml

    echo 
    echo "Generate peer0 tls certificate"
    echo 

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:2000 --caname ca.abbank -M ${PWD}/consortium/crypto-config/peerOrganizations/abbank/peers/peer0.abbank/tls --enrollment.profile tls --csr.hosts localhost --tls.certfiles ${PWD}/consortium/fabric-ca/abbank/tls-cert.pem
    cp ${PWD}/consortium/crypto-config/peerOrganizations/abbank/peers/peer0.abbank/tls/tlscacerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/abbank/peers/peer0.abbank/tls/ca.crt

    cp ${PWD}/consortium/crypto-config/peerOrganizations/abbank/peers/peer0.abbank/tls/signcerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/abbank/peers/peer0.abbank/tls/server.crt
    
    cp ${PWD}/consortium/crypto-config/peerOrganizations/abbank/peers/peer0.abbank/tls/keystore/*  ${PWD}/consortium/crypto-config/peerOrganizations/abbank/peers/peer0.abbank/tls/server.key


     mkdir -p consortium/crypto-config/peerOrganizations/abbank/msp/tlscacerts

    cp ${PWD}/consortium/crypto-config/peerOrganizations/abbank/peers/peer0.abbank/tls/tlscacerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/abbank/msp/tlscacerts

     mkdir -p consortium/crypto-config/peerOrganizations/abbank/tlsca

    cp ${PWD}/consortium/crypto-config/peerOrganizations/abbank/peers/peer0.abbank/tls/tlscacerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/abbank/tlsca/tlsca.abbank-cert.pem
    
     mkdir -p consortium/crypto-config/peerOrganizations/abbank/ca

    cp ${PWD}/consortium/crypto-config/peerOrganizations/abbank/msp/cacerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/abbank/ca/ca.abbank-cert.pem

    cp  ${PWD}/consortium/crypto-config/peerOrganizations/abbank/msp/keystore/*  ${PWD}/consortium/crypto-config/peerOrganizations/abbank/ca/
###########################################################################################################################################################################################################
    
echo 
echo " peer 1"
echo 
    
     mkdir -p consortium/crypto-config/peerOrganizations/abbank/peers/peer1.abbank

    echo 
    echo "Generate the peer1 msp"
    echo 

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:2000 --caname ca.abbank -M ${PWD}/consortium/crypto-config/peerOrganizations/abbank/peers/peer1.abbank/msp --csr.hosts peer1.abbank --tls.certfiles ${PWD}/consortium/fabric-ca/abbank/tls-cert.pem

    cp ${PWD}/consortium/crypto-config/peerOrganizations/abbank/msp/config.yaml ${PWD}/consortium/crypto-config/peerOrganizations/abbank/peers/peer1.abbank/msp/config.yaml

    echo 
    echo "Generate peer1 tls certificate"
    echo 

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:2000 --caname ca.abbank -M ${PWD}/consortium/crypto-config/peerOrganizations/abbank/peers/peer1.abbank/tls --enrollment.profile tls --csr.hosts localhost --tls.certfiles ${PWD}/consortium/fabric-ca/abbank/tls-cert.pem

    cp ${PWD}/consortium/crypto-config/peerOrganizations/abbank/peers/peer1.abbank/tls/tlscacerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/abbank/peers/peer1.abbank/tls/ca.crt

    cp ${PWD}/consortium/crypto-config/peerOrganizations/abbank/peers/peer1.abbank/tls/signcerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/abbank/peers/peer1.abbank/tls/server.crt
    
    cp ${PWD}/consortium/crypto-config/peerOrganizations/abbank/peers/peer1.abbank/tls/keystore/*  ${PWD}/consortium/crypto-config/peerOrganizations/abbank/peers/peer1.abbank/tls/server.key


    echo 
    echo "Generate the user1 msp"
    echo 
    
     mkdir -p consortium/crypto-config/peerOrganizations/abbank/users
     mkdir -p consortium/crypto-config/peerOrganizations/abbank/users/User1


    fabric-ca-client enroll -u https://user1:user1pw@localhost:2000 --caname ca.abbank -M ${PWD}/consortium/crypto-config/peerOrganizations/abbank/users/User1/msp --csr.hosts user1.abbank --tls.certfiles ${PWD}/consortium/fabric-ca/abbank/tls-cert.pem
    
    cp ${PWD}/consortium/crypto-config/peerOrganizations/abbank/msp/config.yaml ${PWD}/consortium/crypto-config/peerOrganizations/abbank/users/User1/msp/config.yaml

     mkdir -p consortium/crypto-config/peerOrganizations/abbank/users/Admin@abbank

    echo 
    echo "Generate the org admin msp"
    echo 

    fabric-ca-client enroll -u https://abbankadmin:abbankadminkpw@localhost:2000 --caname ca.abbank  -M ${PWD}/consortium/crypto-config/peerOrganizations/abbank/users/Admin@abbank/msp --csr.hosts abbankadmin.abbank  --tls.certfiles ${PWD}/consortium/fabric-ca/abbank/tls-cert.pem
    
    cp ${PWD}/consortium/crypto-config/peerOrganizations/abbank/msp/config.yaml ${PWD}/consortium/crypto-config/peerOrganizations/abbank/users/Admin@abbank/msp/config.yaml


}



certificateForDBbank(){
  

    echo 
    echo "..................Enroll DBBANK CA admin .................."
    echo    
    sudo mkdir -p /consortium/crypto-config/peerOrganizations/dbbank/
    # cd consortium
    # sudo chmod -R +w crypto-config
    # cd ..

    export FABRIC_CA_CLIENT_HOME=${PWD}/consortium/crypto-config/peerOrganizations/dbbank

    fabric-ca-client enroll -u https://admin:adminpw@localhost:4000 --caname ca.dbbank --tls.certfiles ${PWD}/consortium/fabric-ca/dbbank/tls-cert.pem

    echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-4000-ca-dbbank.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-4000-ca-dbbank.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-4000-ca-dbbank.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-4000-ca-dbbank.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/consortium/crypto-config/peerOrganizations/dbbank/msp/config.yaml
 
    echo 
    echo "Register peer0"
    echo 

    fabric-ca-client register --caname ca.dbbank --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/consortium/fabric-ca/dbbank/tls-cert.pem
    echo 
    echo "Register peer1"
    echo
    fabric-ca-client register --caname ca.dbbank --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/consortium/fabric-ca/dbbank/tls-cert.pem
    
    echo
    echo "Register the org admin"
    echo
    
    fabric-ca-client register --caname ca.dbbank --id.name dbbankadmin --id.secret dbbankadminkpw --id.type admin --tls.certfiles ${PWD}/consortium/fabric-ca/dbbank/tls-cert.pem

    echo 
    echo "Register user"
    echo
    
    fabric-ca-client register --caname ca.dbbank --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/consortium/fabric-ca/dbbank/tls-cert.pem

    mkdir -p consortium/crypto-config/peerOrganizations/dbbank/peers
    mkdir -p consortium/crypto-config/peerOrganizations/dbbank/peers/peer0.dbbank



    echo 
    echo "Generate the peer0 msp"
    echo


    

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:4000 --caname ca.dbbank -M ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/peers/peer0.dbbank/msp --csr.hosts peer0.dbbank --tls.certfiles ${PWD}/consortium/fabric-ca/dbbank/tls-cert.pem

    cp ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/msp/config.yaml ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/peers/peer0.dbbank/msp/config.yaml

    echo 
    echo "Generate peer0 tls certificate"
    echo 

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:4000 --caname ca.dbbank -M ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/peers/peer0.dbbank/tls --enrollment.profile tls --csr.hosts localhost --tls.certfiles ${PWD}/consortium/fabric-ca/dbbank/tls-cert.pem
    cp ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/peers/peer0.dbbank/tls/tlscacerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/peers/peer0.dbbank/tls/ca.crt

    cp ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/peers/peer0.dbbank/tls/signcerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/peers/peer0.dbbank/tls/server.crt
    
    cp ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/peers/peer0.dbbank/tls/keystore/*  ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/peers/peer0.dbbank/tls/server.key


     mkdir -p consortium/crypto-config/peerOrganizations/dbbank/msp/tlscacerts

    cp ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/peers/peer0.dbbank/tls/tlscacerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/msp/tlscacerts

     mkdir -p consortium/crypto-config/peerOrganizations/dbbank/tlsca

    cp ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/peers/peer0.dbbank/tls/tlscacerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/tlsca/tlsca.dbbank-cert.pem
    
     mkdir -p consortium/crypto-config/peerOrganizations/dbbank/ca

    cp ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/msp/cacerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/ca/ca.dbbank-cert.pem

    cp  ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/msp/keystore/*  ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/ca/
###########################################################################################################################################################################################################
    
echo 
echo " peer 1"
echo 
    
     mkdir -p consortium/crypto-config/peerOrganizations/dbbank/peers/peer1.dbbank

    echo 
    echo "Generate the peer1 msp"
    echo 

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:4000 --caname ca.dbbank -M ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/peers/peer1.dbbank/msp --csr.hosts peer1.dbbank --tls.certfiles ${PWD}/consortium/fabric-ca/dbbank/tls-cert.pem

    cp ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/msp/config.yaml ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/peers/peer1.dbbank/msp/config.yaml

    echo 
    echo "Generate peer1 tls certificate"
    echo 

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:4000 --caname ca.dbbank -M ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/peers/peer1.dbbank/tls --enrollment.profile tls --csr.hosts localhost --tls.certfiles ${PWD}/consortium/fabric-ca/dbbank/tls-cert.pem

    cp ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/peers/peer1.dbbank/tls/tlscacerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/peers/peer1.dbbank/tls/ca.crt

    cp ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/peers/peer1.dbbank/tls/signcerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/peers/peer1.dbbank/tls/server.crt
    
    cp ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/peers/peer1.dbbank/tls/keystore/*  ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/peers/peer1.dbbank/tls/server.key


    echo 
    echo "Generate the user1 msp"
    echo 
    
     mkdir -p consortium/crypto-config/peerOrganizations/dbbank/users
     mkdir -p consortium/crypto-config/peerOrganizations/dbbank/users/User1


    fabric-ca-client enroll -u https://user1:user1pw@localhost:4000 --caname ca.dbbank -M ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/users/User1/msp --csr.hosts user1.dbbank --tls.certfiles ${PWD}/consortium/fabric-ca/dbbank/tls-cert.pem
    
    cp ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/msp/config.yaml ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/users/User1/msp/config.yaml

     mkdir -p consortium/crypto-config/peerOrganizations/dbbank/users/Admin@dbbank

    echo 
    echo "Generate the org admin msp"
    echo 

    fabric-ca-client enroll -u https://dbbankadmin:dbbankadminkpw@localhost:4000 --caname ca.dbbank  -M ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/users/Admin@dbbank/msp --csr.hosts dbbankadmin.dbbank  --tls.certfiles ${PWD}/consortium/fabric-ca/dbbank/tls-cert.pem
    
    cp ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/msp/config.yaml ${PWD}/consortium/crypto-config/peerOrganizations/dbbank/users/Admin@dbbank/msp/config.yaml


}
certificateForIslamiBank(){
   

    echo 
    echo "..................Enroll KrishiBANK CA admin .................."
    echo    
    sudo mkdir -p /consortium/crypto-config/peerOrganizations/islamibank/
    # cd consortium
    # sudo chmod -R +w crypto-config
    # cd ..

    export FABRIC_CA_CLIENT_HOME=${PWD}/consortium/crypto-config/peerOrganizations/islamibank

    fabric-ca-client enroll -u https://admin:adminpw@localhost:3000 --caname ca.islamibank --tls.certfiles ${PWD}/consortium/fabric-ca/islamibank/tls-cert.pem

    echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-3000-ca-islamibank.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-3000-ca-islamibank.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-3000-ca-islamibank.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-3000-ca-islamibank.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/consortium/crypto-config/peerOrganizations/islamibank/msp/config.yaml
 
    echo 
    echo "Register peer0"
    echo 

    fabric-ca-client register --caname ca.islamibank --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/consortium/fabric-ca/islamibank/tls-cert.pem
    echo 
    echo "Register peer1"
    echo
    fabric-ca-client register --caname ca.islamibank --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/consortium/fabric-ca/islamibank/tls-cert.pem
    
    echo
    echo "Register the org admin"
    echo
    
    fabric-ca-client register --caname ca.islamibank --id.name islamibankadmin --id.secret islamibankadminkpw --id.type admin --tls.certfiles ${PWD}/consortium/fabric-ca/islamibank/tls-cert.pem

    echo 
    echo "Register user"
    echo
    
    fabric-ca-client register --caname ca.islamibank --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/consortium/fabric-ca/islamibank/tls-cert.pem

    mkdir -p consortium/crypto-config/peerOrganizations/islamibank/peers
    mkdir -p consortium/crypto-config/peerOrganizations/islamibank/peers/peer0.islamibank



    echo 
    echo "Generate the peer0 msp"
    echo


    

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:3000 --caname ca.islamibank -M ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/peers/peer0.islamibank/msp --csr.hosts peer0.islamibank --tls.certfiles ${PWD}/consortium/fabric-ca/islamibank/tls-cert.pem

    cp ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/msp/config.yaml ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/peers/peer0.islamibank/msp/config.yaml

    echo 
    echo "Generate peer0 tls certificate"
    echo 

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:3000 --caname ca.islamibank -M ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/peers/peer0.islamibank/tls --enrollment.profile tls --csr.hosts localhost --tls.certfiles ${PWD}/consortium/fabric-ca/islamibank/tls-cert.pem
    cp ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/peers/peer0.islamibank/tls/tlscacerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/peers/peer0.islamibank/tls/ca.crt

    cp ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/peers/peer0.islamibank/tls/signcerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/peers/peer0.islamibank/tls/server.crt
    
    cp ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/peers/peer0.islamibank/tls/keystore/*  ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/peers/peer0.islamibank/tls/server.key


     mkdir -p consortium/crypto-config/peerOrganizations/islamibank/msp/tlscacerts

    cp ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/peers/peer0.islamibank/tls/tlscacerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/msp/tlscacerts

     mkdir -p consortium/crypto-config/peerOrganizations/islamibank/tlsca

    cp ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/peers/peer0.islamibank/tls/tlscacerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/tlsca/tlsca.islamibank-cert.pem
    
     mkdir -p consortium/crypto-config/peerOrganizations/islamibank/ca

    cp ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/msp/cacerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/ca/ca.islamibank-cert.pem

    cp  ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/msp/keystore/*  ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/ca/
###########################################################################################################################################################################################################
    
echo 
echo " peer 1"
echo 
    
     mkdir -p consortium/crypto-config/peerOrganizations/islamibank/peers/peer1.islamibank

    echo 
    echo "Generate the peer1 msp"
    echo 

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:3000 --caname ca.islamibank -M ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/peers/peer1.islamibank/msp --csr.hosts peer1.islamibank --tls.certfiles ${PWD}/consortium/fabric-ca/islamibank/tls-cert.pem

    cp ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/msp/config.yaml ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/peers/peer1.islamibank/msp/config.yaml

    echo 
    echo "Generate peer1 tls certificate"
    echo 

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:3000 --caname ca.islamibank -M ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/peers/peer1.islamibank/tls --enrollment.profile tls --csr.hosts localhost --tls.certfiles ${PWD}/consortium/fabric-ca/islamibank/tls-cert.pem

    cp ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/peers/peer1.islamibank/tls/tlscacerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/peers/peer1.islamibank/tls/ca.crt

    cp ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/peers/peer1.islamibank/tls/signcerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/peers/peer1.islamibank/tls/server.crt
    
    cp ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/peers/peer1.islamibank/tls/keystore/*  ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/peers/peer1.islamibank/tls/server.key


    echo 
    echo "Generate the user1 msp"
    echo 
    
     mkdir -p consortium/crypto-config/peerOrganizations/islamibank/users
     mkdir -p consortium/crypto-config/peerOrganizations/islamibank/users/User1


    fabric-ca-client enroll -u https://user1:user1pw@localhost:3000 --caname ca.islamibank -M ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/users/User1/msp --csr.hosts user1.islamibank --tls.certfiles ${PWD}/consortium/fabric-ca/islamibank/tls-cert.pem
    
    cp ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/msp/config.yaml ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/users/User1/msp/config.yaml

     mkdir -p consortium/crypto-config/peerOrganizations/islamibank/users/Admin@islamibank

    echo 
    echo "Generate the org admin msp"
    echo 

    fabric-ca-client enroll -u https://islamibankadmin:islamibankadminkpw@localhost:3000 --caname ca.islamibank  -M ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/users/Admin@islamibank/msp --csr.hosts islamibankadmin.islamibank  --tls.certfiles ${PWD}/consortium/fabric-ca/islamibank/tls-cert.pem
    
    cp ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/msp/config.yaml ${PWD}/consortium/crypto-config/peerOrganizations/islamibank/users/Admin@islamibank/msp/config.yaml

}
certificateForKrishiBank(){

  
    echo 
    echo "..................Enroll KrishiBANK CA admin .................."
    echo    
    sudo mkdir -p /consortium/crypto-config/peerOrganizations/krishibank/
    # cd consortium
    # sudo chmod -R +w crypto-config
    # cd ..

    export FABRIC_CA_CLIENT_HOME=${PWD}/consortium/crypto-config/peerOrganizations/krishibank

    fabric-ca-client enroll -u https://admin:adminpw@localhost:5000 --caname ca.krishibank --tls.certfiles ${PWD}/consortium/fabric-ca/krishibank/tls-cert.pem

    echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-5000-ca-krishibank.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-5000-ca-krishibank.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-5000-ca-krishibank.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-5000-ca-krishibank.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/consortium/crypto-config/peerOrganizations/krishibank/msp/config.yaml
 
    echo 
    echo "Register peer0"
    echo 

    fabric-ca-client register --caname ca.krishibank --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/consortium/fabric-ca/krishibank/tls-cert.pem
    echo 
    echo "Register peer1"
    echo
    fabric-ca-client register --caname ca.krishibank --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/consortium/fabric-ca/krishibank/tls-cert.pem
    
    echo
    echo "Register the org admin"
    echo
    
    fabric-ca-client register --caname ca.krishibank --id.name krishibankadmin --id.secret krishibankadminkpw --id.type admin --tls.certfiles ${PWD}/consortium/fabric-ca/krishibank/tls-cert.pem

    echo 
    echo "Register user"
    echo
    
    fabric-ca-client register --caname ca.krishibank --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/consortium/fabric-ca/krishibank/tls-cert.pem

    mkdir -p consortium/crypto-config/peerOrganizations/krishibank/peers
    mkdir -p consortium/crypto-config/peerOrganizations/krishibank/peers/peer0.krishibank



    echo 
    echo "Generate the peer0 msp"
    echo


    

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:5000 --caname ca.krishibank -M ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/peers/peer0.krishibank/msp --csr.hosts peer0.krishibank --tls.certfiles ${PWD}/consortium/fabric-ca/krishibank/tls-cert.pem

    cp ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/msp/config.yaml ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/peers/peer0.krishibank/msp/config.yaml

    echo 
    echo "Generate peer0 tls certificate"
    echo 

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:5000 --caname ca.krishibank -M ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/peers/peer0.krishibank/tls --enrollment.profile tls --csr.hosts localhost --tls.certfiles ${PWD}/consortium/fabric-ca/krishibank/tls-cert.pem
    cp ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/peers/peer0.krishibank/tls/tlscacerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/peers/peer0.krishibank/tls/ca.crt

    cp ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/peers/peer0.krishibank/tls/signcerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/peers/peer0.krishibank/tls/server.crt
    
    cp ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/peers/peer0.krishibank/tls/keystore/*  ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/peers/peer0.krishibank/tls/server.key


     mkdir -p consortium/crypto-config/peerOrganizations/krishibank/msp/tlscacerts

    cp ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/peers/peer0.krishibank/tls/tlscacerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/msp/tlscacerts

     mkdir -p consortium/crypto-config/peerOrganizations/krishibank/tlsca

    cp ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/peers/peer0.krishibank/tls/tlscacerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/tlsca/tlsca.krishibank-cert.pem
    
     mkdir -p consortium/crypto-config/peerOrganizations/krishibank/ca

    cp ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/msp/cacerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/ca/ca.krishibank-cert.pem

    cp  ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/msp/keystore/*  ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/ca/
###########################################################################################################################################################################################################
    
echo 
echo " peer 1"
echo 
    
     mkdir -p consortium/crypto-config/peerOrganizations/krishibank/peers/peer1.krishibank

    echo 
    echo "Generate the peer1 msp"
    echo 

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:5000 --caname ca.krishibank -M ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/peers/peer1.krishibank/msp --csr.hosts peer1.krishibank --tls.certfiles ${PWD}/consortium/fabric-ca/krishibank/tls-cert.pem

    cp ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/msp/config.yaml ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/peers/peer1.krishibank/msp/config.yaml

    echo 
    echo "Generate peer1 tls certificate"
    echo 

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:5000 --caname ca.krishibank -M ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/peers/peer1.krishibank/tls --enrollment.profile tls --csr.hosts localhost --tls.certfiles ${PWD}/consortium/fabric-ca/krishibank/tls-cert.pem

    cp ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/peers/peer1.krishibank/tls/tlscacerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/peers/peer1.krishibank/tls/ca.crt

    cp ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/peers/peer1.krishibank/tls/signcerts/*  ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/peers/peer1.krishibank/tls/server.crt
    
    cp ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/peers/peer1.krishibank/tls/keystore/*  ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/peers/peer1.krishibank/tls/server.key


    echo 
    echo "Generate the user1 msp"
    echo 
    
     mkdir -p consortium/crypto-config/peerOrganizations/krishibank/users
     mkdir -p consortium/crypto-config/peerOrganizations/krishibank/users/User1


    fabric-ca-client enroll -u https://user1:user1pw@localhost:5000 --caname ca.krishibank -M ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/users/User1/msp --csr.hosts user1.krishibank --tls.certfiles ${PWD}/consortium/fabric-ca/krishibank/tls-cert.pem
    
    cp ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/msp/config.yaml ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/users/User1/msp/config.yaml

     mkdir -p consortium/crypto-config/peerOrganizations/krishibank/users/Admin@krishibank

    echo 
    echo "Generate the org admin msp"
    echo 

    fabric-ca-client enroll -u https://krishibankadmin:krishibankadminkpw@localhost:5000 --caname ca.krishibank  -M ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/users/Admin@krishibank/msp --csr.hosts krishibankadmin.krishibank  --tls.certfiles ${PWD}/consortium/fabric-ca/krishibank/tls-cert.pem
    
    cp ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/msp/config.yaml ${PWD}/consortium/crypto-config/peerOrganizations/krishibank/users/Admin@krishibank/msp/config.yaml


}

createCretificateForOrderer() {
  echo
  echo "Enroll CA admin of Orderer"
  echo
  mkdir -p ./consortium/crypto-config/ordererOrganizations/example.com

  export FABRIC_CA_CLIENT_HOME=${PWD}/consortium/crypto-config/ordererOrganizations/example.com

  fabric-ca-client enroll -u https://admin:adminpw@localhost:6000 --caname ca.orderer --tls.certfiles ${PWD}/consortium/fabric-ca/orderer/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-6000-ca-orderer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-6000-ca-orderer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-6000-ca-orderer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-6000-ca-orderer.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/consortium/crypto-config/ordererOrganizations/example.com/msp/config.yaml

  echo
  echo "Register orderer"
  echo

  fabric-ca-client register --caname ca.orderer --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/consortium/fabric-ca/orderer/tls-cert.pem

  echo
  echo "Register orderer2"
  echo

  fabric-ca-client register --caname ca.orderer --id.name orderer2 --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/consortium/fabric-ca/orderer/tls-cert.pem

  echo
  echo "Register orderer3"
  echo

  fabric-ca-client register --caname ca.orderer --id.name orderer3 --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/consortium/fabric-ca/orderer/tls-cert.pem

  echo
  echo "Register the Orderer Admin"
  echo

  fabric-ca-client register --caname ca.orderer --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles ${PWD}/consortium/fabric-ca/orderer/tls-cert.pem

  # ---------------------------------------------------------------------------
  #  Orderer

  mkdir -p ./consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com

  echo
  echo "Generate the Orderer MSP"
  echo

  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:6000 --caname ca.orderer -M ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp --csr.hosts orderer.example.com --csr.hosts localhost --tls.certfiles ${PWD}/consortium/fabric-ca/orderer/tls-cert.pem

  cp ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/msp/config.yaml ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/config.yaml

  echo
  echo "Generate the orderer TLS Certs"
  echo

  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:6000 --caname ca.orderer -M ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls --enrollment.profile tls --csr.hosts orderer.example.com --csr.hosts localhost --tls.certfiles ${PWD}/consortium/fabric-ca/orderer/tls-cert.pem

  cp ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/tlscacerts/* ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt
  cp ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/signcerts/* ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.crt
  cp ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/keystore/* ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.key

  mkdir ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts
  cp ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/tlscacerts/* ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

  mkdir ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/msp/tlscacerts
  cp ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/tlscacerts/* ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem

  # -----------------------------------------------------------------------
  #  Orderer 2

  mkdir -p ./consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com

  echo
  echo "Generate the Orderer2 MSP"
  echo

  fabric-ca-client enroll -u https://orderer2:ordererpw@localhost:6000 --caname ca.orderer -M ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/msp --csr.hosts orderer2.example.com --csr.hosts localhost --tls.certfiles ${PWD}/consortium/fabric-ca/orderer/tls-cert.pem

  cp ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/msp/config.yaml ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/msp/config.yaml

  echo
  echo "Generate the Orderer2 TLS Certs"
  echo

  fabric-ca-client enroll -u https://orderer2:ordererpw@localhost:6000 --caname ca.orderer -M ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls --enrollment.profile tls --csr.hosts orderer2.example.com --csr.hosts localhost --tls.certfiles ${PWD}/consortium/fabric-ca/orderer/tls-cert.pem

  cp ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/tlscacerts/* ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/ca.crt
  cp ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/signcerts/* ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/server.crt
  cp ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/keystore/* ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/server.key

  mkdir ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/msp/tlscacerts
  cp ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/tlscacerts/* ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

  # ---------------------------------------------------------------------------
  #  Orderer 3
  mkdir -p ./consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com

  echo
  echo "Generate the Orderer3 MSP"
  echo

  fabric-ca-client enroll -u https://orderer3:ordererpw@localhost:6000 --caname ca.orderer -M ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/msp --csr.hosts orderer3.example.com --csr.hosts localhost --tls.certfiles ${PWD}/consortium/fabric-ca/orderer/tls-cert.pem

  cp ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/msp/config.yaml ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/msp/config.yaml

  echo
  echo "Generate the Orderer3 TLS certs"
  echo

  fabric-ca-client enroll -u https://orderer3:ordererpw@localhost:6000 --caname ca.orderer -M ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls --enrollment.profile tls --csr.hosts orderer3.example.com --csr.hosts localhost --tls.certfiles ${PWD}/consortium/fabric-ca/orderer/tls-cert.pem

  cp ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/tlscacerts/* ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/ca.crt
  cp ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/signcerts/* ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/server.crt
  cp ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/keystore/* ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/server.key

  mkdir ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/msp/tlscacerts
  cp ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/tlscacerts/* ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
  # ---------------------------------------------------------------------------

  mkdir -p ./consortium/crypto-config/ordererOrganizations/example.com/users
  mkdir -p ./consortium/crypto-config/ordererOrganizations/example.com/users/Admin@example.com

  echo
  echo "Generate the Admin MSP Orderer"
  echo

  fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:6000 --caname ca.orderer -M ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp --tls.certfiles ${PWD}/consortium/fabric-ca/orderer/tls-cert.pem

  cp ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/msp/config.yaml ${PWD}/consortium/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp/config.yaml

}




certificateForBdbank
certificateForABbank
certificateForDBbank
certificateForIslamiBank
certificateForKrishiBank
createCretificateForOrderer


