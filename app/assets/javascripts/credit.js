function credit_form(){
    $('.settings-email-form').bind("ajax:success",email_form_update)
        .bind("ajax:error", settings_reload);
}

function credit_form(evt,data){

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