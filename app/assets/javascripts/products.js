$(document).ready(function(){
    bind_error_tooltips();
    bind_all_categ_search();
    bind_modal_dismissal();
    bind_pagination();
    bind_edit_container();
});


//helpers
function bind_pagination(){
    $('#products-container-inner .pagination a, form.new_product, form#product-search-form').bind("ajax:success",update_products)
        .bind("ajax:beforeSend ",start_product_loading)
        .bind("ajax:error", product_error);
    $('.product-image-img').centerImage();
}

function bind_edit_container(){
    $(".product-container .edit-button,#newproduct").unbind().bind("ajax:success",edit_product)
        .bind("ajax:beforeSend ",start_edit_loading)
        .bind("ajax:error ",edit_error);

}

function bind_form(){
    $("form.edit_product").bind("ajax:success",product_submit)
        .bind("ajax:beforeSend, ajax:remotipartSubmit",product_submit_loading)
        .bind("ajax:error ",product_submit_error);
    bind_error_tooltips();
    $('.product-image-img').centerImage();
    bind_input();
}

function bind_new_form(){
    $('form.new_product').bind("ajax:success",new_product)
        .bind("ajax:beforeSend ",new_product_loading)
        .bind("ajax:error", new_product_error);
    bind_input();
}


function bind_modal_dismissal(){
    $('*[data-dismiss="modal"]').click(function(){
        $('form.new_product')[0].reset();
        $('.new_product.field_with_errors>*').unwrap();

    });
}

function new_product(evt,data){

    $('#notice').html(data.notice);
    $(".alert-notice").alert();
    window.setTimeout(function() { $(".alert-notice").alert('close'); }, 2000);

    if(data.success == true){
        update_products_data(data.html);
        bind_pagination();
        bind_edit_container();
        product_loading(false);
        $("#myModal").modal('hide');
        $('form.new_product')[0].reset();
        bind_all_categ_search();
        bind_input();
        close_info_panel(false);

    }  else {
        $('form.new_product').replaceWith(data.html);
        bind_new_form();
        bind_input();
    }
    product_loading(false);
}

function new_product_loading(){
    product_loading(false);
}

function new_product_error(){
    product_loading(false);
}

//product listing


function reset_product_search(){
    $(this).siblings("input").val("").submit();
}

$(".search-reset").click(reset_product_search) ;

function bind_all_categ_search(){
    $(".categ-search").click(bind_categ_search);
}

function bind_categ_search(){
    var selec = $(".search-bar input");
    var oldvalue =  selec.val();
    var newvalue =  $(this).parent().text();
    if(oldvalue==newvalue)
        return false; //selec.submit();
    else{
        if(oldvalue!="") oldvalue += " ";
        selec.val(oldvalue+ newvalue ).focus();
        selec.submit();
    }

}

function start_product_loading(){
    product_loading(true);

    //close_info_panel(false);

    //edit_loading(true);
}

function product_error(a,b,c){
    product_loading(false);
}

function update_products_data(html){
    $('#products-container-inner').html(html);
}

function update_products(evt,data){

    close_info_panel(false);

    if(data.notice){
        $('#notice').html(data.notice);
        $(".alert-notice").alert();
        window.setTimeout(function() { $(".alert-notice").alert('close'); }, 2000);
    }

    if(data.success == true){
        update_products_data(data.html);
        bind_pagination();
        bind_edit_container();
        bind_all_categ_search();
    }
    product_loading(false);
    return false;
}

function product_loading(t){
   if(t){
       $(".list-loading").addClass("show")
   }   else  {
       $(".list-loading").removeClass("show");
   }
}

//product editing



function start_edit_loading(){
    var a = $('.product-info-panel');

    if(a.hasClass("show")){
        close_info_panel(false);
    }else{
       $('#product-info-inner').html('');
    }

    edit_loading(true);
}

function edit_loading(t){
    if(t){
        $(".edit-loading").addClass("show")
    }   else  {
        $(".edit-loading").removeClass("show");
    }
}

function edit_error(){
    edit_loading(false);
    close_info_panel(false);
}

function edit_product(evt,data){
    if(data.success == true){


        var timer = setInterval(function(){
            if($('.product-info-panel.show,.product-info-panel.unshow').length==0)
            {
                $('#product-info-inner').html(data.html);
                $('.product-info-panel').addClass("show");
                var id = $(evt.target).attr("id");
                if(id=="newproduct"){
                    bind_new_form();
                } else if($(evt.target).hasClass("edit-button")){
                    bind_form();
                }
                bind_input();
                $('.edit_product #product-cancel,.new_product #product-cancel').click(close_info_panel);

                $('#delete-product').bind("ajax:success",update_products)
                                    .bind("ajax:beforeSend ",start_product_loading)
                                    .bind("ajax:error", product_error);

                edit_loading(false);
                clearInterval(timer);
            }
        },50);
    }
}

// product form submitting

function product_submit(evt,data){
    $('#notice').html(data.notice);
    $(".alert-notice").alert();
    window.setTimeout(function() { $(".alert-notice").alert('close'); }, 2000);

    if(data.success == true){
        $('.product-container#'+data.id).replaceWith(data.updated);
        $('#product-info-inner').html(data.html);
        bind_form();
        $('.edit_product #product-cancel').click(close_info_panel);
        bind_edit_container();
        glow_success(data.id,",.product-info-panel");
        $('.product-container#'+data.id+" .categ-search").click(bind_categ_search);
        close_info_panel(false);
    }  else {
        $('#product-info-inner').html(data.html);
        bind_form();
        $('.edit_product #product-cancel').click(close_info_panel);
        glow_error(data.id,",.product-info-panel");
    }
    edit_loading(false);

}

function product_submit_loading(){
    $('.product-info-panel').addClass("show");
    edit_loading(true);
}

function product_submit_error(){
     window.location = "/products";
}

function glow_success(id,form){
    glow(id+form,'#226699');
}

function glow_error(id,form){
    glow(id+form,'#ff0000');
}

function glow(id, color){
    $('.product-container#'+id).stop().animate({

        boxShadow: "0px 0px 15px "+color,
        mozBoxShadow: "0px 0px 15px "+color
    }, 600, function(){
        $('.product-container#'+id).stop().animate({

            boxShadow: "0px 0px 5px 1px rgba(0, 0, 0, 0.1)",
            mozBoxShadow: "0px 0px 5px 1px rgba(0, 0, 0, 0.1)"
        }, 350);
    });
}

function close_info_panel(button){
    button = button || true;
    if($('.product-info-panel.show').length>0){
        $('.product-info-panel').addClass("unshow").removeClass("show");
        setTimeout(function() {
            $('.product-info-panel').removeClass("unshow");
            $('#product-info-inner').html('');
        }, 255);
    }
    if (button)
        return false;
}

function bind_error_tooltips(){
    $('.error-tooltip').click(function (){
       $(this).fadeOut();
    });
}

$('.product-image-img').centerImage();


