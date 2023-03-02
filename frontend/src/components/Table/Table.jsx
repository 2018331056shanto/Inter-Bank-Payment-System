import React from "react";
import style from './Table.module.css'

const Table=(props)=>{

    return (
        <table className="table">
          <thead>
            <tr>
              {props.header.map((item,id)=>{
                return(
                  <th key={id}>{item}</th>
                )
              })}
            </tr>
          </thead>
          <tbody>
            {props.data.map((item,id)=>{

              return(
                <tr key={id}>
                  
                  {Object.entries(item).map((el1,id)=>{
                    return(
                      <td key={id}>
                        {el1[0]}
                      </td>
                    )
                  })}
                </tr>
              )
            })}
          </tbody>
        </table>
      );
    };
    
    export default Table;
