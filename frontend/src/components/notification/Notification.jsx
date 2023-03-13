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
 

    const navigate=useNavigate()
    const clickHandler=()=>{
        
        setNotificationcnt(0)
     
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
