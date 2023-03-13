import React, { useEffect, useState } from "react";
import style from './Home.module.css'
import Navbar from "../NavbarLogin/Navbar/Navbar";
import Card from "../Card/Card";
import LineChart from "../Linechart/LineChart";
import List from "../List/List";
import { GET } from "../../api/api";
import { useNavigate } from "react-router-dom";
import { useContext } from "react";
import { userContext } from "../../context/Context";
import InformationBox from "../InformationBox/InformatioBox";
import img1 from './transaction.png'
import img2 from './incoming-message.png'

const Home=(props)=>{
    let [Data,setData]=useState([])
    let [transaction,setTransaction]=useState([])
    let [lasttx,setLasttx]=useState({})
    let [notficationcnt,setNotificationcnt]=useState(0)
    let [chartData,setChartData]=useState([])
    let [map,setMap]=useState([])
    let [pending,setpending]=useState(0)
    let [incoming,setIncoming]=useState(0)
    const navigate=useNavigate()
    const {setResult}=useContext(userContext)
    const {setAccount}=useContext(userContext)  
    const {loginUser}=useContext(userContext)
    const {setPending1}=useContext(userContext)
    const {setIncoming1}=useContext(userContext)
    const [onlyTxID,setOnlyTxID]=useState([])
    const getDeletedTxID=async()=>{

        const result=await GET('/api/bank/gettxid')
        console.log(result)
        let txIDArray=[]
        // console.log("hello hunny bunny")

        for(let i=0;i<result.data.length;i++)
        {
            // console.log("hhdsldhs")
            let temp1=result.data[i].txID
            txIDArray.push(temp1)
        }
        console.log(txIDArray)
        setOnlyTxID(txIDArray)
        // setDeletedTxid(result.data)
    }
    const getData=async()=>{
        let string= `/api/bank/account`

        const result=await GET(string)
       console.log(result)
        setAccount(result.data.result.Amount)
        setData(result)
       
    }
    const getTxHistory=async()=>{


        const result1=await GET('/api/bank/gettxid')
        console.log(result1)
        let txIDArray=[]
        console.log("hello hunny bunny")

        for(let i=0;i<result1.data.length;i++)
        {
            // console.log("hhdsldhs")
            let temp1=result1.data[i].txID
            txIDArray.push(temp1)
        }
        console.log(txIDArray)

       let string='/api/bank/history'
        const transactResult=await GET(string)

        console.log(transactResult)
            if(transactResult.data!==""){

           console.log("+++++++++++++++++++++++++++++")
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
      for(let i=0;i<transHistory.length;i++){
        if(transHistory[i].record.status){
            console.log(transHistory[i])
            setLasttx(transHistory[i])
            break
        }
      }
      let cnt=0;
      for(let i=0;i<transHistory.length;i++)
      {
        if(transHistory[i].isDelete==false&&transHistory[i].record.status==false){
            cnt++
        }
      }
      let chart=[]
      let pendingCnt=0
    //   let incomingReq=0
      for(let i=0;i<transHistory.length;i++)
      {
        if(transHistory[i].isDelete==false&&transHistory[i].record.status==true&&transHistory[i].record.from===loginUser){
            
            chart.push(transHistory[i].record.amount)
        }
        
      }
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
      
       setIncoming(map1.size)
      
      let xx=[]
      let dataMap={}
      for( let i=transHistory.length-1;i>=0;i--)
      {
        
        if(transHistory[i].record.status){
            dataMap[transHistory[i].record.to]=transHistory[i]
        }
       
      }

      const dataMapArray=Object.entries(dataMap)
      for(let i=0;i<dataMapArray.length;i++)
      {
        let object={}
        if(dataMapArray[i][0]!=""){
            
            object["Bank"]=dataMapArray[i][0].toLocaleUpperCase()
            object["Amount"]=dataMapArray[i][1].record.amount
            object["TxTime"]=dataMapArray[i][1].timestamp
            object["Txid"]=dataMapArray[i][1].record.txID
            object["Ref"]=dataMapArray[i][1].record.ref
            // object["id"]=dataMapArray[i][1].txID
            xx.push(object)
    
        }
     
      }
      console.log(transHistory)
        setpending(map.size)
        // setIncomiing(incomingReq)
        setPending1(map.size)
        setIncoming1(map1.size)
        setMap(xx)
        setChartData(chart)
        setNotificationcnt(cnt)
        setTransaction(transHistory)
        setResult(transHistory)
    }
}
    useEffect(()=>{
    const token = localStorage.getItem("token");
    if (loginUser==null) {
      navigate("/sign-in");
    }
    getTxHistory()
      getData()
      
     

    },[navigate])

    let cur=new Date()

    // const header=[
    //     {name:"Bank Name"},{name:"Amount"},{name:"Transaction Time"},{name:"Transaction ID"},{name:"Reference"}
    // ]
    const header=[
        {field:"Bank Name"},{field:"Amount"},{field:"Transaction Time"},{field:"Transaction ID"},{field:"Reference"}
    ]
    return(
        <div className={style.con}>

            <div className={style.div1}>
              <Navbar  title={props.sign.org}/> 

            </div>
            <div className={style.info}>
            <InformationBox percentageInfo={"Then previous week"} percentage={"20%"} img={img1} count={pending} info={"Pending Transaction"}/>
            <InformationBox percentageInfo={"Then previous week"} percentage={"19%"} img={img2} count={incoming} info={"Incoming Request."}/>

            </div>
            <div className={style.div2}>
                
                 <Card title={"Current Account Status"}>
                <div className={style.currentA}> 

                    <div className={style.incard}>
                        <span className={style.sp1}>Total Money Remains</span> <span style={{fontSize:`20px`,color:'green'}} className={style.sp2}>{Data.length!=0?Data.data.result.Amount:null}</span>    
                    </div>
                    
                <div className={style.incard}>
                    <span className={style.sp1} >Last Tx ID</span><span className={style.sp2} style={{overflow:"hidden"}}>{Object.keys(lasttx).length!=0?lasttx.record.txID:null}</span>
                </div>
                <div  className={style.incard}>
                    <span className={style.sp1}>Last Tx Amount</span><span className={style.sp2}>{Object.keys(lasttx).length!==0?lasttx.record.amount:null}</span>
                </div>
                <div className={style.incard}>
                    <span className={style.sp1}>Last Bank to Transact</span><span className={style.sp2}>{Object.keys(lasttx).length!==0?lasttx.record.to.toUpperCase():null}</span>
                </div>


                </div>
                
                </Card>
                
                 <Card title={"Today's Loan & Deposit"}>
                    
                 <div className={style.currentA}> 

<div className={style.incard}>
    <span className={style.sp1}>Total Deposit Amount</span> <span style={{fontSize:`20px`,color:'green'}} className={style.sp2}>33443242</span>    
</div>

<div className={style.incard}>
<span className={style.sp1}>Total Loan Amount</span><span style={{fontSize:`20px`,color:'red'}}className={style.sp2}>686</span>
</div>
<div  className={style.incard}>
<span className={style.sp1}>No of Deposit</span><span style={{fontSize:`20px`,color:'green'}} className={style.sp2}>3812</span>
</div>
<div className={style.incard}>
<span className={style.sp1}>No of Loan</span><span style={{fontSize:`20px`,color:'red'}} className={style.sp2}>2737</span>
</div>


</div>
                
                </Card>
               
            </div>
            
            <div className={style.div3}>

                <LineChart data={chartData}/>
            </div>
            <div className={style.table1}>
                <div className={style.title1}>All Banks Transaction</div>
            <List header={header} list={map}/>
            </div>
           
        </div>
    )

}

export default Home