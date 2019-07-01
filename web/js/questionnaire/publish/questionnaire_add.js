var question_list=[];
var module="/QuestionnairePublish";
var existResultset="0";
var ContextPath=$("#ContextPath").val();
var url=ContextPath+module;
var TableEditable = function () {
    var handleTable = function () {
        function restoreRow(oTable, nRow) {
            var aData = oTable.fnGetData(nRow);
            var jqTds = $('>td', nRow);
            for (var i = 0, iLen = jqTds.length; i < iLen; i++) {
                oTable.fnUpdate(aData[i], nRow, i, false);
            }
            oTable.fnDraw();
        }

        function editRow(oTable, nRow) {
            var aData = oTable.fnGetData(nRow);
            var jqTds = $('>td', nRow);
            jqTds[0].innerHTML = '<input type="text" class="form-control" value="' + aData[0] + '">';
            jqTds[1].innerHTML = "<button type=\"button\" class=\"edit btn btn-success btn-sm btn-rounded m-b-10 m-l-5\">保存</button>";
            jqTds[2].innerHTML = "<button type=\"button\" class=\"cancel btn btn-info btn-sm btn-rounded m-b-10 m-l-5\">取消</button>";
        }

        function saveRow(oTable, nRow) {
            var jqInputs = $('input', nRow);
            if(jqInputs[0].value==null||jqInputs[0].value==""){
                Dialog.showWarning("问题不能为空","提示");
                // alert("问题不能为空");

            }else{
                oTable.fnUpdate(jqInputs[0].value, nRow, 0, false);
                oTable.fnUpdate("<button type=\"button\" class=\"edit btn btn-success btn-sm btn-rounded m-b-10 m-l-5\">编辑</button>", nRow, 1, false);
                oTable.fnUpdate("<button type=\"button\" class=\"delete btn btn-info btn-sm btn-rounded m-b-10 m-l-5\">删除</button>", nRow, 2, false);
                oTable.fnDraw();
            }



        }
        function cancelEditRow(oTable, nRow) {
            var jqInputs = $('input', nRow);
            oTable.fnUpdate(jqInputs[0].value, nRow, 0, false);
            oTable.fnUpdate('<button type=\"button\" class=\"edit btn btn-success btn-sm btn-rounded m-b-10 m-l-5\">编辑</button>', nRow, 1, false);
            oTable.fnDraw();
        }

        var table = $('#example23');

        var oTable = table.dataTable({

            "lengthMenu": [
                [15, 20, -1],
                [15, 20, "All"] // change per page values here
            ],
            "pageLength": 10,

            "language": {
                "lengthMenu": " _MENU_ records"
            },
            "columnDefs": [{ // set default column settings
                'orderable': true,
                'targets': [0]
            }, {
                "searchable": true,
                "targets": [0]
            }],
            "order": [
                [0, "asc"]
            ]
            ,    "oLanguage": {
                "sProcessing": "正在加载中......",
                "sLengthMenu": "每页显示 _MENU_ 条问题",
                "sZeroRecords": "对不起，查询不到相关问题！",
                "sEmptyTable": "当前还没有设置问题！",
                "sInfo": "当前问题 _START_ 到 _END_ 条，已经编辑 _TOTAL_ 个问题",
                "sInfoFiltered": "共设置 _MAX_ 条问题",
                "sSearch": "查询",
                "oPaginate": {
                    "sFirst": "首页",
                    "sPrevious": "上一页",
                    "sNext": "下一页",
                    "sLast": "末页"
                }
            }

        });


        var nEditing = null;
        var nNew = false;

        $('#add_new').click(function (e) {

            e.preventDefault();
            var flag=true;
            if (nNew && nEditing) {

                var jqInputs = $('input', nEditing);
                if(jqInputs[0].value==null||jqInputs[0].value==""){
                    Dialog.showWarning("问题不能为空","提示");
                    // alert("问题不能为空");
                    flag=false;
                }else{
                    saveRow(oTable, nEditing); // save
                    nEditing = null;
                    nNew = false;
                }

            }
            if(flag){
                var aiNew = oTable.fnAddData(['', '', '']);
                var nRow = oTable.fnGetNodes(aiNew[0]);
                editRow(oTable, nRow);
                nEditing = nRow;
                nNew = true;
                var aData=oTable.fnGetData();
                question_list=[];
                for(var i=0;i<aData.length;i++){
                    question_list.push(aData[i][0]);
                }
                console.log(question_list);
            }

        });

        table.on('click', '.delete', function (e) {

            e.preventDefault();
            var nRow = $(this).parents('tr')[0];
            oTable.fnDeleteRow(nRow);
            var aData=oTable.fnGetData();

            question_list=[];
            for(var i=0;i<aData.length;i++){
                question_list.push(aData[i][0]);
            }
            console.log(question_list);
        });

        table.on('click', '.cancel', function (e) {

            e.preventDefault();
            if (nNew) {
                oTable.fnDeleteRow(nEditing);
                nEditing = null;
                nNew = false;
            } else {
                restoreRow(oTable, nEditing);
                nEditing = null;
            }
            var aData=oTable.fnGetData();
            question_list=[];
            for(var i=0;i<aData.length;i++){
                question_list.push(aData[i][0]);
            }
            console.log(question_list);
        });

        table.on('click', '.edit', function (e) {
            e.preventDefault();
            var nRow = $(this).parents('tr')[0];
            if (nEditing !== null && nEditing != nRow) {
                restoreRow(oTable, nEditing);
                editRow(oTable, nRow);
                nEditing = nRow;
            } else if (nEditing == nRow && this.innerHTML == "保存") {
                saveRow(oTable, nEditing);
                nEditing = null;
            } else {
                editRow(oTable, nRow);
                nEditing = nRow;
            }
            var aData=oTable.fnGetData();
            question_list=[];
            for(var i=0;i<aData.length;i++){
                question_list.push(aData[i][0]);
            }
            console.log(question_list);
        });
    }

    return {
        init: function () {
            handleTable();
        }

    };

}();


var DatePicker = function(){
    var initDatePicker = function(){
        $('.datetime-picker').datepicker({
            opens : 'right', //日期选择框的弹出位置
            autoclose:true,
            format:"yyyy-mm-dd",
            startDate:"0d",
            errDealMode:1,
            todayBtn:'linked',
            language: 'cn',  //修改默认为cn
            todayHighlight: true,
        });
    }

    return {
        init: function(){
            initDatePicker();
        }
    }
}();
var Page=function() {

    var handleButtonEvent=function(){
        $('#return_button').click(function() {Page.confirmBack();});
        $('#submit_button').click(function() {Page.submitRecord();});
        var createTime="2019-09-01";
        $("#limit_time").val(createTime);
    };
    var submitRecord=function(){
        var id=$("#id").val();
        var title=$("#title").val();
        var time=$("#limit_time").val();

        url=url+"?action=add_record&title="+title+"&limit_time="+time;
        url=url+"&question_list="+JSON.stringify(question_list);
        if(checkInput()==true){
            //page_form.action=url;
            $.post(url,function(json){
                history.go(-1);
            })
        }
    };
    var checkInput=function(){
        if(question_list.length<1){
            Dialog.showWarning("需要设置至少一个问题","提示");
            // alert("需要设置至少一个问题");
            return false;
        }
        if($("#title").val().length<1){
            Dialog.showWarning("输入标题","提示");
            // alert("输入标题");
            return false;
        }
        return true;
    };
    var confirmBack=function(){
        history.go(-1);
    };

    return {
        init: function() {
            handleButtonEvent();
        },

        submitRecord:function(){
            submitRecord();
        },
        checkInput:function(){
            checkInput();
        },
        confirmBack:function(){
            confirmBack();
        },
    }
}();

TableEditable.init();
Page.init();
DatePicker.init();