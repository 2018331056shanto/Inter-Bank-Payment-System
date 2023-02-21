const express=require("express")
const app=express()
const log4js=require("log4js")
var logger=log4js.getLogger("Inter Bank")
const cors=require("cors")
const bodyParser=require("body-parser")
const responseTime=require("response-time")
const session=require('express-session')
// const bankRouter=require("./server/routers/bankRouter")
const hcf=require('fabric-client')
const helper=require("./server/utils/helper")
// let client=new hcf()
// hcf.newCryptoSuite("hald")
// client.setCryptoSuite("dhald")
// client.newChannel()

// client.c
logger.level = "debug"

app.use('*',cors())
app.use(bodyParser.json({limit: '50mb'}));
app.use(bodyParser.urlencoded({extended:true,limit: '50mb'}));
app.use(responseTime())
app.use(session({secret:'thisismysecret',resave:true,saveUninitialized:true,cookie:{maxAge:60000}}))
// app.use('/api',)

app.set('secret',"thisismysecret")



function getErrorMessage(field) {
    var response = {
        success: false,
        message: field + ' field is missing or Invalid in the request'
    };
    return response;
}


app.post("/login",(req,res)=>{

    const {user,org}=req.body
    console.log(user+": "+org)
})

app.post("/register",async (req,res)=>{

    const {user,org}=req.body
    logger.debug('End point : /register');
    logger.debug('User name : ' + user);
    logger.debug('Org name  : ' + org);
    if(!user){
        res.json(getErrorMessage('\'username\''))
    }
    if(!org||(org!="abbank"||org!="bdbank"||org!="dbbank"||org!="islamibank"||org!="krishibank")){
        res.json(getErrorMessage('\'orgname\''))
    }

    helper.getCCP(org)

    let response=await helper.registerUser(user,org) 
    // console.log(response)
    // logger.debug('-- returned from registering the username %s for organization %s', user, org);
    // if (response && typeof response !== 'string') {
    //     logger.debug('Successfully registered the username %s for organization %s', user, org);
    //     res.json({ success: true});
    // } else {
    //     logger.debug('Failed to register the username %s for organization %s with::%s', user, org, response);
    //     res.json({ success: false });
    // }

    // console.log(user+": "+org)
})
app.listen(9000,()=>{
    console.log("server is running")
})

