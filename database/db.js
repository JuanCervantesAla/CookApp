const mysql = require('mysql');

// Variable de conexion a la base de datos
const conn = mysql.createConnection({
    host : process.env.DB_HOST,
    user : process.env.DB_USER,
    password : process.env.DB_PASS,
    database : process.env.DB_DATABASE
});

conn.connect( error => {
    if(error){
        console.error('Ha ocurrido un error de conexion a la base de datos: '+error);
        return;
    }
    console.log('Conexion a la base de datos exitosa');
});

module.exports = conn;