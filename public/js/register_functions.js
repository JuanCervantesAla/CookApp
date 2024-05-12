document.addEventListener('DOMContentLoaded', () =>{ //Lee el documento, desde el .ejs que se invoco

    const form = document.getElementById('registerForm');//Inicio de la instancia de .ejs hacia js
    const email = document.getElementById('email');
    const name = document.getElementById('name');
    const description = document.getElementById('description');
    const age = document.getElementById('age');
    const secretAnswer = document.getElementById('secretAnswer');
    const password = document.getElementById('password');


    //-------------------------------------------------------------------
    function validateEmail(){//Funcion para validar, los campos, las demas funciones son iguales en parametros
        const value = email.value.trim();//Obtenemos el valor ingresado en el campo
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if(value === ''){//Si es un campo vacio...
            Swal.fire({//Lanzaremos una alerta de que esta vacio
                title: 'Ingresa un correo electronico',
                icon: 'waning',
                confirmButtonText: 'OK'
              });
            return false;//Regresaremos falso
        } else if (!emailRegex.test(value)){
            Swal.fire({//Lanzaremos una alerta de que esta vacio
                title: 'Correo electronico incorrecto',
                icon: 'waning',
                confirmButtonText: 'OK'
              });
              return false;
        }
        return true;//Regresaremos verdadero para validar el submit
    }

    function validateName(){
        const value = name.value.trim();
        if(value === ''){
            Swal.fire({
                title: 'Nombre incorrecto',
                icon: 'waning',
                confirmButtonText: 'OK'
              });
            return false;
        }
        return true;
    }

    function validateDescription(){
        const value = description.value.trim();
        const valueLength = description.value;
        if(value === ''){
            Swal.fire({
                title: 'Agrega una descripcion!',
                icon: 'waning',
                confirmButtonText: 'OK'
              });
            return false;
        }else if(valueLength.length >= 120){
            Swal.fire({
                title: 'La descripcion no debe sobrepasar los 120 caracteres',
                icon: 'waning',
                confirmButtonText: 'OK'
              });
            return false;
        }
        return true;
    }

    function validateAge(){
        const value = age.value.trim();
        if(value === '' || (value < 1 || value >99)){
            Swal.fire({
                title: 'Ingresa tu edad correcta!',
                icon: 'waning',
                confirmButtonText: 'OK'
              });
            return false;
        }
        return true;
    }

    function validateSecretAnswer(){
        const value = secretAnswer.value.trim();
        if(value === ''){
            Swal.fire({
                title: 'Ingresa la respuesta secreta!',
                icon: 'waning',
                confirmButtonText: 'OK'
              });
            return false;
        }
        return true;
    }

    function validatePassword(){
        const value = password.value.trim();
        if(value === ''){
            Swal.fire({
                title: 'Ingresa tu contrasena!',
                icon: 'waning',
                confirmButtonText: 'OK'
              });
            return false;
        }
        return true;
    }

    function isChecked(){
        if(document.getElementById('politics').checked){
            return true;
        }
        return false;
    }

    //-------------------------------------------------------------------
    form.addEventListener('submit',(event) =>{//Escucha activa del form

        if(!validateEmail() //Valida si la el email esta vacio o lleno
                || !validateName()
                    || !validateDescription()
                        || !validateAge()
                            || !validateSecretAnswer()
                                || !validatePassword()){
            event.preventDefault();//Detiene el envio del formulario
            return;//Fin
        }

        if(!isChecked()){
            event.preventDefault()
            Swal.fire({
                title: 'Acepta los termino y condiciones!',
                icon: 'warning',
                confirmButtonText: 'OK'
              });
              return;
        }

        Swal.fire({//Si todo correcot --> Lanza alerta de que se envio el formulario
            title: 'Registro exitoso!',
            icon: 'success',
            confirmButtonText: 'OK'
          });
    });
});
