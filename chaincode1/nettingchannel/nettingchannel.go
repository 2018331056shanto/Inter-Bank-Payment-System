package main

import (
	"encoding/json"
	"fmt"
	"github.com/hyperledger/fabric-contract-api-go/contractapi"

)
const timeLayout string = "2006-01-02T15:04:05.999Z"
const cycleExpiryMinutes float64 = 5
const regulatorName string = "BangladeshBank"



func main() {
	chaincode, err := contractapi.NewChaincode(new(SimpleChaincode))
	if err != nil {
		fmt.Printf("Error starting Simple chaincode: %s", err)
		return
	}

	if err := chaincode.Start(); err != nil {
		fmt.Printf("Error starting Simple chaincode: %s", err)
	}
}

func (t *SimpleChaincode) InitLedger(ctx contractapi.TransactionContextInterface) ([]byte,error) {
	currTime, err := t.getTxTimeStampAsTime(ctx)

	if err != nil {
		return nil,err
	}
	bankRequestMap := make(map[string]BankRequest)

	nettingCycle := NettingCycle{}
	nettingCycle.ObjectType = nettingCycleObjectType
	nettingCycle.CycleID = 0
	nettingCycle.Status = "SETTLED"
	nettingCycle.BankRequests = bankRequestMap
	nettingCycle.Created = currTime
	nettingCycle.Updated = currTime

	nettingCycleAsBytes, err := json.Marshal(nettingCycle)
	if err != nil {
		return nil,err
	}
	err = ctx.GetStub().PutState(nettingCycleObjectType, nettingCycleAsBytes)
	if err != nil {
		return nil,err
	}


	return nil,nil
}

func (t *SimpleChaincode) Invoke(ctx contractapi.TransactionContextInterface) ([]byte,error) {
 
	function, args := ctx.GetStub().GetFunctionAndParameters()
	fmt.Println("invoke MultilateralChannel is running " + function)

	if function == "pingChaincode" {
		
		return t.pingChaincode(ctx)
	} else if function == "pingChaincodeQuery" {
		return t.pingChaincodeQuery(ctx)

		// Functions for initiation/participation
	} else if function == "conductMLNetting" {
		return t.conductMLNetting(ctx, args)
	} else if function == "queryOngoingMLNetting" {
		return t.queryOngoingMLNetting(ctx)

		// Functions for updating netting cycle status
	} else if function == "expireOngoingMLNetting" {
		return t.expireOngoingMLNetting(ctx)
	} else if function == "settleOngoingMLNetting" {
		return t.updateOngoingMLNettingStatus(ctx, "SETTLED")
	} else if function == "failOngoingMLNetting" {
		return t.updateOngoingMLNettingStatus(ctx, "FAILED")
	} else if function == "getNonNettableTxList" {
		return t.getNonNettableTxList(ctx)

		// Other Functions
	} else if function == "checkParticipation" {
		return t.checkParticipation(ctx, args)
	} else if function == "getBilateralNettableTxList" {
		return t.getBilateralNettableTxList(ctx, args)
	} else if function == "resetChannel" {
		return t.resetChannel(ctx)
	}

	fmt.Println("Netting channel chaincode invocation did not find func: " + function) //error
	return nil,fmt.Errorf("Received unknown function")
}


func (t *SimpleChaincode) pingChaincode(ctx contractapi.TransactionContextInterface) ([]byte,error) {
	pingChaincodeAsBytes, err := ctx.GetStub().GetState("pingchaincode")
	if err != nil {
		return nil,fmt.Errorf("failed to read from world state: %v", err)
	}

	if pingChaincodeAsBytes == nil {
		pingChaincode := PingChaincode{"pingchaincode", 1}
		pingChaincodeAsBytes, err = json.Marshal(pingChaincode)
		if err != nil {
			return nil,fmt.Errorf("failed to marshal pingchaincode: %v", err)
		}

		err = ctx.GetStub().PutState("pingchaincode", pingChaincodeAsBytes)
		if err != nil {
			return nil,fmt.Errorf("failed to write to world state: %v", err)
		}
	} else {
		pingChaincode := &PingChaincode{}
		err = json.Unmarshal(pingChaincodeAsBytes, pingChaincode)
		if err != nil {
			return nil,fmt.Errorf("failed to unmarshal pingchaincode: %v", err)
		}
		pingChaincode.Number++
		pingChaincodeAsBytes, err = json.Marshal(pingChaincode)
		if err != nil {
			return nil, fmt.Errorf("failed to marshal pingchaincode: %v", err)
		}
		err = ctx.GetStub().PutState("pingchaincode", pingChaincodeAsBytes)
		if err != nil {
			return nil,fmt.Errorf("failed to write to world state: %v", err)
		}
	}

	return pingChaincodeAsBytes,nil
}

func (t *SimpleChaincode) pingChaincodeQuery(ctx contractapi.TransactionContextInterface) ([]byte,error) {
    pingChaincodeAsBytes, err := ctx.GetStub().GetState("pingchaincode")
	fmt.Println(pingChaincodeAsBytes)
    if err != nil {
        return nil,fmt.Errorf("failed to read from world state: %w", err)
    }
    return pingChaincodeAsBytes,nil
}


func (t *SimpleChaincode) resetChannel(ctx contractapi.TransactionContextInterface) ([]byte,error) {
	
	err:=t.resetNettingCycle(ctx)

	if err != nil {
		return nil,fmt.Errorf(err.Error())
	}

	err = t.ResetBankRequests(ctx)
	if err != nil {
		return nil,fmt.Errorf(err.Error())
	}
	return nil,nil
}
