// Para el tema del servidor
const express = require('express');
// Para usar variables de entorno
const dotenv = require('dotenv');
// Uso de cookies (tokens)
const cookieParser = require('cookie-parser');

const app = express();

// Definimos el motor de plantillas a usar
app.set('view engine', 'ejs');

// Setear la carpeta public
app.use(express.static('public'));

app.use(express.urlencoded({extended:true}));   // Para el manejo de la url (datos desde forms)
app.use(express.json());  // Para que node trabaje con json

// Definir las variables de entorno
dotenv.config({path: './env/.env'});

// Para poder trabajar con cookies
app.use(cookieParser());

// Llamar al router
app.use('/', require('./routes/router'));

// Para eliminar el cache y que no se pueda regresar el usuario con el boton de "atras" luego de cerrar sesion
app.use(function(req, res, next){
    if(!req.user) res.header('Cache-Control', 'private, no-cache, no-store, must-revalidate');
    next();
});


app.listen(3000, () => {
    console.info('Server up running in http://localhost:3000');
});


