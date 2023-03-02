import React, { useEffect } from "react";
import Navbar from "../NavbarLogin/Navbar/Navbar";
import style from './History.module.css'
import '../../../node_modules/bootstrap/dist/css/bootstrap.min.css'
import Card1 from "../Card/card1/Card1";
const History=(props)=>{

useEffect(()=>{

},[])
const items=["ABBank","BDBank","IslamiBank","DBBank","KrishiBank"]


return(

    <div className={style.cont}>
        <Navbar/>
        <div className={style.card1}>
      <Card1 items={items}/>

        </div>
    </div>
)

}

export default History