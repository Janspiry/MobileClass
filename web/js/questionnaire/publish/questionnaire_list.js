var Data=[];
var module="/QuestionnairePublish";
var existResultset="0";
var ContextPath=$("#ContextPath").val();
function Record(){
    var dataTable=$('#example23').DataTable({
        dom: 'Bfrtip',
        buttons:[
            {
                extend: 'print',
                className: 'buttons-print hidden',
                messageTop: '移动互动课堂|问卷信息列表',
                exportOptions: {
                    columns: [ 0,2,3,4,5,6,7]
                }
            },
            {
                extend: 'excel',
                title: 'questionnaire_info',
                className: 'buttons-excel hidden',
                exportOptions: {
                    columns: [ 0,2,3,4,5,6,7]
                }
            },
            {
                extend: 'csv',
                title: 'questionnaire_info',
                className: 'buttons-csv hidden',
                exportOptions: {
                    columns: [ 0,2,3,4,5,6,7]
                }
            },

        ],
        fixedHeader: true,
        fixedColumns: {
            leftColumns: 1
        },
        ordering: false,
        "oLanguage": {
            "aria": {
                "sortAscending": ": activate to sort column ascending",
                "sortDescending": ": activate to sort column descending"
            },
            "sProcessing":   "处理中...",
            "sLengthMenu":   "_MENU_ 问卷/页",
            "sZeroRecords":  "<span'>没有找到对应的问卷！</span>",
            "sInfo":         "显示第 _START_ 至 _END_ 项问卷，共 _TOTAL_ 项",
            "sInfoEmpty":    "显示第 0 至 0 项问卷，共 0 项",
            "sInfoFiltered": "(由 _MAX_ 项问卷过滤)",
            "sInfoPostFix":  "",
            "sSearch":       "搜索:",
            "oPaginate": {
                "sFirst":    "首页",
                "sPrevious": "上页",
                "sNext":     "下页",
                "sLast":     "末页"
            }
        },
        "autoWidth": true,
        "columnDefs": [
            {
                "targets":1,
                "data": null,
                "mRender":
                    function(data, type, full) {
                        sReturn= "<button type=\"button\" class=\"detail-button btn btn-default btn-sm btn-rounded m-b-10\">用户</button>"
                            if(full[8]==1) {
                                sReturn = sReturn +
                                    "<button type=\"button\" class=\"edit-button btn btn-success btn-sm btn-rounded m-b-10 m-l-5\">修改</button>" +
                                    "<button type=\"button\" class=\"delete-button btn btn-info btn-sm btn-rounded m-b-10 m-l-5\">删除</button>"
                            }
                        if(full[7]=="processing"){
                            sReturn=sReturn+"<button type=\"button\" class=\"answer-button btn btn-primary btn-sm btn-rounded m-b-10 m-l-5\">回答</button>";
                        }


                        return sReturn;
                    },
                "orderable": false
            },
            {
                "targets":2,
                "orderable": false
            },
            {
                "targets":3,
                "orderable": false
            },
            {
                "targets":7,
                "mRender":
                    function(data, type, full) {
                        if(data=="processing"){
                            sReturn='<span class="badge badge-success">'+
                                "进行中"+'</span>';
                        }else if(data=="ended"){
                            sReturn=
                                '<span class="badge badge-danger">'+
                                "已结束"+'</span>';
                        }
                        return sReturn;
                    },

            },
            {
                "targets":8,
                "bVisible": false
            },
        ],
        "aLengthMenu": [[10,15,20,25,40,50,-1],[10,15,20,25,40,50,"所有问卷"]],
    });
    getAllRecord();

    $('#example23 tbody').on('click', '.delete-button', function (event) {
        var _this=this;
        Dialog.showComfirm("确定要删除这条记录吗？", "警告", function(){
            var id = $(_this).parent().prev().text();
            console.log("id"+id);
            deleteRecord(id);
            var table = $('#example23').DataTable();
            table.row($(_this).parents('tr')).remove().draw();
            event.preventDefault();
            Dialog.showSuccess("记录已删除", "操作成功");
        });
    });
    $("#example23 tbody").on("click", ".edit-button", function (event) {
        var tds = $(this).parents("tr").children();
        $.each(tds, function (i, val) {
            var jqob = $(val);
            if (i != 2 &&i!=5) {
                return true;
            }
            var txt = jqob.text();
            var put = $("<input type='text'>");
            put.val(txt);
            jqob.html(put);
        });
        $(this).html("保存");
        $(this).toggleClass("edit-button");
        $(this).toggleClass("save-button");
        event.preventDefault();
    });
    $("#example23 tbody").on("click", ".save-button", function (event) {
        var row = dataTable.row($(this).parents("tr"));
        var tds = $(this).parents("tr").children();
        var valid_flag=1;
        $.each(tds, function (i, val) {
            var jqob = $(val);
            if(i==5){
                var limit_time = jqob.children("input").val();
                if(!isDate(limit_time)){
                    valid_flag=0;
                }else{
                    jqob.html(limit_time);
                    dataTable.cell(jqob).data(limit_time);
                }
            }else if (!jqob.has('button').length) {
                var txt = jqob.children("input").val();
                jqob.html(txt);
                dataTable.cell(jqob).data(txt);
            }

        });
        if(!valid_flag){
            return;
        }
        var data = row.data();
        var guid = data[0];
        var title = data[2];
        var limit_time = data[5];
        url =ContextPath+module+"?action=modify_record";
        if (guid != "") {
            url += "&guid=" + guid;
        }
        if (title != "") {
            url += "&title=" + title;
        }
        if (limit_time != "") {
            url += "&limit_time=" + limit_time;
        }
        getSelectedRecord(url);
        Dialog.showSuccess("记录已修改", "操作成功");
    });
    $('#example23 tbody').on('click', '.answer-button', function (event) {
        var id = $(this).parent().prev().text();
        answerProblem(id);
    });
    $('#example23 tbody').on('click', '.detail-button', function (event) {
        var id = $(this).parent().prev().text();
        answerUser(id);
    });
}
function deleteRecord(id) {
    var url=ContextPath+module+"?action=delete_record";
    if (id !="") {
        url += "&guid=" + id;
    }
    $.post(url, function (jsonObject) {
        alert("删除成功！");
    });
    event.preventDefault();
}
function isDate(dateString) {
    if (dateString.trim() == "")return true;
    //年月日时分正则表达式
    var r = dateString.match(/^(\d{1,4})\-(\d{1,2})\-(\d{1,2})$/);
    if (r == null) {
        Dialog.showText("格式错误","请输入正确格式的日期如：2019-09-09");
        return false;
    }
    var d = new Date(r[1], r[2] - 1, r[3]);
    var num = (d.getFullYear() == r[1] && (d.getMonth() + 1) == r[2] && d.getDate() == r[3]);
    if (num == 0) {
        Dialog.showText("格式错误","请输入正确格式的日期如：2019-09-09");
    }
    return (num != 0);
}

function getAllRecord(){
    var dataTable = $('#example23').DataTable();
    dataTable.clear().draw(); //清除表格数据
    var url=ContextPath+module+"?action=get_record&exist_resultset="+existResultset;
    $.post(url, function (json) {
        Data = json;
        console.log(json);
        for (var i = 0; i < json.length; i++) {
            var id = json[i]["guid"];
            var title = json[i]["title"];
            var author_name = json[i]["author_name"];
            var create_time = json[i]["create_time"];
            var limit_time = json[i]["limit_time"];
            var status = json[i]["status"];
            var answer_num = json[i]["answer_num"];
            var authorization = json[i]["authorization"];
            dataTable.row.add([id,'', title, author_name, create_time, limit_time,answer_num,status,authorization]).draw().node();
        }
    });
}
function getSelectedRecord(url){
    var dataTable = $('#example23').DataTable();
    dataTable.clear().draw(); //清除表格数据
    $.post(url, function (json) {
        Data = json;
        console.log(json);
        for (var i = 0; i < json.length; i++) {
            var id = json[i]["guid"];
            var title = json[i]["title"];
            var author_name = json[i]["author_name"];
            var create_time = json[i]["create_time"];
            var limit_time = json[i]["limit_time"];
            var status = json[i]["status"];
            var answer_num = json[i]["answer_num"];
            var authorization = json[i]["authorization"];
            dataTable.row.add([id,'', title, author_name, create_time, limit_time,answer_num,status,authorization]).draw().node();
        }
    });
}

function addRecord(){
    window.location.href="questionnaire_add.jsp";

}

function statisticRecord(){
    window.location.href="questionnaire_statistic.jsp";
};

function printRecord(){
    window.location.href="questionnaire_print.jsp";
};
function expordExcel(){
    $(".dt-buttons .buttons-excel").click();
};
function expordCsv(){
    $(".dt-buttons .buttons-csv").click();

};
function sortRecord(){
    var key1 = $("#key1").val();
    var key2 = $("#key2").val();
    var key3 = $("#key3").val();
    var rule1 = $("#rule1").val();
    var rule2 = $("#rule2").val();
    var rule3 = $("#rule3").val();
    var url =ContextPath+module+"?action=get_record";
    var title = $("#title").val();
    var author_name = $("#author_name").val();
    if (title != "") {
        url += "&title=" + title;
    }
    if (author_name != "") {
        url += "&author_name=" + author_name;
    }
    var tmp="&orderby=";
    var flag=0;
    if (key1 != "") {
        if(flag){
            tmp += " ," + key1;
            tmp += " " + rule1;
        }else{
            tmp += " " + key1;
            tmp += " " + rule1;
            flag=1;
        }
    }
    if (key2 != "") {
        if(flag){
            tmp += " ," + key2;
            tmp += " " + rule2;
        }else{
            tmp += " " + key2;
            tmp += " " + rule2;
            flag=1;
        }
    }
    if (key3 != "") {
        if(flag){
            tmp += " ," + key3;
            tmp += " " + rule3;
        }else{
            tmp += " " + key3;
            tmp += " " + rule3;
            flag=1;
        }
    }

    url=url+tmp;
    getSelectedRecord(url);
};
function searchRecord(){
    var title = $("#title").val();
    var author_name = $("#author_name").val();
    var url =ContextPath+module+"?action=get_record";
    if (title != "") {
        url += "&title=" + title;
    }
    if (author_name != "") {
        url += "&author_name=" + author_name;
    }
    getSelectedRecord(url);
};
function answerProblem(id){
    var url=ContextPath+"/QuestionnaireAnswer?action=get_record_by_id&id="+id+"&type=user";
    // alert(url);
    $.post(url,function(json){
        console.log(json);
        if(json.length>0){
            window.location.href=ContextPath+"/questionnaire/answer/answer_problem.jsp?id="+id;
        }else{
            Dialog.showError("错误","你已回答过此问卷");
            // alert("你已回答过此问卷");
        }
    })
};
function answerUser(id){
    window.location.href=ContextPath+"/questionnaire/answer/user_list.jsp?id="+id;
};
Record();
