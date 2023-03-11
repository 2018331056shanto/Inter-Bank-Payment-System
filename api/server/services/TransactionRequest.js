const { Wallets, Gateway } = require('fabric-network')
const helper=require('../utils/helper')
const jwt=require('jsonwebtoken')
const xx=require('../../token')
const { uuid } = require('uuidv4');
const { queryTransaction } = require('./QueryTransaction');
const transactionRequest=async(bank,amount,ref)=>{

    const channels=[
        "islamibank-abbank-channel",
        "islamibank-dbbank-channel",
        "islamibank-krishibank-channel",
        "abbank-dbbank-channel",
        "abbank-krishibank-channel",
        "dbbank-krishibank-channel"
    ]
    const token=xx.storage()
    var decode=jwt.verify(token,'thisismysecret')
    const user=decode.username
    const org=decode.orgName
    // console.log(user + org)
    const responses=[]
    const ccp=await helper.getCCP(org)
    const walletPath=await helper.getWalletPath(org)
    const wallet=await Wallets.newFileSystemWallet(walletPath)
    let identity=await wallet.get(user)

    let chaincodeName=""
    if(bank=="bdbank"){
        chaincodeName='netting_cc'
    }
    else{
        chaincodeName='bilateral_cc'
    }


    if(!identity){
    
        console.log(`An identity for the user ${user} does not exist in the wallet, so registering user`);
        return
    }

    const connectionOptions={
        wallet,
        identity:user,
        discovery:{
            enabled:true,
            asLocalhost:true,
        }       
    }

    try{

    const gateway=new Gateway()
    await gateway.connect(ccp,connectionOptions)

    let responses=[]
    for(let i=0;i<channels.length;i++) {

        let el=channels[i]

        if(el.includes(org)&&el.includes(bank)){
            // console.log(el)
            const network=await gateway.getNetwork(el)
            const contract=network.getContract(chaincodeName)
        
            let result
            let message
            const sortbank=[org,bank].sort()
            const idBank=sortbank[0]+sortbank[1]
            console.log(idBank)
            let intermidiateResult=await queryTransaction(el,idBank)
            console.log("intermidiate :",intermidiateResult)
            if(intermidiateResult.result.docType===''||intermidiateResult.result.status!==false){
            result=await contract.submitTransaction("makeTransaction",idBank,parseInt(amount),org,bank,ref,uuid())
            console.log("rsult :",result.toString())
          

            message = `Successfully added the student with key`
            console.log(message)
             let response = {
                message: message,
                result:result.toString()
            }
           responses.push(response)

        
        //    console.log(responses)
        }
       
    }
     
            
        
    }
    gateway.disconnect()
    // console.log("it's responses :",responses)
    return responses
    }
    catch(err){

        return {err:err}
    }
    
       

        
    
    
}

module.exports={
    transactionRequest:transactionRequest
}