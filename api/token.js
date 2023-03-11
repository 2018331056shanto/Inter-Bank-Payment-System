const {LocalStorage}=require('node-localstorage')
const localStorage = new LocalStorage('./local-storage');

const storage=()=>{

    return localStorage.getItem('token')
}
const organization=()=>{
    return localStorage.getItem('org')
}
// constructor function to retrieve localStorage Ite
module.exports={
    storage,
    organization
}