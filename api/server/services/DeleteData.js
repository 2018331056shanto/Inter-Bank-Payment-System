const { Wallets, Gateway } = require('fabric-network')
const helper=require('../utils/helper')
const jwt=require('jsonwebtoken')
const xx=require('../../token')
const db=require('../utils/CreateConnection')
const deleteData=async(id)=>{

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
    for(let i=0;i<channels.length;i++) {

        let el=channels[i]

        if(el.includes(org)&&el.includes(id)){
            console.log(el)
            const network=await gateway.getNetwork(el)
            const contract=network.getContract(chaincodeName)
        
            let result
            let message
            const sortbank=[org,id].sort()
            const idBank=sortbank[0]+sortbank[1]
            // console.log(idBank)
            const intermidiateResult= await contract.evaluateTransaction("queryTransaction",idBank)
            // console.log("bondhu bandhober mak chudi")
            const temp=JSON.parse(intermidiateResult.toString())
         console.log(temp)
         if(temp.txID!==''){
            result=await contract.submitTransaction("deleteTransaction",idBank)
            
            // console.log("rsult :",result)
            
            
            if(result.toString()){
                let transactionID=result.toString()
                const time=new Date()
                db.query("INSERT INTO DeletedData (ID,frombank,tobank,amount,ref,timestamp,bankid,txID) VALUES (?,?,?,?,?,?,?,?)",
            [transactionID,temp.from,temp.to,parseInt(temp.amount),temp.ref,String(time),temp.bank,temp.txID],(err,result1)=>{
                if(err){
                    
                    console.log(err)
                   
                }
                else{
                    console.log(result1)
                }
            })
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
  deleteData:deleteData
}