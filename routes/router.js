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
    res.render('register', {alert: false});
});

router.get('/about_us', (req, res) => {
    res.render('about_us');
});

router.get('/contact', (req, res) => {
    res.render('contact');
});

router.get('/recover_password', (req, res) => {
    res.render('recover_password');
});

router.get('/terms_and_conditions', (req, res) => {
    res.render('terms_and_conditions');
});

router.get('/profile', authController.isAuthenticated, (req, res) => {
    res.render('profile', {user: req.user}); 
});

router.get('/browser', (req, res) => {
    res.render('browser');
});

// Router para los metodos del controller
router.post('/register', authController.register);
router.post('/login', authController.login);
router.get('/logout', authController.logout);

module.exports = router;