<%--
  Created by IntelliJ IDEA.
  User: silenus
  Date: 2019/6/26
  Time: 20:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script type="text/javascript">
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
                    "title": "数量/人",
                    "baseValue": 0,
                    "integersOnly": true,
                    "minimum": 0,
                    "precision": 0,
                    "inside": true
                }],
                "categoryAxis": {
                    "title": "时间"
                },
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
                    "balloonText": "<span style='font-size:13px;'>[[category]]注册的用户数:<b>[[value]]</b> [[additional]]</span>",
                    "dashLengthField": "dashLengthColumn",
                    "fillAlphas": 1,
                    "title": "数量",
                    "type": "column",
                    "valueField": "count"
                }],

                "export": {
                    "enabled": true,
                    "menu":[{
//                        "label": "<span id='chartExportBtn'>保存</span>",
                        "class": "export-main",
                        "menu": [
                            { "fileName": "用户注册时间统计", "format": "png", "label": "导出为PNG" },
                            { "fileName": "用户注册时间统计", "format": "jpg", "label": "导出为JPG" },
                            { "fileName": "用户注册时间统计", "format": "svg", "label": "导出为SVG" },
                        ]
                    }]
                }
            });
        };

        var renderExportButton = function(){
            console.log("renderExportButton");
            console.log($('#chartdiv').html());
        }

        var fetchData = function(){
            var inte = document.getElementById("interval").value;
            var url = "<%=request.getContextPath()%>/UserInfoAction?action=statistics";
            var param = {"interval": inte};
            $.post(url, param, function(json){
                console.log("loadData callback");
                console.log(json);
                chart.dataProvider = json;
                chart.validateNow();
                chart.validateData();
            });
        };

        var interval_changed = function(){
            console.log("interval_changed");
            fetchData();
        };

        var addEventListener = function(){
            $("#interval").change(interval_changed);
        };

        return {
            init: function(){
                console.log("statistics init");
                initAmCharts();
                renderExportButton();
                fetchData();
                addEventListener();
            }
        };
    }();
    function returnBack(){
        window.location.href="<%=request.getContextPath()%>/userinfo/index.jsp";
    };
</script>