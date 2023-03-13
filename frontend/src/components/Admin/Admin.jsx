import React, { useContext, useEffect, useState } from "react";
import Navbar from "../NavbarLogin/Navbar/Navbar";
import style from './Admin.module.css'
import img from '../InformationBox/salary.png'
import img1 from './transaction.png'
import img2 from './task.png'
import InformationBox from "../InformationBox/InformatioBox";
import { GET } from "../../api/api";
import { userContext } from "../../context/Context";
import LineChart from "../Linechart/LineChart";
import Button from '@mui/material/Button';
import List from "../List/List";
const Admin=()=>{

    let [isShown,setIsShown]=useState(false)
    let [isShown1,setIsShown1]=useState(false)
    let [isShown2,setIsShown2]=useState(false)
    const {loginUser}=useContext(userContext)
    const [trasnsactedAmount,setTransactedAmount]=useState(0)
    const [pendingTransaction,setPendingTransaction]=useState(0)
    const [acceptedTransaction,setAcceptedTransaction]=useState(0)
    const [historyData,setHistoryData]=useState([])
    const [chartData,setChartData]=useState([])
    const [pendingData,setPendingData]=useState([])
    const [acceptedData,setAcceptedData]=useState([])
    const [banksData,setBanksData]=useState([])
    const GetData=async ()=>{


        const res=await GET('/api/bank/admin/getdata')
        let pending=0,accepted=0,amount=0
        console.log(res)
        let txIDArray=[]

        if(res.data!==""){
 
            console.log("+++++++++++++++++++++++++++++")
            let history=res.data.map(el=>{
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
        console.log("hello")
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
        // await others()
    // }

    // const others=async()=>{
        let arrayOfamount=[]
        for(let i=0;i<transHistory.length;i++)
        {
            if(transHistory[i].record.status){
                arrayOfamount.push(transHistory[i].record.amount)
                amount+=transHistory[i].record.amount
                accepted++
            }
        }

        let map=new Map()

       for(let i=transHistory.length-1;i>=0;i--){

        let key=transHistory[i].record.txID
        // console.log(onlyTxID)
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
         obj["from"]=value.record.from.toUpperCase()

         obj["to"]=value.record.to.toUpperCase()
         obj["amount"]=value.record.amount
         obj["txid"]=value.record.txID
         obj["timestamp"]=value.timestamp
         obj["ref"]=value.record.ref
         resp.push(obj)
        }

        let resp1=[]
        for(let i=0;i<transHistory.length;i++)
        {
            if(transHistory[i].record.status){
                let obj={}
         obj["from"]=transHistory[i].record.from.toUpperCase()

         obj["to"]=transHistory[i].record.to.toUpperCase()
         obj["amount"]=transHistory[i].record.amount
         obj["txid"]=transHistory[i].record.txID
         obj["timestamp"]=transHistory[i].timestamp
         obj["ref"]=transHistory[i].record.ref
         resp1.push(obj)
            }
        }
        const result2=await GET("/api/bank/getstatus")
        console.log(result2.data.result)
       console.log(map.size)
       setBanksData(result2.data.result)
       setAcceptedData(resp1)
       setPendingData(resp)
       setChartData(arrayOfamount)
       setPendingTransaction(map.size)
       setAcceptedTransaction(accepted)
       setTransactedAmount(amount)
       setHistoryData(transHistory)
    }



    }

    useEffect(()=>{

        GetData()
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
        {field:"Bank From"},{field:"Bank To"},{field:"Tx Amount"},{field:"Transaction ID"},{field:"Transaction Time"},{field:"Reference"}
    ]
    // const banks=[]
    return(
        <div className={style.con}>

            <Navbar/>
            <div className={style.info}>

            <InformationBox percentageInfo={"Then previous week"} percentage={"20%"} img={img} count={trasnsactedAmount} info={"Total Transacted Amount"}/>
            <InformationBox percentageInfo={"Then previous week"} percentage={"20%"} img={img1} count={pendingTransaction}  info={"Total Queued Request"} />
            <InformationBox percentageInfo={"Then previous week"} percentage={"20%"} img={img2} count={acceptedTransaction} info={"Total Accepted Request"} />
        </div>
        
        <div className={style.div3}>

            <LineChart data={chartData}/>
        </div>

        <div className={style.information}>
                <Button onClick={xx} variant="contained" disableElevation>
                     Check Queued Transaction
                </Button>
                <Button onClick={xx1} variant="contained" disableElevation>
                    Check Accepted Request
                </Button>
                <Button onClick={xx2}  variant="contained" disableElevation>
                    Check Banks Account Status
                </Button>
            </div>

            <div style={{marginTop:"40px"}}>


{isShown?<List  header={header} list={pendingData}/>:isShown1?<List header={header} list={acceptedData}/>:isShown2?<div className={style
.accountInfo}>

    {banksData.map((el,id)=>{
        return(<InformationBox key={id} percentageInfo={""} percentage={""} img={img} count={el.Amount} info={el.bank.toUpperCase()}/>

    )})}
</div>:null}
</div>

        </div>
    )

}

export default Admin