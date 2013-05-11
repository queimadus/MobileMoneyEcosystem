$("input[file]").ready(bind_input);
$(".settings-avatar-image").centerImage();

bind_password_form();
bind_avatar_form();
bind_bank_account_form();

function bind_password_form(){
    $('.settings-password-form').bind("ajax:success",password_form_update)
                                .bind("ajax:error", settings_reload);
}

function password_form_update(evt,data){

    if(data.success == true){
        $(".settings-password-form").replaceWith(data.html);
        $(".settings-password-form .controls").append('<span class="settings-success">'+data.notice+'</span>');
        $(".settings-password-form .controls .settings-success").delay(3000).fadeOut(1000);
        bind_password_form();
    }
    else
    {
        $(".settings-password-form").replaceWith(data.html);
        bind_password_form();
    }
}

function bind_avatar_form(){
    $('.settings-avatar-form').bind("ajax:success",avatar_form_update)
                              .bind("ajax:error", settings_reload);
}

function avatar_form_update(evt,data){

    if(data.success == true){
        $(".settings-avatar-form").replaceWith(data.html);
        $(".settings-avatar-form .controls").append('<span class="settings-success">'+data.notice+'</span>');
        $(".settings-avatar-form .controls .settings-success").delay(3000).fadeOut(1000);
        bind_avatar_form();
        $("input[file]").ready(bind_input);
    }
    else
    {
        $(".settings-avatar-form").replaceWith(data.html);
        $(".settings-avatar-form .controls").append('<span class="settings-failure">'+data.notice+'</span>');
        $(".settings-avatar-form .controls .settings-success").delay(3000).fadeOut(1000);
        bind_avatar_form();
        $("input[file]").ready(bind_input);
    }
}



function bind_bank_account_form(){
    $('.bank-account-password-form').bind("ajax:success",bank_account_form_update)
        .bind("ajax:error", settings_reload);
}

function bank_account_form_update(evt,data){

    if(data.success == true){
        $(".bank-account-password-form").replaceWith(data.html);
        $(".bank-account-password-form .controls").append('<span class="settings-success">'+data.notice+'</span>');
        $(".bank-account-password-form .controls .settings-success").delay(3000).fadeOut(1000);
        bind_bank_account_form();
    }
    else
    {
        $(".bank-account-password-form").replaceWith(data.html);
        //$(".bank-account-password-form .controls").append('<span class="settings-failure">'+data.notice+'</span>');
        //$(".bank-account-password-form .controls .settings-success").delay(3000).fadeOut(1000);
        bind_bank_account_form();
    }
}

function settings_reload(){
    window.location("/settings");
}