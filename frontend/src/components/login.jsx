import React, { Component } from 'react'
import 'bootstrap/dist/css/bootstrap.min.css';
import { useState } from 'react';
import { POST } from '../api/api';

import Nav from './NavbarLogin/NavbarLogin';
import { useNavigate } from 'react-router-dom';

const Login=(props)=> {


  let [user,setUser]=useState("")
  let [org,setOrg]=useState("")
  let [res,setRes]=useState([])

  const navigate=useNavigate()
  const onChangeUser=(e)=>{

    // console.log(e.target.value)
    setUser(e.target.value)
  }
  const onChangeSelect=(e)=>{

    // console.log(e.target.value)
    setOrg(e.target.value)
  }

  const onClickHandler=async()=>{

    // console.log("its submit button")
    try {
      const response =  await POST("/login", { user: user, org: org });
      console.log(response.data.message);
      console.log(response.data.token)
      // console.log(localStorage.getItem('token'))
      if(response.data.token==null){
        // console.log("in if ")
        navigate("/sign-in")
      }
      else{
        // console.log("in else funct")
        localStorage.setItem("token",response.data.token)

      props.signin({org:org,token:response.data.token})
      setRes(response);
      navigate("/api/home")
      }
    
    } catch (error) {
      console.log(error);
    }

  }
  
    return (
      <div>
        <Nav/>
        
        <h3>Sign In</h3>
        <div className="mb-3">
          <label>Username</label>
          <input
            onChange={(e)=>onChangeUser(e)}
            type="text"
            className="form-control"
            placeholder="Enter username"
          />
        </div>
        <div className="mb-3">
          <label>Organization</label>
         <select onClick={(e)=>onChangeSelect(e)} style={{marginLeft:"15px"}}name="bank">
          <option value="abbank">AB Bank</option>
          <option value="bdbank">BD Bank</option>
          <option value="dbbank">DB Bank</option>
          <option value="islamibank">Islami Bank</option>
          <option value="krishibank">Krishi Bank</option>
          </select>
        </div>
        <div className="mb-3">
          <div 
          className="custom-control custom-checkbox"
          >
            <input
              type="checkbox"
              className="custom-control-input"
              id="customCheck1"
            />
            <label
             className="custom-control-label"
              htmlFor="customCheck1"
              >
              Remember me
            </label>
          </div>
        </div>
        <div 
        className="d-grid"
        >
          <button onClick={onClickHandler}
           className="btn btn-primary"
           >
            Submit
          </button>
        </div>
        <p className="forgot-password text-right">
          Forgot <a href="#">password?</a>
        </p>
       </div>
    )
  }

  export default Login