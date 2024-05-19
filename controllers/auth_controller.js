const jwt = require('jsonwebtoken');
const bcryptjs = require('bcryptjs');
const {conn} = require('../database/db');
const {promisify, getSystemErrorMap} = require('util');
const { error } = require('console');
const Swal = require('sweetalert2');
const fs = require('fs');
const path = require('path');

// const { title } = require('process');

let user = {};
let idUser;

exports.register = async (req, res) => {
    try {
        const email = req.body.email;
        const name = req.body.name;
        const description = req.body.description;
        const age = req.body.age;
        const pass = req.body.pass;
        const preguntaSecreta = req.body.preguntaSecreta;
        const respuestaSecreta = req.body.respuestaSecreta;

        if (!email || !name || !description || !age || !pass || !preguntaSecreta || !respuestaSecreta) {
            return res.render('register', {
                alert: true,
                alertTitle: 'Advertencia',
                alertMessage: 'Favor de llenar todos los campos',
                alertIcon: 'info',
                showConfirmButton: true,
                timer: false,
                route: 'register'
            });
        }

        // Verificar si el correo electrónico ya está en uso
        conn.query('SELECT COUNT(*) AS count FROM userc WHERE email = ?', [email], async (error, results) => {
            if (error) {
                console.error(`Ha ocurrido un error: ${error}`);
                return res.redirect('/');
            }
            const count = results[0].count;
            if (count > 0) {
                return res.render('register', {
                    alert: true,
                    alertTitle: 'Advertencia',
                    alertMessage: 'El correo electrónico ya está en uso',
                    alertIcon: 'warning',
                    showConfirmButton: true,
                    timer: false,
                    route: 'register'
                });
            }

            // Si el correo electrónico no está en uso, procede con el registro
            try {
                let passHash = await bcryptjs.hash(pass, 8);
                conn.query('INSERT INTO userc SET ?', { email: email, name: name, description: description, age: age }, (error, results) => {
                    if (error) {
                        console.error(`Ha ocurrido un error: ${error}`);
                        return res.redirect('/');
                    }
                    conn.query('SELECT id FROM userc WHERE email = ?', [email], (error, results) => {
                        if (error) {
                            console.error(`Ha ocurrido un error: ${error}`);
                            return res.redirect('/');
                        }
                        let idFromUserToPass = results[0].id;
                        conn.query('INSERT INTO passwordc SET ?', { idUserC: idFromUserToPass, pass: passHash, preguntaSecreta: preguntaSecreta, respuestaSecreta: respuestaSecreta }, (error, results) => {
                            if (error) {
                                console.error(`Ha ocurrido un error: ${error}`);
                                return res.redirect('/');
                            }
                            return res.render('register', {
                                alert: true,
                                alertTitle: 'Registro exitoso',
                                alertMessage: 'Ahora inicia sesión',
                                alertIcon: 'ok',
                                showConfirmButton: true,
                                timer: 5000,
                                route: 'register'
                            });
                        });
                    });
                });
            } catch (error) {
                console.error(`Ha ocurrido un error: ${error}`);
                return res.redirect('/');
            }
        });
    } catch (error) {
        console.error(`Ha ocurrido un error: ${error}`);
        return res.redirect('/');
    }
}



// Procedimiento para logearse
exports.login = async (req, res) => {
    try{
        const email = req.body.email;
        const pass = req.body.pass;

        if(!email || !pass){
            // Lanzar alerta de error
            res.render('login', {
                alert: true,
                alertTitle: 'Advertencia',
                alertMessage: 'Ingresa un email y contraseña',
                alertIcon: 'info',
                showConfirmButton: true,
                timer: false,
                route: 'login'
            });
        }else{
            conn.query('SELECT * FROM userc WHERE email = ?', [email], async (error, resultsUser) => {
                if(error){
                    console.error(`Ha ochurido un erro: ${error}`);
                    res.redirect('/login');
                    return;
                }
                // Verificar si no se encontro ningun usuario (resultado) con ese correo electronico
                if (resultsUser.length === 0) {
                    // Lanzar alerta de error
                    res.render('login', {
                        alert: true,
                        alertTitle: 'Error',
                        alertMessage: 'Usuario y/o contraseña incorrectos',
                        alertIcon: 'error',
                        showConfirmButton: true,
                        timer: false,
                        route: 'login'
                    });
                    return; 
                }
                idUser = resultsUser[0].id;
                conn.query('SELECT * FROM passwordc WHERE idUserC = ?', [resultsUser[0].id], async (error, resultsPass)=>{
                    if(error){
                        console.error(`Ha ochurido un erro: ${error}`);
                        res.redirect('/login');
                        return;
                    }
                    
                    if(resultsUser.length === 0 || resultsPass.length === 0 || !(await bcryptjs.compare(pass, resultsPass[0].pass))){
                        // Lanzar alerta de error
                        res.render('login', {
                            alert: true,
                            alertTitle: 'Error',
                            alertMessage: 'Usuario y/o contraseña incorrectos',
                            alertIcon: 'error',
                            showConfirmButton: true,
                            timer: false,
                            route: 'login'
                        });
                    }else{
                        // Inicio de sesion correcto
                        const id = resultsUser[0].id;
                        
                        // Generacion de token web
                        const token = jwt.sign({id:id}, process.env.JWT_SECRET, {
                            expiresIn: process.env.JWT_EXPIRY_TIME
                        });

                        // Configuracion de cookie
                        const cookieOptions = {
                            expires: new Date(Date.now()+process.env.JWT_COOKIE_EXPIRES * 24 * 60 * 60 * 1000),
                            httpOnly: true
                        }

                        res.cookie('jwt', token, cookieOptions);

                        res.render('login', {
                            alert: true,
                            alertTitle: 'Conexion exitosa',
                            alertMessage: '¡Inicio de sesion correcto!',
                            alertIcon: 'success',
                            showConfirmButton: false,
                            timer: 800,
                            route: ''
                        });
                    }
                });
            });
        }
    }catch(error){
        console.error(`Ha ocurrido un error: ${error}`);
        
    }
}


exports.isAuthenticated = async (req, res, next) => {
    if(req.cookies.jwt){
        try{
            const decoded = await promisify(jwt.verify)(req.cookies.jwt, process.env.JWT_SECRET);
            conn.query('SELECT * FROM userc WHERE id = ?', [decoded.id], (error, results) => {
                if(!results){return next()};
                req.user = results[0];
                user = req.user;
                idUser = decoded.id;
                return next();
            });
        }catch(error){
            console.error(`Ha ocurrido algun error: ${error}`);
            return next();
        }
    }else{
        res.redirect('/home_no_logeado');
    }
}

exports.isAuthenticatedForSecondaryPages = async (req, res, next) => {
    if(req.cookies.jwt){
        try{
            const decoded = await promisify(jwt.verify)(req.cookies.jwt, process.env.JWT_SECRET);
            conn.query('SELECT * FROM userc WHERE id = ?', [decoded.id], (error, results) => {
                if(!results){return next()};
                req.user = results[0];
                req.isAuthenticatedForSecondaryPages = true;
                req.userForSecondaryPages = results[0];
                return next();
            });
        }catch(error){
            console.error(`Ha ocurrido algun error: ${error}`);
            return next();
        }
    }else{
        req.isAuthenticatedForSecondaryPages = false;
        req.user = '';
        return next();
    }
}


exports.logout = (req, res) => {
    res.clearCookie('jwt');
    return res.redirect('/');
}


exports.updateDescription = async (req, res) => {
    try {
        const userId = idUser;
        const newDescription = req.body.description; 
        if (!newDescription) {
            return res.render('profile', {
                alert: true,
                alertTitle: 'Advertencia',
                alertMessage: 'La descripción no puede estar vacía',
                alertIcon: 'info',
                showConfirmButton: true,
                timer: false,
                route: 'profile'
            });
        }else if(newDescription.length >= 120){
            return res.render('profile', {
                user: user, 
                updateSuccess: 0
            });
        }
        // Actualizar la descripcion en la base de datos
        conn.query('UPDATE userc SET description = ? WHERE id = ?', [newDescription, userId], (error, results) => {
            if (error) {
                return res.render('profile', {
                    user: user, 
                    updateSuccess: -1
                });
            }else{
                // Renderizar la página profile con la bandera updateSuccess
                return res.render('profile', {
                    user: user, 
                    updateSuccess: 1
                });
            }
        });
    } catch (error) {
        console.error(`Ha ocurrido un error: ${error}`);
        return res.redirect('/profile');
    }
}

exports.updateProfilePic = async (req, res) => {
    try {
        const userId = idUser; // Obtener el ID de usuario
        let profilePicPath = req.file.path; // Obtener la ruta de la imagen
        profilePicPath = profilePicPath.replace("public\\", "");

        // Verificar si se ha enviado un archivo
        if (!req.file) {
            return res.render('profile', {
                user: user, 
                updateSuccess: -2 // Código para indicar que no se envió ninguna imagen
            });
        }

        // Verificar si el usuario ya tiene una imagen de perfil anterior
        conn.query('SELECT profilePicUrl FROM userc WHERE id = ?', [userId], (error, results) => {
            if (error) {
                return res.render('profile', {
                    user: user, 
                    updateSuccess: -2
                });
            }

            // Actualizar la ruta de la imagen en la base de datos
            conn.query('UPDATE userc SET profilePicUrl = ? WHERE id = ?', [profilePicPath, userId], (error, results) => {
                if (error) {
                    return res.render('profile', {
                        user: user, 
                        updateSuccess: -2
                    });
                }
                return res.render('profile', {
                    user: user, 
                    updateSuccess: 2
                });
            });
        });
    } catch (error) {
        return res.render('profile', {
            user: user, 
            updateSuccess: -2
        });
    }
};


exports.getUser = () => user;


exports.addRecipe = async (req, res) => {
    try {
        let userId = idUser; // Obtener el ID de usuario

        const nombre = req.body.nombre_receta;
        let portada = req.files['portada'] ? req.files['portada'][0].path : null;
        if (portada) portada = portada.replace("public\\", "");
        const ingredientes = req.body.ingredientes;
        const pasos = req.body.pasos;
        const categoria = req.body.categoria;
        const idUserRecipe = idUser;

        let arrIngredientes = ingredientes.split('\n');
        let txtIngredientes = arrIngredientes.join(',');

        let arrPasos = pasos.split('\n');
        let txtPasos = arrPasos.join(',');

        if (!nombre || !ingredientes || !pasos || !categoria) {
            return res.render('add_recipe', {
                alert: true,
                alertTitle: 'Advertencia',
                alertMessage: 'Favor de llenar todos los campos',
                alertIcon: 'info',
                showConfirmButton: true,
                timer: false,
                route: 'add_recipe',
                user: user
            });
        }

        if (!req.files['portada']) {
            return res.render('add_recipe', {
                alert: true,
                alertTitle: 'Oops',
                alertMessage: 'Ha ocurrido un error al subir la imagen de portada, lo lamentamos',
                alertIcon: 'error',
                showConfirmButton: true,
                timer: false,
                route: 'add_recipe',
                user: user
            });
        }

        // Procesar imágenes de los pasos si existen
        let imagenesPasos = req.files['imagenes'] || [];
        let rutasImagenesPasos = imagenesPasos.map(file => file.path.replace("public\\", "")).join(',');

        conn.query('INSERT INTO recipe SET ?', {
            titleRecipe: nombre, 
            categoryRecipe: categoria, 
            stepsRecipe: txtPasos, 
            ingredientsRecipe: txtIngredientes, 
            imgTitleRecipe: portada, 
            imgStepsRecipe: rutasImagenesPasos, // Asegúrate de que la columna imgStepsRecipe existe en tu tabla
            idUserSenderRecipe: userId 
        }, (error, results) => {
            if (error) {
                return res.render('add_recipe', {
                    alert: true,
                    alertTitle: 'Oops',
                    alertMessage: 'Ha ocurrido un error al subir la receta, lo lamentamos',
                    alertIcon: 'error',
                    showConfirmButton: true,
                    timer: false,
                    route: 'add_recipe',
                    user: user
                });
            }
            return res.render('add_recipe', {
                alert: true,
                alertTitle: 'Publicación exitosa',
                alertMessage: 'Se ha publicado exitosamente su receta',
                alertIcon: 'success',
                showConfirmButton: true,
                timer: false,
                route: 'add_recipe',
                user: user
            });
        });

    } catch (error) {
        return res.render('add_recipe', {
            alert: true,
            alertTitle: 'Error',
            alertMessage: `Ha ocurrido un error al subir la receta: ${error}`,
            alertIcon: 'error',
            showConfirmButton: true,
            timer: false,
            route: 'add_recipe',
            user: user
        });
    }
}



// home_controller.js

const { getRecipes } = require('../database/db'); // Importa la función getRecipes

exports.showHomePage = (req, res) => {
    res.render('index', { user: req.user }); // Renderiza la vista inicial
};

exports.showHomePageDeslogeado = (req, res) => {
    res.render('home_no_logeado'); // Renderiza la vista inicial
};

exports.getMoreRecipes = (req, res) => {
    const currentPage = parseInt(req.query.page) || 1;

    getRecipes(currentPage, (err, recipes) => {
        if (err) {
            console.error('Error fetching recipes: ' + err);
            return res.status(500).json({ error: 'Error fetching recipes' });
        }

        res.json(recipes); // Devuelve las recetas en formato JSON
    });
};


