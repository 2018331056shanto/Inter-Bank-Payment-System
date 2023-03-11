const db=require('../utils/CreateConnection')


const getDeletedData=async()=>{

    db.query('SELECT *FROM DeletedData',(err,result)=>{

        if(err){
            console.log(err)
        }
        else{
            console.log("ki holo")
            console.log(result)
            return result
        }
    })
}
module.exports={
    getDeletedData:getDeletedData
}