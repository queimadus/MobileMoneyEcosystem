$("input[file]").ready(bind_input);
$(".settings-avatar-image").centerImage();

$(document).ready(function(){
    bind_password_form();
    bind_avatar_form();
    bind_bank_account_form();
    bind_email_form();
    bind_name_form();
    bind_extra_form();
});

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
        update_header_info();
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



function bind_email_form(){
    $('.settings-email-form').bind("ajax:success",email_form_update)
        .bind("ajax:error", settings_reload);
}

function email_form_update(evt,data){

    if(data.success == true){
        $(".settings-email-form").replaceWith(data.html);
        $(".settings-email-form .controls").append('<span class="settings-success">'+data.notice+'</span>');
        $(".settings-email-form .controls .settings-success").delay(3000).fadeOut(1000);
        bind_email_form();
    }
    else
    {
        $(".settings-email-form").replaceWith(data.html);
        //$(".bank-account-password-form .controls").append('<span class="settings-failure">'+data.notice+'</span>');
        //$(".bank-account-password-form .controls .settings-success").delay(3000).fadeOut(1000);
        bind_email_form();
    }
}


function bind_name_form(){
    $('.settings-name-form').bind("ajax:success",name_form_update)
        .bind("ajax:error", settings_reload);
}

function name_form_update(evt,data){

    if(data.success == true){
        $(".settings-name-form").replaceWith(data.html);
        $(".settings-name-form .controls").append('<span class="settings-success">'+data.notice+'</span>');
        $(".settings-name-form .controls .settings-success").delay(3000).fadeOut(1000);
        bind_name_form();
        update_header_info();
    }
    else
    {
        $(".settings-name-form").replaceWith(data.html);
        //$(".bank-account-password-form .controls").append('<span class="settings-failure">'+data.notice+'</span>');
        //$(".bank-account-password-form .controls .settings-success").delay(3000).fadeOut(1000);
        bind_name_form();
    }
}

function bind_extra_form(){
    $('.client-extra-info-form').bind("ajax:success",extra_form_update)
        .bind("ajax:error", settings_reload);
}

function extra_form_update(evt,data){

    if(data.success == true){
        $(".client-extra-info-form").replaceWith(data.html);
        $(".client-extra-info-form .controls").append('<span class="settings-success">'+data.notice+'</span>');
        $(".client-extra-info-form .controls .settings-success").delay(3000).fadeOut(1000);
        bind_extra_form();
    }
    else
    {
        $(".client-extra-info-form").replaceWith(data.html);
        //$(".bank-account-password-form .controls").append('<span class="settings-failure">'+data.notice+'</span>');
        //$(".bank-account-password-form .controls .settings-success").delay(3000).fadeOut(1000);
        bind_extra_form();
    }
}

function settings_reload(){
    window.location("/settings");
}

function update_header_info(){
    $.ajax({
        type: 'GET',
        url: 'header_info.json',
        async: true,
        datatype: 'JSON',
        success: function(data)
        {
            if (data)
            {
                $(".header-credit span").text(data.credit);
                $(".header-name span").text(data.name);
                $(".main-avatar-image").attr("src",data.image_url);
            }
        }
    });
}