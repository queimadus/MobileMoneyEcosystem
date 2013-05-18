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

