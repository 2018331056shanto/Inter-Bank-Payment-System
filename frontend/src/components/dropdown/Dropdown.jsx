import React, { useContext } from "react";
import style from './Dropdown.module.css'
import img1 from './logout.png'
import user from './user.png'
import { Link, useNavigate } from "react-router-dom";
import { GET } from "../../api/api";
import { userContext } from "../../context/Context";

const Dropdown=()=>{

    const{loginUser}=useContext(userContext)

    let navigte=useNavigate()



    const clickHandler=async()=>{
     const res=await GET('/logout')

     
    navigte('/sign-in')

    }
    return(
        <div className={style.con}>
            <div  onClick={clickHandler} className={style.div1}>
                <span className={style.sp1}><img  className={style.img}  src={img1}/> </span>
                <span className={style.text}>Logout</span>

            </div>
            {loginUser!=="bdbank"?
            <div className={style.div1}>
            <span className={style.sp1}><img className={style.img} src={user}/> </span>

            <Link style={{textDecoration:"none",color:"black"}} to={'/api/bank/profile'}> <span className={style.text}>Profile</span></Link>

            </div>
            :null}
            {/* <div className={style.div2}>world</div> */}
        </div>
    )

}

export default Dropdown