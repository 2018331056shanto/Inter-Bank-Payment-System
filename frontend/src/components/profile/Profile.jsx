import React, {useState,useContext, useEffect } from "react";
import { userContext } from "../../context/Context";
import InformationBox from "../InformationBox/InformatioBox";
import Navbar from "../NavbarLogin/Navbar/Navbar";
import styles from './Profile.module.css'
import img from '../InformationBox/salary.png'
import img1 from './transaction.png'
import img2 from './incoming-message.png'
import Button from '@mui/material/Button';
import { GET } from "../../api/api";
import List from "../List/List";
import Stack from '@mui/material/Stack';
import { ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { toast } from 'react-toastify';
import { POST } from "../../api/api";
const Profile=()=>{

    let [isShown,setIsShown]=useState(false)
    let [isShown1,setIsShown1]=useState(false)
    let [isShown2,setIsShown2]=useState(false)
    const {loginUser}=useContext(userContext)
    const {account}=useContext(userContext)
    const [pendingHistory,setPendingHistory]=useState([])
    const [incomingHistory,setIncomiingHistory]=useState([])
    const [deletedTxid,setDeletedTxid]=useState([])
    const [onlyTxID,setOnlyTxID]=useState([])
    
    const acceptHandler=async (e)=>{

        const data={
            from:e.target.parentNode.parentNode.parentNode.cells[0].textContent.toLowerCase(),
            amount:e.target.parentNode.parentNode.parentNode.cells[1].textContent,

        }
        
        const res=await POST("/bank/accepttx",data)
        console.log(data)

        toast.success('🦄 The Transaction Request is Accepted!', {
            position: "top-right",
            autoClose: 2000,
            hideProgressBar: false,
            closeOnClick: true,
            pauseOnHover: true,
            draggable: true,
            progress: undefined,
            theme: "light",
            });
    }
    const rejectHandler=async (e)=>{
        const data={
            from:e.target.parentNode.parentNode.parentNode.cells[0].textContent.toLowerCase(),
        }
        
        const res= await POST("/bank/rejecttx",data)

        toast.success('🦄 Incoming Transaction has been Rejected!', {
            position: "top-right",
            autoClose: 3000,
            hideProgressBar: false,
            closeOnClick: true,
            pauseOnHover: true,
            draggable: true,
            progress: undefined,
            theme: "light",
            });
        console.log("titu magi")
    }
    const getTxHistory=async()=>{

        const result1=await GET('/api/bank/gettxid')
        console.log(result1)
        let txIDArray=[]
        console.log("hello hunny bunny")

        for(let i=0;i<result1.data.length;i++)
        {
            let temp1=result1.data[i].txID
            txIDArray.push(temp1)
        }
        console.log(txIDArray)

        let string='/api/bank/history'
        const transactResult=await GET(string)

        console.log('hellohunne')
        if(transactResult.data!==""){
 
            let history=transactResult.data.map(el=>{
             const temp=JSON.parse(el.result)
             const arr=Object.values(temp)
             return arr
        })
 

            let transHistory=[]
 
            history.map(el=>{
         
            el.map(el1=>{
             
            transHistory.push(el1)
            })
        })
        transHistory.sort((a, b) => {
         if (a.timestamp < b.timestamp) {
           return 1;
         }
         if (a.timestamp > b.timestamp) {
           return -1;
         }
         return 0;
        });
        
        
        console.log(transHistory)
    

        let map=new Map()

       for(let i=transHistory.length-1;i>=0;i--){

        let key=transHistory[i].record.txID
        console.log(onlyTxID)
        if(txIDArray.includes(key)===false)
        {
            if(key!==''&&transHistory[i].record.from===loginUser){
                console.log("hello how are you")

                if(map.get(key)){
                    console.log(transHistory[i])
                    map.delete(key)
                }
                else{
                    console.log(transHistory[i])
                    map.set(key,transHistory[i])
                }
            }
        }
       }
       let resp=[]
      console.log(map)
       for(let [key,value] of map){
        let obj={}
        obj["to"]=value.record.to.toUpperCase()
        obj["amount"]=value.record.amount
        obj["txid"]=value.record.txID
        obj["timestamp"]=value.timestamp
        obj["ref"]=value.record.ref
        resp.push(obj)
       }
      

       let map1=new Map()
   

       for(let i=transHistory.length-1;i>=0;i--)
       {
            let key=transHistory[i].record.txID
            console.log(onlyTxID)
            if(txIDArray.includes(key)===false)
            {
                if(key!==''&&transHistory[i].record.to===loginUser){
                    console.log("hello how are you")

                    if(map1.get(key)){
                        console.log(transHistory[i])
                        map1.delete(key)
                    }
                    else{
                        console.log(transHistory[i])
                        map1.set(key,transHistory[i])
                    }
                }
            }
        }
        let resp1=[]
        console.log(map1)
        for(let[key,value] of map1){

            let obj={}
            obj["from"]=value.record.from.toUpperCase()
            obj["amount"]=value.record.amount
            obj["txid"]=value.record.txID
            obj["ref"]=value.record.ref
            obj["status"]= <Stack style={{marginLeft:"18%"}} direction="row" spacing={2}>
    
            <Button onClick={(e)=>acceptHandler(e)} variant="contained" color="success">
              Accept
            </Button>
            <Button onClick={rejectHandler} variant="contained" color="error">
              Reject
            </Button>
          </Stack>
    
            resp1.push(obj)

        }
       
        let rejected=[]
        for(let i=result1.data.length-1;i>=0;i--)
        {
            let dataTemp=result1.data
            let obj={}
            console.log(dataTemp)
            if(dataTemp[i].tobank!==loginUser)
            {

            
            obj["Bank"]=dataTemp[i].tobank
            obj["Amount"]=dataTemp[i].amount
            obj["txid"]=dataTemp[i].txID
            obj["time"]=dataTemp[i].timestamp
            rejected.push(obj)
            }
        }
               
       console.log(resp1)
       setOnlyTxID(txIDArray)
       setDeletedTxid(rejected)
       setPendingHistory(resp)
       setIncomiingHistory(resp1)

        
    }
         
    
}
useEffect(()=>{

   getTxHistory()
  
   
},[])
    const xx=()=>{
        
        setIsShown(current => !current);

    }
    const xx1=()=>{
        
        setIsShown1(current => !current);

    }
    const xx2=()=>{
        
        
        setIsShown2(current => !current);

    }

    const header=[
        {field:"Bank Name"},{field:"Tx Amount"},{field:"Transaction ID"},{field:"Transaction Time"},{field:"Reference"}
    ]
    const header1=[
        {field:"Incoming Bank"},{field:"Tx Amount"},{field:"Transaction ID"},{field:"Reference"},{field:"Status"}
    ]

    const header2=[
        {field:"Requested Bank"},{field:"Tx Amount"},{field:"Transaction ID"},{field:"Timestamp"}
    ]

   
    
  

    return(
        <>
        <div className={styles.con}>

            <Navbar/>
            <ToastContainer/>
            <div className={styles.dashboardContainer}>
            <InformationBox percentageInfo={"Then previous week"} percentage={"15%"}  img={img} count={account} info={"Total Amount"}/>
            <InformationBox percentageInfo={"Then previous week"} percentage={"20%"} img={img1} count={pendingHistory.length} info={"Pending Transaction"}/>
            <InformationBox percentageInfo={"Then previous week"} percentage={"19%"} img={img2} count={incomingHistory.length} info={"Incoming Request."}/>

            </div>
            <div className={styles.information}>
                <Button onClick={xx} variant="contained" disableElevation>
                     Check Pending Transaction
                </Button>
                <Button onClick={xx1} variant="contained" disableElevation>
                    Check Incoming Tx Request
                </Button>
                <Button onClick={xx2}  variant="contained" disableElevation>
                    Check Rejected Transaction
                </Button>
            </div>
            <div style={{marginTop:"40px"}}>


                {isShown?<List  header={header} list={pendingHistory}/>:isShown1?<List header={header1} list={incomingHistory}/>:isShown2?<List header={header2} list={deletedTxid}/>:null}
            </div>
        </div>
                

        </>
    )
}
    

export default Profile