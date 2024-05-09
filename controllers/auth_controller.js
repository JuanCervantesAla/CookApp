const jwt = require('jsonwebtoken');
const bcryptjs = require('bcryptjs');
const conn = require('../database/db');
const {promisify, getSystemErrorMap} = require('util');
const { error } = require('console');
const Swal = require('sweetalert2');



// Procedimiento para registrar usuario
// exports.register = async (req, res) => {
//     try{
//         const email = req.body.email;
//         const name = req.body.name;
//         const description = req.body.description;
//         const age = req.body.age;
//         const pass = req.body.pass;
//         const preguntaSecreta = req.body.preguntaSecreta;
//         const respuestaSecreta = req.body.respuestaSecreta;
//         let passHash = await bcryptjs.hash(pass, 8);
//         let idFromUserToPass;

//         if(!email || !name || !description || !age || !pass || !preguntaSecreta || !respuestaSecreta){
//             res.render('register', {
//                 alert: true,
//                 alertTitle: 'Advertencia',
//                 alertMessage: 'Favor de llenar todos los campos',
//                 alertIcon: 'info',
//                 showConfirmButton: true,
//                 timer: false,
//                 route: 'register'
//             });
//         }

//         // Sentencias SQL
//         conn.query('INSERT INTO userc SET ?', {email: email, name:name, description:description, age:age}, (error, results) => {
//             if(error){
//                 console.error(`Ha ochurido un erro: ${error}`);
//                 res.redirect('/');
//                 return;
//             }
//             conn.query('SELECT id FROM userc WHERE email = ?', [email], (error, results) => {
//                 if(error){
//                     console.error(`Ha ochurido un erro: ${error}`);
//                     res.redirect('/');
//                     return;
//                 }
//                 idFromUserToPass = results.map(row => row.id);
//                 conn.query('INSERT INTO passwordc SET ?', {idUserC:idFromUserToPass, pass:passHash, preguntaSecreta:preguntaSecreta, respuestaSecreta:respuestaSecreta}, (error, results) => {
//                     if(error){
//                         console.error(`Ha ochurido un erro: ${error}`);
//                         res.redirect('/');
//                         return;
//                     }
//                 });
//                 // res.redirect('/login');
//                 res.render('register', {
//                     alert: true,
//                     alertTitle: 'Registro exitoso',
//                     alertMessage: 'Ahora inicia sesión',
//                     alertIcon: 'ok',
//                     showConfirmButton: true,
//                     timer: 5000,
//                     route: 'register'
//                 });
//             });
//         });
//     }catch(error){
//         console.error(`Ha ochurido un erro: ${error}`);
//     }    
// }



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