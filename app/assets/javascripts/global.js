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

$(".menu-item").mouseenter(handlerIn).mouseleave(handlerOut);
var menu_bar = $("#menu-bar");
var act = $(".menu-item.active");
handlerOut();
menu_bar.show();
function handlerIn(){
   menu_bar.css("width",$(this).outerWidth()).css("left",$(this).position().left);
}

function handlerOut(){
    menu_bar.delay(1300).css("width",act.outerWidth()).css("left",act.position().left);
}