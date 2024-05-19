const hamburgerMenu = (panelBtn, panel, menuLink) => {
    const d = document;
    d.addEventListener("click", e => {
        if(e.target.matches(panelBtn) || e.target.matches(`${panelBtn} *`)){
            d.querySelector(panel).classList.toggle("is-active");
            d.querySelector(panelBtn).classList.toggle("is-active");
        }
        if(e.target.matches(menuLink)){
            d.querySelector(panel).classList.remove("is-active");
            d.querySelector(panelBtn).classList.remove("is-active");
        }
    });
}

const d = document;

d.addEventListener("DOMContentLoaded", e => {
    hamburgerMenu(".panel-btn", ".panel", ".menu a");

    const $likeRecipes = document.querySelectorAll('.like-recipe');

    $likeRecipes.forEach(($likeRecipe) => {
        $likeRecipe.addEventListener("click", (e) => {
            e.preventDefault(); // Prevenir la acción por defecto si es necesario
            const $likeIcon = $likeRecipe.querySelector('.like');
            const currentFill = $likeIcon.getAttribute('fill');
            
            // Cambiar el color dependiendo del estado actual
            const newFill = currentFill === '#ffffff' ? '#ff0000' : '#ffffff'; // Rojo si es blanco, blanco si es rojo

            $likeIcon.setAttribute('fill', newFill);
        });
    });
});


