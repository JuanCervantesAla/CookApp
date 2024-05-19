const express = require('express');
const router = express.Router();
const authController = require('../controllers/auth_controller');
const multer = require('multer');
const path = require('path');
const conn = require('../database/db');


// Router para las vistas
router.get('/', authController.isAuthenticated, authController.showHomePage, (req, res) => {
    res.render('index', {user: req.user});    // Express ya sabe por defecto que las vistas estan en la carpeta view
});

router.get('/more-recipes', authController.getMoreRecipes);

router.get('/home_no_logeado', authController.showHomePageDeslogeado, (req, res) => {
    res.render('home_no_logeado');
});

// Ruta para mostrar la receta completa
router.get('/recipe/:id', authController.showRecipe);

// router.get('/recipe/:id', authController.showRecipe, authController.isAuthenticated, (req, res) => {
//     res.render('recipe', { user: req.user});
// });

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

// Configurar multer para manejar la carga de archivos de perfil
const profileStorage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, 'public/uploads/profile_pics/');
    },
    filename: function (req, file, cb) {
        // const userId = req.user.id; // Obtener el ID de usuario
        const userId = authController.getUser();
        cb(null, 'profile_pic_' + userId.id + path.extname(file.originalname));
    }
});

// Función para validar el formato de archivo de perfil
const profileFileFilter = (req, file, cb) => {
    const allowedFormats = ['.jpg', '.jpeg', '.png', '.gif'];
    const fileExtension = path.extname(file.originalname);
    if (allowedFormats.includes(fileExtension)) {
        cb(null, true); // Aceptar el archivo si su formato está permitido
    } else {
        cb(null, false); // Rechazar el archivo si su formato no está permitido
    }
};

// Crear una instancia de multer para la carga de archivos de perfil
const profileUpload = multer({ 
    storage: profileStorage,
    fileFilter: profileFileFilter // Aplicar la validación de formato de archivo
});




// Configurar almacenamiento para la portada
const portadaStorage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, 'public/uploads/title_pics_recipe/');
    },
    filename: function (req, file, cb) {
        const userId = authController.getUser();
        cb(null, 'image_title_recipe_' + userId.id + '_' + Math.round(Math.random() * 1E9) + path.extname(file.originalname));
    }
});

// Configurar almacenamiento para las imágenes de los pasos
const pasosStorage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, 'public/uploads/step_pics_recipe/');
    },
    filename: function (req, file, cb) {
        const userId = authController.getUser();
        cb(null, 'image_step_recipe_' + userId.id + '_' + Math.round(Math.random() * 1E9) + path.extname(file.originalname));
    }
});

// Validación de formato de archivo
const fileFilter = (req, file, cb) => {
    const allowedFormats = ['.jpg', '.jpeg', '.png', '.gif'];
    const fileExtension = path.extname(file.originalname);
    if (allowedFormats.includes(fileExtension)) {
        cb(null, true);
    } else {
        cb(null, false);
    }
};

// Crear instancia de multer para la portada y las imágenes de los pasos
const upload = multer({
    storage: multer.diskStorage({
        destination: function (req, file, cb) {
            if (file.fieldname === 'portada') {
                cb(null, 'public/uploads/title_pics_recipe/');
            } else if (file.fieldname === 'imagenes') {
                cb(null, 'public/uploads/steps_pics_recipe/');
            }
        },
        filename: function (req, file, cb) {
            const userId = authController.getUser();
            const uniqueSuffix = userId.id + '_' + Math.round(Math.random() * 1E9) + path.extname(file.originalname);
            if (file.fieldname === 'portada') {
                cb(null, 'image_title_recipe_' + uniqueSuffix);
            } else if (file.fieldname === 'imagenes') {
                cb(null, 'image_step_recipe_' + uniqueSuffix);
            }
        }
    }),
    fileFilter: fileFilter
});

// Configurar la ruta para subir la receta
router.post('/add_recipe', upload.fields([{ name: 'portada', maxCount: 1 }, { name: 'imagenes', maxCount: 5 }]), authController.addRecipe);

// Rutas para la carga de imágenes de perfil y recetas
router.post('/update-profile-pic', profileUpload.single('profile-pic'), authController.updateProfilePic);




module.exports = router;