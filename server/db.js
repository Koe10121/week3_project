const mysql=require('mysql2');
const con=mysql.createConnection({
    user:'root',
    password:'',
    database:'expenses',

});

module.exports=con;