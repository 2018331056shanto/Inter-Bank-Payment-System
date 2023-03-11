const express=require("express")
const app=express()
const log4js=require("log4js")
var logger=log4js.getLogger("Inter Bank")
const cors=require("cors")
const bodyParser=require("body-parser")
const responseTime=require("response-time")
const session=require('express-session')
const bankRouter=require("./server/routers/Router")
const hcf=require('fabric-client')
const helper=require("./server/utils/helper")
const jwt=require('jsonwebtoken')
const http=require('http')
const cookieParser = require("cookie-parser");
const bearerToken = require('express-bearer-token');
const invoke=require('../api/server/utils/invoke')
const {LocalStorage} = require('node-localstorage');
const localStorage = new LocalStorage('./local-storage');
const transactionRequest=require('./server/services/TransactionRequest')
const accountBalanceChange  = require("./server/services/AccountBalanceChange")
const { deleteData } = require("./server/services/DeleteData")
const mysql=require("mysql")
const db=require('./server/utils/CreateConnection')
const deletedData=require('./server/models/DeletedDataTable')
logger.level = "debug"

db.query(`SELECT 1 FROM DeletedData LIMIT 1`, async(err, result) => {
    if (err) {
        // console.log(err)
      if (err.code === 'ER_NO_SUCH_TABLE') {
        console.log("hello")
        db.query(deleteData,(err1,result1)=>{
           if(err1)
           throw err;
        console.log(result1)
        })
      } else {
        console.error(err);
      }
    } else {
      console.log(`Table does exists`);
    }
  });
app.use(cors());
app.use("/api",bankRouter)
// app.use(cookieParser());
app.use(bodyParser.json({limit: '50mb'}));
app.use(bodyParser.urlencoded({extended:true,limit: '50mb'}));
app.use(responseTime())
app.set('secret',"thisismysecret")


const getErrorMessage=(field)=> {
    var response = {
        success: false,
        message: field + ' field is missing or Invalid in the request'
    };
    return response;
}


app.get('/logout',(req,res)=>{
    res.send("hello")
    localStorage.clear()
})
app.post("/login", async (req,res)=>{

    const {user,org}=req.body
    console.log(user+":"+org)
    if(!user){
        res.json(getErrorMessage('\'username\''))
        return 
    }

    const token =  jwt.sign({
        exp: Math.floor(Date.now() / 1000) + 36000,
        username: user,
        orgName: org
    }, app.get('secret'));


    console.log(token)
    localStorage.setItem('token',token)
    localStorage.setItem('org',org)
    let isUserRegistered=await helper.isUserRegistered(user,org)
   
    if(isUserRegistered){
      

        const maxAge = 1 * 24 * 60 * 60;


        res.send({success: true, message: { token: token,org:org } });
    }
    else{

         res.send({ success: false, message: `User with username ${user} is not registered with ${org}, Please register first.`,token:null });
    }
    
})

app.post("/register",async (req,res)=>{

    const {user,org}=req.body
    logger.debug('End point : /register');
    logger.debug('User name : ' + user);
    logger.debug('Org name  : ' + org);
    if(!user){
        return res.json(getErrorMessage('\'username\''))
        
    }
    let response=await helper.registerUser(user,org) 
    logger.debug('-- returned from registering the username %s for organization %s', user, org);
    if (response && typeof response !== 'string') {
        logger.debug('Successfully registered the username %s for organization %s', user, org);
        return res.json({ success: true});
    } else {
        logger.debug('Failed to register the username %s for organization %s with::%s', user, org, response);
        return res.json({ success: false });
    }

})

app.post('/bank/txreq',async(req,res)=>{

    const {selectBank,amount,ref}=req.body
    const result=await transactionRequest.transactionRequest(selectBank,amount,ref)
    console.log(result.length)
    if(result.length!==0)
    res.status(200).send(result)
    else
    res.status(200).send(result)
})



app.post("/bank/accepttx",async(req,res)=>{
    const {from,amount}=req.body
    console.log(23323)
    const result=await accountBalanceChange.accountBalanceChange(from,amount)
    console.log(result)
    res.send("hell welsdfsl")
})

app.post('/bank/rejecttx',async (req,res)=>{

    const {from}=req.body
    const result=await deleteData(from)
    console.log(result)
    res.send("hello")
    // console.log(from)
})

const root=async()=>{

    const user="admin1"
    const org="bdbank"

    let response=await helper.registerUser(user,org) 
    console.log(response)
    logger.debug('-- returned from registering the username %s for organization %s', user, org);
    if (response && typeof response !== 'string') {
        logger.debug('Successfully registered the username %s for organization %s', user, org);
        return { success: true};
    } else {
        logger.debug('Failed to register the username %s for organization %s with::%s', user, org, response);
        return { success: false };
    }
   
}

// root()


// ====================================================================================
    // just to check 


app.get('/invoke',async(req,res)=>{

    let fcn="manipulateAccount"
    let args=["Shanto","2018331056","CSE","Science","2018","3.40","A+","YES","www.hlahlsdsdlsa"]
    let transient="hdladhlsdhadsda"

    
    let message=await invoke.invokeTransaction()
    const response_payload = {
        result: message,
        error: null,
        errorData: null
    }
    res.send(response_payload);

})  

app.listen(9000,()=>{
    console.log("server is running")
})



