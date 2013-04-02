//product listing

$('.pagination a').bind("ajax:success",update_products)
    .bind("ajax:beforeSend ",start_product_loading)
    .bind("ajax:error", product_error);


function start_product_loading(){
    product_loading(true);
}

function product_error(){
    product_loading(false);
}

function update_products(evt,data){
    if(data.success == true){
        $('#products-container-inner').html(data.html);
        $('.pagination a').bind("ajax:success",update_products)
            .bind("ajax:beforeSend ",start_product_loading)
            .bind("ajax:error", product_error);
        $(".edit-button").bind("ajax:success",edit_product)
            .bind("ajax:beforeSend ",start_edit_loading)
            .bind("ajax:error ",edit_error);
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

$(".edit-button").bind("ajax:success",edit_product)
    .bind("ajax:beforeSend ",start_edit_loading)
    .bind("ajax:error ",edit_error);

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
        $("form.edit_product").bind("ajax:success",product_submit)
            .bind("ajax:beforeSend ",product_submit_loading)
            .bind("ajax:error ",product_submit_error);
    }
    edit_loading(false);
}

// product form submitting

$("form.edit_product").bind("ajax:success",product_submit)
    .bind("ajax:beforeSend ",product_submit_loading)
    .bind("ajax:error ",product_submit_error);

function product_submit(evt,data){
    if(data.success == true){
        $('.product-container#'+data.id).replaceWith(data.updated);
        glow(data.id);
        $('#notice').html(data.notice);
        $(".alert-notice").alert();
        window.setTimeout(function() { $(".alert-notice").alert('close'); }, 2000);
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

function glow(id){
    $('.product-container#'+id).stop().animate({

        boxShadow: "0px 0px 10px #226699",
        mozBoxShadow: "0px 0px 10px #226699"
    }, 1000, function(){
        $('.product-container#'+id).stop().animate({

            boxShadow: "0px 0px 5px 1px rgba(0, 0, 0, 0.1)",
            mozBoxShadow: "0px 0px 5px 1px rgba(0, 0, 0, 0.1)"
        }, 600);
    });
}


