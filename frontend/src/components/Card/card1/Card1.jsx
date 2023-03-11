import React, { useContext } from "react";
import { Link } from "react-router-dom";
import { userContext } from "../../../context/Context";
import style from './Card1.module.css'


const Card1=(props)=>{

    const {loginUser}=useContext(userContext)
    console.log(loginUser)
    const onClickHandler=()=>{
        
    }
    return(
        <div className={style.card1}>
            {props.items.map((item,id)=>{
                return(
                    <div key={id} className={style.div1}>
                        {
                            item.toLowerCase()!=loginUser?<Link className={style.span} to={'/api/bank/txhistory/'+item.toLowerCase()}> <span className={style.span}>{item}</span></Link>:null
                        }
        
                    </div>
                )
            })}
           
           
        </div>
    )
}

export default Card1