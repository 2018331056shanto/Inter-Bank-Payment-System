import React, { useContext, useEffect, useState } from "react";
import Navbar from "../NavbarLogin/Navbar/Navbar";
import style from './Txhistory.module.css'
import List from "../List/List";
import { userContext } from "../../context/Context";
import { useParams } from "react-router-dom";
import { GET } from "../../api/api";
const Txhistory=(props)=>{
    const {loginUser}=useContext(userContext)
    const {id}=useParams()
    let [result,setResult]=useState([])
    // console.log(id)

    const getTxHistory=async()=>{

        let string='/api/bank/txhistory/'+id
        console.log(string)

        const transactResult=await GET(string)
      
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
    // console.log(transHistory)
    let data=[]

    for(let i=0;i<transHistory.length;i++)
    {
        let object={}

        if(transHistory[i].record.bank!=""&&transHistory[i].record.status){

            object["Amount"]=transHistory[i].record.amount
            object["Txtime"]=transHistory[i].timestamp
            object["TxID"]=transHistory[i].record.txID
            object["ref"]=transHistory[i].record.ref
            data.push(object)
        }
    }

    setResult(data)

    }



    useEffect(()=>{

        getTxHistory()


    },[])
    let cur=new Date()
    console.log(props.sign.org)
    const header=[
       {field:"Amount"},{field:"Transaction Time"},{field:"Transaction ID"},{field:"Reference"}
    ]
    // const data=[
    //     {
    //         A:"ab"
    //     }
    // ]
  
    return(
        <div className={style.cont}>
            <Navbar title={props.sign.org}/>
            <div className={style.table1}>
                <div className={style.title1}>Transactions With {id.toLocaleUpperCase()}</div>
            <List header={header} list={result}/>
            </div>
        </div>
    )
}

export default Txhistory