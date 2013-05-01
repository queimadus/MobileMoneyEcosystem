// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

generate_qrcodes();
$('.market-product-image').centerImage();

function generate_qrcodes(){
    $.each($(".product-qrcode"), function(key,value){
        $(value).qrcode({text: value.dataset.qrcode,
                         height: 64,
                         width: 64});
    });

}