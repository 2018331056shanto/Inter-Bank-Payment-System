import React, { useState } from 'react'
import '../node_modules/bootstrap/dist/css/bootstrap.min.css'
import './App.css'
import { BrowserRouter,Router, Routes, Route, Link } from 'react-router-dom'
import Login from './components/login'
import SignUp from './components/signup'
import Home from './components/Home/Home'
import History from './components/History/History'
import Txhistory from './components/TxHistory/Txhistory'
import Txrequest from './components/Txrequest/Txrequest'
import UserProvider from './context/Context'
import Profile from './components/profile/Profile'
import Admin from './components/Admin/Admin'
function App() {

  let [sign,setSign]=useState({})
  const signIn=(e)=>{
    console.log(e.token)
    setSign(e)
  }
  return (

    <>
    <BrowserRouter>
      <UserProvider>
 
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
        <Login signin={signIn} />
              
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
              <Route exact path='/api/bank/home' element={sign.token!=null?<Home sign={{token:sign.token,org:sign.org}}/>:<div className="auth-wrapper">
        <div className="auth-inner">
              <Login />
              
              </div>
              </div>}/>
              <Route exact path='/api/bank/txhistory' element={<History sign={{token:sign.token,org:sign.org}}/>}/>
              <Route exact path='/api/bank/mktxreq' element={<Txrequest sign={{token:sign.token,org:sign.org}}/>}/>
              <Route exact path='/api/bank/txhistory/:id' element={<Txhistory sign={{token:sign.token,org:sign.org}}/>}/>
              <Route exact path='/api/bank/profile' element={<Profile sign={{token:sign.token,org:sign.org}}/>}/>
              <Route exect path="/api/bank/admin/home" element={<Admin sign={{token:sign.token,org:sign.org}}/>}/>
            </Routes>
        
      </div>
 
    </UserProvider>
      </BrowserRouter>
    </>
  )
}
export default App