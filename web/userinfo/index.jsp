<%--
  Created by IntelliJ IDEA.
  User: silenus
  Date: 2019/6/16
  Time: 21:13
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
    <link href="<%=request.getContextPath()%>/css/lib/nestable/nestable.css" rel="stylesheet">
    <title>移动互动课堂 | 用户信息管理</title>
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
                    <li class="breadcrumb-item"><a href="javascript:void(0)">移动互动课堂</a></li>
                    <li class="breadcrumb-item active">用户信息管理</li>
                </ol>
            </div>
        </div>
        <!-- End Bread crumb -->

        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <label id="fold-btn"> <a class="nav-link" href="#"><span><i id="fold-icon" style="font-size:20px" class="fa fa-angle-down"></i></span></a> </label>
                        <li class="nav-item"> <a class="nav-link" data-toggle="tab" href="#tab-query" role="tab"><span class="hidden-sm-up"><i class="ti-user"></i></span> <span class="hidden-xs-down">查询</span></a> </li>
                        <li class="nav-item"> <a class="nav-link" data-toggle="tab" href="#tab-add" role="tab"><span class="hidden-sm-up"><i class="ti-user"></i></span> <span class="hidden-xs-down">添加</span></a> </li>
                        <li class="nav-item"> <a class="nav-link" data-toggle="tab" href="#tab-sort" role="tab"><span class="hidden-sm-up"><i class="ti-user"></i></span> <span class="hidden-xs-down">排序</span></a> </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                                <span class="hidden-sm-up"><i class="ti-email"></i></span> <span class="hidden-xs-down">更多</span>
                            </a>
                            <div class="dropdown-menu"> <a class="dropdown-item" id="dropdown1-tab" href="#dropdown1" role="tab" data-toggle="tab" aria-controls="dropdown1">@fat</a> <a class="dropdown-item" id="dropdown2-tab" href="#dropdown2" role="tab" data-toggle="tab"
                                                                                                                                                                                         aria-controls="dropdown2">@mdo</a> </div>
                        </li>
                    </ul>
                    <div id="tab-content" class="tab-content tabcontent-border p-20" style="display: none;">
                        <div role="tabpanel" class="tab-pane active" id="tab-query">
                            <form id="form-query" action="#" class="form-horizontal">
                                <div class="form-body">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group row">
                                                <label class="control-label text-right col-md-3">用户名</label>
                                                <div class="col-md-9">
                                                    <input name="username" type="text" class="form-control" placeholder="User Name">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group row">
                                                <label class="control-label text-right col-md-3">籍贯</label>
                                                <div class="col-md-9">
                                                    <input name="nativeplace" type="text" class="form-control" placeholder="Native Place">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group row">
                                                <label class="control-label text-right col-md-3">姓名</label>
                                                <div class="col-md-9">
                                                    <input name="fullname" type="text" class="form-control" placeholder="Full Name">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group row">
                                                <label class="control-label text-right col-md-3">邮箱</label>
                                                <div class="col-md-9">
                                                    <input name="email" type="text" class="form-control" placeholder="Email">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group row">
                                                <label class="control-label text-right col-md-3">性别</label>
                                                <div class="col-md-9">
                                                    <select name="gender" class="form-control">
                                                        <option value="0">-- Gender --</option>
                                                        <option value="1">男</option>
                                                        <option value="2">女</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group row">
                                                <label class="control-label text-right col-md-3">电话</label>
                                                <div class="col-md-9">
                                                    <input name="phone" type="text" class="form-control" placeholder="Phone">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group row">
                                                <label class="control-label text-right col-md-3">学号</label>
                                                <div class="col-md-9">
                                                    <input name="schoolnum" type="text" class="form-control" placeholder="School Number">
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <hr>
                                <div class="form-actions">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                    <button type="submit" class="btn btn-success">查询</button>
                                                    <button type="clear" class="btn btn-inverse">清空</button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6"> </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="tab-pane" id="tab-add" role="tabpanel">
                            <form id="form-add" action="#" class="form-horizontal">
                                <div class="form-body">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group row">
                                                <label class="control-label text-right col-md-3">用户名</label>
                                                <div class="col-md-9">
                                                    <input name="username" type="text" class="form-control" placeholder="User Name">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group row">
                                                <label class="control-label text-right col-md-3">密码</label>
                                                <div class="col-md-9">
                                                    <input name="password" type="password" class="form-control" placeholder="Password">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group row">
                                                <label class="control-label text-right col-md-3">姓名</label>
                                                <div class="col-md-9">
                                                    <input name="fullname" type="text" class="form-control" placeholder="Full Name">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group row">
                                                <label class="control-label text-right col-md-3">籍贯</label>
                                                <div class="col-md-9">
                                                    <input name="nativeplace" type="text" class="form-control" placeholder="Native Place">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group row">
                                                <label class="control-label text-right col-md-3">性别</label>
                                                <div class="col-md-9">
                                                    <select name="gender" class="form-control">
                                                        <option value="0">-- Gender --</option>
                                                        <option value="1">男</option>
                                                        <option value="2">女</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group row">
                                                <label class="control-label text-right col-md-3">邮箱</label>
                                                <div class="col-md-9">
                                                    <input name="email" type="text" class="form-control" placeholder="Email">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group row">
                                                <label class="control-label text-right col-md-3">学号</label>
                                                <div class="col-md-9">
                                                    <input name="schoolnum" type="text" class="form-control" placeholder="School Number">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group row">
                                                <label class="control-label text-right col-md-3">电话</label>
                                                <div class="col-md-9">
                                                    <input name="phone" type="text" class="form-control" placeholder="Phone">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <hr>
                                <div class="form-actions">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                    <button type="submit" class="btn btn-success">添加</button>
                                                    <button type="clear" class="btn btn-inverse">清空</button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6"> </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div role="tabpanel" class="tab-pane active" id="tab-sort">
                            <%--<div class="row">--%>
                                <%--<div class="col-lg-1"></div>--%>

                                <%--<div class="col-lg-5">--%>
                                    <%--<div class="card">--%>
                                        <%--<div class="card-body">--%>
                                            <%--<h4 class="card-title">排序规则</h4>--%>
                                            <%--<div class="card-content">--%>
                                                <%--<div class="nestable">--%>
                                                    <%--<div class="dd" id="form-sort-rule">--%>
                                                        <%--<ol class="dd-list">--%>

                                                        <%--</ol>--%>
                                                    <%--</div>--%>
                                                <%--</div>--%>
                                            <%--</div>--%>
                                        <%--</div>--%>
                                    <%--</div>--%>
                                <%--</div>--%>

                                <%--<div class="col-lg-5">--%>
                                    <%--<div class="card">--%>
                                        <%--<div class="card-body">--%>
                                            <%--<h4 class="card-title">候选规则</h4>--%>
                                            <%--<div class="card-content">--%>
                                                <%--<div class="nestable">--%>
                                                    <%--<div class="dd" id="form-sort-choice">--%>
                                                        <%--<ol class="dd-list">--%>
                                                        <%--</ol>--%>
                                                    <%--</div>--%>
                                                <%--</div>--%>
                                            <%--</div>--%>
                                        <%--</div>--%>
                                    <%--</div>--%>
                                <%--</div>--%>

                                <%--<div class="col-lg-1"></div>--%>
                            <%--</div>--%>

                        </div>
                        <div class="tab-pane fade" id="dropdown1" role="tabpanel" aria-labelledby="dropdown1-tab">

                        </div>
                        <div class="tab-pane fade" id="dropdown2" role="tabpanel" aria-labelledby="dropdown2-tab">

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">用户列表</h4>
                    <div class="table-responsive m-t-40">
                        <table id="myDataTable" class="display nowrap table table-hover table-bordered" cellspacing="2px" width="100%">
                            <thead>
                            <tr>
                                <th>GUID</th>
                                <th>操作</th>
                                <th>用户名</th>
                                <th>姓名</th>
                                <th>性别</th>
                                <th>学号</th>
                                <th>籍贯</th>
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
<script src="<%=request.getContextPath()%>/js/lib/nestable/jquery.nestable.js"></script>

<script src="../js/tabview.js"></script>
<%@include file="../js/mobileclass.jsp"%>
<%@include file="../js/userinfo/index_js.jsp"%>
</body>

</html>
<script type="text/javascript">
    jQuery(document).ready(function() {
        TabView.init();
        MobileClass.init();
        Page.init();
    });
</script>