package main

import (
	"encoding/json"
	"fmt"
	"strconv"
	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

// ***********************************************************
// External Queue Getter Functions
// ***********************************************************

func (t *SimpleChaincode) getSortedQueueString(
	ctx contractapi.TransactionContextInterface)([]byte, error) {

	queryString := fmt.Sprintf(
		`{"selector":{"docType":"%s"}}`,
		queuedTxObjectType)
	queryResults, err := getSortedQueues(ctx, queryString)
	if err != nil {
		return nil, fmt.Errorf("Error retrieving sorted queue: %s", err)
	}
	queryResultsString, err := json.MarshalIndent(queryResults, "", "  ")
	if err != nil {
		return nil, fmt.Errorf("Error marshalling sorted queue: %s", err)
	}
	return []byte(queryResultsString), nil
}

func (t *SimpleChaincode) getOutgoingQueueString(
	ctx contractapi.TransactionContextInterface,
	args []string) ([]byte, error) {

	err := checkArgArrayLength(args, 1)
	if err != nil {
		return nil, fmt.Errorf("Incorrect number of arguments. Expecting 1")
	}
	var accountID string
	accountID = args[0]
	queryString := fmt.Sprintf(
		`{"selector":{"docType":"%s","sender":"%s"}}`,
		queuedTxObjectType,
		accountID)
	queryResults, err := getSortedQueues(ctx, queryString)
	if err != nil {
		return nil, fmt.Errorf("Error retrieving outgoing queue: %s", err)
	}
	queryResultsString, err := json.MarshalIndent(queryResults, "", "  ")
	if err != nil {
		return nil, fmt.Errorf("Error marshalling outgoing queue: %s", err)
	}
	return []byte(queryResultsString), nil
}

func (t *SimpleChaincode) getIncomingQueueString(
	ctx contractapi.TransactionContextInterface,
	args []string) ([]byte, error) {

	err := checkArgArrayLength(args, 1)
	if err != nil {
		return nil, fmt.Errorf("Incorrect number of arguments. Expecting 1")
	}
	accountID := args[0]
	queryString := fmt.Sprintf(
		`{"selector":{"docType":"%s","receiver":"%s"}}`,
		queuedTxObjectType,
		accountID)
	queryResults, err := getSortedQueues(ctx, queryString)
	if err != nil {
		return  nil, fmt.Errorf("Error retrieving incoming queue: %s", err)
	}
	queryResultsString, err := json.MarshalIndent(queryResults, "", "  ")
	if err != nil {
		return nil, fmt.Errorf("Error marshalling incoming queue: %s", err)
	}
	return []byte(queryResultsString), nil
}

func (t *SimpleChaincode) getNettableOutgoingQueueString(
	ctx contractapi.TransactionContextInterface,
	args []string) ([]byte, error) {

	err := checkArgArrayLength(args, 1)
	if err != nil {
		return nil, fmt.Errorf("Incorrect number of arguments. Expecting 1")
	}
	accountID := args[0]
	queryString := fmt.Sprintf(
		`{"selector":{
			"docType":"%s",
			"status":"ACTIVE",
			"sender":"%s",
			"nettable":true,
			"isFrozen":false
		}}`,
		queuedTxObjectType,
		accountID)
	queryResults, err := getSortedQueues(ctx, queryString)
	if err != nil {
		return nil, fmt.Errorf("Error retrieving nettable outgoing queue: %s", err)
	}
	queryResultsString, err := json.MarshalIndent(queryResults, "", "  ")
	if err != nil {
		return nil, fmt.Errorf("Error marshalling nettable outgoing queue: %s", err)
	}
	return []byte(queryResultsString), nil
}

func (t *SimpleChaincode) getNettableIncomingQueueString(
	ctx contractapi.TransactionContextInterface,
	args []string) ([]byte, error) {

	err := checkArgArrayLength(args, 1)
	if err != nil {
		return nil, fmt.Errorf("Incorrect number of arguments. Expecting 1")
	}
	accountID := args[0]
	queryString := fmt.Sprintf(
		`{"selector":{
			"docType":"%s",
			"status":"ACTIVE",
			"receiver":"%s",
			"nettable":true,
			"isFrozen":false
		}}`,
		queuedTxObjectType,
		accountID)
	queryResults, err := getSortedQueues(ctx, queryString)
	if err != nil {
		return nil, fmt.Errorf("Error retrieving nettable incoming queue: %s", err)
	}
	queryResultsString, err := json.MarshalIndent(queryResults, "", "  ")
	if err != nil {
		return nil, fmt.Errorf("Error marshalling nettable incoming queue: %s", err)
	}
	return []byte(queryResultsString), nil
}

// ***********************************************************
// External Queue Update Functions
// ***********************************************************

func (t *SimpleChaincode) updateQueueStatus(
	ctx contractapi.TransactionContextInterface,
	args []string,
	status string) error {

	err := checkArgArrayLength(args, 1)
	if err != nil {
		return fmt.Errorf("Incorrect number of arguments. Expecting 1")
	}
	if len(args[0]) <= 0 {
		return fmt.Errorf("Reference ID must be a non-empty string")
	}
	if len(status) <= 0 {
		return fmt.Errorf("Status must be a non-empty string")
	}

	refID := args[0]

	queuedTx, err := getQueueStructFromID(ctx, refID)
	if err != nil {
		return fmt.Errorf("Error retrieving queued transaction: %s", err)
	}
	queuedTx.Status = status
	queuedTx.UpdateTime, err = getTxTimeStampAsTime(ctx)
	if err != nil {
		return fmt.Errorf("Error retrieving transaction timestamp: %s", err)
	}

	queuedTxAsBytes, err := json.Marshal(queuedTx)
	if err != nil {
		return fmt.Errorf("Error marshalling queued transaction: %s", err)
	}
	err = ctx.GetStub().PutState(queuedTx.RefID, queuedTxAsBytes)
	if err != nil {
		return fmt.Errorf("Error updating queued transaction: %s", err)
	}

	return nil
}

func (t *SimpleChaincode) toggleHoldResume(
	ctx contractapi.TransactionContextInterface,
	args []string) ([]byte, error) {

	err := checkArgArrayLength(args, 1)
	if err != nil {
		return nil,fmt.Errorf("Incorrect number of arguments. Expecting 1")
	}
	if len(args[0]) <= 0 {
		return nil,fmt.Errorf("Reference ID must be a non-empty string")
	}

	queueID := args[0]

	queuedTx, err := getQueueStructFromID(ctx, queueID)
	if err != nil {
		return nil,fmt.Errorf("Error retrieving queued transaction: %s", err)
	}

	var respMsg string
	if queuedTx.Status == "HOLD" {
		respMsg = fmt.Sprintf("Successfully changed status of %s to ACTIVE", queueID)
		queuedTx.Status = "ACTIVE"
	} else if queuedTx.Status == "ACTIVE" {
		respMsg = fmt.Sprintf("Successfully changed status of %s to HOLD", queueID)
		queuedTx.Status = "HOLD"
	}

	queuedTx.UpdateTime, err = getTxTimeStampAsTime(ctx)
	if err != nil {
		return nil,fmt.Errorf("Error retrieving transaction timestamp: %s", err)
	}

	queuedTxAsBytes, err := json.Marshal(queuedTx)
	if err != nil {
		return nil,fmt.Errorf("Error marshalling queued transaction: %s", err)
	}
	err = ctx.GetStub().PutState(queuedTx.RefID, queuedTxAsBytes)
	if err != nil {
		return nil,fmt.Errorf("Error updating queued transaction: %s", err)
	}

	return []byte(respMsg),nil
}

func (t *SimpleChaincode) updateQueuePriority(
	ctx contractapi.TransactionContextInterface,
	args []string) ([]byte,error) {

	// instructionID, priority, currentTime
	err := checkArgArrayLength(args, 2)
	if err != nil {
		return nil,fmt.Errorf("Incorrect number of arguments. Expecting 2")	
	}
	if len(args[0]) <= 0 {
		return nil,fmt.Errorf("Reference ID must be a non-empty string")
	}
	if len(args[1]) <= 0 {
		return nil,fmt.Errorf("Priority must be a non-empty string")
	}

	refID := args[0]
	priority, err := strconv.Atoi(args[1])
	if err != nil {
		return nil,fmt.Errorf("Priority must be an integer")
	}

	isParticipatingInNetting, err := checkMLNettingParticipation(ctx)
	if err != nil {
		return nil,fmt.Errorf("Error checking multilateral netting participation: %s", err)
	} else if isParticipatingInNetting {
		errMsg := "Error: Multilateral netting is ongoing"
		return nil,fmt.Errorf(errMsg)
	}

	queuedTx, err := getQueueStructFromID(ctx, refID)
	if err != nil {
		return nil,fmt.Errorf("Error retrieving queued transaction: %s", err)
	}
	queuedTx.Priority = priority
	queuedTx.UpdateTime, err = getTxTimeStampAsTime(ctx)
	if err != nil {
		return nil,fmt.Errorf("Error retrieving transaction timestamp: %s", err)
	}

	queuedTxAsBytes, err := json.Marshal(queuedTx)
	if err != nil {
		return nil,fmt.Errorf("Error marshalling queued transaction: %s", err)
	}
	err = ctx.GetStub().PutState(queuedTx.RefID, queuedTxAsBytes)
	if err != nil {
		return nil,fmt.Errorf("Error updating queued transaction: %s", err)
	}

	return queuedTxAsBytes,nil
}

func (t *SimpleChaincode) cancelQueue(
	ctx contractapi.TransactionContextInterface,
	args []string) ([]byte, error) {

	// queueID
	err := checkArgArrayLength(args, 1)
	if err != nil {
		return nil,fmt.Errorf("Incorrect number of arguments. Expecting 1")
	}
	if len(args[0]) <= 0 {
		return nil,fmt.Errorf("Reference ID must be a non-empty string")
	}

	refID := args[0]

	isParticipatingInNetting, err := checkMLNettingParticipation(ctx)
	if err != nil {
		return nil,fmt.Errorf("Error checking multilateral netting participation: %s", err)
	} else if isParticipatingInNetting {
		errMsg := "Error: Multilateral netting is ongoing"
		return nil,fmt.Errorf(errMsg)
	}

	queuedTx, err := getQueueStructFromID(ctx, refID)
	if err != nil {
		return nil,fmt.Errorf("Error retrieving queued transaction: %s", err)
	}
	err = moveQueuedTxStructToCompleted(ctx, *queuedTx, "CANCELLED")
	if err != nil {
		return nil,fmt.Errorf("Error moving queued transaction to completed: %s", err)
	}

	return []byte("Cancellation Success"),nil
}

func (t *SimpleChaincode) checkQueueAndSettle(
	ctx contractapi.TransactionContextInterface,
	args []string)([]byte, error) {

	var totalSettledAmount float64
	var receiverAccount *Account
	var unsettledTxList []QueuedTransaction

	// accountID
	err := checkArgArrayLength(args, 1)
	if err != nil {
		return nil,fmt.Errorf("Incorrect number of arguments. Expecting 1")
	}
	if len(args[0]) <= 0 {
		return nil,fmt.Errorf("Account ID must be a non-empty string")
	}

	accountID := args[0]

	// Access Control
	err = verifyIdentity(ctx, accountID, regulatorName)
	if err != nil {
		return nil,fmt.Errorf("Error verifying identity: %s", err)
	}

	isParticipatingInNetting, err := checkMLNettingParticipation(ctx)
	if err != nil {
		return nil,fmt.Errorf("Error checking multilateral netting participation: %s", err)
	} else if isParticipatingInNetting {
		errMsg := "Error: Multilateral netting is ongoing"
		return nil,fmt.Errorf(errMsg)
	}

	senderAccount, err := getAccountStructFromID(ctx, accountID)
	if err != nil {
		return nil,fmt.Errorf("Error retrieving account: %s", err)
	}
	accountBal := senderAccount.Amount
	queryString := fmt.Sprintf(
		`{"selector":{
			"docType":"%s",
			"status":"ACTIVE",
			"sender":"%s"
		}}`,
		queuedTxObjectType,
		accountID)
	queueArr, err := getSortedQueues(ctx, queryString)
	if err != nil {
		return nil,fmt.Errorf("Error retrieving queued transactions: %s", err)
	}

	totalSettledAmount = 0
	for i, queueElement := range queueArr {
		if queueElement.Amount <= accountBal {
			amount := queueElement.Amount

			err = moveQueuedTxStructToCompleted(ctx, queueElement, "SETTLED")
			if err != nil {
				return nil,fmt.Errorf("Error moving queued transaction to completed: %s", err)
			}
			totalSettledAmount += amount
			accountBal -= amount
		} else {
			unsettledTxList = queueArr[i:]
			break
		}
	}

	accountList, err := getListOfAccounts(ctx)
	if err != nil {
		return nil,fmt.Errorf("Error retrieving account list: %s", err)
	}
	if accountList[0] != accountID {
		receiverAccount, err = getAccountStructFromID(ctx, accountList[0])
	} else {
		receiverAccount, err = getAccountStructFromID(ctx, accountList[1])
	}
	if err != nil {
		return nil,fmt.Errorf("Error retrieving account: %s", err)
	}
	senderAccount.Amount -= totalSettledAmount
	receiverAccount.Amount += totalSettledAmount
	queryString = fmt.Sprintf(
		`{"selector":{
			"docType":"%s",
			"status":"ACTIVE",
			"receiver":"%s"
		}}`,
		queuedTxObjectType,
		accountID)
	incomingQueueArr, err := getSortedQueues(ctx, queryString)
	if err != nil {
		return nil,fmt.Errorf("Error retrieving queued transactions: %s", err)
	}

	isNetted, err := tryBilateralNetting(ctx,
		senderAccount,
		receiverAccount,
		unsettledTxList,
		incomingQueueArr)
	if err != nil {
		return nil,fmt.Errorf("Error trying bilateral netting: %s", err)
	}
	respMsg := "Bilateral Netting"
	if !isNetted && totalSettledAmount > 0 {
		err = updateAccountBalance(ctx,
			senderAccount.AccountID,
			senderAccount.Currency,
			totalSettledAmount,
			true)
		if err != nil {
			return nil,fmt.Errorf("Error updating account balance: %s", err)
		}
		err = updateAccountBalance(ctx,
			receiverAccount.AccountID,
			receiverAccount.Currency,
			totalSettledAmount,
			false)
		if err != nil {
			return nil,fmt.Errorf("Error updating account balance: %s", err)
		}
		respMsg = "no bilateral netting"
	}

	return []byte(respMsg),nil
}

func moveQueuedTxStructToCompleted(
	ctx contractapi.TransactionContextInterface,
	queuedTx QueuedTransaction,
	status string) error {

	var err error

	completedTx := CompletedTransaction{}
	completedTx.ObjectType = completedTxObjectType
	completedTx.RefID = queuedTx.RefID
	completedTx.Sender = queuedTx.Sender
	completedTx.Receiver = queuedTx.Receiver
	completedTx.Priority = queuedTx.Priority
	completedTx.Amount = queuedTx.Amount
	completedTx.Currency = queuedTx.Currency
	completedTx.Status = status
	completedTx.CreateTime = queuedTx.CreateTime
	completedTx.UpdateTime, err = getTxTimeStampAsTime(ctx)
	if err != nil {
		return err
	}

	completedTxAsBytes, err := json.Marshal(completedTx)
	if err != nil {
		return err
	}
	err = ctx.GetStub().PutState(queuedTx.RefID, completedTxAsBytes)
	if err != nil {
		return err
	}

	return nil
}