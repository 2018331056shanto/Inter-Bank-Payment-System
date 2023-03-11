import React, { Component } from 'react'
import 'bootstrap/dist/css/bootstrap.min.css';
import { POST } from '../api/api';
import { useState } from 'react'
import Nav from './NavbarLogin/NavbarLogin';
import { ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { toast } from 'react-toastify';
const  SignUp=(props)=>{
    let [org,setOrg]=useState("abbank")
    let [user,setUser]=useState("")

    const onChangeSelect=(e)=>{

      setOrg(e.target.value)
      console.log(e.target.value)
    }

    const onChangeInput=(e)=>{
      console.log(e.target.value)
      setUser(e.target.value)

    }
    // console.log(org+" :hall")

    const onClickHandler=async()=>{

      const res=await POST("/register",{user:user,org:org})
      console.log(res)
      if(res.status==200){

        toast.success('🦄 Successfully Registered The User!', {
            position: "bottom-right",
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
        toast.error('🦄 Error While Registering!', {
            position: "bottom-right",
            autoClose: 2000,
            hideProgressBar: false,
            closeOnClick: true,
            pauseOnHover: true,
            draggable: true,
            progress: undefined,
            theme: "light",
            });
     }
    }
    return (
      <>
        

    
      <div>
        <Nav/>

        <h3>Sign Up</h3>
  
       
        <div className="mb-3">
          <label>Username</label>
          <input
            type="text"
            className="form-control"
            placeholder="Enter username"
            onChange={(e)=>onChangeInput(e)}
          />
        </div>
        <div className="mb-3">
          <label>Organization</label>
         <select onChange={(e)=>onChangeSelect(e)} style={{marginLeft:"15px"}}name="bank">
          <option value="abbank">AB Bank</option>
          <option value="bdbank">BD Bank</option>
          <option value="dbbank">DB Bank</option>
          <option value="islamibank">Islami Bank</option>
          <option value="krishibank">Krishi Bank</option>
          </select>
        </div>
        <div className="d-grid">
          <button onClick={onClickHandler} type="submit" className="btn btn-primary">
            Sign Up
          </button>
        </div>
        <p className="forgot-password text-right">
          Already registered <a href="/sign-in">sign in?</a>
        </p>
      </div>
      <ToastContainer />
      </>
    )
  }

export default SignUp