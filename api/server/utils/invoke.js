const { Wallets, Gateway } = require('fabric-network')
const helper=require('./helper')

const invokeTransaction=async(fcn,args,user,org,)=>{

    
        let result
        let message
        
        
        console.log("invoking")

        // if(fcn==="addStudent"){

            result=await contract.evaluateTransaction("getTransactionHistory","abbank")
            // result=await contract.submitTransaction("makeTransaction","abbank",50000,"abbank","krishibank")
            // result=await contract.submitTransaction("deleteStudent","2018331056")
            
            // result=await contract.evaluateTransaction("getStudentHistory","2018331056")
            console.log(JSON.parse(result.toString()))
            message = `Successfully added the student with key ${args[1]}`
        // }
        const channel=network.getChannel()
        const snap=await channel.
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

module.exports={
    invokeTransaction:invokeTransaction
}