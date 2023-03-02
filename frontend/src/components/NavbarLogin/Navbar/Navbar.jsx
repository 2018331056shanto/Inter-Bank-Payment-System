import React, { useState } from "react";
import style from './Navbar.module.css'
// import  '../../../../node_modules/bootstrap/dist/css/bootstrap.min.css'
import NotificationBadge from "../../notification/Notification";
import Dropdown from "../../dropdown/Dropdown";
import img1 from './user.png'
import { Link } from "react-router-dom";
const Navbar=(props)=>{
    let bank="abbank"
    let [drop,setDrop]=useState(false)
    const dorpHandler=()=>{

        setDrop(!drop)
    }


    return(
        <nav className={style.nav}>
           <div className={style.div1}>
            {/* <span>{props.bankName}</span> */}
            <span className={style.text}>{bank.toUpperCase()}</span>
            
           </div>
           <div className={style.div2}>

           <Link style={{textDecoration:"none"}} to='/api/home'> <span className={style.sp3}>Dashboard</span></Link>
           <Link style={{textDecoration:"none"}} to='/api/txhistory'> <span className={style.sp3}>Tx History</span></Link>
            {bank=="bdbank"?<span>null</span>:<Link style={{textDecoration:"none"}} to='/api/mkreq'><span className={style.sp3}>Make Tx Request</span></Link>}
           </div>
           <div className={style.div3}>
            
            <span className={style.sp2}><NotificationBadge/></span>
            <span className={style.sp1} onClick={dorpHandler}>{drop==true?<Dropdown/>:null}
            <img src={img1} />
            </span>
           </div>
        </nav>
    )

}

export default Navbar