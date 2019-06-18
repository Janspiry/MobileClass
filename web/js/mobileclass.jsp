<%--
  Created by IntelliJ IDEA.
  User: silenus
  Date: 2019/6/12
  Time: 21:01
  To change this template use File | Settings | File Templates.
--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%--%>
    <%--if(session.getAttribute("guid")==null || (int)session.getAttribute("guid")<=0 || session.getAttribute("check")==null)--%>
    <%--{--%>
        <%--System.out.println("check login failed");--%>
        <%--response.sendRedirect(request.getContextPath()+"/login.jsp");--%>
        <%--return;--%>
    <%--}--%>
<%--%>--%>

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
</script>