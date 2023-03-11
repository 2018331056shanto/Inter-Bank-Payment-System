import React from "react";
import styles from "./InformationBox.module.css"
import img from './salary.png'
const InformationBox=(props)=>{
 
    return(
        <div className={styles.informationBoxContainer}>
            <div className={styles.imgTextContainer}>

            <div className={styles.imgContainer}>
                <img src={props.img}/>
            </div>
            <div className={styles.textContainer}>
               <div style={{fontWeight:"800"}}>{props.info}</div>

               <h4>{props.count}</h4>

            </div>
            </div>
            <hr/>
            <div className={styles.statContainer}>
                <div className={styles.percentage}>
                    {props.percentage}
                    {/* +55%   */}
                </div>
                <div style={{fontFamily:"sans-serif",fontSize:"15px",fontWeight:"800",marginTop:"10px"}} className={styles.percentageInfo}>
                    {props.percentageInfo}
                    {/* {props.percentageInfo!=null?"Than last Week":null} */}
                </div>
            </div>
        </div>
    )
}
export default InformationBox;