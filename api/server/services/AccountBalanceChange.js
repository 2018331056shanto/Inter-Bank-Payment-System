const { Wallets, Gateway } = require('fabric-network')
const helper=require('../utils/helper')
const jwt=require('jsonwebtoken')
const xx=require('../../token')
const UpdateStatus = require('./UpdateStatus')

const accountBalanceChange=async(from,amount)=>{

    console.log("from account balance change")
    const token=xx.storage()
    var decode=jwt.verify(token,'thisismysecret')
    const user=decode.username
    const org=decode.orgName
    // console.log(user + org)
    const responses=[]
    const ccp=await helper.getCCP("bdbank")
    const walletPath=await helper.getWalletPath("bdbank")
    const wallet=await Wallets.newFileSystemWallet(walletPath)
    let identity=await wallet.get("admin1")
    console.log(identity)
    const chaincodeName='netting_cc'
    const channelName='netting-channel'


    if(!identity){
    
        console.log(`An identity for the user  does not exist in the wallet, so registering user`);
        return
    }

    const connectionOptions={
        wallet,
        identity:"admin1",
        discovery:{
            enabled:true,
            asLocalhost:true,
        }       
    }

    try{

    const gateway=new Gateway()
    await gateway.connect(ccp,connectionOptions)

    
            const network=await gateway.getNetwork(channelName)
            const contract=network.getContract(chaincodeName)
        
            let result
            let message
        //    console.log("idonw know why not working")   
            result=await contract.submitTransaction('manipulateAccount',org,false,parseInt(amount))
            result=await contract.submitTransaction('manipulateAccount',from,true,parseInt(amount))

            console.log("rsult :",result)

            let resp=await UpdateStatus.updateStatus(from)           

            if(resp.toString()){

                // console.log("fuck you bitch")

                // console.log(result.toString())
            // console.log(JSON.parse(result.toString()))
            message = `Successfully added the student with key`
    
            gateway.disconnect()
            
            
                // console.log(responses)


            let response = {
                message: message,
                result:resp.toString()
            }
            console.log(response)
            return response
              
        
    }
    
    // console.log("it's responses :",responses)
 
    }
    catch(err){

        return {err:err}
    }
    
       
}

module.exports={
   accountBalanceChange:accountBalanceChange
}