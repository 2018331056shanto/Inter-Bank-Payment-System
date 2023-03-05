import React, { useState } from 'react'
import '../node_modules/bootstrap/dist/css/bootstrap.min.css'
import './App.css'
import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom'
import Login from './components/login'
import SignUp from './components/signup'
import Home from './components/Home/Home'
import History from './components/History/History'
import Txhistory from './components/TxHistory/Txhistory'
import Txrequest from './components/Txrequest/Txrequest'
function App() {

  let [sign,setSign]=useState({})
  const signIn=(e)=>{
    console.log(e.org)
    setSign(e)
  }
  return (

    <Router>
      <div className="App">
       
            <Routes>
              <Route exact path="/" element={
            
        <div className="auth-wrapper">
        <div className="auth-inner">  
              <Login signin={signIn} />
            </div>
            </div>
            
            } 
              
              />
              <Route path="/sign-in" element={
              
        <div className="auth-wrapper">
        <div className="auth-inner">
              <Login />
              
              </div>
              </div>
              } 
              
              />
              <Route path="/sign-up" element={
              
        <div className="auth-wrapper">
        <div className="auth-inner">
              <SignUp />
              
              </div>
              </div>
              } />
              <Route exact path='/api/home' element={sign.token!=null?<Home sign={sign.org}/>:<div className="auth-wrapper">
        <div className="auth-inner">
              <Login />
              
              </div>
              </div>}/>
              <Route exact path='/api/txhistory' element={<History/>}/>
              <Route exact path='/api/mkreq' element={<Txrequest/>}/>
              <Route exact path='/api/txhistory/:id' element={<Txhistory/>}/>

            </Routes>
        
      </div>
    </Router>
  )
}
export default App