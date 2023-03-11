import React, { useContext, useState } from "react";
import style from './Navbar.module.css'
// import  '../../../../node_modules/bootstrap/dist/css/bootstrap.min.css'
import NotificationBadge from "../../notification/Notification";
import Dropdown from "../../dropdown/Dropdown";
import img1 from './user.png'
import { Link } from "react-router-dom";
import { userContext } from "../../../context/Context";
const Navbar=(props)=>{

    const {loginUser}=useContext(userContext)
    
    let bank=loginUser
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

           <Link style={{textDecoration:"none"}} to='/api/bank/home'> <span className={style.sp3}>Dashboard</span></Link>
           <Link style={{textDecoration:"none"}} to='/api/bank/txhistory'> <span className={style.sp3}>Tx History</span></Link>
            {bank=="bdbank"?<span></span>:<Link style={{textDecoration:"none"}} to='/api/bank/mktxreq'><span className={style.sp3}>Make Tx Request</span></Link>}
           </div>
           <div className={style.div3}>
           <Link style={{textDecoration:"none"}} className={style.sp2} to='/api/bank/profile'>

            <span >

  
                <NotificationBadge/></span>
                </Link>
            <span className={style.sp1} onClick={dorpHandler}>{drop==true?<Dropdown/>:null}
            <img src={img1} />
            </span>
           </div>
        </nav>
    )

}

export default Navbar