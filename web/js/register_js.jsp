<%--
  Created by IntelliJ IDEA.
  User: silenus
  Date: 2019/6/12
  Time: 23:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script type="text/javascript">
    var Page = function()
    {
        var renderSelect = function(){
            var color='rgb(108,137,191)';
            $('.form-group').find('select').css('color',color);
            $('.form-group').find('select').change(function(){
                console.log($(this).val());
               if($(this).val()==='0') {
                   $(this).css('color', color);
               }
                else{
                   $(this).css('color', 'black');
               }
            });
        }

        var bindValidation = function(){

            $.validator.addMethod("id",function(value,element,params){
                var checkId = /^[_a-zA-Z0-9]+$/;
                return this.optional(element)||(checkId.test(value));
            },"ID格式不正确");

            $.validator.addMethod("id_zh",function(value,element,params){
                var checkIdzh = /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/;
                return this.optional(element)||(checkIdzh.test(value));
            },"中文ID格式不正确");

            $(".register-form").validate({
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
                    rpassword: {
                        equalTo: "#register_password"
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
                    tnc: {
                        required: true
                    }
                },

                messages: { // custom messages for radio buttons and checkboxes
                    username: {
                        id: "用户名只能包含英文、数字、下划线",
                        required: "请输入用户名"
                    },
                    password: {
                        required: "请输入密码",
                        rangelength: "密码长度必须在4~20字符之间"
                    },
                    rpassword: {
                        equalTo: "两次输入的密码不一致"
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
                        id: "学号只能包含英文、数字、下划线",
                        required: "请输入学号"
                    },
                    nativeplace: {
                        id_zh: "籍贯只能包含英文、数字、下划线、中文",
                        required: "请输入籍贯"
                    },
                    tnc: {
                        required: "请先同意条款"
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
                    if (element.attr("name") == "tnc") { // insert checkbox errors after the container
                        error.insertAfter($('#register_tnc'));
                    } else {
                        error.insertAfter(element);
                    }
                },

                submitHandler: function(form) {
                    console.log("submitHandler");
                    register_btn_onClick();
                }
            });
        };

        var register_btn_onClick = function() {
            if(!$("#reg_form").valid())return;
            url = "<%=request.getContextPath()%>/AccountAction?action=register";
            url += "&username="+reg_form.username.value;
            url += "&password="+reg_form.password.value;
            url += "&email="+reg_form.email.value;
            url += "&phone="+reg_form.phone.value;
            url += "&fullname="+reg_form.fullname.value;
            url += "&gender="+reg_form.gender.value;
            url += "&schoolnum="+reg_form.schoolnum.value;
            url += "&nativeplace="+reg_form.nativeplace.value;
            console.log(url);
            $.post(url, function(result){
                console.log("register callback");
                console.log("result");
                if(result.register_errno == 0)
                {
                    alert("注册成功");
                    window.location.href="login.jsp";
                }
                else {
                    alert(result.register_msg);
                }
            });
        };

        var addEventListener = function() {
//            $('#register-btn').click(register_btn_onClick);
        };

        return {
            init: function(){
                renderSelect();
                bindValidation();
                addEventListener();
            }
        };
    }();
</script>
