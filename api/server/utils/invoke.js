const { Wallets, Gateway } = require('fabric-network')
const helper=require('./helper')
const jwt=require('jsonwebtoken')
const xx=require('../../token')

const invokeTransaction=async()=>{

    const token=xx.storage()
    console.log(token)
    var decode=jwt.verify(token,'thisismysecret')
    const user=decode.username
    const org=decode.orgName
    console.log(user + org)
    const channelName="netting-channel"
    const chaincodeName="netting_cc"
    const ccp=await helper.getCCP(org)
    const walletPath=await helper.getWalletPath(org)
    const wallet=await Wallets.newFileSystemWallet(walletPath)
    let identity=await wallet.get(user)



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

    const gateway=new Gateway()
    await gateway.connect(ccp,connectionOptions)

    const network=await gateway.getNetwork(channelName)
    const contract=await network.getContract(chaincodeName)

    // console.log(contract)
    // const contract= await ConnectNetwork()
    
        let result
        let message
        
        
        console.log("invoking")

        // if(fcn==="addStudent"){
            result=await contract.submitTransaction("manipulateAccount","abbank",true,1111)
            // console.log(result)
            // result=await contract.evaluateTransaction("queryAccount","abbank")
            // result=await contract.submitTransaction("makeTransaction","abbank",50000,"abbank","krishibank")
            // result=await contract.submitTransaction("deleteStudent","2018331056")
            
            // result=await contract.evaluateTransaction("getTransactionHistory","abbank")
            // console.log(JSON.parse(result.toString()))
            message = `Successfully added the student with key`
        // }
        // const channel=network.getChannel()
        // const snap=await channel.
      console.log(result.entries())
        gateway.disconnect()
        if(!result.toString()){
            result="Success"
        }

        // let response = {
        //     message: message,
        //     result:JSON.parse(result.toString())
        // }

        return result
    
    
}

module.exports={
    invokeTransaction:invokeTransaction
}