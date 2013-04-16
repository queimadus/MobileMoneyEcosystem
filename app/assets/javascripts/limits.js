$(function() {
    $( ".datepicker" ).datepicker({ dateFormat: "yy-mm-dd", minDate: "-1y", maxDate: " " });
});

bind_add();
bind_replace_for_edit();

function bind_add(){
    $('#newlimit').bind("ajax:success",add_to_limit_list)
        .bind("ajax:beforeSend ",add_to_limit_list_loading)
        .bind("ajax:error", add_to_limit_list_error);
}

function bind_replace_for_edit(){
    $('.limit-container a.edit-button').bind("ajax:success",replace_show_for_edit)
        .bind("ajax:beforeSend ",replace_show_for_edit_loading)
        .bind("ajax:error", replace_show_for_edit_error);
}

function bind_replace_for_show(id){
    var sel = $(".limit-container#"+id+" form");
    sel.bind("ajax:success",replace_edit_for_show)
        .bind("ajax:beforeSend ",replace_edit_for_show_loading)
        .bind("ajax:error", replace_edit_for_show_error);
}

function bind_edit_limit_cancel(id){
    var sel = $(".limit-container#"+id+" .limit-edit-cancel");
    sel.bind("ajax:success",replace_edit_for_show)
        .bind("ajax:beforeSend ",replace_edit_for_show_loading)
        .bind("ajax:error", replace_edit_for_show_error);
}

function limit_loading(t){
    if(t){
        $(".list-loading").addClass("show")
    }   else  {
        $(".list-loading").removeClass("show");
    }
}

function bind_new_limit_cancel(){
    $(".limit-submit-btns .limit-new-cancel").click(function(){
       var s = $(this).parent().parent().parent().parent();
       s.removeClass("new-item").addClass("remove-item");
        setTimeout(function() {
            s.remove();
        }, 100);

    });
}

function add_to_limit_list(evt,data){
    if(data.success == true){
        $("#limits-container-inner").prepend(data.html);
        $( "#datepicker" ).datepicker({ dateFormat: "yy-mm-dd", minDate: "-1y", maxDate: " " });
        bind_new_limit_cancel();
    }
    limit_loading(false);
}

function add_to_limit_list_loading(){
    limit_loading(true);
}

function add_to_limit_list_error(){
    limit_loading(false);
}

function replace_show_for_edit(evt,data){
    if(data.success == true){

        var sel = $(".limit-container#"+data.id);
        sel.addClass("remove-item");
        setTimeout(function() {
            sel.replaceWith(data.html);
            sel.removeClass("remove-item").addClass("replace-item");

            $( ".datepicker" ).datepicker({ dateFormat: "yy-mm-dd", minDate: "-1y", maxDate: " " });

            bind_replace_for_show(data.id);
            bind_edit_limit_cancel(data.id);

        }, 100);

    }
    limit_loading(false);
}

function replace_show_for_edit_loading(){
    limit_loading(true);
}

function replace_show_for_edit_error(){

}

function replace_edit_for_show(evt,data){
    if(data.success == true){

        var sel = $(".limit-container#"+data.id);

        sel.removeClass("replace-item").addClass("remove-item");
        setTimeout(function() {
            sel.replaceWith(data.html);
            sel.removeClass("remove-item").addClass("replace-item");

            $('.limit-container#'+data.id+' a.edit-button').bind("ajax:success",replace_show_for_edit)
                .bind("ajax:beforeSend ",replace_show_for_edit_loading)
                .bind("ajax:error", replace_show_for_edit_error);
        }, 100);

    }
    limit_loading(false);
}

function replace_edit_for_show_loading(){
    limit_loading(true);
}

function replace_edit_for_show_error(){

}