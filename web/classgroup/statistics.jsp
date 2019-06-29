<%--
  Created by IntelliJ IDEA.
  User: silenus
  Date: 2019/6/26
  Time: 17:02
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <link rel="icon" type="../../image/png" sizes="16x16" href="<%=request.getContextPath()%>/images/favicon.png">
    <title>移动互动课堂 | 权限管理 | 统计</title>
    <!-- Custom CSS -->
    <link href="<%=request.getContextPath()%>/css/lib/amchart/export.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/css/lib/owl.carousel.min.css" rel="stylesheet" />
    <link href="<%=request.getContextPath()%>/css/lib/owl.theme.default.min.css" rel="stylesheet" />

    <link href="../../css/style.css" rel="stylesheet">
</head>

<body class="header-fix fix-sidebar">

<div id="main-wrapper">
    <%@include file="../page_header.jsp"%>
    <%@include file="../page_sidebar_menu.jsp"%>

    <div class="page-wrapper">

        <div class="row page-titles">
            <div class="col-md-5 align-self-center"></div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/index.jsp">移动互动课堂</a></li>
                    <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/auth/index.jsp">权限管理</a></li>
                    <li class="breadcrumb-item active">统计</li>
                </ol>
            </div>
        </div>

        <div class="container-fluid">
            <button type="button" onclick="returnBack()" class="btn btn-success m-b-10 m-l-5">返回</button>
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-title">
                            <h4>用户权限分布</h4>
                        </div>
                        <div class="card-body">
                            <div id="chartdiv"></div>
                        </div>
                    </div>
                </div>
            </div>
            <%--</form>--%>

            <!-- End PAge Content -->
        </div>
        <!-- End Container fluid  -->
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
<%@include file="../js/mobileclass.jsp"%>
<%@include file="../js/auth/statistics_js.jsp"%>

</body>

</html>
<script type="text/javascript">
    jQuery(document).ready(function() {
        MobileClass.init();
        Page.init();
    });
</script>