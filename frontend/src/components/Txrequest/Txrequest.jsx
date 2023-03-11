import React, { useContext, useState } from "react";
import style from './Txrequest.module.css'
import Navbar from '../NavbarLogin/Navbar/Navbar'
import '../../../node_modules/bootstrap/dist/css/bootstrap.min.css'
import { userContext } from "../../context/Context";
import { POST } from "../../api/api";
import { ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { toast } from 'react-toastify';

const Txrequest=(props)=>{

    let [selectBank,setSelectBank]=useState("")
    let [amount,setAmount]=useState("")
    let [ref,setRef]=useState("")

    const onClickHandler=async()=>{

        const res=await POST('/bank/txreq',{selectBank:selectBank,amount:amount,ref:ref})
         if(res.data.length!==0){

            toast.success('🦄 Successfully Made Transaction!', {
                position: "top-right",
                autoClose: 2000,
                hideProgressBar: false,
                closeOnClick: true,
                pauseOnHover: true,
                draggable: true,
                progress: undefined,
                theme: "light",
                });

         }
         else{
            toast.error('🦄 Can not Process Transaction Already Pending Transaction !', {
                position: "top-right",
                autoClose: 2000,
                hideProgressBar: false,
                closeOnClick: true,
                pauseOnHover: true,
                draggable: true,
                progress: undefined,
                theme: "light",
                });
         }
        console.log(res)
    }
    const onChangeBank=(e)=>{

        console.log(e.target.value)
        setSelectBank(e.target.value)
    }
    const onChangeAmount=(e)=>{

        console.log(e.target.value)
        setAmount(e.target.value)

    }
    const onChangeRef=(e)=>{

        console.log(e.target.value)

        setRef(e.target.value)
    }
    const {loginUser}=useContext(userContext)
    console.log(loginUser)
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
          <ToastContainer />
            <div className={style.inner}>
                <div className={style.card}>
                    <div className={style.form}>
                   <div className={style.div1}>
                    <span className={style.sp1}>Select Bank</span>
                   <select onChange={(e)=>onChangeBank(e)} className={style.select} name="bank">
                        {banks.map(item=>{
                        return(
                            item.name!=loginUser?<option  className={style.option} key={item.name} value={item.name}>{item.display}</option>:null

                        )     
                        
                        })}
                    </select>
                    
                   </div>
                   <div className={style.div1}>
                    <span className={style.sp1}>Amount</span>
                    <input onChange={(e)=>onChangeAmount(e)} className={style.input} type="text"/>
                   </div>
                   <div className={style.div1}>
                    <span className={style.sp1}>Reference</span>
                    <input onChange={(e)=>onChangeRef(e)}  className={style.input} type="text"/>
                   </div>
                   <div onClick={onClickHandler} className={style.div2}>
                   <button className={style.button}>Make Transaction</button>
                   </div>
                    </div>
                    
                </div>
                
            </div>
            
        </div>
    )
}

export default Txrequest