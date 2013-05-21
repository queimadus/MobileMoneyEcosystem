$(document).ready(function() {
    if($("#client-home-stats").length>0){
        google.load("visualization", "1", {packages:["corechart"], callback:client_stats})

        //google.load("visualization", "1", {packages:["corechart"]});
       // google.setOnLoadCallback(client_stats);

    }
    if($("#merchant-home-stats").length>0){

    }
});

function client_stats(){
    var loader = $("#client-home-stats-pie>.stats-loader").addClass("loading");
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
        loader.removeClass("loading");
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
        channelChartWrapper.draw();
    });


    /*
    $.ajax({
        type: "GET",
        url: "statistics",
        dataType: 'json',
        data: { name: "John", location: "Boston" }
    }).done(client_stats_done);*/
};

function client_stats_done(reply){



        var data = google.visualization.DataTable(reply);
    /*arrayToDataTable([
            ['Task', 'Hours per Day'],
            ['Work',     11],
            ['Eat',      2],
            ['Commute',  2],
            ['Watch TV', 2],
            ['Sleep',    7]
        ]);*/

        var options = {
            title: 'My Daily Activities',
            slices: {0: {color: 'rgb(10,100,10)'}, 1:{color: '#00FF08'}, 2:{color: 'blue'}, 3: {color: 'red'}, 4:{color: 'grey'}},
            fontName: "roboto",
            width: 350,
            height: 350
        };

        var chart = new google.visualization.PieChart($('.client-home-stats .pie').get(0));
        chart.draw(data, options);

}
