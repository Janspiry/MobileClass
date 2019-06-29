<%--
  Created by IntelliJ IDEA.
  User: silenus
  Date: 2019/6/29
  Time: 17:01
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script type="text/javascript">

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

    var Page = function(){

        var initDataTable = function(){
            var dataTable=$('#myDataTable').DataTable({
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
                                            "<button type='button' class='delete-button btn btn-info btn-sm btn-rounded m-b-10 m-l-5'>删除</button>"
                                    return sReturn;
                                },
                    },
                    {
                        "targets":1,
                        "data": "username",
                        "orderable": false
                    },
                    {
                        "targets":2,
                        "data": "fullname",
                        "orderable": false
                    },
                    {
                        "targets":3,
                        "data": "gender",
                        "orderable": false,
                        "mRender":function(data,type,full){
                            var res="null";
                            if(data===1)res="男";
                            else if(data===2)res="女";
                            return res;
                        }
                    },
                    {
                        "targets":4,
                        "data": "schoolnum",
                        "orderable":false,
                    },
                    {
                        "targets":5,
                        "data": "email",
                        "orderable": false,
                    },
                    {
                        "targets":6,
                        "data": "phone",
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

        var delete_button_onclick = function(evt){
            var node=$(evt.target).parents('tr');
            var table=$('#myDataTable').DataTable();
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
                FormAdd.init();
                addEventListener();
            },
            fetchResult: fetchResult
        };

    }();

</script>