<%--
  Created by IntelliJ IDEA.
  User: silenus
  Date: 2019/6/12
  Time: 20:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input type="hidden" id="ContextPath" name="ContextPath" value="<%=request.getContextPath()%>" />
<input type="hidden" id="id" name="id" value="<%=request.getParameter("id")%>"/>
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
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">操作</h4>
                            <!-- Nav tabs -->
                            <div class="vtabs customvtab">
                                <ul class="nav nav-tabs tabs-vertical" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link active" data-toggle="tab" href="#messages3" role="tab">
                                            <span class="hidden-sm-up"></span>
                                            <span class="hidden-xs-down">其他</span>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link " data-toggle="tab" href="#home3" role="tab">
                                            <span class="hidden-sm-up"></span>
                                            <span class="hidden-xs-down">排序</span>
                                        </a>
                                    </li>
                                    <%--<li class="nav-item">--%>
                                        <%--<a class="nav-link" data-toggle="tab" href="#static3" role="tab">--%>
                                            <%--<span class="hidden-sm-up"></span>--%>
                                            <%--<span class="hidden-xs-down">统计</span>--%>
                                        <%--</a>--%>
                                    <%--</li>--%>
                                    <li class="nav-item">
                                        <a class="nav-link" data-toggle="tab" href="#profile3" role="tab">
                                            <span class="hidden-sm-up"></span>
                                            <span class="hidden-xs-down">查询</span>
                                        </a>
                                    </li>

                                </ul>
                                <!-- Tab panes -->
                                <div class="tab-content">

                                    <div class="tab-pane p-20" id="home3" role="tabpanel">
                                        <div class="row">

                                            <div class="col-lg-12">
                                                <label class="control-label">第一字段规则</label>
                                                <select id="rule1" data-placeholder="asc" tabindex="1">
                                                    <option value="asc" selected="selected">升序</option>
                                                    <option value="desc">降序</option>
                                                </select>
                                                <label class="control-label">第二字段规则</label>
                                                <select id="rule2"data-placeholder="asc" tabindex="2">
                                                    <option value="asc" selected="selected">升序</option>
                                                    <option value="desc">降序</option>
                                                </select>
                                                <label class="control-label">第三字段规则</label>
                                                <select id="rule3" data-placeholder="asc" tabindex="3">
                                                    <option value="asc" selected="selected">升序</option>
                                                    <option value="desc">降序</option>
                                                </select>

                                                <div class="form-group">
                                                    <label>字段选择</label>
                                                    <select id="key1" class="form-control">
                                                        <option value="create_time" selected="selected">首次提交时间</option>
                                                        <option value="change_time" >最后修改时间</option>
                                                        <option value="answer_num" >回答次数</option>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <select id="key2" class="form-control">
                                                        <option value="" selected="selected">请选择</option>
                                                        <option value="change_time" >最后修改时间</option>
                                                        <option value="create_time">首次提交时间</option>
                                                        <option value="answer_num" >回答次数</option>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <select id="key3" class="form-control">
                                                        <option value="" selected="selected">请选择</option>
                                                        <option value="answer_num" >回答次数</option>
                                                        <option value="create_time">首次提交时间</option>
                                                        <option value="change_time" >最后修改时间</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <button type="button" onclick="sortRecord()" class="btn btn-default btn-flat m-b-10">确认</button>
                                    </div>
                                    <div class="tab-pane  p-20" id="profile3" role="tabpanel">

                                            <div class="row">
                                                <div class="col-lg-auto">
                                                    <div class="card">
                                                        <div class="form-group">
                                                            <p class="text-muted m-b-15 f-s-12">用户名</p>
                                                            <input type="text" id="user_name" name="user_name" class="form-control input-focus" placeholder="输入用户名">
                                                        </div>
                                                    </div>
                                                </div>


                                            </div>
                                        <button type="button" onclick="searchRecord()" class="btn btn-default btn-flat m-b-10">查询</button>
                                            </div>
                                    <div class="tab-pane active" id="messages3" role="tabpanel">

                                        <div class="row">
                                            <div class="col-lg-12">
                                                    <div class="card-toggle-body">
                                                        <div class="button-list">
                                                            <div class="btn-group">
                                                                <button type="button" onclick="returnBack()" class="btn btn-pink btn-flat m-b-10 m-l-5">返回</button>
                                                                <button type="button" onclick="statisticRecord()" class="btn btn-success btn-flat  m-b-10 m-l-5">统计</button>
                                                                <button type="button" onclick="getAllRecord()" class="btn btn-primary btn-flat  m-b-10 m-l-5">所有记录</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                            </div>
                                        </div>
                                        <%--</div>--%>
                                        <%--<button type="button" class="btn btn-warning btn-flat m-b-10 m-l-5">Warning</button>--%>
                                        <%--<button type="button" class="btn btn-danger btn-flat m-b-10 m-l-5">Danger</button>--%>
                                        <%--<button type="button" class="btn btn-pink btn-flat m-b-10 m-l-5">Pink</button>--%>
                                        <%--<button type="button" class="btn btn-dark btn-flat m-b-10 m-l-5">Dark</button>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>




            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">问卷用户</h4>
                            <h6 class="card-subtitle">这是此用户所有回答的用户</h6>
                            <div class="table-responsive m-t-40">
                                <table id="example23" class="display nowrap table table-hover table-striped table-bordered" cellspacing="0" width="100%">
                                    <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>操作</th>
                                        <th>问卷名</th>
                                        <th>发布者</th>
                                        <th>首次回答时间</th>
                                        <th>最后修改时间</th>
                                        <th>回答次数</th>
                                        <th>回答用户</th>
                                    </tr>
                                    </thead>
                                    <tfoot>
                                    <tr>
                                        <th>ID</th>
                                        <th>操作</th>
                                        <th>问卷名</th>
                                        <th>发布者</th>
                                        <th>首次回答时间</th>
                                        <th>最后修改时间</th>
                                        <th>回答次数</th>
                                        <th>回答用户</th>
                                    </tr>
                                    </tfoot>
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


<script src="<%=request.getContextPath()%>/js/questionnaire/answer/user_list.js"></script>
<%--<script src="<%=request.getContextPath()%>/js/lib/atatables/datatables-init.js"></script>--%>

</body>

</html>
<script type="text/javascript">
    jQuery(document).ready(function() {
        MobileClass.init();
    });
</script>