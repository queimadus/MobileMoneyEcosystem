//helpers
function bind_pagination(){
    $('.pagination a, form.new_product').bind("ajax:success",update_products)
        .bind("ajax:beforeSend ",start_product_loading)
        .bind("ajax:error", product_error);
    $('.product-image-img').centerImage();
}

function bind_edit_container(){
    $(".edit-button").bind("ajax:success",edit_product)
        .bind("ajax:beforeSend ",start_edit_loading)
        .bind("ajax:error ",edit_error);

}

function bind_form(){
    $("form.edit_product").bind("ajax:success",product_submit)
        .bind("ajax:beforeSend ",product_submit_loading)
        .bind("ajax:error ",product_submit_error);
    bind_error_tooltips();
    $('.product-image-img').centerImage();
    bind_input();
}

bind_error_tooltips();
bind_input();
bind_form();
//product listing

bind_pagination();


function start_product_loading(){
    product_loading(true);
}

function product_error(){
    product_loading(false);
}

function update_products_data(html){
    $('#products-container-inner').html(html);
}

function update_products(evt,data){
    if(data.success == true){
        update_products_data(data.html);
        bind_pagination();
        bind_edit_container();
        product_loading(false);
        $("#myModal").modal('hide');
        $('form.new_product')[0].reset();
    }
    product_loading(false);
}

function product_loading(t){
   if(t){
       $(".product-list-loading").addClass("show")
   }   else  {
       $(".product-list-loading").removeClass("show");
   }
}

//product editing

bind_edit_container();

function start_edit_loading(){
    $('#product-info-inner').html('');
    $('.product-info-panel').addClass("show");
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
    $('.product-info-panel').removeClass("show");
}

function edit_product(evt,data){
    if(data.success == true){
        $('#product-info-inner').html(data.html);
       bind_form();
        $('.edit_product #product-cancel').click(close_info_panel);
    }
    edit_loading(false);
}

// product form submitting

$("form.edit_product").bind("ajax:success",product_submit)
    .bind("ajax:beforeSend ",product_submit_loading)
    .bind("ajax:error ",product_submit_error);

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
        glow_success(data.id);
    }  else {
        $('#product-info-inner').html(data.html);
        bind_form();
        $('.edit_product #product-cancel').click(close_info_panel);
        glow_error(data.id);
    }
    edit_loading(false);

}

function product_submit_loading(){
    $('.product-info-panel').addClass("show");
    edit_loading(true);
}

function product_submit_error(){
    alert("error");
}

function glow_success(id){
    glow(id,'#226699');
}

function glow_error(id){
    glow(id,'#ff0000');
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

function close_info_panel(){

    $('.product-info-panel').removeClass("show");
    return false;
}

function bind_error_tooltips(){
    $('.error-tooltip').click(function (){
       $(this).fadeOut();
    });
}

$('.product-image-img').centerImage();


