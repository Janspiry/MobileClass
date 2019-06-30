<%--
  Created by IntelliJ IDEA.
  User: silenus
  Date: 2019/6/29
  Time: 16:48
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
%>

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
    <%--<title>移动互动课堂 | 用户信息管理</title>--%>
    <%@include file="../page_css.jsp"%>
</head>

<body class="header-fix fix-sidebar">
<!-- Main wrapper  -->
<div id="main-wrapper">
    <%@include file="../page_header.jsp"%>
    <%@include file="../page_sidebar_menu.jsp"%>
    <!-- Page wrapper  -->
    <div class="page-wrapper">
        <!-- Bread crumb -->
        <div class="row page-titles">
            <div class="col-md-5 align-self-center"></div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/index.jsp">移动互动课堂</a></li>
                    <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/classgroup/index.jsp">分组管理</a></li>
                    <li class="breadcrumb-item active">分组成员</li>
                </ol>
            </div>
        </div>
        <!-- End Bread crumb -->

        <div class="container-fluid">
            <button type="button" onclick="javascript: window.location.href='<%=request.getContextPath()%>/classgroup/index.jsp'" class="btn btn-success m-b-10 m-l-5">返回</button>
        </div>

        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <label id="fold-btn"> <a class="nav-link" href="#"><span><i id="fold-icon" style="font-size:20px" class="fa fa-angle-down"></i></span></a> </label>
                        <li class="nav-item"> <a class="nav-link" data-toggle="tab" href="#tab-add" role="tab"><span class="hidden-sm-up"><i class="fa fa-plus"></i></span> <span class="hidden-xs-down">添加</span></a> </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                                <span class="hidden-sm-up"><i class="fa fa-ellipsis-h"></i></span> <span class="hidden-xs-down">更多</span>
                            </a>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" id="tab-sta" role="tab" data-toggle="modal">统计</a>
                            </div>
                        </li>
                    </ul>
                    <div id="tab-content" class="tab-content tabcontent-border p-20" style="display: none;">
                        <div class="tab-pane" id="tab-add" role="tabpanel">

                            <form id="form-add" method="post" action="#" class="form-horizontal">
                                <div class="form-body">
                                    <input type="hidden" id="group_id" name="group_id" value="<%=request.getParameter("group_id")%>">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group row">
                                                <label class="control-label text-right col-md-3">所有者</label>
                                                <div class="col-md-9">
                                                    <select id="id_or_email" name="id_or_email" class="form-control">
                                                        <option value='email'>邮箱</option>
                                                        <option value='owner_id'>ID</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group row">
                                                <label class="control-label text-right col-md-3"></label>
                                                <div class="col-md-9">
                                                    <input name="owner" type="text" class="form-control" placeholder="所有者ID或邮箱">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <hr>
                                <div class="form-actions">
                                    <div class="row">
                                        <div class="col-md-4"></div>
                                        <button type="button" id="form-add-submit" class="col-md-2 btn btn-success">添加</button>
                                        <button type="button" id="form-add-reset" class="col-md-2 btn btn-inverse" style="margin-left: 20px;">清空</button>
                                    </div>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">成员列表</h4>
                    <h6 class="card-title">当前分组：<%=request.getParameter("group_name")%></h6>
                    <div class="table-responsive m-t-40">
                        <table id="myDataTable" class="display nowrap table table-hover table-bordered" cellspacing="2px" width="100%">
                            <thead>
                            <tr>
                                <th>user_id</th>
                                <th>操作</th>
                                <th>用户名</th>
                                <th>姓名</th>
                                <th>性别</th>
                                <th>学号</th>
                                <th>邮箱</th>
                                <th>电话</th>
                            </tr>
                            </thead>

                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="../page_footer.jsp"%>
    </div>
    <!-- End Page wrapper  -->
</div>
<!-- End Wrapper -->

<%@include file="../page_js.jsp"%>
<script src="<%=request.getContextPath()%>/js/lib/datatables/datatables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/lib/datatables/cdn.datatables.net/buttons/1.2.2/js/dataTables.buttons.min.js"></script>
<script src="<%=request.getContextPath()%>/js/lib/datatables/cdn.datatables.net/buttons/1.2.2/js/buttons.flash.min.js"></script>
<script src="<%=request.getContextPath()%>/js/lib/datatables/cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>
<script src="<%=request.getContextPath()%>/js/lib/datatables/cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/pdfmake.min.js"></script>
<script src="<%=request.getContextPath()%>/js/lib/datatables/cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/vfs_fonts.js"></script>
<script src="<%=request.getContextPath()%>/js/lib/datatables/cdn.datatables.net/buttons/1.2.2/js/buttons.html5.min.js"></script>
<script src="<%=request.getContextPath()%>/js/lib/datatables/cdn.datatables.net/buttons/1.2.2/js/buttons.print.min.js"></script>

<script src="../js/tabview.js"></script>
<%@include file="../js/mobileclass.jsp"%>
<%@include file="../js/classgroup/member_js.jsp"%>
</body>

</html>
<script type="text/javascript">
    jQuery(document).ready(function() {
        TabView.init();
        MobileClass.init();
        Page.init();
    });
</script>