const { Wallets, Gateway } = require('fabric-network')
const helper=require('../utils/helper')
const jwt=require('jsonwebtoken')
const xx=require('../../token')

const getBanksAccount=async()=>{

    
    const token=xx.storage()
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

    try{

        const gateway=new Gateway()
    await gateway.connect(ccp,connectionOptions)

    const network=await gateway.getNetwork(channelName)
    const contract=await network.getContract(chaincodeName)

        let result
        let message

        result=await contract.evaluateTransaction("getAllAssets")
        console.log(JSON.parse(result.toString()))
        message = `Successfully added the student with key`

        gateway.disconnect()
        if(!result.toString()){
            result="Success"
        }
         let response = {
            message: message,
            result:JSON.parse(result.toString())
        }
        return response
    }
    catch(err){

        return {err:err}
    }
    
       

        
    
    
}

module.exports={
    getBanksAccount:getBanksAccount
}