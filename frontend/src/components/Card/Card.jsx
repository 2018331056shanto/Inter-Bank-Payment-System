import React from "react";
import style from './Card.module.css'


const Card=(props)=>{

    return(
        <div className={style.rootC}>
            <div className={style.title}>   
            {props.title}
            </div>
            <div  className={style.card}>
                  {props.children}
            </div>
      

        </div>
    )
}

export default Card