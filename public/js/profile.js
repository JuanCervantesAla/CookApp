// Modal descripcion
let modalDescription = document.getElementById("update-description-modal");
// Boton que abre el modal
let btnDescription = document.getElementById("description-modal");
// Elemento <span> que cierra el modal
let spanDescription = document.getElementById("close-description-modal");

btnDescription.onclick = function() {
  modalDescription.style.display = "block";
}

spanDescription.onclick = function() {
  modalDescription.style.display = "none";
}


// Modal foto de perfil
let modalPic = document.getElementById("update-profile-pic-modal");
// Boton que abre el modal
let btnPic = document.getElementById("profile-pic-modal");
// Elemento <span> que cierra el modal
let spanPic = document.getElementById("close-pic-modal");

btnPic.onclick = function() {
  modalPic.style.display = "block";
}

spanPic.onclick = function() {
  modalPic.style.display = "none";
}


// Validaciones del form
document.getElementById("btn-update-description").addEventListener("click", ()=>{
  let description = document.getElementById('description').value;
  if(description === ""){
    Swal.fire({
      title: 'Agrega una descripcion!',
      icon: 'warning',
      confirmButtonText: 'OK'
    });
  }else if(description.length >= 120){
    Swal.fire({
      title: 'Solo se aceptan 120 caracteres en la descripcion',
      icon: 'warning',
      confirmButtonText: 'OK'
    });
  }
});
