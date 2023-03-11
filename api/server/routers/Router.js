const { response } = require("express")
const express=require("express")
const router=express.Router()
const bankService=require("../services/GetSelfAccount")
const helper=require("../utils/helper")
const selfAccount=require('../services/GetSelfAccount')
const transactionHistory=require('../services/TransactiionHistory')
const transactionHistoryByChannel=require('../services/TransactionHistoryByChannel')
const GetDeletedData = require("../services/GetDeletedData")
const db=require('../utils/CreateConnection')
router.get("/bank/account",async(req,res)=>{

   const results=await selfAccount.selfAccount()
   console.log(results)
    res.send(results)
})
router.get("/bank/history",async(req,res)=>{

    const result=await transactionHistory.transactionHistory()
    console.log("hello :",result)
    if(result.length!=0)
    {
        
        // console.log("fuck you")
         res.send(result)
    }
    else{
        res.send()
    }
   

})

router.get("/bank/txhistory/:id",async(req,res)=>{

    const id=req.params.id
    const result=await transactionHistoryByChannel.transactionHistoryByChannel(id)
    console.log(result)
    res.send(result)
})


router.get("/bank/gettxid",async(req,res)=>{
    db.query('SELECT *FROM DeletedData',(err,result)=>{

        if(err){
            console.log(err)
        }
        else{
            console.log(result)
            res.send(result)
        }
    })
})

// router.post("/bank/accepttx",(req,res)=>{

//     console.log("i know what to do")
//     console.log(req.body)
//     res.status(200).send("hello")
// })
// router.post('/bank/txreq',async(req,res)=>{

//     // console.log("hdhsld")
//     // req.
//     // const {selectBank,amount,ref}=req.body
//     // console.log(selectBank+amount+ref)
//     console.log(req.body)
//     res.send("hello")
// })


module.exports=router