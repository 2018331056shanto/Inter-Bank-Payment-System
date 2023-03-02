import React from "react";
import { Link } from "react-router-dom";
import style from './Card1.module.css'


const Card1=(props)=>{


    return(
        <div className={style.card1}>
            {props.items.map((item,id)=>{
                return(
                    <div key={id} className={style.div1}>
                   <Link  className={style.span} to={'/api/txhistory/'+item.toLowerCase()}> <span className={style.span}>{item}</span></Link>
        
                    </div>
                )
            })}
           
           
        </div>
    )
}

export default Card1