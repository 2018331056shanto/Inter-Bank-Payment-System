# Inter-Bank-Payment-System
---
### Table of Content
- [Introduction](https://github.com/2018331056shanto/Inter-Bank-Payment-System#introduction)
- [Motivation](https://github.com/2018331056shanto/Inter-Bank-Payment-System#motivation)
- [Project Structure](https://github.com/2018331056shanto/Inter-Bank-Payment-System#project-structure)
- [Features](https://github.com/2018331056shanto/Inter-Bank-Payment-System#features)
- [Project Overview](https://github.com/2018331056shanto/Inter-Bank-Payment-System#project-overview)

---

## Introduction

The Inter Bank Payment System (IBPS) is distributed banking system that leverages the power of **Hyperledger Fabric**, a robust and secure **Blockchain Technology**. Traditional banking systems often face delays and security vulnerabilities due to their reliance on a central authority. IBPS eliminates these drawbacks by enabling seamless, **Secure**, and **Efficient** transactions between different banks through **Private Channels**, all while ensuring transparency and immutability in the ledger.

---

## Motivation

The motivation behind the development of IBPS stems from the need to address the inherent **Inefficiencies & Vulnerabilities** in the traditional banking system. With the central authority acting as a **Single Point of Failure**, the existing system is prone to delays, potential data interception, and security breaches. IBPS introduce a secure, efficient, and decentralized approach that empowers individual banks while maintaining regulatory oversight from the central authority. By leveraging the cutting-edge features of Hyperledger Fabric and blockchain technology.

---

## Project Structure

```js

Inter-Bank-Payment-System
    |--- Frontend
    |
    |--- API
    |       |--- Server
    |       |       |--- services (helps to make transaction request to the Hyperledger Network)
    |       |
    |       |--- wallet (holds credentials, such as Private Keys and Certificates)
    |       |--- networkConfig (holds the connection information Credentials for every Organization)
    |       |--- app.js (express server as api)
    |
    |--- config
    |        |--- configtx.yaml (configure network)
    |        |--- core.yaml (configure the peer node)
    |        |--- orderer.yaml (configure orderer node)
    |
    |--- bin (holds all the binary files for Hyperledger Fabric)
    |
    |--- configtx (blue print for all the custom channels and access control for an organization in a channel)
    |
    |--- consortium
    |            |--- crypto-config (holds the CA certificate for Orderer and PeerOrganization)
    |            |--- fabric-ca (holds the CA certificates for Organizations)
    |
    |--- docker (holds all the docker file to start Docker Containers for the network to UP)
    |
    |--- chaincode (holds the Chaincode to interact and manipulate the Blockchain ledger)
    |
    |--- generate.sh (script to create and deploy Channel and Chaincode)
    |
    |--- tear.sh (to down the Hyperledger network)



```
---
## Features
- **Decentralized Transaction Processing:** IBPS allows banks to conduct transactions directly with each other, eliminating the need for a central authority and enabling faster and more efficient payments.
- **Enhanced Security Measures:** By utilizing blockchain technology, IBPS ensures the highest level of security for all transactions. The system's inherent decentralization and encryption protocols make it highly resistant to unauthorized access and tampering.
- **Immutable Ledger:** All transaction information is stored on an immutable ledger, providing an auditable and transparent record of all financial activities. This feature fosters trust and accountability among participating banks.
- **Private Channels for Secure Communication:** IBPS offers various types of private channels, including bilateral, multilateral, and bilateral channels with the central bank, enabling secure and confidential communication between banks and the central authority.

---
## Project Overview


