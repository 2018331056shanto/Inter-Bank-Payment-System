package main

import (
	"time"

	// "golang.org/x/text/number"
	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

// "time"

const bankRequestObjectType string = "bankrequest"
const nettingCycleObjectType string = "nettingcycle"

type BankRequest struct {
	ObjectType      string   `json:"docType"`
	BankRequestID   string   `json:"bankRequestID"`
	BankID          string   `json:"bankID"`
	NetValue        float64  `json:"netvalue"`
	NettableList    []string `json:"nettableList"`
	NonNettableList []string `json:"nonNettableList"`
}
type NettingCycle struct {
	ObjectType   string                 `json:"docType"`
	CycleID      int                    `json:"cycleID"`
	Status       string                 `json:"status"`
	Created      time.Time              `json:"created"`
	Updated      time.Time              `json:"updated"`
	BankRequests map[string]BankRequest `json:"bankRequests"`
}

type PingChaincode struct {
	ObjectType string `json:"docType"`
	Number     int    `json:"number"`
}

type SimpleChaincode struct {
	contractapi.Contract
}
type ReturnValue struct {
}
