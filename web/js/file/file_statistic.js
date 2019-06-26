var question_list=[];
var module="/FileManagement";
var existResultset="0";
var ContextPath=$("#ContextPath").val();
var initurl=ContextPath+module;

console.log("file_statistic js初始化执行完毕！");

/*================================================================================*/
var chart = null;
var Page = function(){
    var initAmCharts = function() {
        chart = AmCharts.makeChart("chartdiv", {
            "type": "serial",
            "theme": "light",
            "dataDateFormat": "YYYY-MM-DD",
            "autoMargins": false,
            "marginLeft": 30,
            "marginRight": 8,
            "marginTop": 10,
            "marginBottom": 26,

            "fontFamily": 'Open Sans',
            "color":    '#888',
            "valueAxes": [{
                "title": "数量",
                "baseValue": 0,
                "integersOnly": true,
                "minimum": 0,
                "precision": 0,
                "inside": true
            }],
            "categoryAxis": {
                "title": "上传时间"
            },
            "chartScrollbar": {
                "graph": "g1",
                "oppositeAxis": false,
                "offset": 30,
                "scrollbarHeight": 50,
                "backgroundAlpha": 0,
                "selectedBackgroundAlpha": 0.9,
                "selectedBackgroundColor": "#ffffff",
                "graphFillAlpha": 0,
                "graphLineAlpha": 0.5,
                "selectedGraphFillAlpha": 0,
                "selectedGraphLineAlpha": 1,
                "autoGridCount": true,
                "color": "#AAAAAA"
            },
            "chartCursor": {
                "pan": true,
                "valueLineEnabled": true,
                "valueLineBalloonEnabled": true,
                "cursorAlpha": 0,
                "valueLineAlpha": 0.2
            },
            // "categoryField": "date",
            "categoryField": "time",
            "legend": {
                "useGraphSettings": true,
                "position": "top"
            },
            "balloon": {
                "borderThickness": 1,
                "shadowAlpha": 0
            },

            "graphs": [{
                "alphaField": "alpha",
                "balloonText": "<span style='font-size:13px;'>[[category]]上传的文件数[[title]]:<b>[[value]]</b> [[additional]]</span>",
                "dashLengthField": "dashLengthColumn",
                "fillAlphas": 1,
                "title": "数量",
                "type": "column",
                "valueField": "count"
            }],
            "export": {
                "enabled": true,
                "menu":[{
                    "class": "export-main",
                    "menu": [
                        { "fileName": "文件上传时间统计", "format": "png", "label": "导出为PNG" },
                        { "fileName": "文件上传时间统计", "format": "jpg", "label": "导出为JPG" },
                        { "fileName": "文件上传时间统计", "format": "svg", "label": "导出为SVG" },
                    ]
                }]
            }

        });
    };

    var loadData = function(){
        var inte = document.getElementById("interval").value;
        var url = initurl+"?action=getStatistics&interval="+inte;
        console.log(url);
        $.post(url, function(json){
            console.log("loadData callback");
            console.log(json);
            chart.dataProvider = json;
            chart.validateNow();
            chart.validateData();
        });
    };

    var interval_changed = function(){
        console.log("interval_changed");
        loadData();
    };

    var addEventListener = function(){
        $("#interval").change(interval_changed);
    };

    return {
        init: function(){
            console.log("statistics init");
            initAmCharts();
            loadData();
            addEventListener();
        }
    };
}();
function returnBack(){
    window.location.href=ContextPath+"/file/file_list.jsp";
};

