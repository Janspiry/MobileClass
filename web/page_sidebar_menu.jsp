<%--
  Created by IntelliJ IDEA.
  User: silenus
  Date: 2019/6/12
  Time: 20:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="left-sidebar">
    <!-- Sidebar scroll-->
    <div class="scroll-sidebar">
        <!-- Sidebar navigation-->
        <nav class="sidebar-nav">
            <ul id="sidebar-menu">
                <li class="nav-devider"></li>
                <li> <a class="has-arrow" href="#" aria-expanded="false"> <i class="fa fa-tachometer"></i> <span class="hide-menu">用户信息管理 </span></a>
                    <ul aria-expanded="false" class="collapse">
                        <li><a href="#">我的信息</a></li>
                        <li><a href="#">学生信息</a></li>
                    </ul></li>
                <li class="nav-devider"></li>
                <li> <a class="has-arrow" href="#" aria-expanded="false"> <i class="fa fa-tachometer"></i> <span class="hide-menu">投票管理 </span></a>
                    <ul aria-expanded="false" class="collapse">
                        <li><a href="#">发起投票</a></li>
                        <li><a href="#">参与投票</a></li>
                    </ul></li>
                <li class="nav-devider"></li>
                <li> <a class="has-arrow" href="#" aria-expanded="false"> <i class="fa fa-tachometer"></i> <span class="hide-menu">作业管理 </span></a>
                    <ul aria-expanded="false" class="collapse">
                        <li><a href="/work/todo/todo_list.jsp">作业管理</a></li>
                        <li><a href="#">布置作业</a></li>
                    </ul></li>
                <li class="nav-devider"></li>
                <li> <a class="has-arrow" href="#" aria-expanded="false"> <i class="fa fa-tachometer"></i> <span class="hide-menu">批改作业 </span></a>
                    <ul aria-expanded="false" class="collapse"></ul></li>
                <li class="nav-devider"></li>
                <li> <a class="has-arrow" href="#" aria-expanded="false"> <i class="fa fa-tachometer"></i> <span class="hide-menu">开发者 </span></a>
                    <ul aria-expanded="false" class="collapse">
                        <li><a href="#">删库跑路</a></li>
                    </ul></li>
                <li class="nav-devider"></li>
                <li> <a class="has-arrow" href="#" aria-expanded="false"> <i class="fa fa-tachometer"></i> <span class="hide-menu">管理员 </span></a>
                    <ul aria-expanded="false" class="collapse">
                        <li><a href="#">只有管理员才看得见</a></li>
                        <li><a href="/templates/admin/authmng.jsp">权限管理</a></li>
                    </ul></li>
                <li class="nav-devider"></li>
                <li> <a class="has-arrow" href="#" aria-expanded="false"> <i class="fa fa-tachometer"></i> <span class="hide-menu">文件管理 </span></a>
                    <ul aria-expanded="false" class="collapse">
                        <li><a href="/project/todo/todo_list.jsp">文件管理</a></li>
                    </ul></li>
            </ul>
        </nav>
        <!-- End Sidebar navigation -->
    </div>
    <!-- End Sidebar scroll-->
</div>