if($(".credit-page").length>0)
    bind_credit_form();

function bind_credit_form(){
    $('#credit-form').bind("ajax:success",credit_form)
        .bind('ajax:beforeSend',start_credit_loading)
        .bind("ajax:error", credit_error);
}

function start_credit_loading(){
    credit_loading(true);
}

function credit_error(){
    window.location("/credits");
}

function credit_loading(t){
    if(t){

        $("#credit-form").attr("disabled", "disabled");
    }   else {
        $("#credit-form").removeAttr("disabled");
    }
}

function credit_form(evt,data){

    credit_loading(false);

    if(data.success == true){
        $(".credit-form-container").html(data.html);
        bind_credit_form();
    }
    else
    {
        $(".credit-form-container").html(data.html);
        bind_credit_form();
    }
}