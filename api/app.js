const express=require("express")
const app=express()
const log4js=require("log4js")
var logger=log4js.getLogger("Inter Bank")
const cors=require("cors")
const bodyParser=require("body-parser")
const responseTime=require("response-time")
const session=require('express-session')
const bankRouter=require("./server/routers/bankRouter")
const hcf=require('fabric-client')
const helper=require("./server/utils/helper")
const jwt=require('jsonwebtoken')
const http=require('http')
const cookieParser = require("cookie-parser");
const bearerToken = require('express-bearer-token');
const invoke=require('../api/server/utils/invoke')
const {LocalStorage} = require('node-localstorage');
const localStorage = new LocalStorage('./local-storage');

const corsOptions = {
    credentials: true,
    ///..other options
  };
  
logger.level = "debug"

app.use("/api",bankRouter)
app.use(cookieParser());
app.use(cors(corsOptions));
app.use('*',cors())
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



app.get("/data",(req,res)=>{

    res.cookie("jwttoken","hello how are you");

    console.log(req.cookies)
    res.send({time:new Date()})
})

app.post("/login", async (req,res)=>{

    const {user,org}=req.body
    console.log(user+":"+org)
    if(!user){
        res.json(getErrorMessage('\'username\''))
        return 
    }

    // if((org!="abbank"||org!="bdbank"||org!="dbbank"||org!="islamibank"||org!="krishibank")){
    //     console.log("yy")

    //     res.json(getErrorMessage('\'orgname\''))
    //     return 
    // }

    const token =  jwt.sign({
        exp: Math.floor(Date.now() / 1000) + 36000,
        username: user,
        orgName: org
    }, app.get('secret'));

    // console.log(token)
    let isUserRegistered=await helper.isUserRegistered(user,org)
    // console.log(`user regiserd:  ${isUserRegistered}`)
    if(isUserRegistered){
      
    
        const maxAge = 1 * 24 * 60 * 60;

        localStorage.setItem("token",token)
        // console.log("hello is anybody in there")
        // res.cookie("jwttoken","hello how are you");
        res.send({success: true, message: { token: token } });
        //  console.log("zz")
    }
    else{
        res.json({ success: false, message: `User with username ${user} is not registered with ${org}, Please register first.` });
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
    // if(!org||(org!="abbank"||org!="bdbank"||org!="dbbank"||org!="islamibank"||org!="krishibank")){
    //     return res.json(getErrorMessage('\'orgname\''))
    // }

    helper.getCCP(org)

    let response=await helper.registerUser(user,org) 
    // console.log(response)
    logger.debug('-- returned from registering the username %s for organization %s', user, org);
    if (response && typeof response !== 'string') {
        logger.debug('Successfully registered the username %s for organization %s', user, org);
        return res.json({ success: true});
    } else {
        logger.debug('Failed to register the username %s for organization %s with::%s', user, org, response);
        return res.json({ success: false });
    }

    // console.log(user+": "+org)
})





// ====================================================================================
    // just to check 


app.get('/invoke',async(req,res)=>{

    let fcn="addStudent"
    let args=["Shanto","2018331056","CSE","Applied Science","2018","3.40","B+","YES","www.hlahlsdsdlsa"]
    let transient="hdladhlsdhadsda"

    
    let message=await invoke.invokeTransaction(fcn,args,"shanto","abbank",transient)
    // console.log(args)
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

