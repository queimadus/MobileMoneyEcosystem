$(document).ready(function() {
    if($(".client-statistics").length>0){
        google.load("visualization", "1", {packages:["corechart"], callback:client_big_stats_default});
    }
    if($(".merchant-statistics").length>0){
        google.load("visualization", "1", {packages:["corechart"], callback:merchant_big_stats_default});
    }
});

function client_big_stats_default(){
    client_big_stats("");
}

function merchant_big_stats_default(){
    merchant_big_stats("");
}

$("#client-stat-form").submit(function(){
   client_big_stats($(this).serialize());
   return false;
});

$("#merchant-stat-form").submit(function(){
    merchant_big_stats($(this).serialize());
    return false;
});

function client_big_stats(action){
    var loader = $("#client-stats-pie+.stats-loader,#client-stats-bar+.stats-loader").addClass("loading");
    $.getJSON("statistics/categories?"+action, function(data) {
        var channelChartWrapper = new window.google.visualization.ChartWrapper({
            chartType: "PieChart",
            dataTable: data,
            options: {
                title: "Spent by category from "+data.p.from+" to "+data.p.to,
                colors: data.p.colors,
                width: 928,
                height: 420,
                fontName: "roboto",
                fontSize: 14,
                chartArea:{left:20,top:60,width:"100%",height:"70%"},
                titleTextStyle: {color: "rgb(66, 139, 202)", fontSize: 17 }
            },
            containerId: "client-stats-pie"
        });
        $("#client-stats-pie+.stats-loader").removeClass("loading");
        channelChartWrapper.draw();
    });

    $.getJSON("statistics/credit?"+action, function(data) {
        var channelChartWrapper = new window.google.visualization.ChartWrapper({
            chartType: "LineChart",
            dataTable: data,
            options: {
                title: "Credit spent from "+data.p.from+" to "+data.p.to,
                width: 928,
                height: 420,
                fontName: "roboto",
                fontSize: 14,
                chartArea:{left:50,top:70,width:"83%",height:"67%"},
                titleTextStyle: {color: "rgb(66, 139, 202)", fontSize: 17 }
            },
            containerId: "client-stats-bar"
        });
        $("#client-stats-bar+.stats-loader").removeClass("loading");
        channelChartWrapper.draw();
    });
};

function merchant_big_stats(action){
    var loader = $("#merchant-stats-pie+.stats-loader,#merchant-stats-bar+.stats-loader").addClass("loading");
    $.getJSON("statistics/categories?"+action, function(data) {
        var channelChartWrapper = new window.google.visualization.ChartWrapper({
            chartType: "PieChart",
            dataTable: data,
            options: {
                title: "Credit by category from 0"+data.p.from+" to "+data.p.to,
                colors: data.p.colors,
                width: 928,
                height: 420,
                fontName: "roboto",
                fontSize: 14,
                chartArea:{left:20,top:60,width:"100%",height:"70%"},
                titleTextStyle: {color: "rgb(66, 139, 202)", fontSize: 17 }
            },
            containerId: "merchant-stats-pie"
        });
        $("#merchant-stats-pie+.stats-loader").removeClass("loading");
        channelChartWrapper.draw();
    });

    $.getJSON("statistics/credit?"+action, function(data) {
        var channelChartWrapper = new window.google.visualization.ChartWrapper({
            chartType: "LineChart",
            dataTable: data,
            options: {
                title: "Credit from "+data.p.from+" to "+data.p.to,
                width: 928,
                height: 420,
                fontName: "roboto",
                fontSize: 14,
                chartArea:{left:50,top:70,width:"83%",height:"67%"},
                titleTextStyle: {color: "rgb(66, 139, 202)", fontSize: 17 }
            },
            containerId: "merchant-stats-bar"
        });
        $("#merchant-stats-bar+.stats-loader").removeClass("loading");
        channelChartWrapper.draw();
    });
};