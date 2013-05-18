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
       parent.prepend(elem)

       elem.focus();
    }
});