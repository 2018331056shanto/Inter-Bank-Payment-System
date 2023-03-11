import React, { Component } from 'react'
import 'bootstrap/dist/css/bootstrap.min.css';
import { useState,useContext } from 'react';
import { POST } from '../api/api';
import Nav from './NavbarLogin/NavbarLogin';
import { useNavigate } from 'react-router-dom';
import { userContext } from '../context/Context';
import { ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { toast } from 'react-toastify';
const Login=(props)=> {

  const { setLoginUser } = useContext(userContext);

  let [user,setUser]=useState("")
  let [org,setOrg]=useState("")
  let [res,setRes]=useState([])

  const navigate=useNavigate()
  const onChangeUser=(e)=>{

    setUser(e.target.value)
  }
  const onChangeSelect=(e)=>{

    setOrg(e.target.value)
  }

  const onClickHandler=async()=>{

    try {
      const response =  await POST("/login", { user: user, org: org });

      console.log(response)
      if(response.data.message.token==null){
        toast.error('🦄 Error While Logging In!', {
          position: "bottom-right",
          autoClose: 2000,
          hideProgressBar: false,
          closeOnClick: true,
          pauseOnHover: true,
          draggable: true,
          progress: undefined,
          theme: "light",
          });
        navigate("/sign-in")
      }
      else{
        localStorage.setItem("token",response.data.token)
        localStorage.setItem("loggedUser", response.data.message.org);
        setLoginUser(response.data.message.org)
        if(response.status==200){

          toast.success('🦄 Successfully Logged In!', {
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
      
      props.signin({token:response.data.message.token,org:response.data.message.org})
      setRes(response);

      const funct=()=>{

        navigate("/api/bank/home")
      }

      setTimeout( funct,2000)
     
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
        <ToastContainer />

       </div>
    )
  }

  export default Login