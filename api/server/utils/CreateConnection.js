const mysql=require("mysql")
require("dotenv").config()
module.exports=db=mysql.createConnection({
                host:process.env.HOST,
                user:"root",
                password:process.env.PASSWORD,
                database:process.env.DATABASE
}
)
