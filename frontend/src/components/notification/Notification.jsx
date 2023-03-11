import React, { useState,useEffect, useContext } from 'react';
import { FaBell } from 'react-icons/fa';
import 'bootstrap/dist/css/bootstrap.min.css';
import { useNavigate } from 'react-router-dom';
import { GET } from '../../api/api';
import { userContext } from '../../context/Context';
const NotificationBadge = (props) => {

  let [notficationcnt,setNotificationcnt]=useState(0)
  let [data,setData]=useState([])
  const {loginUser}=useContext(userContext)
  const {incoming1}=useContext(userContext)
  // const org=localStorage.getItem('loggedUser')  
  // const getTxHistory=async()=>{
  //    let string='/api/bank/history'
  //     const transactResult=await GET(string)
      

  //     let history=transactResult.data.map(el=>{
  //         const temp=JSON.parse(el.result)
  //         const arr=Object.values(temp)
  //         // console.log(arr)
  //         return arr
  //     })

  // let transHistory=[]

  // // console.log(history)
  // history.map(el=>{
      
  //     el.map(el1=>{
          
  //         transHistory.push(el1)
  //     })
  // })
  // let map1=new Map()
  // for(let i=transHistory.length-1;i>=0;i--)
  // {
  //      let key=transHistory[i].record.txID
  //      if(map1.get(key)||transHistory[i].isDelete===true){

  //          // console.log("deleted key : ",transHistory[i])
  //          map1.delete(key)
  //      }
  //      else{
  //          if(transHistory[i].record.txID!==""&&transHistory[i].record.to===loginUser)
  //              {
  //                  map1.set(key,transHistory[i])
  //                  // console.log("set key : ",transHistory[i])
       
  //                  }       
  //          }

  // }
  // setNotificationcnt(map1.size)
    
      
  // }
  // useEffect(()=>{
      
  // // console.log("hello welcome home")
  //     getTxHistory()
   

  // },[])

    const navigate=useNavigate()
    // setCount(props.notification)
    const clickHandler=()=>{
        
        // count=0  
        setNotificationcnt(0)
        // navigate('/sign-in')
     
    }
  return (
    <div className="position-relative">
      <button onClick={clickHandler} className="btn btn-light">
        <FaBell />
      </button>
      {incoming1 > 0 && (
        <span className="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
          {incoming1}  
        </span>
        
      )}
    </div>
  );
};

export default NotificationBadge;
