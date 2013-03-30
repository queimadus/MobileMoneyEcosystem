$(document).ready(function() {
    //$('#register-link').click(fade_main_to_register_selection);
});

function fade_main_to_register_selection(){

    $('#main #home-content').fadeOut(function(){
        $('#main #register-selection').fadeIn();
    });
    return false;
}