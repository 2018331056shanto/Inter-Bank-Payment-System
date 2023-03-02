import React, { Component } from 'react'
import 'bootstrap/dist/css/bootstrap.min.css';
import { POST } from '../api/api';
import { useState } from 'react'
import Nav from './NavbarLogin/NavbarLogin';
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

    const onClickHandler=()=>{

      const res=POST("/register",{user:user,org:org})
    }
    return (
      <form>
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
      </form>
    )
  }

export default SignUp