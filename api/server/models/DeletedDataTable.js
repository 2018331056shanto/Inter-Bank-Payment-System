const deletedData=`create table DeletedData (
    ID varchar(100) primary key,
    frombank varchar(10),
    tobank varchar(10),
    amount int,
    ref varchar(100),
    timestamp varchar(100),
    bankid varchar(50),
    txID varchar(50)
    );`
    module.exports=deletedData;

    