<%--
  Created by IntelliJ IDEA.
  User: silenus
  Date: 2019/6/12
  Time: 20:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="header">
    <nav class="navbar top-navbar navbar-expand-md navbar-light">
        <!-- Logo -->
        <div class="navbar-header">
            <a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">
                <!-- Logo icon -->
                <b><img src="<%=request.getContextPath()%>/images/logo.png" alt="homepage" class="dark-logo" /></b>
                <!--End Logo icon -->
                <!-- Logo text -->
                <span><img src="<%=request.getContextPath()%>/images/logo-text.png" alt="homepage" class="dark-logo" /></span>
            </a>
        </div>
        <!-- End Logo -->
        <div class="navbar-collapse">
            <!-- toggle and nav items -->
            <ul class="navbar-nav mr-auto mt-md-0">
                <!-- This is  -->
                <li class="nav-item"> <a class="nav-link toggle-nav hidden-md-up text-muted  " href="javascript:void(0)"><i class="mdi mdi-menu"></i></a> </li>
                <li class="nav-item m-l-10"> <a class="nav-link sidebartoggle hidden-sm-down text-muted  " href="javascript:void(0)"><i class="ti-menu"></i></a> </li>
            </ul>
            <!-- User profile and search -->
            <ul class="navbar-nav my-lg-0">
                <!-- Comment -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-muted text-muted  " href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="fa fa-bell"></i>
                        <div class="notify"> <span class="heartbit"></span> <span class="point"></span> </div>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right mailbox animated slideInRight">
                        <ul>
                            <li>
                                <div class="drop-title">Notifications</div>
                            </li>
                            <li>
                                <div class="header-notify">
                                    <!-- Message -->
                                    <a href="#">
                                        <i class="cc BTC m-r-10 f-s-40" title="BTC"></i>
                                        <div class="notification-contnet">
                                            <h5>All Transaction BTC</h5> <span class="mail-desc">Just see the my new admin!</span>
                                        </div>
                                    </a>
                                    <!-- Message -->
                                    <a href="#">
                                        <i class="cc LTC m-r-10 f-s-40" title="BTC"></i>
                                        <div class="notification-contnet">
                                            <h5>This is LTC coin</h5> <span class="mail-desc">Just a reminder that you have event</span>
                                        </div>
                                    </a>
                                    <!-- Message -->
                                    <a href="#">
                                        <i class="cc DASH m-r-10 f-s-40" title="BTC"></i>
                                        <div class="notification-contnet">
                                            <h5>This is DASH coin</h5> <span class="mail-desc">You can customize this template as you want</span>
                                        </div>
                                    </a>
                                    <!-- Message -->
                                    <a href="#">
                                        <i class="cc XRP m-r-10 f-s-40" title="BTC"></i>
                                        <div class="notification-contnet">
                                            <h5>This is LTC coin</h5> <span class="mail-desc">Just see the my admin!</span>
                                        </div>
                                    </a>
                                </div>
                            </li>
                            <li>
                                <a class="nav-link text-center" href="javascript:void(0);"> Check all notifications <i class="fa fa-angle-right"></i> </a>
                            </li>
                        </ul>
                    </div>
                </li>
                <!-- End Comment -->
                <!-- Messages -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-muted  " href="#" id="2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="fa fa-envelope"></i>
                        <div class="notify"> <span class="heartbit"></span> <span class="point"></span> </div>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right mailbox animated slideInRight" aria-labelledby="2">
                        <ul>
                            <li>
                                <div class="drop-title">You have 4 new messages</div>
                            </li>
                            <li>
                                <div class="header-notify">
                                    <!-- Message -->
                                    <a href="#">
                                        <div class="notification-contnet">
                                            <h5>Michael Qin</h5> <span class="mail-desc">Just see the my admin!</span>
                                        </div>
                                    </a>
                                    <!-- Message -->
                                    <a href="#">
                                        <div class="notification-contnet">
                                            <h5>John Doe</h5> <span class="mail-desc">I've sung a song! See you at</span>
                                        </div>
                                    </a>
                                    <!-- Message -->
                                    <a href="#">
                                        <div class="notification-contnet">
                                            <h5>Mr. John</h5> <span class="mail-desc">I am a singer!</span>
                                        </div>
                                    </a>
                                    <!-- Message -->
                                    <a href="#">
                                        <div class="notification-contnet">
                                            <h5>Michael Qin</h5> <span class="mail-desc">Just see the my admin!</span>
                                        </div>
                                    </a>
                                </div>
                            </li>
                            <li>
                                <a class="nav-link text-center" href="javascript:void(0);"> See all e-Mails <i class="fa fa-angle-right"></i> </a>
                            </li>
                        </ul>
                    </div>
                </li>
                <!-- End Messages -->
                <!-- Profile -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-muted  " href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-user"></i></a>
                    <div class="dropdown-menu dropdown-menu-right animated slideInRight">
                        <ul class="dropdown-user">
                            <li role="separator" class="divider"></li>
                            <li><a href="<%=request.getContextPath()%>/userinfo/index.jsp"> 个人信息</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="<%=request.getContextPath()%>/AccountAction?action=logout"> 退出登录</a></li>
                        </ul>
                    </div>
                </li>
            </ul>
            <span>当前用户：</span><span id="header_username">sss</span>
        </div>
    </nav>
</div>