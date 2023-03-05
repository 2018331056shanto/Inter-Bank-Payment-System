const { response } = require("express")
const express=require("express")
const router=express.Router()
const bankService=require("../services/GetSelfAccount")
const helper=require("../utils/helper")


router.get("/bank/:id",(req,res)=>{

    res.send("hello world")
})


module.exports=router