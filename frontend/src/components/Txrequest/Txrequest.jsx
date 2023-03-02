import React from "react";
import style from './Txrequest.module.css'
import Navbar from '../NavbarLogin/Navbar/Navbar'
import '../../../node_modules/bootstrap/dist/css/bootstrap.min.css'
const Txrequest=(props)=>{

    const banks=[{
                name:"bdbank",
                display:"Bangladesh Bank"
                },
                {
                    name:"abbank",
                    display:"AB Bank"
                    },
                    {
                        name:"dbbank",
                        display:"DB Bank"
                        },
                        {
                            name:"krishibank",
                            display:"Krishi Bank"
                            },
                            {
                                name:"islamibank",
                                display:"Islami Bank"
                                },
            ]
    return(
        <div className={style.cont}>
            <Navbar/>
            <div className={style.inner}>
                <div className={style.card}>
                    <div className={style.form}>
                   <div className={style.div1}>
                    <span className={style.sp1}>Select Bank</span>
                   <select className={style.select} name="bank">
                        {banks.map(item=><option className={style.option} key={item.name} value={item.name}>{item.display}</option>)}
                    </select>
                    
                   </div>
                   <div className={style.div1}>
                    <span className={style.sp1}>Amount</span>
                    <input className={style.input} type="text"/>
                   </div>
                   <div className={style.div1}>
                    <span className={style.sp1}>Reference</span>
                    <input  className={style.input} type="text"/>
                   </div>
                   <div className={style.div2}>
                   <button className={style.button}>Make Transaction</button>
                   </div>
                    </div>
                </div>
            </div>
           
        </div>
    )
}

export default Txrequest