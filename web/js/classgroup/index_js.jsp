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
                    group_id: {
                      number: true
                    },
                    group_name: {
                        id_zh: true
                    },
                    owner_id: {
                        number: true
                    },
                    username: {
                        id: true
                    },
                    email: {
                        email: true
                    },
                },

                messages: { // custom messages for radio buttons and checkboxes
                    group_id: {
                        number: "不是有效的组ID"
                    },
                    group_name: {
                        id_zh: "分组名称只能包含字母、数字、下划线、中文"
                    },
                    owner_id: {
                        number: "不是有效的所有者ID"
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
            url = "<%=request.getContextPath()%>/ClassGroupAction?action=query";
            var form=document.getElementById("form-query");
            var param = {
                "group_id": form.group_id.value,
                "group_name": form.group_name.value,
                "owner_id": form.owner_id.value,
                "username": form.username.value,
                "email": form.email.value,
            };
            $.post(url, param, function(res){
                console.log("classgroup query callback");
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
            url = "<%=request.getContextPath()%>/ClassGroupAction?action=clearQuery";
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

        $.validator.addMethod("name",function(value,element,params){
            var checkId = /^[^/\\'"%&\$\<\>]+$/;
            return this.optional(element)||(checkId.test(value));
        },"名称包含非法字符");

        $.validator.addMethod("owner_id",function(value,element,params){
            if($('#id_or_email').val()!='owner_id')return true;
            var checkId = /^[1-9][0-9]*$/;
            return this.optional(element)||(checkId.test(value));
        },"所有者ID格式不正确");

        $.validator.addMethod("owner_email",function(value,element,params){
            if($('#id_or_email').val()!='email')return true;
            var checkId = /^[_a-zA-Z0-9]+@[_a-zA-Z0-9]+(\.com)?$/;
            return this.optional(element)||(checkId.test(value));
        },"所有者邮箱格式不正确");

        var bindValidation = function(){
            $("#form-add").validate({
                errorElement: 'span', //default input error message container
                errorClass: 'color-danger', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                    group_name: {
                        name: true,
                        required: true
                    },
                    owner: {
                        required: true,
                        owner_id: true,
                        owner_email: true
                    },
                },

                messages: { // custom messages for radio buttons and checkboxes
                    group_name: {
                        required: "请输入分组名称"
                    },
                    owner: {
                        required: "请输入所有者ID或邮箱",
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

                }
            });
        };

        var addEventListener = function(){
            $('#form-add-submit').click(btnSubmit_onclick);
            $('#form-add-reset').click(btnReset_onclick);
        }

        var btnSubmit_onclick = function() {
            if(!$("#form-add").valid())return;
            url = "<%=request.getContextPath()%>/ClassGroupAction?action=add";
            var form=document.getElementById("form-add");
            var param = {
                "group_name": form.group_name.value,
                "id_or_email": form.id_or_email.value,
                "owner": form.owner.value,
            };
            $.post(url, param, function(res){
                console.log("register callback");
                console.log(res);
                if(res.errno == 0)
                {
                    Dialog.showSuccess("分组添加成功", "操作成功");
                    Page.fetchResult();
                }
                else {
                    Dialog.showError(res.msg, "错误");
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
            ['classgroup.group_id','组ID'],
            ['classgroup.group_name','分组名称'],
            ['classgroup.owner_id','所有者ID'],
            ['userinfo.username','用户名'],
            ['userinfo.email','邮箱'],
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
                rule += $(val).attr("data-id");
                if($(val).find('i').hasClass('fa fa-sort-amount-asc')){
                    rule += ' asc';
                }else{
                    rule += ' desc';
                }
            });
            console.log(rule);
            var url = "<%=request.getContextPath()%>/ClassGroupAction?action=sort";
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
            var url = "<%=request.getContextPath()%>/ClassGroupAction?action=clearSort";
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

    var Page = function(){

        var initDataTable = function(){
            var dataTable=$('#myDataTable').DataTable({
                dom: 'Bfrtip',
                buttons:[
                    {
                        extend: 'print',
                        className: 'buttons-print hidden',
                        messageTop: '移动互动课堂 分组管理',
                        exportOptions: {
                            columns: [ 1,2,3,4,5 ]
                        }
                    },
                    {
                        extend: 'excel',
                        title: 'classgroup_export',
                        className: 'buttons-excel hidden',
                        exportOptions: {
                            columns: [ 1,2,3,4,5 ]
                        }
                    },
                    {
                        extend: 'csv',
                        title: 'classgroup_export',
                        className: 'buttons-csv hidden',
                        exportOptions: {
                            columns: [ 1,2,3,4,5 ]
                        }
                    },
                    {
                        extend: 'pdfHtml5',
                        title: 'classgroup_export',
                        bom: true,
                        className: 'buttons-pdf hidden',
                        exportOptions: {
                            columns: [ 1,2,3,4,5 ]
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
                                            "<button type='button' class='member-button btn btn-primary btn-sm btn-rounded m-b-10 m-l-5'>成员</button>"+
                                            "<button type='button' class='edit-button btn btn-success btn-sm btn-rounded m-b-10 m-l-5'>修改</button>"+
                                            "<button type='button' class='delete-button btn btn-info btn-sm btn-rounded m-b-10 m-l-5'>删除</button>"
                                    return sReturn;
                                },
                    },
                    {
                        "targets":1,
                        "data": "group_id",
                        "orderable": false
                    },
                    {
                        "targets":2,
                        "data": "group_name",
                        "orderable": false
                    },
                    {
                        "targets":3,
                        "data": "owner_id",
                        "orderable": false
                    },
                    {
                        "targets":4,
                        "data": "username",
                        "orderable":false,
                    },
                    {
                        "targets":5,
                        "data": "email",
                        "orderable": false,
                    },
                ],
                "aLengthMenu": [[10,20,50,-1],[10,20,50,"所有记录"]],
            });
            fetchResult();
        };

        var addEventListener = function(){
            $("#myDataTable tbody").on("click", ".member-button", member_button_onclick);
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

        var member_button_onclick = function(evt){
            var that = $(evt.target);
            var dt = $('#myDataTable').DataTable();
            var data = dt.row(that.parents("tr")).data();
            if("<%=session.getAttribute("guid")%>" != data["owner_id"].toString()){
                Dialog.showWarning("你不是该组的所有者", "警告");
                return;
            }else{
                sendRedirect("<%=request.getContextPath()%>/classgroup/member.jsp", {
                    "group_id": data["group_id"],
                    "group_name": data["group_name"]
                });
                <%--window.location.href = "<%=request.getContextPath()%>/classgroup/member.jsp?" +--%>
                <%--"group_id=" + data["group_id"] +--%>
                <%--"&group_name=" + data["group_name"];--%>
            }
        }

        var delete_button_onclick = function(evt){
            var node=$(evt.target).parents('tr');
            var table=$('#myDataTable').DataTable();
            var data = table.row(node).data();
            if("<%=session.getAttribute("guid")%>" != data["owner_id"].toString()) {
                Dialog.showWarning("你不是该组的所有者", "警告");
                return;
            }
            var id = table.row(node).data()['group_id'];
            console.log("delete_button_onClick", id);
            Dialog.showComfirm("确定要删除这条记录吗？", "警告", function(){
                url="<%=request.getContextPath()%>/ClassGroupAction?action=delete";
                param={
                    "group_id": id
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
            var dt = $('#myDataTable').DataTable();
             data = dt.row($(evt.target).parents("tr")).data();
            if("<%=session.getAttribute("guid")%>" != data["owner_id"].toString()){
                Dialog.showWarning("你不是该组的所有者", "警告");
                return;
            }
            var that = $(evt.target);
            var tds = that.parents("tr").children();
            $.each(tds, function (i, val) {
                if(i<2 || i==3 || i==4)return true;
                var jqob = $(val);
                var put=null;
                put=$("<input type='text'>");
                put.val(jqob.text());
                jqob.html(put);
            });
            that.html("保存");
            that.removeClass("edit-button");
            that.addClass("save-button");
            var btnDelete = that.siblings(".delete-button");
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
                "group_id": row.data()['group_id'],
            };
            param["group_name"] = tr.children().eq(2).children("input").val();
            param["email"] = tr.children().eq(5).children("input").val();
            console.log(param);
            var url = "<%=request.getContextPath()%>/ClassGroupAction?action=update";
            $.post(url, param, function(res){
                console.log("save_button_onclick callback");
                console.log(res);
                if(res.errno==0){
                    Dialog.showSuccess("修改成功", "");
                    param["owner_id"]=res.owner_id;
                    param["username"]=res.username;
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
            window.location.href = "<%=request.getContextPath()%>/classgroup/statistics.jsp";
        }

        var fetchResult = function(){
            var dt = $('#myDataTable').DataTable();
            dt.clear().draw();
            var url="<%=request.getContextPath()%>/ClassGroupAction?action=getResult";
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
                addEventListener();
            },
            fetchResult: fetchResult
        };

    }();

</script>