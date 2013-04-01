$('.pagination a').bind("ajax:success",update_products);
$('.pagination a').bind("ajax:beforeSend ",a);


function a(){
    product_loading(true);
}

function update_products(evt,data){
    if(data.success == true){
        $('#products-container-inner').html(data.html);
        $('.pagination a').bind("ajax:success",update_products);
        $('.pagination a').bind("ajax:beforeSend ",a);
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
/*
$(document).ajaxStart(function() {
    //alert("lol")         ;
});
*/
