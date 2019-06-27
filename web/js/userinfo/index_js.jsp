<%--
  Created by IntelliJ IDEA.
  User: silenus
  Date: 2019/6/18
  Time: 22:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script type="text/javascript">

    var FormQuery = function(){

        $.validator.addMethod("id",function(value,element,params){
            var checkId = /^[_a-zA-Z0-9]+$/;
            return this.optional(element)||(checkId.test(value));
        },"ID格式不正确");

        $.validator.addMethod("id_zh",function(value,element,params){
            var checkIdzh = /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/;
            return this.optional(element)||(checkIdzh.test(value));
        },"中文ID格式不正确");

        var bindValidation = function(){
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
                    submitForm_onClick();
                }
            });
        };

        var submitForm_onClick = function(){
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
                    Page.fetchResult();
                }
            });
        };

        return {
            init: function(){
                bindValidation();
            }
        };

    }();

    var FormAdd = function(){

        var bindValidation = function(){
            $("#form-add").validate({
                errorElement: 'span', //default input error message container
                errorClass: 'color-danger', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                    username: {
                        id: true,
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
                        id_zh: true,
                        required: true
                    },
                    gender: {
                        required: true,
                        min: 1
                    },
                    schoolnum: {
                        id: true,
                        required: true
                    },
                    nativeplace: {
                        id_zh: true,
                        required: true
                    },
                },

                messages: { // custom messages for radio buttons and checkboxes
                    username: {
                        id: "用户名只能包含字母、数字、下划线",
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
                        id_zh: "姓名只能包含字母、数字、下划线、汉字",
                        required: "请输入姓名"
                    },
                    gender: {
                        required: "请选择性别",
                        min: "请选择性别"
                    },
                    schoolnum: {
                        id: "学号只能包含字母、数字、下划线",
                        required: "请输入学号"
                    },
                    nativeplace: {
                        id_zh: "籍贯只能包含字母、数字、下划线、汉字",
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
                    submitForm_onClick();
                }
            });
        };

        var submitForm_onClick = function() {
            if(!$("#form-add").valid())return;
            url = "<%=request.getContextPath()%>/AccountAction?action=register";
            var form=document.getElementById("form-add");

            var param = {
                "username": form.username.value,
                "password": form.password.value,
                "fullname": form.fullname.value,
                "nativeplace": form.nativeplace.value,
                "email": form.email.value,
                "phone": form.phone.value,
                "gender": form.gender.value,
                "schoolnum": form.schoolnum.value
            };
            $.post(url, param, function(res){
                console.log("register callback");
                console.log(res);
                if(res.register_errno == 0)
                {
                    Dialog.showSuccess("用户添加成功", "操作成功");
                    Page.fetchResult();
                }
                else {
                    Dialog.showError(res.register_msg, "错误");
                }
            });
        };

        return {
            init: function(){
                bindValidation();
            }
        };

    }();

    var FormSort = function(){

        var choice = [
            ['username','用户名'],
            ['fullname','姓名'],
            ['schoolnum','学号'],
            ['nativeplace','籍贯'],
            ['email','邮箱'],
            ['phone','电话']
        ];

        var addEventListener = function(){
            $('.btn-dark').click(btnOrder_onclick);
            $('#form-sort-submit').click(btnSubmit_onclick);
            $('#form-sort-reset').click(btnReset_onclick);
        }

        var btnOrder_onclick = function(evt){
            var i = $(evt.target).children('i');
            if(i.hasClass('fa fa-sort-amount-asc')){
                i.html('降序');
                i.removeClass('fa fa-sort-amount-asc');
                i.addClass('fa fa-sort-amount-desc');
            }else{
                i.html('升序');
                i.removeClass('fa fa-sort-amount-desc');
                i.addClass('fa fa-sort-amount-asc');
            }
            evt.preventDefault();
        }

        var btnSubmit_onclick = function(evt){
            console.log('btnSubmit_onclick');
            var li = $('#form-sort-rule').find('li');
            var rule = '';
            $.each(li, function(i, val){
                if(rule.length > 0)rule += ',';
                rule += " `" + $(val).attr("data-id") + "`";
                if($(val).find('i').hasClass('fa fa-sort-amount-asc')){
                    rule += ' asc';
                }else{
                    rule += ' desc';
                }
            });
            console.log(rule);
            var url = "<%=request.getContextPath()%>/UserInfoAction?action=sort";
            var param = {"sortBy": rule};
            $.post(url, param, function(res){
                console.log('btnSubmit_onclick callback');
                console.log(res);
                Page.fetchResult();
            });
        }

        var btnReset_onclick = function(evt){
            console.log('btnReset_onclick');
            initNestable();
        }

        var initNestable = function(){
            var li="  <li class='dd-item dd3-item' data-id='{0}'>"
                    +"  <div class='dd-handle dd3-handle'></div>"
                    +"  <div class='dd3-content'>"
                    +"      <div class='row'>"
                    +"          <h5 class='col-md-8'>{1}</h5>"
                    +"          <button type='button' class='col-md-3 btn btn-dark btn-xs btn-outline btn-rounded' style='margin-top:-4px;'>"
                    +"              <i class='fa fa-sort-amount-asc' style='pointer-events: none;'>升序</i>"
                    +"          </button>"
                    +"      </div>"
                    +"</div></li>";
            var pref='<ol class="dd-list">';
            var suff='</ol>';
            var html='';
//            if(choice.length > 0){
//                html+=String.format(li, choice[0][0], choice[0][1]);
//            }
            $('#form-sort-rule').html("<div class='dd-empty'></div>");
            html="";
            for(var i=0;i<choice.length;i++){
                html+=String.format(li, choice[i][0], choice[i][1]);
            }
            $('#form-sort-choice').html(pref+html+suff);
        };

        return {
            init: function(){
                initNestable();
                $('#form-sort-rule').nestable({
                    "maxDepth": 1,
                    "group": 1
                });
                $('#form-sort-choice').nestable({
                    "maxDepth": 1,
                    "group": 1
                });
                addEventListener();
            }
        };

    }();

    var Page = function(){

        var initDataTable = function(){
            var dataTable=$('#myDataTable').DataTable({
                dom: 'Bfrtip',
                buttons:[
                    {
                        extend: 'print',
                        className: 'buttons-print hidden',
                        messageTop: '移动互动课堂 用户信息列表',
                        exportOptions: {
                            columns: [ 2,3,4,5,6,7,8 ]
                        }
                    },
                    {
                        extend: 'excel',
                        title: 'userinfo_export',
                        className: 'buttons-excel hidden',
                        exportOptions: {
                            columns: [ 2,3,4,5,6,7,8 ]
                        }
                    },
                    {
                        extend: 'csv',
                        title: 'userinfo_export',
                        className: 'buttons-csv hidden',
                        exportOptions: {
                            columns: [ 2,3,4,5,6,7,8 ]
                        }
                    },
                    {
                        extend: 'pdfHtml5',
                        title: 'userinfo_export',
                        bom: true,
                        className: 'buttons-pdf hidden',
                        exportOptions: {
                            columns: [ 2,3,4,5,6,7,8 ]
                        }
                    }
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
                    "sLengthMenu":   "当前每页显示 _MENU_ 项记录",
                    "sZeroRecords":  "<span>没有找到记录！</span>",
                    "sInfo":         "显示第 _START_ 至 _END_ 项记录，共 _TOTAL_ 项",
                    "sInfoEmpty":    "显示第 0 至 0 项记录，共 0 项",
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
                        "targets":0,
                        "bVisible":false,
                        "data": "guid"
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
                        "targets":2,
                        "data": "username",
                        "orderable": false
                    },
                    {
                        "targets":3,
                        "data": "fullname",
                        "orderable": false
                    },
                    {
                        "targets":4,
                        "data": "gender",
                        "orderable":false,
                        "mRender":function(data,type,full){
                            var res="null";
                            if(data===1)res="男";
                            else if(data===2)res="女";
                            return res;
                        }
                    },
                    {
                        "targets":5,
                        "data": "schoolnum",
                        "orderable": false
                    },
                    {
                        "targets":6,
                        "data": "nativeplace",
                        "orderable": false
                    },
                    {
                        "targets":7,
                        "data": "email",
                        "orderable": false
                    },
                    {
                        "targets":8,
                        "data": "phone",
                        "orderable": false
                    },
                ],
                "aLengthMenu": [[10,20,50,-1],[10,20,50,"所有记录"]],
            });
            fetchResult();
        };

        var addEventListener = function(){
            $('#myDataTable tbody').on('click', '.delete-button', delete_button_onclick);
            $("#myDataTable tbody").on("click", ".edit-button", edit_button_onclick);
            $("#myDataTable tbody").on("click", ".save-button", save_button_onclick);
            $("#myDataTable tbody").on("click", ".cancel-button", cancel_button_onclick);
            $("#tab-print").click(print_onclick);
            $("#tab-excel").click(excel_onclick);
            $("#tab-csv").click(csv_onclick);
            $("#tab-pdf").click(pdf_onclick);
            $("#tab-sta").click(sta_onclick);
        }

        var fetchResult = function(){
            var dt = $('#myDataTable').DataTable();
            dt.clear().draw();
            var url="<%=request.getContextPath()%>/UserInfoAction?action=getResult";
            $.post(url, function (json) {
                console.log(json);
                for (var i = 0; i < json.length; i++) {
                    var it=json[i];
//                    var row=[it.guid, '', it.username, it.fullname, it.gender, it.schoolnum, it.nativeplace, it.email, it.phone];
                    dt.row.add(it).draw().node();
                }
            });
        };

        var delete_button_onclick = function(evt){
            var node=$(evt.target).parents('tr');
            var table=$('#myDataTable').DataTable();
            var id = table.row(node).data()['guid'];
            console.log("delete_button_onClick", id);
            Dialog.showComfirm("确定要删除这条记录吗？", "警告", function(){
                url="<%=request.getContextPath()%>/UserInfoAction?action=delete";
                param={
                    "guid": id
                };
                $.post(url, param, function(res){
                    console.log(res);
                    table.row(node).remove().draw();
                    event.preventDefault();
                    Dialog.showSuccess("记录已删除", "操作成功");
                });
            });
        };

        var edit_button_onclick = function(evt){
            var that = $(evt.target);
            var tds = that.parents("tr").children();
            $.each(tds, function (i, val) {
                if(i==0)return true;
                var jqob = $(val);
                var put=null;
                if(i==3){
                    put=$("<select style='width: 75px;' class='form-control'>"
                          +"  <option value='1'>男</option>"
                          +"  <option value='2'>女</option>"
                          +"</select>");
                    var val = "0";
                    if(jqob.text()=="男")val="1";
                    else if(jqob.text()=="女")val="2";
                    put.val(val);
                }else{
                    put=$("<input type='text'>");
                    put.val(jqob.text());
                }
                jqob.html(put);
            });
            that.html("保存");
            that.removeClass("edit-button");
            that.addClass("save-button");
            var btnDelete = that.siblings("button");
            btnDelete.html("取消");
            btnDelete.removeClass("delete-button");
            btnDelete.addClass("cancel-button");
            evt.preventDefault();
        }

        var save_button_onclick = function(evt){
            var that = $(evt.target);
            var dt = $('#myDataTable').DataTable();
            var row = dt.row(that.parents("tr"));
            var tr = that.parents("tr");
            var param = {"guid": row.data()['guid']};
            param["username"] = tr.children().eq(1).children("input").val();
            param["fullname"] = tr.children().eq(2).children("input").val();
            param["gender"] = parseInt(tr.children().eq(3).children("select").val());
            param["schoolnum"] = tr.children().eq(4).children("input").val();
            param["nativeplace"] = tr.children().eq(5).children("input").val();
            param["email"] = tr.children().eq(6).children("input").val();
            param["phone"] = tr.children().eq(7).children("input").val();
            console.log(param);
            var url = "<%=request.getContextPath()%>/UserInfoAction?action=update";
            $.post(url, param, function(res){
                console.log("save_button_onclick callback");
                console.log(res);
                if(res.errno==0){
                    Dialog.showSuccess("修改成功", "");
                    row.data(param).draw(false);
                }else{
                    Dialog.showError(res.msg, "修改失败");
                }
            });
        }

        var cancel_button_onclick = function(evt) {
            var that = $(evt.target);
            var dt = $('#myDataTable').DataTable();
            var row = dt.row(that.parents("tr"));
            row.data(row.data()).draw(false);
        }

        var print_onclick = function(){
            console.log("print_onclick");
//            var dt = $('#myDataTable').DataTable();
//            dt.buttons.exportData();
            $(".dt-buttons .buttons-print").click();
        }

        var excel_onclick = function(){
            console.log("excel_onclick");
            $(".dt-buttons .buttons-excel").click();
        }

        var csv_onclick = function(){
            console.log("csv_onclick");
            $(".dt-buttons .buttons-csv").click();
        }

        var pdf_onclick = function(){
            console.log("pdf_onclick");
            $(".dt-buttons .buttons-pdf").click();
        }

        var sta_onclick = function(evt){
            console.log("sta_onclick");
            window.location.href = "<%=request.getContextPath()%>/userinfo/statistics.jsp";
        }

        return {
            init: function(){
                initDataTable();
                FormQuery.init();
                FormAdd.init();
                FormSort.init();
                addEventListener();
            },
            fetchResult: fetchResult
        };

    }();
</script>