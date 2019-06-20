<%--
  Created by IntelliJ IDEA.
  User: silenus
  Date: 2019/6/18
  Time: 22:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script type="text/javascript">
    var Page = function(){

        var showSussess = function(msg){
            toastr.success(msg,'操作成功',{
                "positionClass": "toast-top-center",
                timeOut: 3000,
                "closeButton": true,
                "debug": false,
                "newestOnTop": true,
                "progressBar": true,
                "preventDuplicates": true,
                "onclick": null,
                "showDuration": "300",
                "hideDuration": "1000",
                "extendedTimeOut": "1000",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut",
                "tapToDismiss": false

            })
        }

        var showError = function(msg){
            toastr.error(msg,'错误',{
                "positionClass": "toast-top-center",
                timeOut: 3000,
                "closeButton": true,
                "debug": false,
                "newestOnTop": true,
                "progressBar": true,
                "preventDuplicates": true,
                "onclick": null,
                "showDuration": "300",
                "hideDuration": "1000",
                "extendedTimeOut": "1000",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut",
                "tapToDismiss": false

            })
        }

        var bindValidationToFormQuery = function(){
            $("#form-query").validate({
                errorElement: 'span', //default input error message container
                errorClass: 'color-danger', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                    username: {
                        id: true
                    },
                    fullname: {
                        id_zh: true
                    },
                    email: {
                        email: true
                    },
                    phone: {
                        number: true,
                        rangelength: [3, 15]
                    },
                    schoolnum: {
                        id: true
                    },
                    nativeplace: {
                        id_zh: true
                    },
                },

                messages: { // custom messages for radio buttons and checkboxes
                    username: {
                        id: "用户名只能包含字母、数字、下划线"
                    },
                    email: {
                        email: "邮箱格式不正确"
                    },
                    phone: {
                        number: "电话格式不正确",
                        rangelength: "电话格式不正确"
                    },
                    fullname: {
                        id_zh: "姓名只能包含字母、数字、下划线、汉字"
                    },
                    schoolnum: {
                        id: "学号只能包含字母、数字、下划线"
                    },
                    nativeplace: {
                        id_zh: "籍贯只能包含字母、数字、下划线、汉字"
                    },
                },

                highlight: function(element) { // hightlight error inputs
                    $(element)
                            .closest('.form-group').addClass('has-error'); // set error class to the control group
                },

                success: function(label) {
                    label.closest('.form-group').removeClass('has-error');
                    label.remove();
                },

                errorPlacement: function(error, element) {
                    error.insertAfter(element);
                },

                submitHandler: function(form) {
                    console.log("submitHandler");
                    submitFormQuery_onClick();
                }
            });

            $.validator.addMethod("id",function(value,element,params){
                var checkId = /^[_a-zA-Z0-9]+$/;
                return this.optional(element)||(checkId.test(value));
            },"ID格式不正确");

            $.validator.addMethod("id_zh",function(value,element,params){
                var checkIdzh = /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/;
                return this.optional(element)||(checkIdzh.test(value));
            },"中文ID格式不正确");
        };

        var submitFormQuery_onClick = function(){
            if(!$('#form-query').valid())return;
            url = "<%=request.getContextPath()%>/UserInfoAction?action=query";
            var form=document.getElementById("form-query");
            var param = {
                "username": form.username.value,
                "fullname": form.fullname.value,
                "nativeplace": form.nativeplace.value,
                "email": form.email.value,
                "phone": form.phone.value,
                "gender": form.gender.value
            };
            $.post(url, param, function(res){
                console.log("userinfo query callback");
                console.log(res);
                if(res.errno != 0){
                    showError(res.msg);
                }else{
                    fetchRecord();
                }
            });
        };

        var bindValidationToFormAdd = function(){
            $("#form-add").validate({
                errorElement: 'span', //default input error message container
                errorClass: 'color-danger', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                    username: {
                        required: true
                    },
                    password: {
                        required: true,
                        rangelength: [4, 20]
                    },
                    email: {
                        required: true,
                        email: true
                    },
                    phone: {
                        required: true,
                        number: true,
                        rangelength: [3, 15]
                    },
                    fullname: {
                        required: true
                    },
                    gender: {
                        required: true,
                        min: 1
                    },
                    schoolnum: {
                        required: true
                    },
                    nativeplace: {
                        required: true
                    },
                },

                messages: { // custom messages for radio buttons and checkboxes
                    username: {
                        required: "请输入用户名"
                    },
                    password: {
                        required: "请输入密码",
                        rangelength: "密码长度必须在4~20字符之间"
                    },
                    email: {
                        required: "请输入邮箱",
                        email: "邮箱格式不正确"
                    },
                    phone: {
                        required: "请输入电话",
                        number: "电话格式不正确",
                        rangelength: "电话格式不正确"
                    },
                    fullname: {
                        required: "请输入姓名"
                    },
                    gender: {
                        required: "请选择性别",
                        min: "请选择性别"
                    },
                    schoolnum: {
                        required: "请输入学号"
                    },
                    nativeplace: {
                        required: "请输入籍贯"
                    },
                },

                highlight: function(element) { // hightlight error inputs
                    $(element)
                            .closest('.form-group').addClass('has-error'); // set error class to the control group
                },

                success: function(label) {
                    label.closest('.form-group').removeClass('has-error');
                    label.remove();
                },

                errorPlacement: function(error, element) {
                    error.insertAfter(element);
                },

                submitHandler: function(form) {
                    console.log("submitHandler");
                    submitFormAdd_onClick();
                }
            });
        };

        var submitFormAdd_onClick = function() {
            if(!$("#form-add").valid())return;
            url = "<%=request.getContextPath()%>/AccountAction?action=register";
            var form=document.getElementById("form-add");
            url += "&username="+form.username.value;
            url += "&password="+form.password.value;
            url += "&email="+form.email.value;
            url += "&phone="+form.phone.value;
            url += "&fullname="+form.fullname.value;
            url += "&gender="+form.gender.value;
            url += "&schoolnum="+form.schoolnum.value;
            url += "&nativeplace="+form.nativeplace.value;
            console.log(url);
            $.post(url, function(result){
                console.log("register callback");
                console.log(result);
                if(result.register_errno == 0)
                {
                    showSussess("用户添加成功");
                    fetchRecord();
                }
                else {
                    showError(result.register_msg);
                }
            });
        };

        var initNestable = function(){
            $('#form-sort').nestable({
                "maxDepth": 1
            });
        };

        var initDataTable = function(){
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
            var dataTable=$('#myDataTable').DataTable({
                dom: 'Bfrtip',
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
                    "sLengthMenu":   "当前每页显示 _MENU_ 项记录",
                    "sZeroRecords":  "<span>没有找到记录！</span>",
                    "sInfo":         "显示第 _START_ 至 _END_ 项记录，共 _TOTAL_ 项",
                    "sInfoEmpty":    "显示第 0 至 0 项记录，共 0 项",
//                    "sInfoFiltered": "(由 _MAX_ 项问卷过滤)",
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
                        "targets":0,
                        "bVisible":false
                    },
                    {
                        "targets":1,
                        "data": null,
                        "mRender":
                                function(data, type, full) {
                                    sReturn=
                                            "<button type='button' class='edit-button btn btn-success btn-sm btn-rounded m-b-10 m-l-5'>修改</button>"+
                                            "<button type='button' class='delete-button btn btn-info btn-sm btn-rounded m-b-10 m-l-5'>删除</button>"
                                    return sReturn;
                                },
                        "orderable": false
                    },
                    {
                        "targets":4,
                        "orderable":false,
                        "mRender":function(data,type,full){
                            var res="null";
                            if(data===1)res="男";
                            else if(data===2)res="女";
                            return res;
                        }
                    },
                    {
                        "targets":[2,3,5,6,7,8],
                        "orderable": false
                    },
                ],
                "aLengthMenu": [[10,15,20,25,40,50,-1],[10,15,20,25,40,50,"所有记录"]],
            });
            fetchRecord();
//            $('#myDataTable tbody').on('click', '.delete-button', function (event) {
//                var id = $(this).parent().prev().text();
//                deleteRecord(id);
//                var table = $('#example23').DataTable();
//                table.row($(this).parents('tr')).remove().draw();
//                event.preventDefault();
//            });
//            $("#myDataTable tbody").on("click", ".edit-button", function (event) {
//                var tds = $(this).parents("tr").children();
//                $.each(tds, function (i, val) {
//                    var jqob = $(val);
//                    if (i != 2 &&i!=5) {
//                        return true;
//                    }
//                    var txt = jqob.text();
//                    var put = $("<input type='text'>");
//                    put.val(txt);
//                    jqob.html(put);
//                });
//                $(this).html("保存");
//                $(this).toggleClass("edit-button");
//                $(this).toggleClass("save-button");
//                event.preventDefault();
//            });
//            $("#myDataTable tbody").on("click", ".save-button", function (event) {
//                var row = dataTable.row($(this).parents("tr"));
//                var tds = $(this).parents("tr").children();
//                var valid_flag=1;
//                $.each(tds, function (i, val) {
//                    var jqob = $(val);
//                    if(i==5){
//                        var limit_time = jqob.children("input").val();
//                        if(!isDate(limit_time)){
//                            valid_flag=0;
//                        }else{
//                            jqob.html(limit_time);
//                            dataTable.cell(jqob).data(limit_time);
//                        }
//                    }else if (!jqob.has('button').length) {
//                        var txt = jqob.children("input").val();
//                        jqob.html(txt);
//                        dataTable.cell(jqob).data(txt);
//                    }
//
//                });
//                if(!valid_flag){
//                    return;
//                }
//                var data = row.data();
//                var guid = data[0];
//                var title = data[2];
//                var limit_time = data[5];
//                url =ContextPath+module+"?action=modify_record";
//                if (guid != "") {
//                    url += "&guid=" + guid;
//                }
//                if (title != "") {
//                    url += "&title=" + title;
//                }
//                if (limit_time != "") {
//                    url += "&limit_time=" + limit_time;
//                }
//                getSelectedRecord(url);
//
//            });
//            $('#myDataTable tbody').on('click', '.answer-button', function (event) {
//                var id = $(this).parent().prev().text();
//                answerProblem(id);
//            });
//            $('#myDataTable tbody').on('click', '.detail-button', function (event) {
//                var id = $(this).parent().prev().text();
//                answerUser(id);
//            });
        };

        var fetchRecord = function(){
            var dt = $('#myDataTable').DataTable();
            dt.clear().draw();
            var url="<%=request.getContextPath()%>/UserInfoAction?action=getResult";
            $.post(url, function (json) {
                console.log(json);
                for (var i = 0; i < json.length; i++) {
                    var it=json[i];
                    var row=[it.guid, '', it.username, it.fullname, it.gender, it.schoolnum, it.nativeplace, it.email, it.phone];
                    dt.row.add(row).draw().node();
                }
            });
        }

        return {
            init: function(){
                initDataTable();
                bindValidationToFormQuery();
                bindValidationToFormAdd();
                initNestable();
            }
        };

    }();
</script>