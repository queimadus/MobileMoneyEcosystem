$(".history-date-selector-container .down-arrow").click(function(){
   $(this).siblings("input").focus();
});

$('.history-date-selector-container span span').click(function(){
    if($(this).siblings("input").length==0){

        var parent = $(this).parent();
        var id = parent.attr("id");
        var elem = $('<input type="text" />');

        if(id=="from"){
            elem.attr("name","from");
            elem.datepicker({ dateFormat: "yy-mm-dd", minDate: "-1y", maxDate: "-1" }).datepicker("setDate", "-1m");
        } else if(id=="to"){
            elem.attr("name","to");
            elem.datepicker({ dateFormat: "yy-mm-dd", minDate: "-1y", maxDate: "+0" }).datepicker("setDate", "0");

        }
       parent.children('.mock-date').remove();//.parent().append(elem);
       elem.fadeIn(300);
       parent.prepend(elem);

       elem.focus();
    }
});

bind_history_pagination();

function bind_history_pagination(){
    $('.client-history-container .pagination a, form#history-search-form').bind("ajax:success",update_history)
        .bind("ajax:beforeSend ",start_history_loading)
        .bind("ajax:error", history_error);
    //$('.product-image-img').centerImage();
}

function history_loading(t){
    if(t){
        $(".list-loading").addClass("show")
    }   else  {
        $(".list-loading").removeClass("show");
    }
}

function start_history_loading(){
    history_loading(true);
}


function history_error(){
    window.location("/history");
}

function update_history(evt,data){

    if(data.success == true){
        $(".client-history-container-inner").replaceWith(data.html);
        bind_history_pagination();
        bind_all_categ_search();
    }
    history_loading(false);
    return false;
}
