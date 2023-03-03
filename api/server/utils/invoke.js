const { Wallets, Gateway } = require('fabric-network')
const helper=require('./helper')
// const {Block}

const invokeTransaction=async(fcn,args,user,org,transientData)=>{

    console.log("invoking transaction")
    try{

        const ccp=await helper.getCCP(org)
        console.log(ccp)
        
        const walletPath=await helper.getWalletPath(org)
        const wallet=await Wallets.newFileSystemWallet(walletPath)
        let identity=await wallet.get(user)
        // console.log(identity)
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
       
        console.log("before connection")
        const gateway=new Gateway()
        await gateway.connect(ccp,connectionOptions)
        console.log("connection")
        const channelName="abbank-krishibank-channel"
        const chaincodeName='bilateral_cc'
        
        const network=await gateway.getNetwork(channelName)
        const contract=network.getContract(chaincodeName)
        // contract.
        // contract.createTransaction().setTransient().submit()
        let result
        let message
        
        
        console.log("invoking")

        // if(fcn==="addStudent"){

            result=await contract.submitTransaction("makeTransaction","abbank",50000,"abbank","krishibank")
            // result=await contract.submitTransaction("deleteStudent","2018331056")
            
            // result=await contract.evaluateTransaction("getStudentHistory","2018331056")
            console.log(JSON.parse(result.toString()))
            message = `Successfully added the student with key ${args[1]}`
        // }
        gateway.disconnect()
        if(!result.toString()){
            result="Success"
        }

        let response = {
            message: message,
            result:JSON.parse(result.toString())
        }

        return response;
    }
    catch(err){
        return err
    }

}

module.exports={
    invokeTransaction:invokeTransaction
}