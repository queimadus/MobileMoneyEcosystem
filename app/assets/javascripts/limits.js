$(function() {
    $( ".datepicker" ).datepicker({ dateFormat: "yy-mm-dd", minDate: "-1y", maxDate: " " });
});

bind_add();
bind_replace_for_edit();
bind_limit_pagination();

function notice(notice){
    if(notice!=null){
        $('#notice').html(notice);
        $(".alert-notice, .alert-error").alert();
        window.setTimeout(function() { $(".alert-notice, .alert-error").alert('close'); }, 2000);
    }
}

$("#newlimit").click(function(){
   if($(".limit-container.new-item, .limit-container.error-item").length !== 0){
       return false;
   }
});

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

function bind_edit_limit_delete(id){
    var sel = $(".limit-container#"+id+" .limit-edit-delete");
    sel.bind("ajax:success",remove_limit)
        .bind("ajax:beforeSend ",remove_limit_loading)
        .bind("ajax:error", remove_limit_error);
}

function remove_limit(evt, data){
    if(data.success == true){

        var sel = $(".limit-container#"+data.id);
        sel.removeClass("replace-item").addClass("delete-item");
        setTimeout(function() {
           sel.remove();
        }, 300);

    }
    limit_loading(evt,false);
}

function remove_limit_loading(evt){
    limit_loading(evt,true);
}

function remove_limit_error(){

}

function limit_loading(evt,t){
    if(t){
        if($(evt.currentTarget).parents(".pagination").length>0)
            $(".list-loading").addClass("show");

        var a = $(evt.currentTarget).parents(".limit-container");
        a.attr("style","opacity:0.2;");
        //var b = $(evt.currentTarget);
        //if(b==$("#limits-container-inner .pagination a"))
        //    $(".list-loading").addClass("show")
    }   else  {
        $(".list-loading").removeClass("show");
        //a.show();
    }
}

function bind_new_limit_cancel(){
    $(".limit-submit-btns .limit-new-cancel").click(function(){
       var s = $(this).parent().parent().parent().parent();
       s.removeClass("new-item").addClass("delete-item");
        setTimeout(function() {
            s.remove();
        }, 300);

    });
}

function add_to_limit_list(evt,data){
    if(data.success == true){
        notice(data.notice);
        var a = $(data.html).addClass("new-item");
        $("#limits-container-inner").prepend(a);
        $( ".datepicker" ).datepicker({ dateFormat: "yy-mm-dd", minDate: "-1y", maxDate: " " });

        var sel = $(".limit-container.new-item form");
        sel.bind("ajax:success",replace_edit_for_show)
            .bind("ajax:beforeSend ",replace_edit_for_show_loading)
            .bind("ajax:error", replace_edit_for_show_error);
        bind_new_limit_cancel();
    }
    limit_loading(evt,false);
}

function add_to_limit_list_loading(evt){
    limit_loading(evt,true);
}

function add_to_limit_list_error(){
    limit_loading(evt,false);
}

function replace_show_for_edit(evt,data){
    if(data.success == true){
        notice(data.notice);
        var sel = $(".limit-container#"+data.id);
        sel.addClass("remove-item");
        setTimeout(function() {
            sel.replaceWith($(data.html).addClass("replace-item"));
            sel.removeClass("remove-item").addClass("replace-item");

            $( ".datepicker" ).datepicker({ dateFormat: "yy-mm-dd", minDate: "-1y", maxDate: " " });

            bind_replace_for_show(data.id);
            bind_edit_limit_cancel(data.id);
            bind_edit_limit_delete(data.id);
        }, 100);

    }
    limit_loading(evt,false);
}

function replace_show_for_edit_loading(evt){
    limit_loading(evt,true);
}

function replace_show_for_edit_error(){

}

function replace_edit_for_show(evt,data){
    if(data.success == true && data.type!="delete"){
        notice(data.notice);
        if(data.type=="new"){
            var sel = $(this).parent();
            sel.attr("id",data.id);
        }

        var sel = $(".limit-container#"+data.id);

        sel.removeClass("replace-item new-item").addClass("remove-item");
        setTimeout(function() {
            sel.replaceWith(data.html);//addClass("replace-item");
            $(".limit-container#"+data.id).addClass("replace-item");
            //sel.

            $('.limit-container#'+data.id+' a.edit-button').bind("ajax:success",replace_show_for_edit)
                .bind("ajax:beforeSend ",replace_show_for_edit_loading)
                .bind("ajax:error", replace_show_for_edit_error);

        }, 100);

    }
    else if(data.success==false){
        notice(data.notice);
        if(data.type=="new"){
            var sel = $(".limit-container.new-item, .limit-container.error-item ");
            var a = $(data.html).addClass("error-item");
            sel.replaceWith(a);

            $( ".datepicker" ).datepicker({ dateFormat: "yy-mm-dd", minDate: "-1y", maxDate: " " });

            sel = $(".limit-container.error-item form");
            sel.bind("ajax:success",replace_edit_for_show)
                .bind("ajax:beforeSend ",replace_edit_for_show_loading)
                .bind("ajax:error", replace_edit_for_show_error);
            bind_new_limit_cancel();
        }
        if(data.type=="edit"){

            var sel = $(".limit-container#"+data.id);

            sel.replaceWith(data.html);

            bind_replace_for_show(data.id);
            bind_edit_limit_cancel(data.id);
        }
    }
    limit_loading(false);
}

function replace_edit_for_show_loading(evt){
    limit_loading(evt,true);
}

function replace_edit_for_show_error(){

}

function bind_limit_pagination(){
    $('#limits-container-inner .pagination a, form#limit-search-form').bind("ajax:success",page_limits)
        .bind("ajax:beforeSend ",page_limits_loading)
        .bind("ajax:error", page_limits_error);
}

function page_limits(evt,data){
    if(data.success == true){
        notice(data.notice);

        $("#limits-container-inner").html(data.html);
        bind_limit_pagination();
        bind_replace_for_edit();
    }
    limit_loading(evt,false);
}

function page_limits_loading(evt){
    limit_loading(evt,true);

}

function page_limits_error(){

}