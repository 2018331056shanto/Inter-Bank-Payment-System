import React, { useState } from 'react';
import { FaBell } from 'react-icons/fa';
import 'bootstrap/dist/css/bootstrap.min.css';
import { useNavigate } from 'react-router-dom';
const NotificationBadge = (props) => {
    let [count,setCount]=useState(232)
    const navigate=useNavigate()
    const clickHandler=()=>{
        
        // count=0  
        setCount(0)
        // navigate('/sign-in')
     
    }
  return (
    <div className="position-relative">
      <button onClick={clickHandler} className="btn btn-light">
        <FaBell />
      </button>
      {count > 0 && (
        <span className="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
          {count}  
        </span>
        
      )}
    </div>
  );
};

export default NotificationBadge;
