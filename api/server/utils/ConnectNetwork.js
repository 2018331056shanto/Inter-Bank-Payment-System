const { Wallets, Gateway } = require('fabric-network')
const helper=require('./helper')



const connectNetwork=async(org,user,channelName,chaincodeName)=>{

    try{
        
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

    return contract
}
catch(err){
    return err
}

}
module.exports={
    connectNetwork:connectNetwork
}