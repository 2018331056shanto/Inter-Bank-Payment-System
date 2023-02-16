package main

import (
	"encoding/json"
	"fmt"
	"strconv"
	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

func (t *SimpleChaincode) settleMLNettingInstructions(
	ctx contractapi.TransactionContextInterface,
	args []string) ([]byte, error) {

	err := checkArgArrayLength(args, 1)
	if err != nil {
		return nil, fmt.Errorf("Incorrect number of arguments. Expecting 1")
	}

	if len(args[0]) <= 0 {
		return nil, fmt.Errorf("Nettable Tx List must be a non-empty string")
	}

	var nettableTxList []string

	nettableTxListAsBytes := []byte(args[0])

	err = json.Unmarshal(nettableTxListAsBytes, &nettableTxList)
	if err != nil {
		return nil, fmt.Errorf("Nettable Tx List must be a valid JSON array")
	}

	isWentToLoop := false
	for _, txID := range nettableTxList {
		isWentToLoop = true

		queuedTx, err := getQueueStructFromID(ctx, txID)
		if err != nil {
			return nil, fmt.Errorf(err.Error())
		}
		err = moveQueuedTxStructToCompleted(ctx, *queuedTx, "SETTLED")
		if err != nil {
			return nil, fmt.Errorf(err.Error())
		}
	}

	resp := SettleMLNettingResp{
		nettableTxList,
		isWentToLoop}
	respAsBytes, err := json.Marshal(resp)
	if err != nil {
		return nil, fmt.Errorf(err.Error())
	}

	_, err = unfreezeAllQueues(ctx)
	if err != nil {
		return nil, fmt.Errorf(err.Error())
	}

	return respAsBytes, nil
}

func (t *SimpleChaincode) unfreezeAllTransactions(
	ctx contractapi.TransactionContextInterface) ([]byte, error) {

	frozenQueuesArr, err := unfreezeAllQueues(ctx)
	if err != nil {
		return nil, fmt.Errorf(err.Error())
	}

	frozenQueuesArrAsBytes, err := json.Marshal(frozenQueuesArr)
	if err != nil {
		return nil, fmt.Errorf(err.Error())
	}

	return 	frozenQueuesArrAsBytes, nil
}

func unfreezeAllQueues(
	ctx contractapi.TransactionContextInterface) ([]QueuedTransaction, error) {

	var frozenQueuesArr []QueuedTransaction
	queryString := fmt.Sprintf(
		`{"selector":{
			"docType":"%s",
			"isFrozen":true
		}}`,
		queuedTxObjectType)

	frozenQueuesArr, err := getSortedQueues(ctx, queryString)
	if err != nil {
		return frozenQueuesArr, err
	}
	for _, queuedTx := range frozenQueuesArr {
		queuedTx.IsFrozen = false
		queuedTxAsBytes, err := json.Marshal(queuedTx)
		err = ctx.GetStub().PutState(queuedTx.RefID, queuedTxAsBytes)
		if err != nil {
			return frozenQueuesArr, err
		}
	}

	return frozenQueuesArr, nil
}

func checkMLNettingParticipation(
	ctx contractapi.TransactionContextInterface) (bool, error) {

	var isParticipating bool

	accountList, err := getListOfAccounts(ctx)
	if err != nil {
		return isParticipating, err
	}

	account1ID := accountList[0]
	account2ID := accountList[1]

	queryArgs := [][]byte{
		[]byte("checkParticipation"),
		[]byte(account1ID),
		[]byte(account2ID)}
	isParticipatingAsBytes, err := crossChannelQuery(ctx,
		queryArgs,
		nettingChannelName,
		nettingChaincodeName)
	if err != nil {
		return isParticipating, err
	}
	isParticipating, err = strconv.ParseBool(string(isParticipatingAsBytes))
	if err != nil {
		return isParticipating, err
	}

	return isParticipating, nil
}