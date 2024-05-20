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

function getRecipes(page, idUser, callback) {
    const offset = (page - 1) * ITEMS_PER_PAGE;
    // const sql = 'SELECT * FROM recipe ORDER BY idRecipe DESC LIMIT ?, ?';
    // const sql = 'SELECT recipe.*, userc.profilePicUrl, userc.name FROM recipe JOIN userc ON recipe.idUserSenderRecipe = userc.id ORDER BY recipe.idRecipe DESC LIMIT ?, ?';
    

    const sql = `
    SELECT 
        recipe.*, 
        userc.profilePicUrl, 
        userc.name, 
        CASE WHEN fav.idUserLike IS NOT NULL THEN 1 ELSE 0 END AS liked 
    FROM 
        recipe 
    JOIN 
        userc 
    ON 
        recipe.idUserSenderRecipe = userc.id 
    LEFT JOIN 
        \`like\` AS fav 
    ON 
        recipe.idRecipe = fav.idRecipeLike 
    AND 
        fav.idUserLike = ?
    ORDER BY 
        recipe.idRecipe DESC 
    LIMIT 
        ?, ?`;

    
    
    // conn.query(sql, [offset, ITEMS_PER_PAGE], (err, results) => {
    //     if (err) {
    //         return callback(err, null);
    //     }
    //     return callback(null, results);
    // });



    conn.query(sql, [idUser, offset, ITEMS_PER_PAGE], (err, results) => {
        if (err) {
            return callback(err, null);
        }
        return callback(null, results);
    });
}

// Función para obtener una receta específica por su ID
function getRecipeById(id, callback) {
    const sql = 'SELECT recipe.*, userc.profilePicUrl, userc.name FROM recipe JOIN userc ON recipe.idUserSenderRecipe = userc.id WHERE idRecipe = ?';
    conn.query(sql, [id], (err, results) => {
        if (err) {
            return callback(err, null);
        }
        return callback(null, results[0]); // results[0] porque esperamos un solo resultado
    });
}

function getRecipesUser(idUser, callback) {
    const sql = 'SELECT * FROM recipe WHERE idUserSenderRecipe = ?';
    conn.query(sql, [idUser], (err, results) => {
        if (err) {
            return callback(err, null);
        }
        return callback(null, results);
    });
}


function toggleLikeForRecipe(userId, recipeId, callback) {
    // Verifica si el "me gusta" ya existe
    const checkLikeSql = 'SELECT * FROM `like` WHERE idUserLike = ? AND idRecipeLike = ?';
    conn.query(checkLikeSql, [userId, recipeId], (err, results) => {
        if (err) {
            return callback(err, null);
        }

        if (results.length > 0) {
            // Si ya existe, elimina el "me gusta"
            const deleteLikeSql = 'DELETE FROM `like` WHERE idUserLike = ? AND idRecipeLike = ?';
            conn.query(deleteLikeSql, [userId, recipeId], (err, results) => {
                if (err) {
                    return callback(err, null);
                }
                return callback(null, false); // False indica que se eliminó el "me gusta"
            });
        } else {
            // Si no existe, inserta el "me gusta"
            const insertLikeSql = 'INSERT INTO `like` (idUserLike, idRecipeLike) VALUES (?, ?)';
            conn.query(insertLikeSql, [userId, recipeId], (err, results) => {
                if (err) {
                    return callback(err, null);
                }
                return callback(null, true); // True indica que se añadió el "me gusta"
            });
        }
    });
} 



module.exports = {
    conn: conn,
    getRecipes: getRecipes,
    getRecipeById: getRecipeById,
    getRecipesUser: getRecipesUser,
    toggleLikeForRecipe: toggleLikeForRecipe
};
