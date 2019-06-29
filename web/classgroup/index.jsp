<%--
  Created by IntelliJ IDEA.
  User: silenus
  Date: 2019/6/16
  Time: 21:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    session.setAttribute("guid", "7");
    session.setAttribute("username", "wkb");
    session.setAttribute("email", "var_emailbox@qq.com");
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
                    <li class="breadcrumb-item active">分组管理</li>
                </ol>
            </div>
        </div>
        <!-- End Bread crumb -->

        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <label id="fold-btn"> <a class="nav-link" href="#"><span><i id="fold-icon" style="font-size:20px" class="fa fa-angle-down"></i></span></a> </label>
                        <li class="nav-item"> <a class="nav-link" data-toggle="tab" href="#tab-query" role="tab"><span class="hidden-sm-up"><i class="fa fa-search"></i></span> <span class="hidden-xs-down">查询</span></a> </li>
                        <li class="nav-item"> <a class="nav-link" data-toggle="tab" href="#tab-add" role="tab"><span class="hidden-sm-up"><i class="fa fa-plus"></i></span> <span class="hidden-xs-down">添加</span></a> </li>
                        <li class="nav-item"> <a class="nav-link" data-toggle="tab" href="#tab-sort" role="tab"><span class="hidden-sm-up"><i class="fa fa-sort-alpha-asc"></i></span> <span class="hidden-xs-down">排序</span></a> </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                                <span class="hidden-sm-up"><i class="fa fa-ellipsis-h"></i></span> <span class="hidden-xs-down">更多</span>
                            </a>
                            <div class="dropdown-menu">
                                <span class="dropdown-item" id="tab-print" role="tab">打印</span>
                                <span class="dropdown-item" id="tab-excel" role="tab">导出为Excel</span>
                                <span class="dropdown-item" id="tab-csv" role="tab">导出为CSV</span>
                            </div>
                        </li>
                    </ul>
                    <div id="tab-content" class="tab-content tabcontent-border p-20" style="display: none;">
                        <div role="tabpanel" class="tab-pane active" id="tab-query">
                            <%@include file="form_query.jsp"%>
                        </div>
                        <div class="tab-pane" id="tab-add" role="tabpanel">
                            <%@include file="form_add.jsp"%>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="tab-sort">
                            <%@include file="form_sort.jsp"%>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">分组列表</h4>
                    <div class="table-responsive m-t-40">
                        <table id="myDataTable" class="display nowrap table table-hover table-bordered" cellspacing="2px" width="100%">
                            <thead>
                            <tr>
                                <th>操作</th>
                                <th>组ID</th>
                                <th>分组名称</th>
                                <th>所有者ID</th>
                                <th>所有者用户名</th>
                                <th>所有者邮箱</th>
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
<%@include file="../js/classgroup/index_js.jsp"%>
</body>

</html>
<script type="text/javascript">
    jQuery(document).ready(function() {
        TabView.init();
        MobileClass.init();
        Page.init();
    });
</script>