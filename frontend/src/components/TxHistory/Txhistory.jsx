import React from "react";
import Navbar from "../NavbarLogin/Navbar/Navbar";
import style from './Txhistory.module.css'
import List from "../List/List";

const Txhistory=(props)=>{
    let cur=new Date()
    const header=[
        {name:"Bank Name"},{name:"Amount"},{name:"Tx Time"},{name:"Last TX"}
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
        <div className={style.cont}>
            <Navbar/>
            <div className={style.table1}>
                <div className={style.title1}>All Banks Transaction</div>
            <List header={header} list={data}/>
            </div>
        </div>
    )
}

export default Txhistory