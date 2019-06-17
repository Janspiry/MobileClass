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
                <li>
                    <a href="<%=request.getContextPath()%>/questionnaire/publish/questionnaire_list.jsp">
                        <i class="fa fa-tachometer">
                        </i>
                        <span class="hide-menu">
                            问卷管理
                        </span>
                    </a>
                </li>
                <li class="nav-devider"></li>
                <li>
                    <a href="<%=request.getContextPath()%>/file/file_list.jsp">
                        <i class="fa fa-tachometer">
                        </i>
                        <span class="hide-menu">
                            文件管理
                        </span>
                    </a>
                </li>
            </ul>
        </nav>
        <!-- End Sidebar navigation -->
    </div>
    <!-- End Sidebar scroll-->
</div>