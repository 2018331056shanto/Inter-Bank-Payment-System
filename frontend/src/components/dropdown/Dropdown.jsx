import React from "react";
import style from './Dropdown.module.css'
import img1 from './logout.png'
import { useNavigate } from "react-router-dom";

const Dropdown=()=>{

    let navigte=useNavigate()


    const clickHandler=()=>{

        navigte('/sign-in')

    }
    return(
        <div className={style.con}>
            <div className={style.div1}>
                <span className={style.sp1}><img src={img1}/> </span>
                <span className={style.text} onClick={clickHandler}>Logout</span>
            </div>
            {/* <div className={style.div2}>world</div> */}
        </div>
    )

}

export default Dropdown