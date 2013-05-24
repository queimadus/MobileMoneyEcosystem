$(document).ready(function() {
    if($("#client-home-stats").length>0){
        google.load("visualization", "1", {packages:["corechart"], callback:client_stats});
    }
    if($("#merchant-home-stats").length>0){
        google.load("visualization", "1", {packages:["corechart"], callback:merchant_stats});
    }
});

function client_stats(){
    var loader = $("#client-home-stats-pie+.stats-loader,#client-home-stats-bar+.stats-loader").addClass("loading");
    $.getJSON("statistics/categories", function(data) {
        var channelChartWrapper = new window.google.visualization.ChartWrapper({
            chartType: "PieChart",
            dataTable: data,
            options: {
                title: "Spent by category",
                colors: data.p.colors,
                width: 460,
                height: 300,
                fontName: "roboto",
                fontSize: 14,
                chartArea:{left:20,top:60,width:"100%",height:"70%"},
                titleTextStyle: {color: "rgb(66, 139, 202)", fontSize: 17 }
            },
            containerId: "client-home-stats-pie"
        });
        $("#client-home-stats-pie+.stats-loader").removeClass("loading");
        channelChartWrapper.draw();
    });

    $.getJSON("statistics/credit", function(data) {
        var channelChartWrapper = new window.google.visualization.ChartWrapper({
            chartType: "LineChart",
            dataTable: data,
            options: {
                title: "Credit spent",
                width: 460,
                height: 300,
                fontName: "roboto",
                fontSize: 14,
                chartArea:{left:50,top:70,width:"67%",height:"60%"},
                titleTextStyle: {color: "rgb(66, 139, 202)", fontSize: 17 }
            },
            containerId: "client-home-stats-bar"
        });
        $("#client-home-stats-bar+.stats-loader").removeClass("loading");
        channelChartWrapper.draw();
    });
};

function merchant_stats(){
    var loader = $("#merchant-home-stats-pie+.stats-loader,#merchant-home-stats-pie+.stats-loader").addClass("loading");
    $.getJSON("statistics/categories", function(data) {
        var channelChartWrapper = new window.google.visualization.ChartWrapper({
            chartType: "PieChart",
            dataTable: data,
            options: {
                title: "Credit by category",
                colors: data.p.colors,
                width: 460,
                height: 300,
                fontName: "roboto",
                fontSize: 14,
                chartArea:{left:20,top:60,width:"100%",height:"70%"},
                titleTextStyle: {color: "rgb(66, 139, 202)", fontSize: 17 }
            },
            containerId: "merchant-home-stats-pie"
        });
        $("#merchant-home-stats-pie+.stats-loader").removeClass("loading");
        channelChartWrapper.draw();
    });

    $.getJSON("statistics/credit", function(data) {
        var channelChartWrapper = new window.google.visualization.ChartWrapper({
            chartType: "LineChart",
            dataTable: data,
            options: {
                title: "Credit",
                width: 460,
                height: 300,
                fontName: "roboto",
                fontSize: 14,
                chartArea:{left:50,top:70,width:"67%",height:"60%"},
                titleTextStyle: {color: "rgb(66, 139, 202)", fontSize: 17 }
            },
            containerId: "merchant-home-stats-bar"
        });
        $("#merchant-home-stats-bar+.stats-loader").removeClass("loading");
        channelChartWrapper.draw();
    });
};