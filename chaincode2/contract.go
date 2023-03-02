package main

import (
	"encoding/json"
	"fmt"
	"time"
	"github.com/hyperledger/fabric-contract-api-go/contractapi"
	"github.com/hyperledger/fabric-protos-go/peer"

)

type SmartContract struct {

	contractapi.Contract
	
}

type Account struct{

	Bank	string		`json:"bank"`
	Amount	int			`json:"amount:`
	UpdateTime	time.Time	`json:"updateTime` 
}
type Transaction struct{
	
	Bank 		string		`json:"bank"`
	Amount 		int			`json:"amount"`
	TXID 		string		`json:"txID"`
	CreateTime  time.Time	`json:"createTime"` 
}

func main(){

	chaincode,err:=contractapi.NewChaincode(new(SmartContract))

	// err=chaincode.
	if err!=nil{
		fmt.Printf("Error starting Simple chaincode: %s", err)
		return
	}

	if err:=chaincode.Start();err!=nil{

		fmt.Printf("Error starting Simple chaincode: %s", err)

	}
}

func (t *SmartContract) InitLedger(ctx contractapi.TransactionContextInterface) error{

	bankAccounts:=[]Account{

		{
			Bank: "abbank",
			Amount: 100000,
			UpdateTime: time.Now(),
		},
		{
			Bank: "bdbank",
			Amount: 32300000,
			UpdateTime: time.Now(),
		},
		{
			Bank: "dbbank",
			Amount: 3200000,
			UpdateTime: time.Now(),
		},
		{
			Bank: "islamibank",
			Amount: 3100000,
			UpdateTime: time.Now(),
		},
		{
			Bank: "krishibank",
			Amount: 4500000,
			UpdateTime: time.Now(),
		},

	}

	for _,bankAccount:=range bankAccounts{

		bankAsBytes,_:=json.Marshal(bankAccount)

		err:=ctx.GetStub().PutState(bankAccount.Bank,bankAsBytes)

		if err!=nil{
			return fmt.Errorf(err.Error())
		}
	}
	return nil
}