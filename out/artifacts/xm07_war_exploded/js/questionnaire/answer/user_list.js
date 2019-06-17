var Data=[];
var module="/QuestionnaireAnswer";
var existResultset="0";
var ContextPath=$("#ContextPath").val();
var id=$("#id").val();
function Record(){
    $(document).ready(function() {
        $('#myTable').DataTable();
        $(document).ready(function() {
            var table = $('#example').DataTable({
                "columnDefs": [{
                    "visible": false,
                    "targets": 2
                }],
                "order": [
                    [2, 'asc']
                ],
                "displayLength": 25,
                "drawCallback": function(settings) {
                    var api = this.api();
                    var rows = api.rows({
                        page: 'current'
                    }).nodes();
                    var last = null;
                    api.column(2, {
                        page: 'current'
                    }).data().each(function(group, i) {
                        if (last !== group) {
                            $(rows).eq(i).before('<tr class="group"><td colspan="5">' + group + '</td></tr>');
                            last = group;
                        }
                    });
                }
            });
            // Order by the grouping
            $('#example tbody').on('click', 'tr.group', function() {
                var currentOrder = table.order()[0];
                if (currentOrder[0] === 2 && currentOrder[1] === 'asc') {
                    table.order([2, 'desc']).draw();
                } else {
                    table.order([2, 'asc']).draw();
                }
            });
        });
    });
    var dataTable=$('#example23').DataTable({
        dom: 'Bfrtip',

        // buttons: [
        //     'excel', 'pdf', 'print'
        // ],
        buttons: [
            'excel', 'print'
        ],
        ordering: false,
        "oLanguage": {
            "aria": {
                "sortAscending": ": activate to sort column ascending",
                "sortDescending": ": activate to sort column descending"
            },
            "sProcessing":   "处理中...",
            "sLengthMenu":   "_MENU_ 用户/页",
            "sZeroRecords":  "<span'>没有找到对应的用户！</span>",
            "sInfo":         "显示第 _START_ 至 _END_ 个用户，共 _TOTAL_ 个",
            "sInfoEmpty":    "显示第 0 至 0 个用户，共 0 个",
            "sInfoFiltered": "(由 _MAX_个用户过滤)",
            "sInfoPostFix":  "",
            "sSearch":       "搜索:",
            "oPaginate": {
                "sFirst":    "首页",
                "sPrevious": "上页",
                "sNext":     "下页",
                "sLast":     "末页"
            }
        },
        "columnDefs": [
            {
                "targets":1,
                "data": null,
                "mRender":
                    function(data, type, full) {
                        sReturn=
                            "<button type=\"button\" class=\"detail-button btn btn-default btn-sm btn-rounded m-b-10\">回答详情</button>"+
                            "<button type=\"button\" class=\"edit-button btn btn-success btn-sm btn-rounded m-b-10 m-l-5\">修改回答</button>"+
                            "<button type=\"button\" class=\"delete-button btn btn-info btn-sm btn-rounded m-b-10 m-l-5\">删除回答</button>"
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
        ],
        "aLengthMenu": [[10,15,20,25,40,50,-1],[10,15,20,25,40,50,"所有问卷"]],
    });
    getAllRecord();

    $('#example23 tbody').on('click', '.delete-button', function (event) {
        var id = $(this).parent().prev().text();
        deleteRecord(id);
        var table = $('#example23').DataTable();
        table.row($(this).parents('tr')).remove().draw();
        event.preventDefault();
    });
    $("#example23 tbody").on("click", ".edit-button", function (event) {
        var id = $(this).parent().prev().text();
        modifyRecord(id);
    });
    $('#example23 tbody').on('click', '.detail-button', function (event) {
        var id = $(this).parent().prev().text();
        answerDetail(id);
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
        alert("请输入正确格式的日期\n\r如：2019-09-09\n\r");
        return false;
    }
    var d = new Date(r[1], r[2] - 1, r[3]);
    var num = (d.getFullYear() == r[1] && (d.getMonth() + 1) == r[2] && d.getDate() == r[3]);
    if (num == 0) {
        alert("请输入正确格式的日期\n\r如：2019-09-09\n\r");
    }
    return (num != 0);
}

function getAllRecord(){

    var dataTable = $('#example23').DataTable();
    dataTable.clear().draw(); //清除表格数据
    var url=ContextPath+module+"?action=get_record&id="+id+"&type=user";
    $.post(url, function (json) {
        Data = json;
        console.log(json);
        for (var i = 0; i < json.length; i++) {
            var id = json[i]["guid"];
            var title = json[i]["title"];
            var author_name = json[i]["author_name"];
            var change_time = json[i]["change_time"];
            var create_time = json[i]["limit_time"];
            var answer_num = json[i]["answer_num"];
            var user_name = json[i]["user_name"];
            dataTable.row.add([id,'', title, author_name, create_time, change_time,answer_num,user_name]).draw().node();
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
            dataTable.row.add([id,'', title, author_name, create_time, limit_time,answer_num,status]).draw().node();
        }
    });
}

function addRecord(){
    window.location.href="questionnaire_add.jsp";
}

function statisticRecord(){
    window.location.href="questionnaire_statistic.jsp";

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
function modifyReaord(id){
    window.location.href=ContextPath+"/questionnaire/answer/answer_modify.jsp?id="+id;
};
function answerDetail(id){
    window.location.href=ContextPath+"/questionnaire/answer/answer_detail.jsp?id="+id;
};
Record();
