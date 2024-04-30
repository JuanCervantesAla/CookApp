const express = require('express');
const router = express.Router();
const authController = require('../controllers/auth_controller');

// Router para las vistas
router.get('/', authController.isAuthenticated, (req, res) => {
    res.render('index', {user: req.user});    // Express ya sabe por defecto que las vistas estan en la carpeta view
});

router.get('/home_no_logeado', (req, res) => {
    res.render('home_no_logeado');
});

router.get('/login', (req, res) => {
    res.render('login', {alert: false});
});

router.get('/register', (req, res) => {
    res.render('register');
});

// Router para los metodos del controller
router.post('/register', authController.register);
router.post('/login', authController.login);
router.get('/logout', authController.logout);

module.exports = router;