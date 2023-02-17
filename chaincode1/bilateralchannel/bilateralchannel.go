package main

import (
	"encoding/json"
	"fmt"
	"strconv"
	"strings"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

const nettingChaincodeName string = "netting_cc"
const nettingChannelName string = "netting-channel"

const fundingChaincodeName string = "funding_cc"
const fundingChannelName string = "funding-channel"

const isBilateralNetting bool = true
const regulatorName string = "BangladeshBank"

type lessFunc func(p1, p2 *QueuedTransaction) bool

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

func (t *SimpleChaincode) InitLedger(ctx contractapi.TransactionContextInterface) ([]byte, error) {
	return nil, nil
}

func (t *SimpleChaincode) Invoke(ctx contractapi.TransactionContextInterface) ([]byte, error) {
	function, args := ctx.GetStub().GetFunctionAndParameters()
	fmt.Println("invoke account is running " + function)

	if function == "pingChaincode" {
		return t.pingChaincode(ctx)
	} else if function == "pingChaincodeQuery" {
		return t.pingChaincodeQuery(ctx)

		// Account Functions
	} else if function == "initAccount" {
		return t.initAccount(ctx, args)
	} else if function == "deleteAccount" {
		return t.deleteAccount(ctx, args)
	} else if function == "readAccount" {
		return t.getStateAsBytes(ctx, args)
	} else if function == "freezeAccount" {
		return t.updateAccountStatus(ctx, args, "PAUSED")
	} else if function == "unfreezeAccount" {
		return t.updateAccountStatus(ctx, args, "NORMAL")

		// Fund Manipulation Functions
	} else if function == "pledgeFund" {
		return t.createDestroyFund(ctx, args, pledgeObjectType)
	} else if function == "redeemFund" {
		return t.createDestroyFund(ctx, args, redeemObjectType)
	} else if function == "nettingAdd" {
		return t.createDestroyFund(ctx, args, nettingAddObjectType)
	} else if function == "nettingSubtract" {
		return t.createDestroyFund(ctx, args, nettingSubtractObjectType)
	} else if function == "fundTransfer" {
		return t.fundTransfer(ctx, args)

		// Cross Channel Fund Movement Functions
	} else if function == "moveOutFund" {
		return t.moveOutFund(ctx, args)
	} else if function == "moveInFund" {
		return t.moveInFund(ctx, args)

		// Queueing Functions
	} else if function == "checkQueueAndSettle" {
		return t.checkQueueAndSettle(ctx, args)
	} else if function == "getSortedQueue" {
		return t.getSortedQueueString(ctx)
	} else if function == "getIncomingQueue" {
		return t.getIncomingQueueString(ctx, args)
	} else if function == "getOutgoingQueue" {
		return t.getOutgoingQueueString(ctx, args)
	} else if function == "updatePriority" {
		return t.updateQueuePriority(ctx, args)
	} else if function == "toggleHoldResume" {
		return t.toggleHoldResume(ctx, args)
	} else if function == "cancelQueue" {
		return t.cancelQueue(ctx, args)

		// Multilateral Netting Functions
	} else if function == "getNettableIncomingQueue" {
		return t.getNettableIncomingQueueString(ctx, args)
	} else if function == "getNettableOutgoingQueue" {
		return t.getNettableOutgoingQueueString(ctx, args)
	} else if function == "settleMLNettingInstructions" {
		return t.settleMLNettingInstructions(ctx, args)
	} else if function == "unfreezeAllTransactions" {
		return t.unfreezeAllTransactions(ctx)

		// Other Functions
	} else if function == "getState" {
		return t.getStateAsBytes(ctx, args)
	} else if function == "getTransactionHistory" {
		return t.getTransactionHistory(ctx, args)
	} else if function == "getChannelLiquidity" {
		return t.getChannelLiquidity(ctx)
	} else if function == "resetChannel" {
		return t.resetChannel(ctx, args)
	}

	fmt.Println("Account invoke did not find func: " + function) //error
	return nil, fmt.Errorf("Received unknown function for Bilateral Channel invocation")
}

func (t *SimpleChaincode) pingChaincode(
	ctx contractapi.TransactionContextInterface) ([]byte, error) {

	pingChaincodeAsBytes, err := ctx.GetStub().GetState("pingchaincode")
	if err != nil {
		jsonResp := "Error: Failed to get state for pingchaincode"
		return nil, fmt.Errorf(jsonResp)
	} else if pingChaincodeAsBytes == nil {
		pingChaincode := PingChaincode{"pingchaincode", 1}
		pingChaincodeAsBytes, err = json.Marshal(pingChaincode)
		if err != nil {
			return nil, fmt.Errorf(err.Error())
		}

		err = ctx.GetStub().PutState("pingchaincode", pingChaincodeAsBytes)
		if err != nil {
			return nil, fmt.Errorf(err.Error())
		}
	} else {
		pingChaincode := &PingChaincode{}
		err = json.Unmarshal([]byte(pingChaincodeAsBytes), pingChaincode)
		pingChaincode.Number++
		pingChaincodeAsBytes, err = json.Marshal(pingChaincode)
		if err != nil {
			return nil, fmt.Errorf(err.Error())
		}
		err = ctx.GetStub().PutState("pingchaincode", pingChaincodeAsBytes)
		if err != nil {
			return nil, fmt.Errorf(err.Error())
		}
	}
	return pingChaincodeAsBytes, nil
}

func (t *SimpleChaincode) pingChaincodeQuery(
	ctx contractapi.TransactionContextInterface) ([]byte, error) {

	pingChaincodeAsBytes, err := ctx.GetStub().GetState("pingchaincode")
	if err != nil {
		return nil, fmt.Errorf("Error: Failed to get state for pingchaincode")
	}
	return pingChaincodeAsBytes, nil
}

func (t *SimpleChaincode) getStateAsBytes(
	ctx contractapi.TransactionContextInterface,
	args []string) ([]byte, error) {

	err := checkArgArrayLength(args, 1)
	if err != nil {
		return nil, fmt.Errorf(err.Error())
	}

	key := args[0]
	valAsbytes, err := ctx.GetStub().GetState(key)
	if err != nil {
		return nil, fmt.Errorf("Error: Failed to get state for key (%s)", key)
	} else if valAsbytes == nil {
		errMsg := fmt.Sprintf("Error: Key does not exist (%s)", key)
		return nil, fmt.Errorf(errMsg)
	}

	return valAsbytes, nil
}

func (t *SimpleChaincode) getTransactionHistory(
	ctx contractapi.TransactionContextInterface,
	args []string) ([]byte, error) {

	var completedTransactionArr []CompletedTransaction
	var pledgeRedeemFundArr []PledgeRedeemFund
	var queryString string

	err := checkArgArrayLength(args, 1)
	if err != nil {
		return nil, fmt.Errorf(err.Error())
	}
	accountID := args[0]

	if accountID == regulatorName {
		queryString = fmt.Sprintf(
			`{"selector":{  
	        	"$or":[  
	            	{"docType":"%s"},
	            	{"docType":"%s"},
	            	{"docType":"%s"},
	            	{"docType":"%s"}
	        	]
	    	}}`,
			pledgeObjectType,
			redeemObjectType,
			nettingAddObjectType,
			nettingSubtractObjectType)
	} else {
		queryString = fmt.Sprintf(
			`{"selector":{"docType":"%s"}}`,
			completedTxObjectType)
		completedTransactionArr, err = getCompletedTxArrFromQuery(ctx, queryString)
		if err != nil {
			return nil, fmt.Errorf(err.Error())
		}

		queryString = fmt.Sprintf(
			`{"selector":{  
		        "accountID":"%s",
		        "$or":[  
		            {"docType":"%s"},
		            {"docType":"%s"},
		            {"docType":"%s"},
		            {"docType":"%s"}
		        ]
			}}`,
			accountID,
			pledgeObjectType,
			redeemObjectType,
			nettingAddObjectType,
			nettingSubtractObjectType)
	}

	pledgeRedeemFundArr, err = getPledgeRedeemFundArrFromQuery(ctx, queryString)
	if err != nil {
		return nil, fmt.Errorf(err.Error())
	}

	queryString = fmt.Sprintf(
		`{"selector":{
			"accountID":"%s",
			"$or":[
				{"docType":"moveoutfund"},
				{"docType":"moveinfund"}
			]
		}}`,
		accountID)
	moveOutInFundArr, err := getMoveOutInFundArrayFromQuery(ctx, queryString)
	if err != nil {
		return nil, fmt.Errorf(err.Error())
	}
	transactionHistory := TransactionHistory{
		completedTransactionArr,
		pledgeRedeemFundArr,
		moveOutInFundArr}
	transactionHistoryAsBytes, err := json.Marshal(transactionHistory)
	if err != nil {
		return nil, fmt.Errorf(err.Error())
	}
	return transactionHistoryAsBytes, nil
}

func (t *SimpleChaincode) resetChannel(
	ctx contractapi.TransactionContextInterface,
	args []string) ([]byte, error) {

	var err error
	respMsg := "Successfully reset all assets"

	isResetHistory := false
	if len(args) > 0 && len(args[0]) > 0 {
		isResetHistory, err = strconv.ParseBool(strings.ToLower(args[0]))
		if err != nil {
			return nil, fmt.Errorf(err.Error())
		}
	}

	err = resetAllAccounts(ctx)
	if err != nil {
		return nil, fmt.Errorf(err.Error())
	}

	err = resetAllQueues(ctx)
	if err != nil {
		return nil, fmt.Errorf(err.Error())
	}
	if isResetHistory {
		respMsg = "Successfully reset all assets and transaction history"
		err = resetAllCompletedTx(ctx)
		if err != nil {
			return nil, fmt.Errorf(err.Error())
		}
		err = resetAllPledgeRedeem(ctx)
		if err != nil {
			return nil, fmt.Errorf(err.Error())
		}
		err = resetAllMoveOutInFund(ctx)
		if err != nil {
			return nil, fmt.Errorf(err.Error())
		}
	}

	return []byte(respMsg), nil
}
