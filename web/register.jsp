<%--
  Created by IntelliJ IDEA.
  User: silenus
  Date: 2019/6/12
  Time: 22:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="images/favicon.png">
    <title>移动互动课堂 | 注册</title>
    <!-- Custom CSS -->

    <link href="css/style.css" rel="stylesheet">
    <style>
        .form-group select option{
            color:black;
        }
    </style>
</head>

<body class="header-fix fix-sidebar">

<!-- Main wrapper  -->
<div id="main-wrapper">

    <div class="unix-login">
        <div class="container-fluid">
            <div class="row justify-content-center">
                <div class="col-lg-4">
                    <div class="login-content card">
                        <div class="login-form">
                            <h4>注册</h4>
                            <form id="reg_form" class="register-form" method="post">
                                <input type="hidden" name="action" value="register">
                                <div class="form-group">
                                    <label>用户名</label>
                                    <input name="username" type="text" class="form-control" placeholder="User Name">
                                </div>
                                <div class="form-group">
                                    <label>密码</label>
                                    <input name="password" id="register_password" type="password" class="form-control" placeholder="Password">
                                </div>
                                <div class="form-group">
                                    <label>确认密码</label>
                                    <input name="rpassword" type="password" class="form-control" placeholder="Repeat Password">
                                </div>
                                <div class="form-group">
                                    <label>邮箱</label>
                                    <input name="email" type="text" class="form-control" placeholder="Email Address">
                                </div>
                                <div class="form-group">
                                    <label>电话</label>
                                    <input name="phone" type="text" class="form-control" placeholder="Phone Number">
                                </div>
                                <div class="form-group">
                                    <label>姓名</label>
                                    <input name="fullname" type="text" class="form-control" placeholder="Full Name">
                                </div>
                                <div class="form-group">
                                    <label>性别</label>
                                        <select class="form-control" name="gender">
                                            <option value="0">-- Gender --</option>
                                            <option value="1">男</option>
                                            <option value="2">女</option>
                                        </select>
                                </div>
                                <div class="form-group">
                                    <label>学号</label>
                                    <input name="schoolnum" type="text" class="form-control" placeholder="School Number">
                                </div>
                                <div class="form-group">
                                    <label>籍贯</label>
                                    <input name="nativeplace" type="text" class="form-control" placeholder="Native Place">
                                </div>
                                <div class="checkbox">
                                    <label id="register_tnc">
                                        <input name="tnc" type="checkbox"> 同意xxx条款
                                    </label>
                                </div>
                                <button id="register-btn" type="submit" class="btn btn-primary btn-flat m-b-30 m-t-30">提交</button>
                                <div class="register-link m-t-15 text-center">
                                    <p>已经有账号？<a href="login.jsp"> 点这里登录</a></p>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<!-- End Wrapper -->
<!-- All Jquery -->
<script src="js/lib/jquery/jquery.min.js"></script>
<!-- Bootstrap tether Core JavaScript -->
<script src="js/lib/bootstrap/js/popper.min.js"></script>
<script src="js/lib/bootstrap/js/bootstrap.min.js"></script>
<!-- slimscrollbar scrollbar JavaScript -->
<script src="js/jquery.slimscroll.js"></script>
<!--Menu sidebar -->
<script src="js/sidebarmenu.js"></script>
<!--stickey kit -->
<script src="js/lib/sticky-kit-master/dist/sticky-kit.min.js"></script>
<!--Custom JavaScript -->
<script src="js/custom.min.js"></script>
<script src="js/lib/jquery/jquery.validate.min.js"></script>
<%@include file="js/register_js.jsp"%>
</body>

</html>
<script type="text/javascript">
    jQuery(document).ready(function() {
        Page.init();
    });
</script>