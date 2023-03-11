const { Wallets, Gateway } = require('fabric-network')
const helper=require('../utils/helper')
const jwt=require('jsonwebtoken')
const xx=require('../../token')

const transactionHistory=async()=>{

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
    console.log(user + org)
    const responses=[]
    const ccp=await helper.getCCP(org)
    const walletPath=await helper.getWalletPath(org)
    const wallet=await Wallets.newFileSystemWallet(walletPath)
    let identity=await wallet.get(user)

    const chaincodeName='bilateral_cc'


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
    const banks=["abbank","dbbank","bdbank","krishibank","islamibank"]

    for(let j=0;j<banks.length;j++)
    {

        console.log("f======================================")
        if(banks[j]==org)
        {
            console.log("*******************************")
            continue
        }
        const sortbank=[banks[j],org].sort()
        const idBank=sortbank[0]+sortbank[1]
        console.log("idbank :",idBank)
    for(let i=0;i<channels.length;i++) {

        let el=channels[i]

        if(el.includes(org)){
            const network=await gateway.getNetwork(el)
            const contract=network.getContract(chaincodeName)
        
            let result
            let message
    
            result=await contract.evaluateTransaction("getTransactionHistory",idBank)
            console.log("rsult :",result.toString())
            if(result.toString()){

                // console.log("fuck you bitch")

                // console.log(result.toString())
            // console.log(JSON.parse(result.toString()))
            message = `Successfully added the student with key`
    
           
            
             let response = {
                message: message,
                result:result.toString()
            }
           responses.push(response)
        //    console.log(responses)
        }
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
    transactionHistory:transactionHistory
}