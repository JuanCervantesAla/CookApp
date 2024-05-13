const express = require('express');
const router = express.Router();
const authController = require('../controllers/auth_controller');
const multer = require('multer');
const path = require('path');


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

router.get('/about_us', authController.isAuthenticatedForSecondaryPages, (req, res) => {
    res.render('about_us', {isAuthenticatedForSecondaryPages: req.isAuthenticatedForSecondaryPages, user: req.user});
});

router.get('/contact', authController.isAuthenticatedForSecondaryPages, (req, res) => {
    res.render('contact', {isAuthenticatedForSecondaryPages: req.isAuthenticatedForSecondaryPages, user: req.user});
});

router.get('/recover_password', (req, res) => {
    res.render('recover_password');
});

router.get('/terms_and_conditions', authController.isAuthenticatedForSecondaryPages, (req, res) => {
    res.render('terms_and_conditions', {isAuthenticatedForSecondaryPages: req.isAuthenticatedForSecondaryPages, user: req.user});
});

router.get('/profile', authController.isAuthenticated, (req, res) => {
    res.render('profile', {user: req.user, updateSuccess: false }); 
});


router.get('/add_recipe', authController.isAuthenticated, (req, res) => {
    res.render('add_recipe', {user: req.user, alert: false}); 
});

router.get('/favorites', authController.isAuthenticated, (req, res) => {
    res.render('favorites', {user: req.user, alert: false}); 
});

router.get('/browser', (req, res) => {
    res.render('browser');
});


// Router para los metodos del controller
router.post('/register', authController.register);
router.post('/login', authController.login);
router.get('/logout', authController.logout);
router.post('/update-description', authController.updateDescription);


// Configurar multer para manejar la carga de archivos
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, 'public/uploads/profile_pics/');
    },
    filename: function (req, file, cb) {
        // const userId = req.user.id; // Obtener el ID de usuario
        const userId = authController.getUser();
        cb(null, 'profile_pic_' + userId.id + path.extname(file.originalname));
    }
});

// Función para validar el formato de archivo
const fileFilter = (req, file, cb) => {
    const allowedFormats = ['.jpg', '.jpeg', '.png', '.gif'];
    const fileExtension = path.extname(file.originalname);
    if (allowedFormats.includes(fileExtension)) {
        cb(null, true); // Aceptar el archivo si su formato está permitido
    } else {
        cb(null, false); // Rechazar el archivo si su formato no está permitido
    }
};

// const upload = multer({ storage: storage });
const upload = multer({ 
    storage: storage,
    fileFilter: fileFilter // Aplicar la validación de formato de archivo
});

// Agregar la ruta para actualizar la foto de perfil
router.post('/update-profile-pic', upload.single('profile-pic'), authController.updateProfilePic);





module.exports = router;