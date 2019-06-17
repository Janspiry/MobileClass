<%--
  Created by IntelliJ IDEA.
  User: silenus
  Date: 2019/6/12
  Time: 20:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input type="hidden" id="ContextPath" name="ContextPath" value="<%=request.getContextPath()%>" />
<%--<%@include file="js/check_login.jsp"%>--%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Favicon icon -->
    <link rel="icon" type="../../image/png" sizes="16x16" href="../../images/favicon.png">
    <title>移动互动课堂 | 问卷管理</title>
    <!-- Custom CSS -->
    <link href="../../css/lib/amchart/export.css" rel="stylesheet">
    <link href="../../css/lib/owl.carousel.min.css" rel="stylesheet" />
    <link href="../../css/lib/owl.theme.default.min.css" rel="stylesheet" />
    <link href="../../css/style.css" rel="stylesheet">
</head>

<body class="header-fix fix-sidebar">
<!-- Main wrapper  -->
<div id="main-wrapper">
    <%@include file="../../page_header.jsp"%>
    <%@include file="../../page_sidebar_menu.jsp"%>
    <!-- Page wrapper  -->
    <div class="page-wrapper">
        <!-- Bread crumb -->
        <div class="row page-titles">
            <div class="col-md-5 align-self-center"></div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">移动互动课堂</a></li>
                    <li class="breadcrumb-item active">问卷管理</li>
                </ol>
            </div>
        </div>
        <!-- End Bread crumb -->
        <!-- Container fluid  -->
        <div class="container-fluid">
            <!-- Start Page Content -->

            <form  role="form" id="page_form" name="page_form" action="add_record">
                <div class="row">
                    <div class="col-md-12 ">
                        <div class="form-group">
                            <label>问卷名</label>
                            <input type="text" id="title" name="title" class="form-control">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 ">
                        <div class="form-group">
                            <label class="control-label">截止日期</label>
                            <input type="date" id="limit_time" name="limit_time" class="form-control">
                        </div>
                    </div>
                </div>
            </form>
            <button type="button" id="add_new" class="btn btn-default m-b-10">增加问题</button>
            <button type="button" id="submit_button" class="btn btn-primary m-b-10 m-l-5">发布问卷</button>
            <button type="button" id="return_button" class="btn btn-success m-b-10 m-l-5">取消发布</button>
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">新建问卷</h4>
                                <h6 class="card-subtitle">编辑你要发布的问题</h6>
                                <div class="table-responsive m-t-40">
                                    <table id="example23" class="display nowrap table table-hover table-striped table-bordered" cellspacing="0" width="100%">
                                        <thead>
                                        <tr>
                                            <th>问题</th>
                                            <th>操作</th>
                                            <th>问题</th>

                                        </tr>
                                        </thead>

                                        <tbody>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>




            <!-- End PAge Content -->
        </div>
        <!-- End Container fluid  -->
        <%@include file="../../page_footer.jsp"%>
    </div>
    <!-- End Page wrapper  -->
</div>
<!-- End Wrapper -->
<%@include file="../../page_js.jsp"%>
<%@include file="../../js/mobileclass.jsp"%>


<script src="<%=request.getContextPath()%>/js/lib/datatables/datatables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/lib/datatables/cdn.datatables.net/buttons/1.2.2/js/dataTables.buttons.min.js"></script>
<script src="<%=request.getContextPath()%>/js/lib/datatables/cdn.datatables.net/buttons/1.2.2/js/buttons.flash.min.js"></script>
<script src="<%=request.getContextPath()%>/js/lib/datatables/cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>
<script src="<%=request.getContextPath()%>/js/lib/datatables/cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/pdfmake.min.js"></script>
<script src="<%=request.getContextPath()%>/js/lib/datatables/cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/vfs_fonts.js"></script>
<script src="<%=request.getContextPath()%>/js/lib/datatables/cdn.datatables.net/buttons/1.2.2/js/buttons.html5.min.js"></script>
<script src="<%=request.getContextPath()%>/js/lib/datatables/cdn.datatables.net/buttons/1.2.2/js/buttons.print.min.js"></script>


<script src="<%=request.getContextPath()%>/js/questionnaire/publish/questionnaire_add.js"></script>
<%--<script src="<%=request.getContextPath()%>/js/lib/atatables/datatables-init.js"></script>--%>

</body>

</html>
<script type="text/javascript">
    jQuery(document).ready(function() {
        MobileClass.init();
    });
</script>