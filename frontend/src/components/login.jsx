import React, { Component } from 'react'
import 'bootstrap/dist/css/bootstrap.min.css';
import { useState } from 'react';
import { POST } from '../api/api';
const Login=(props)=> {


  let [user,setUser]=useState("")
  let [org,setOrg]=useState("")

  const onChangeUser=(e)=>{

    console.log(e.target.value)
    setUser(e.target.value)
  }
  const onChangeOrg=(e)=>{

    console.log(e.target.value)
    setOrg(e.target.value)
  }

  const onClickHandler=()=>{


    const res=POST("/login",{user:user,org:org})

  }
  
    return (
      <form>
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
          <input
            onChange={(e)=>onChangeOrg(e)}
            type="text"
            className="form-control"
            placeholder="Enter organization name"
          />
        </div>
        <div className="mb-3">
          <div className="custom-control custom-checkbox">
            <input
              type="checkbox"
              className="custom-control-input"
              id="customCheck1"
            />
            <label className="custom-control-label" htmlFor="customCheck1">
              Remember me
            </label>
          </div>
        </div>
        <div className="d-grid">
          <button onClick={onClickHandler} type="submit" className="btn btn-primary">
            Submit
          </button>
        </div>
        <p className="forgot-password text-right">
          Forgot <a href="#">password?</a>
        </p>
      </form>
    )
  }

  export default Login