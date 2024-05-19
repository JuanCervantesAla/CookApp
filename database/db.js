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


// Función para obtener recetas con paginación
const ITEMS_PER_PAGE = 9;

function getRecipes(page, callback) {
    const offset = (page - 1) * ITEMS_PER_PAGE;
    // const sql = 'SELECT * FROM recipe ORDER BY idRecipe DESC LIMIT ?, ?';
    const sql = 'SELECT recipe.*, userc.profilePicUrl, userc.name FROM recipe JOIN userc ON recipe.idUserSenderRecipe = userc.id ORDER BY recipe.idRecipe DESC LIMIT ?, ?';
    conn.query(sql, [offset, ITEMS_PER_PAGE], (err, results) => {
        if (err) {
            return callback(err, null);
        }
        return callback(null, results);
    });
}

module.exports = {
    conn: conn,
    getRecipes: getRecipes
};

// module.exports = conn;

