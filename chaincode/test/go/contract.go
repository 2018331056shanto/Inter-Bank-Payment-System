package main

import (
	"encoding/json"
	"fmt"
	"time"
	"github.com/golang/protobuf/ptypes"
	"github.com/darrylwest/go-unique/src/unique"
	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

type SmartContract struct {

	contractapi.Contract
	
}

type Account struct{

	DocType  	string 		`json:"docType"`
	Bank		string		`json:"bank"`
	Amount		int			`json:"amount:`
	// UpdateTime	time.Time	`json:"updateTime` 
}
type Transaction struct{
	DocType  	string 		`json:"docType"`
	Bank 		string		`json:"bank"`
	Amount 		int			`json:"amount"`
	TXID 		string		`json:"txID"`
	// CreateTime  time.Time	`json:"createTime"`
	From 		string		`json:"from"`
	To			string		`json:"to"` 
}

type TransactionHistory struct{
	Record		*Transaction	`json:"record"`
	Timestamp	time.Time		`json:"timestamp"`
	IsDelete	bool			`json:"isDelete"`

}
type AccountHistory struct{
	Record  	*Account		`json:"record"`
	Timestamp	time.Time		`json:"timestamp"`
	IsDelete	bool			`json:"isDelete"`
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
			// UpdateTime:time.Time{},
			DocType: "account",
		},
		{
			Bank: "bdbank",
			Amount: 32300000,
			// UpdateTime:time.Time{},
			DocType: "account",
		},
		{
			Bank: "dbbank",
			Amount: 3200000,
			// UpdateTime:time.Time{},
			DocType: "account",
		},
		{
			Bank: "islamibank",
			Amount: 3100000,
			// UpdateTime: time.Time{},
			DocType: "account",
		},
		{
			Bank: "krishibank",
			Amount: 4500000,
			// UpdateTime: time.Time{},
			DocType: "account",
		},

	}


	for _,bankAccount:=range bankAccounts{
		assetType:="account"
		queryString:=fmt.Sprintf("{\"selector\":{\"docType\":\"%s\", \"id\":\"%s\"}}", assetType, bankAccount.Bank)
	
		bankAsBytes,_:=json.Marshal(bankAccount)

		err:=ctx.GetStub().PutState(queryString,bankAsBytes)

		if err!=nil{
			return fmt.Errorf(err.Error())
		}
	}

	return nil
}

// func (t *SmartContract) InitLedgerTx(ctx contractapi.TransactionContextInterface)error{

// 	transaction:=Tra
// }

func(t *SmartContract) MakeTransaction(ctx contractapi.TransactionContextInterface,bank string,amount int,from string,to string) error{
	
	uuid:=unique.CreateUUID()
	assetType:="transaction"
	queryString:=fmt.Sprintf("{\"selector\":{\"docType\":\"%s\", \"id\":\"%s\"}}", assetType, bank)

	// txTimestamp,err:=ctx.GetStub().GetTxTimestamp()

	// if err!=nil{
	// 	return fmt.Errorf("error from 1st make tx")
	// }
	transaction:=Transaction{
		Bank: bank,
		Amount: amount,
		TXID: uuid,
		// CreateTime: time.Unix(txTimestamp.Seconds,time.Hour.Microseconds()).UTC(),
		DocType: "transaction",
	}

	transactionAsBytes,err:=json.Marshal(transaction)

	if err!=nil{
		return fmt.Errorf("error from 2nd make tx")
	}

	err1:=ctx.GetStub().PutState(queryString,transactionAsBytes)

	if err1!=nil{
		return fmt.Errorf("error from 3rd make tx")
	}
	return nil
	
	
}

func (t *SmartContract) DeleteTransaction(ctx contractapi.TransactionContextInterface,bank string) error{

	assetType:="transaction"
	queryString:=fmt.Sprintf("{\"selector\":{\"docType\":\"%s\", \"id\":\"%s\"}}", assetType, bank)

	err:=ctx.GetStub().DelState(queryString)
	if err!=nil{
		return fmt.Errorf(err.Error())
	}

	return nil
}



func (t *SmartContract) QueryAccount(ctx contractapi.TransactionContextInterface,bank string,whichAsset string)(*Account,error){

	assetType:=whichAsset
	queryString:=fmt.Sprintf("{\"selector\":{\"docType\":\"%s\", \"id\":\"%s\"}}", assetType, bank)

	accountAsBytes,err:=ctx.GetStub().GetState(queryString)

	if err!=nil{
		return nil,fmt.Errorf(err.Error())
	}

	account:=new(Account)
	_=json.Unmarshal(accountAsBytes,account)
	
	return account,nil
	

}

func (t *SmartContract) ManipulateAccount(ctx contractapi.TransactionContextInterface,bank string,isAdd bool,amount int)(error){

	assetType:="account"
	queryString:=fmt.Sprintf("{\"selector\":{\"docType\":\"%s\", \"id\":\"%s\"}}", assetType, bank)
	accountAsBytes,err:=ctx.GetStub().GetState(queryString)

	if err!=nil{
		return fmt.Errorf(err.Error())
	}


	// txTimestamp,err1:=ctx.GetStub().GetTxTimestamp()

	// if err1!=nil{
	// 	return fmt.Errorf(err1.Error())
	// }

	account:=new(Account)

	_=json.Unmarshal(accountAsBytes,account)

	if isAdd==true{
		
		account.Amount=account.Amount+amount
		// account.UpdateTime=time.Unix(txTimestamp.Seconds,int64(txTimestamp.Nanos)).UTC()

	}else{
		account.Amount=account.Amount-amount
	}

	accountBytes,err2:=json.Marshal(account)

	if err2!=nil{

		return fmt.Errorf(err2.Error())
	}

	err4:=ctx.GetStub().PutState(queryString,accountBytes)

	if err4!=nil{
		
		return fmt.Errorf(err4.Error())
	}
	return nil

}

func (t *SmartContract) GetAccountHistory(ctx contractapi.TransactionContextInterface,bank string)([]AccountHistory,error){

	assetType:="account"
	queryString:=fmt.Sprintf("{\"selector\":{\"docType\":\"%s\", \"id\":\"%s\"}}", assetType, bank)

	resultsIterator,err:=ctx.GetStub().GetHistoryForKey(queryString)

	if err!=nil{
		return nil,fmt.Errorf(err.Error())
	}

	defer resultsIterator.Close()
	
	var records []AccountHistory


		for resultsIterator.HasNext(){

			response,err1:=resultsIterator.Next()

			if err1!=nil{
				return nil,fmt.Errorf(err1.Error())
			}
			var account Account

			if len(response.Value)>0{
				err2:=json.Unmarshal(response.Value,&account)

				if err2!=nil{
					return nil,fmt.Errorf(err2.Error())
				}
			}else{

				account=Account{
					Bank: bank,
					}
				}	
			timestamp,err3:=	ptypes.Timestamp(response.Timestamp)
			
			if err3 != nil {
				return nil, err
			}
			record:=AccountHistory{
				Timestamp: timestamp,
				Record: &account,
				IsDelete: response.IsDelete,
			}
			records=append(records, record)
		}
	return records,nil


}

func (t *SmartContract) GetTransactionHistory(ctx contractapi.TransactionContextInterface,bank string)([]TransactionHistory,error){

	assetType:="transaction"
	queryString:=fmt.Sprintf("{\"selector\":{\"docType\":\"%s\", \"id\":\"%s\"}}", assetType, bank)

	resultsIterator,err:=ctx.GetStub().GetHistoryForKey(queryString)

	if err!=nil{
		return nil,fmt.Errorf(err.Error())
	}

	defer resultsIterator.Close()
	
	var records []TransactionHistory


		for resultsIterator.HasNext(){

			response,err1:=resultsIterator.Next()

			if err1!=nil{
				return nil,fmt.Errorf(err1.Error())
			}
			var transaction Transaction

			if len(response.Value)>0{
				err2:=json.Unmarshal(response.Value,&transaction)

				if err2!=nil{
					return nil,fmt.Errorf(err2.Error())
				}
			}else{

				transaction=Transaction{
					Bank: bank,
					}
				}	
			timestamp,err3:=	ptypes.Timestamp(response.Timestamp)
			
			if err3 != nil {
				return nil, err
			}
			record:=TransactionHistory{
				Timestamp: timestamp,
				Record: &transaction,
				IsDelete: response.IsDelete,
			}
			records=append(records, record)
		}
	return records,nil


}