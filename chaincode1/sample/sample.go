package main

import (
	"encoding/json"
	"fmt"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

type Chaincode struct {
	contractapi.Contract
}

type Asset struct {
	Name string `json:"Name"`
	ID   string `json:"ID"`
	Age  int    `json:"Age"`
}

func (t *Chaincode) InitLedger(ctx contractapi.TransactionContextInterface) error {
	personInfo := []Asset{
		{
			Name: "Ashraful Islam",
			ID:   "01",
			Age:  25,
		},
		{
			Name: "Ahsanul Amin",
			ID:   "02",
			Age:  24,
		},
	}

	for _, person := range personInfo {
		personInfoAsBytes, err := json.Marshal(person)
		if err != nil {
			return err
		}

		err2 := ctx.GetStub().PutState(person.ID, personInfoAsBytes)
		if err2 != nil {
			return fmt.Errorf("failed to put to world state. %s", err.Error())
		}
	}

	return nil
}

func (t *Chaincode) QueryPersonInfo(ctx contractapi.TransactionContextInterface, id string) (*Asset, error) {
	infoBlockAsBytes, err := ctx.GetStub().GetState(id)
	if err != nil {
		return nil, fmt.Errorf("Failed to read from world state. %s", err.Error())
	}

	if infoBlockAsBytes == nil {
		return nil, fmt.Errorf("%s does not exist", id)
	}

	infoblock := new(Asset)

	err2 := json.Unmarshal(infoBlockAsBytes, infoblock)
	if err2 != nil {
		return nil, err2
	}
	return infoblock, nil
}

func main() {
	chaincode, err := contractapi.NewChaincode(new(Chaincode))
	if err != nil {
		fmt.Printf("Error creating chaincode: %s", err.Error())
		return
	}

	chaincode.Info.Title = "PersonInfoChaincode"
	chaincode.Info.Version = "1.0"

	if err := chaincode.Start(); err != nil {
		fmt.Printf("Error starting chaincode: %s", err.Error())
	}
}
