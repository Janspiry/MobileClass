<%--
  Created by IntelliJ IDEA.
  User: silenus
  Date: 2019/6/12
  Time: 21:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if(session.getAttribute("guid")==null || (int)session.getAttribute("guid")<=0 || session.getAttribute("check")==null)
    {
%>
        <script type="text/javascript">
            console.log("check login failed");
            alert("请先登录");
            window.location.href="<%=request.getContextPath()%>/login.jsp";
        </script>
<%
        return;
    }
%>

<script type="text/javascript">
var MobileClass = function(){
    var init_header = function(){
        console.log("init_header");
        document.getElementById("header_username").innerHTML="<%=session.getAttribute("username")%>";
    };
    var init_sidebar_menu = function(){
        console.log("page_sidebar_menu action getmenu");
        $.post("<%=request.getContextPath()%>/AccountAction?action=getmenu", function(menuList){
            console.log("init_sidebar_menu getmenu callback");
            html = "";
            for(var i in menuList)
            {
                var menuItem = menuList[i];
                if(menuItem==null)continue;
                html +=
                        "<li class='nav-devider'></li><li>"
                        +"   <a class='has-arrow' href='#' aria-expanded='false'>"
                        +"   <i class='fa fa-tachometer'></i>"
                        +"   <span class='hide-menu'>"
                        +       menuItem.title
                        +"  </span></a>"
                        +"	<ul aria-expanded='false' class='collapse'>";
                for(var j in menuItem.sub)
                {
                    var subMenuItem = menuItem.sub[j];
                    html += "<li><a href='" + subMenuItem.href + "'>" + subMenuItem.title + "</a></li>";
                }
                html += "</ul></li>";
            }
            document.getElementById("sidebar-menu").innerHTML = html;
            $("#sidebar-menu").metisMenu();
        });
    };
    return {
        init: function(){
            console.log("enter MobileClass.init");
            init_header();
            init_sidebar_menu();
            console.log("exit MobileClass.init");
        }
    };
}();

String.format = function() {
    if( arguments.length == 0 )
        return null;

    var str = arguments[0];
    for(var i=1;i<arguments.length;i++) {
        var re = new RegExp('\\{' + (i-1) + '\\}','gm');
        str = str.replace(re, arguments[i]);
    }
    return str;
}

var Dialog = function() {
    var showSuccess = function(sMsg, sTitle){
        toastr.success(sMsg, sTitle,{
            "positionClass": "toast-top-center",
            timeOut: 3000,
            "closeButton": true,
            "debug": false,
            "newestOnTop": true,
            "progressBar": true,
            "preventDuplicates": true,
            "onclick": null,
            "showDuration": "300",
            "hideDuration": "1000",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut",
            "tapToDismiss": false
        });
    };

    var showError = function(sMsg, sTitle){
        toastr.error(sMsg, sTitle,{
            "positionClass": "toast-top-center",
            timeOut: 3000,
            "closeButton": true,
            "debug": false,
            "newestOnTop": true,
            "progressBar": true,
            "preventDuplicates": true,
            "onclick": null,
            "showDuration": "300",
            "hideDuration": "1000",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut",
            "tapToDismiss": false
        });
    };

    var showComfirm = function(sText, sTitle, fnCallback) {
        swal({
                    title: sTitle,
                    text: sText,
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "确认",
                    cancelButtonText: "放弃",
                    closeOnConfirm: true
                },
                fnCallback
        );
    };

    return {
        showSuccess: showSuccess,
        showError: showError,
        showComfirm: showComfirm
    };
}();
</script>