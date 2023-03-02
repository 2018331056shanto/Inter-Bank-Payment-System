let {Gateway,Wallets}=require('fabric-network')
const path=require("path")
const FabricCAService=require("fabric-ca-client")
const fs=require("fs")
const util=require("util")
const {ok}=require("assert")
const http=require('http')
const netRef=require("../NetworkRef.json")
const log4js=require("log4js")
const logger=log4js.getLogger("Helper")
logger.level="ERROR"


const getLogger=(moduleName)=>{
    const logger=log4js.getLogger("moduleName")
    logger.level="ERROR"
    return logger
}
const getChannelList=async(org)=>{

    if(netRef.regulators.includes(org))
    {
        let channelNames=Object.keys(netRef.channelMapping).map(val=>val)
        // console.log(channelNames)
        let allChannels=Object.values(netRef.channelMapping).map((val,idx)=>{
            
            if(val.includes(org))
            {
                return channelNames[idx]
            }
        })

        return allChannels
        
    }
    else{

        let channelNames=Object.keys(netRef.channelMapping).map(val=>val)
        // console.log(channelNames)
        let bileteral=Object.values(netRef.channelMapping).map((val,idx)=>{
            
            if(val.includes(org))
            {
                return channelNames[idx]
            }

        })
        bileteral=bileteral.filter(e=>e!=undefined)
        return bileteral
    }
   
}
const getCCP=async (org)=>{

    let ccpPath
    let fileName=`connection-${org}.json`
    console.log(fileName)
    try{

        ccpPath=path.resolve(__dirname,'../..','networkConfig',fileName)

    }
    catch{
        return null
    }
    const ccpJSON=fs.readFileSync(ccpPath,'utf8')
    const ccp=JSON.parse(ccpJSON)
    // console.log(ccp)
    return ccp

}

const getCaUrl=async (org,ccp)=>{

    let caURL

    let caName=`ca.${org}`
    try{

         caURL=ccp.certificateAuthorities[caName].url
         return caURL   
    }
    catch{
        return null
    }
 
   

}

const getWalletPath=async (org)=>{
    
    let walletPath
    let walletName=`${org}-wallet`
    try{

        walletPath=path.join(process.cwd(),walletName)
        return walletPath
    }
    catch{
        return null
    }



}

const getCaInfo=async (org,ccp)=>{
    let caInfo
    let caName=`ca.${org}`
    console.log(caName)
    try{

        caInfo=ccp.certificateAuthorities[caName]
        return caInfo
    }
    catch{
        return null
    }
}

const enrollAdmin=async(org,ccp)=>{

    try{
        const caInfo=await getCaInfo(org,ccp)
        const caTLSCACerts=caInfo.tlsCACerts.pem
        const ca=new FabricCAService(caInfo.url,{
            trustedRoots:caTLSCACerts,verify:false
        },caInfo.caName)

        const walletPath=await getWalletPath(org)
        const wallet=await Wallets.newFileSystemWallet(walletPath)
        // console.log(wallet)
        const identity=await wallet.get('admin')
        if(identity){
            console.log('An identity for the admin user "admin" already exists in the wallet');
            return;
        }
        console.log(caInfo)
        // console.log(enrollID+" : "+enrollSecret)
        const enrollment=await ca.enroll({enrollmentID:"admin",enrollmentSecret:"adminpw"})
        

        let x509Identity;
        let msp=`${org}MSP`
        x509Identity = {
            credentials: {
                certificate: enrollment.certificate,
                privateKey: enrollment.key.toBytes(),
            },
            mspId: msp,
            type: 'X.509',
        };

        await wallet.put('admin', x509Identity);

        console.log('Successfully enrolled admin user "admin" and imported it into the wallet');
        return
    } catch (error) {
        console.error(`Failed to enroll admin user "admin": ${error}`);
    }

    
}

const registerUser=async (user,org)=>{

    let ccp=await getCCP(org)
    const caURL=await getCaUrl(org,ccp)
    const ca=new FabricCAService(caURL)
    const walletPath=await getWalletPath(org)
    console.log("wallet path : ",walletPath)
    const wallet=await Wallets.newFileSystemWallet(walletPath)


    const userIdentity=await wallet.get(user)
    // console.log(userIdentity)
    if(userIdentity){
        let response={
            success:true,
            message:user+'enrolled Successfully'
        }
        return response
    }

    let adminIdentity=await wallet.get('admin')
    if(!adminIdentity){
        
        console.log("the admin is not in wallet ")
        await enrollAdmin(org,ccp)
        adminIdentity = await wallet.get('admin');
        // console.log(adminIdentity)
        console.log("Admin Enrolled Successfully")
    }

    const provider=wallet.getProviderRegistry().getProvider(adminIdentity.type)
    const adminUser=await provider.getUserContext(adminIdentity,'admin')

    let secret;
    try{
        secret=await ca.register({enrollmentID:user,role:'client'},adminUser)
    }
    catch(err)
    {
        return err.message
    }
    
    const enrollment=await ca.enroll({enrollmentID:user,enrollmentSecret:secret})

    let x509Identity
    let msp=`${org}MSP`

    x509Identity = {
        credentials: {
            certificate: enrollment.certificate,
            privateKey: enrollment.key.toBytes(),
        },
        mspId:msp,
        type: 'X.509',
    };

    await wallet.put(user,x509Identity)

    console.log(`Successfully registered and enrolled user ${user} and imported it into the wallet`);

    var response = {
        success: true,
        message: user + ' enrolled Successfully',
    };
    return response
}

const isUserRegistered=async (user,org)=>{

    const walletPath=await getWalletPath(org)
    const wallet=await Wallets.newFileSystemWallet(walletPath)
    const userIdentity=await wallet.get(user)
    // console.log(userIdentity)
    if(userIdentity){
        console.log(`An identity for the user ${user} exists in the wallet`);
        return true
    }
    return false
}

module.exports={
    getCCP:getCCP,
    getCaUrl:getCaUrl,
    getWalletPath:getWalletPath,
    registerUser:registerUser,
    isUserRegistered:isUserRegistered,
    getChannelList:getChannelList,
    getLogger:getLogger
}