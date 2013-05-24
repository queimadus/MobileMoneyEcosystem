$('.main-avatar-container').click(function(){
    var btn = $(".profile-dropdown-container");
    if(btn.hasClass("open"))
        $(".profile-dropdown-container").hide();
    else
        $(".profile-dropdown-container").show();

    $(".profile-dropdown-container").toggleClass("open");
    return false;
});

$(document).mouseup(function()
{
    $(".profile-dropdown-container").hide();
});


if($(".menu-item.active").length>0){

    var menu_bar = $("#menu-bar");
    var act = $(".menu-item.active");
    menu_bar.css("width",act.outerWidth()).css("left",act.position().left);

    $(".menu-item").mouseenter(function(){menu_bar.css("width",$(this).outerWidth()).css("left",$(this).position().left);}).mouseleave(function(){menu_bar.css("width",act.outerWidth()).css("left",act.position().left);});
    menu_bar.show();

}