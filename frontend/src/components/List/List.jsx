import React from "react";
import { Link, useLocation } from "react-router-dom";
import styles from "./List.module.css"

const List=(props)=>{
    const location=useLocation();
    let path=location.pathname;
    return(
        <div className={styles.container}>
            <div className={styles.text}>
                {props.textToShow}
            </div>
            
            <div>
            <table class="table table-hover">
  <thead>
    <tr>
        {props.header.map((el,id)=><th key={id}scope="col">{el.field}</th>)}
      
     
    </tr>
  </thead>
  <tbody>

    {props.list.map((el,id1)=>{

return(

    <tr  key={id1}>
       {Object.values(el).map((el1,id)=>{
        return(<>
        {id===0?<th value={el1}scope="row" key={id}>{el1}</th>:<td value={el1} key={id}>{el1}</td>}
        </>
        
    )})}
</tr>
)})}
   
  </tbody>
</table>
            </div>
            {/* <div className={styles.listContainer}>
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

                              
                            {Object.values(el).map((el1,id)=>{
                                return(
                                    <td key={id} className={styles.listItem}>

                                        {el1}      
                                    </td>
                                  )
                              })}                                                            
                        </tr>
                        )
                       
                    })}
                </table>
            </div> */}
           
        </div>
    )
}
export default List;