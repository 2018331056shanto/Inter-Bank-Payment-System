const { response } = require("express")
const express=require("express")
const router=express.Router()
const bankService=require("../services/bankService")
const helper=require("../utils/helper")


router.get('/bank/transactions',(req,res)=>{

    bankService.getTransactions(req,res,(response)=>{
        res.send(response)
    })

})

router.get('/bank/info',(req,res)=>{

})

router.get('/bank/couterparties',(req,res)=>{

})


router.post('/bank/unfreeze/all',(req,res)=>{

})

router.get('/bank/balance/all',(req,res)=>{

})




module.exports=router