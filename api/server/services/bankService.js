const express=require("express")
const app=express()
const helper=require("../utils/helper")
const {LocalStorage} = require('node-localstorage');
const localStorage = new LocalStorage('./local-storage');
const jwt=require("jsonwebtoken")
const logger=helper.getLogger("bankservice")
const token=localStorage.getItem("token")
const netRef=require("../NetworkRef.json")
const chaicodeName=netRef.chainCodeMapping.bilateral

    const decode=jwt.verify(token,"thisismysecret")
    const requestingBank=decode.orgName
    console.log(decode)


const getTransactions=async(req,res,callback)=>{

    let bankName=requestingBank
    let response={}
    let channels=[]
    let transactionlist=[]
    let fcn="getTransactionHistory"
    let args=[bankName]
    
    const channelList=await helper.getChannelList("abbank")
    
    channelList.forEach((channelName,functioncallback)=>{

        if(netRef.multilateralChannels.includes(channelName)){

            functioncallback()
        }
        else{
            logger.debug(channelName+":",+chaicodeName+":"+fcn+":"+args)
        }
    })
    // console.log(channelList
    res.send("hello how are you")    

}


module.exports={

    getTransactions:getTransactions

}