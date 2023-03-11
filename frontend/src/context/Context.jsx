import { createContext, useState } from "react";

export const userContext = createContext();

const UserProvider = ({ children }) => {
let [loginUser, setLoginUser] = useState("");
let [result,setResult]=useState([])
let [account,setAccount]=useState(0)
let [pending1,setPending1]=useState(0)
let [incoming1,setIncoming1]=useState(0)
  return (
    <>
      <userContext.Provider value={{ loginUser, setLoginUser ,result,setResult,account,setAccount,pending1,setPending1,incoming1,setIncoming1}}>
        {children}
      </userContext.Provider>
    </>
  );
};

export default UserProvider