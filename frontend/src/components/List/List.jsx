import React from "react";
import { Link, useLocation } from "react-router-dom";
import styles from "./List.module.css"
const List=(props)=>{
    const location=useLocation();
    let path=location.pathname;
    console.log(props.list)
    return(
        <div className={styles.container}>
            <div className={styles.text}>
                {props.textToShow}
            </div>
            <div className={styles.listContainer}>
                <table   border="0" cellSpacing="0" cellPadding="0" className={styles.tableContainer}>
                    <tr>
                       {props.header.map((el,id)=>{
                           return(
                               <th className={styles.text} key={id}>{el.name}</th>
                           )
                       })}
                    </tr>
                    {props.list.map((el,id)=>{
                        return(
                            <tr  className={id%2?styles.row1:styles.row} key={id}>
                                
                              {Object.entries(el).map((el1,id)=>{
                                  return(
                                      <td key={id} className={styles.listItem}>
                                          
                                         {el1[0]==="MedicalHistory"?<span><Link className={styles.link} to={path+"/"+el.Patient_ID}>History</Link></span>:<span>{el1[0]==="Patient_ID"?<span>{id}</span>:<span>{el1[0]==="Status"?null:<span>{el1[1]}</span>}</span>}</span>}
                                        </td>
                                  )
                              })}
                           
                        </tr>
                        )
                       
                    })}
                </table>
            </div>
           
        </div>
    )
}
export default List;