import axios from 'axios'
/// random string
const BASEURL = "http://localhost:9000";
const API = axios.create({baseURL:BASEURL})
export const GET = async (x)=>{
    const s = await API.get(x);
    return s;
}
export const POST=async(x,y)=>{
    console.log(x+"  "+y)
    
    const res=await API.post(x,y)
    // console.log(res)
    return res;
}