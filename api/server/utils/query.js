const { Wallets, Gateway } = require("fabric-network")
const helper = require("./helper")

const chaincodQuery=async(fcn,channelName,chaincodeName,args,user,org)=>{

    try{
        const ccp=await helper.getCCP(org)
        const walletPath=await helper.getWalletPath(org)
        const wallet=await Wallets.newFileSystemWallet(walletPath)
        let identity=await wallet.get(user)
        if(!identity){
            
            
            console.log(`An identity for the user ${user} does not exist in the wallet, so registering user`);
            // await helper.getRe
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

        let result,message

        result=await contract.evaluateTransaction(fcn,args[0])
        gateway.disconnect()

        let response={
            message:"successfully evaluated the transaction",
            result:JSON.parse(result.toString())
        }
        
        return response

    }
    catch(err){

        return err
    }
}


