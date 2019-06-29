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

//        $.validator.addMethod("group",function(value,element,params){
//            if(value==null || value.length==0)return true;
//            var input = $('input[group='+params+']');
//            $.each(input, function(i, val){
//                console.log(i, val);
//            });
//        },"同组字段必须同时填写");
//
//        $.validator.addMethod("greaterThan",function(value,element,params){
//            console.log('validator group');
//            console.log(value);
//            console.log(element);
//            console.log(params);
//            return true;
//        },"该字段必须大于");

        var bindValidation = function(){
            $("#form-query").validate({
                errorElement: 'span', //default input error message container
                errorClass: 'color-danger', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
//                onsubmit: false,
                ignore: "",
                rules: {
                    guid: {
                      number: true
                    },
                    username: {
                        id: true
                    },
                    email: {
                        email: true
                    },
//                    create_time_from: {
//                        group: 'create_time_group'
//                    },
//                    create_time_to: {
//                        group: 'create_time_group',
//                        greaterThan: '#create_time_from'
//                    }
                },

                messages: { // custom messages for radio buttons and checkboxes
                    guid: {
                        number: "不是有效的GUID"
                    },
                    username: {
                        id: "用户名只能包含字母、数字、下划线"
                    },
                    email: {
                        email: "邮箱格式不正确"
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
                    alert("submitHandler");
//                    submitForm_onClick();
                }
            });
        };

        var addEventListener = function(){
            $('#form-query-submit').click(btnSubmit_onclick);
            $('#form-query-reset').click(btnReset_onclick);
        }

        var btnSubmit_onclick = function(){
            if(!$('#form-query').valid())return;
            url = "<%=request.getContextPath()%>/AuthorizationAction?action=query";
            var form=document.getElementById("form-query");
            var t1=form.create_time_from.value;
            var t2=form.create_time_to.value;
            var t3=form.modify_time_from.value;
            var t4=form.modify_time_to.value;
            if(t1.length>0 && t2.length>0 && t1>t2 || t3.length>0 && t4.length>0 && t3>t4){
                Dialog.showWarning("开始日期不能大于结束日期", "警告");
                return;
            }
            if(((t1.length>0)^(t2.length>0))>0 || ((t3.length>0)^(t4.length>0))>0){
                Dialog.showWarning("开始日期和结束日期必须同时填写", "警告");
                return;
            }
            var param = {
                "guid": form.guid.value,
                "username": form.username.value,
                "email": form.email.value,
                "authorization": form.authorization.value,
                "create_time_from": form.create_time_from.value,
                "create_time_to": form.create_time_to.value,
                "modify_time_from": form.modify_time_from.value,
                "modify_time_to": form.modify_time_to.value,
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

        var btnReset_onclick = function(){
            console.log('btnReset_onclick');
            $('#form-query').find('input').val('');
            $('#form-query').find('select').val('0');
            url = "<%=request.getContextPath()%>/AuthorizationAction?action=clearQuery";
            $.post(url, function(){
                Page.fetchResult();
            })
        }

        return {
            init: function(){
                bindValidation();
                addEventListener();
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
                    email: {
                        required: true,
                        email: true
                    },
                    authorization: {
                        min: 1
                    }
                },

                messages: { // custom messages for radio buttons and checkboxes
                    username: {
                        id: "用户名只能包含字母、数字、下划线",
                        required: "请输入用户名"
                    },
                    email: {
                        required: "请输入邮箱",
                        email: "邮箱格式不正确"
                    },
                    authorization: {
                        min: "请选择权限"
                    }
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

                }
            });
        };

        var addEventListener = function(){
            $('#form-add-submit').click(btnSubmit_onclick);
            $('#form-add-reset').click(btnReset_onclick);
        }

        var btnSubmit_onclick = function() {
            if(!$("#form-add").valid())return;
            url = "<%=request.getContextPath()%>/AccountAction?action=register";
            var form=document.getElementById("form-add");
            var param = {
                "username": form.username.value,
                "email": form.email.value,
                "authorization": form.authorization.value,
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

        var btnReset_onclick = function(){
            console.log('btnReset_onclick');
            $('#form-add').find('input').val('');
            $('#form-add').find('select').val('0');
        }

        return {
            init: function(){
                bindValidation();
                addEventListener();
            }
        };

    }();

    var FormSort = function(){

        var choice = [
            ['guid','GUID'],
            ['username','用户名'],
            ['fullname','姓名'],
            ['authorization','权限'],
            ['create_time','创建时间'],
            ['modify_time','修改时间'],
        ];

        var addEventListener = function(){
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
            var url = "<%=request.getContextPath()%>/AuthorizationAction?action=sort";
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
            var url = "<%=request.getContextPath()%>/AuthorizationAction?action=clearSort";
            $.post(url, function(){
                Page.fetchResult();
            })
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
            $('#form-sort-rule').html("<div class='dd-empty'></div>");
            html="";
            for(var i=0;i<choice.length;i++){
                html+=String.format(li, choice[i][0], choice[i][1]);
            }
            $('#form-sort-choice').html(pref+html+suff);
            $('.btn-dark').click(btnOrder_onclick);
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

    var DatetimePicker = function(){
        var initDatetimePicker = function(){
            $('.datetime-picker').datetimepicker({
                format: "yyyy-mm-dd hh:ii:ss",
                autoclose: true,
                todayBtn: true,
                minuteStep: 5
            });
        }

        return {
            init: function(){
                initDatetimePicker();
            }
        }
    }();

    var Page = function(){

        var initDataTable = function(){
            var dataTable=$('#myDataTable').DataTable({
                dom: 'Bfrtip',
                buttons:[
                    {
                        extend: 'print',
                        className: 'buttons-print hidden',
                        messageTop: '移动互动课堂 用户权限',
                        exportOptions: {
                            columns: [ 1,2,3,4,5,6 ]
                        }
                    },
                    {
                        extend: 'excel',
                        title: 'authorization_export',
                        className: 'buttons-excel hidden',
                        exportOptions: {
                            columns: [ 1,2,3,4,5,6 ]
                        }
                    },
                    {
                        extend: 'csv',
                        title: 'authorization_export',
                        className: 'buttons-csv hidden',
                        exportOptions: {
                            columns: [ 1,2,3,4,5,6 ]
                        }
                    },
                    {
                        extend: 'pdfHtml5',
                        title: 'authorization_export',
                        bom: true,
                        className: 'buttons-pdf hidden',
                        exportOptions: {
                            columns: [ 1,2,3,4,5,6 ]
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
                        "data": null,
                        "orderable": false,
                        "mRender":
                                function(data, type, full) {
                                    sReturn=
                                            "<button type='button' class='edit-button btn btn-success btn-sm btn-rounded m-b-10 m-l-5'>修改</button>"+
                                            "<button type='button' class='delete-button btn btn-info btn-sm btn-rounded m-b-10 m-l-5'>删除</button>"
                                    return sReturn;
                                },
                    },
                    {
                        "targets":1,
                        "data": "guid",
                        "orderable": false
                    },
                    {
                        "targets":2,
                        "data": "username",
                        "orderable": false
                    },
                    {
                        "targets":3,
                        "data": "email",
                        "orderable": false
                    },
                    {
                        "targets":4,
                        "data": "authorization",
                        "orderable":false,
                        "mRender":function(data,type,full){
                            var res="null";
                            if((data & 8) > 0)res="开发者";
                            else if((data & 4) > 0)res="管理员";
                            else if((data & 2) > 0)res="教师";
                            else if((data & 1) > 0)res="学生";
                            return res;
                        }
                    },
                    {
                        "targets":5,
                        "data": "create_time",
                        "orderable": false,
                        "mRender":function(data,type,full){
                            if(data==null)return '(null)';
                            else return data;
                        }
                    },
                    {
                        "targets":6,
                        "data": "modify_time",
                        "orderable": false,
                        "mRender":function(data,type,full){
                            if(data==null)return '(null)';
                            else return data;
                        }
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

        var delete_button_onclick = function(evt){
            var node=$(evt.target).parents('tr');
            var table=$('#myDataTable').DataTable();
            var id = table.row(node).data()['guid'];
            console.log("delete_button_onClick", id);
            Dialog.showComfirm("确定要删除这条记录吗？", "警告", function(){
                url="<%=request.getContextPath()%>/AuthorizationAction?action=delete";
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
                if(!(2<=i && i<=4))return true;
                var jqob = $(val);
                var put=null;
                if(i==4){
                    put=$("<select style='width: 100px;' class='form-control'>"
                          +"  <option value='1'>学生</option>"
                          +"  <option value='2'>教师</option>"
                          +"  <option value='4'>管理员</option>"
                          +"  <option value='8'>开发者</option>"
                          +"</select>");
                    var val="null";
                    if(jqob.text()=='学生')val="1";
                    else if(jqob.text()=='教师')val="2";
                    else if(jqob.text()=='管理员')val="4";
                    else if(jqob.text()=='开发者')val="8";
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
            var param = {
                "guid": row.data()['guid'],
                "create_time": row.data()['create_time'],
                "modify_time": row.data()['modify_time'],
            };
            param["username"] = tr.children().eq(2).children("input").val();
            param["email"] = tr.children().eq(3).children("input").val();
            param["authorization"] = parseInt(tr.children().eq(4).children("select").val());
            console.log(param);
            var url = "<%=request.getContextPath()%>/AuthorizationAction?action=update";
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
            window.location.href = "<%=request.getContextPath()%>/auth/statistics.jsp";
        }

        var fetchResult = function(){
            var dt = $('#myDataTable').DataTable();
            dt.clear().draw();
            var url="<%=request.getContextPath()%>/AuthorizationAction?action=getResult";
            $.post(url, function (json) {
                console.log(json);
                for (var i = 0; i < json.length; i++) {
                    var it=json[i];
                    dt.row.add(it).draw().node();
                }
            });
        };

        return {
            init: function(){
                initDataTable();
                FormQuery.init();
                FormAdd.init();
                FormSort.init();
                DatetimePicker.init();
                addEventListener();
            },
            fetchResult: fetchResult
        };

    }();

</script>