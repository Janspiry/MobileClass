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
        var bindValidation = function(){
            $(".register-form").validate({
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
                    tnc: {
                        required: true
                    }
                },

                messages: { // custom messages for radio buttons and checkboxes
                    username: {
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
                        required: "请输入学号"
                    },
                    nativeplace: {
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
                if(result.errno == 0)
                {
                    alert("注册成功");
                    window.location.href="login.jsp";
                }
                else {
                    alert(result.msg);
                }
            });
        };

        var addEventListener = function() {
            $('#register-btn').click(register_btn_onClick);
        };

        return {
            init: function(){
                bindValidation();
            }
        };
    }();
</script>
