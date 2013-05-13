// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

generate_qrcodes();
bind_market_pagination();
$('.market-product-image').centerImage();

function generate_qrcodes(){
    $.each($(".product-qrcode"), function(key,value){
        $(value).qrcode({text: value.dataset.qrcode,
                         height: 64,
                         width: 64});
    });
}

function bind_market_pagination(){
    $('#market-products-container .pagination a, #product-search-form').bind("ajax:success",update_market)
        .bind("ajax:beforeSend ",start_market_loading)
        .bind("ajax:error", market_error);
}

function update_market(evt, data){
    if(data.notice){
        $('#notice').html(data.notice);
        $(".alert-notice").alert();
        window.setTimeout(function() { $(".alert-notice").alert('close'); }, 2000);
    }

    if(data.success == true){
        update_market_data(data.html);
        bind_market_pagination();
        generate_qrcodes();
        market_loading(evt,false);
        $('.market-product-image').centerImage();
    }
    market_loading(evt,false);
}

function start_market_loading(evt){
    market_loading(evt,true);
}

function market_error(){
    //location.reload();
}

function market_loading(evt,t){
    if(t){
        $(".list-loading").addClass("show")
    }   else  {
        $(".list-loading").removeClass("show");
    }
}

function update_market_data(html){
    $('#market-products-container-inner').html(html);
}