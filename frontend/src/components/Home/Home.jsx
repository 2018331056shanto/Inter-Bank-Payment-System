import React, { useEffect, useState } from "react";
import style from './Home.module.css'
import Navbar from "../NavbarLogin/Navbar/Navbar";
import Card from "../Card/Card";
import LineChart from "../Linechart/LineChart";
import List from "../List/List";
import { GET } from "../../api/api";


const Home=(props)=>{

    let [Data,setData]=useState([])

    const getData=async()=>{
          console.log(props.sign)
        const result=await GET(`/api/bank/+${props.sign}`)
        console.log(result)
        setData(result)
    }
    useEffect(()=>{

      getData()

    },[])

    let cur=new Date()
    const header=[
        {name:"Bank Name"},{name:"Amount"},{name:"Tx Time"},{name:"TX ID"}
    ]

    const data=[
        {
         
            Bank:"ABBank",
            Amount:2311,
            Time:cur.toJSON(),
            LastTx:"shdla;ddhasdasda"
        },
        {
           
            Bank:"BDBank",
            Amount:2311,
            Time:cur.toJSON(),
            LastTx:"shdla;ddhasdasda"
        },
        {
            
            Bank:"KrishiBank",
            Amount:2311,
            Time:cur.toJSON(),
            LastTx:"shdla;ddhasdasda"
        }
        ,
        {
            
            Bank:"IslamiBank",
            Amount:2311,
            Time: cur.toJSON(),
            LastTx:"shdla;ddhasdasda"
        }
    ]
    return(
        <div className={style.con}>

            <div className={style.div1}>
              <Navbar/>  
            </div>
            <div className={style.div2}>
                
                 <Card title={"Current Account Status"}>
                <div className={style.currentA}> 

                    <div className={style.incard}>
                        <span className={style.sp1}>Total Money Remains</span> <span style={{fontSize:`20px`,color:'green'}} className={style.sp2}>33443242</span>    
                    </div>
                    
                <div className={style.incard}>
                    <span className={style.sp1}>Last Tx ID</span><span className={style.sp2}>3d8dhdadasdasdsasss</span>
                </div>
                <div  className={style.incard}>
                    <span className={style.sp1}>Last Tx Amount</span><span className={style.sp2}>3812</span>
                </div>
                <div className={style.incard}>
                    <span className={style.sp1}>Last Bank to Transact</span><span className={style.sp2}>Bdbank</span>
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

                <LineChart/>
            </div>
            <div className={style.table1}>
                <div className={style.title1}>All Banks Transaction</div>
            <List header={header} list={data}/>
            </div>
           
        </div>
    )

}

export default Home