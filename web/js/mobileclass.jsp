<%--
  Created by IntelliJ IDEA.
  User: silenus
  Date: 2019/6/12
  Time: 21:01
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%--%>
    <%--if(session.getAttribute("guid")==null || (int)session.getAttribute("guid")<=0 || session.getAttribute("check")==null)--%>
    <%--{--%>
<%--%>--%>
        <%--<script type="text/javascript">--%>
            <%--console.log("check login failed");--%>
            <%--alert("请先登录");--%>
            <%--window.location.href="<%=request.getContextPath()%>/login.jsp";--%>
        <%--</script>--%>
<%--<%--%>
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

function sendRedirect(URL, PARAMTERS) {
    var temp_form = document.createElement("form");
    temp_form.action = URL;
    temp_form.target = "_self";
    temp_form.method = "post";
    temp_form.style.display = "none";
    for (var item in PARAMTERS) {
        var opt = document.createElement("textarea");
        opt.name = PARAMTERS[item].name;
        opt.value = PARAMTERS[item].value;
        temp_form.appendChild(opt);
    }
    document.body.appendChild(temp_form);
    temp_form.submit();
};

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
            "positionClass": "toast-top-full-width",
            timeOut: 1000,
            "closeButton": true,
            "debug": false,
            "newestOnTop": true,
            "progressBar": true,
            "preventDuplicates": false,
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
            "positionClass": "toast-top-full-width",
            timeOut: 5000,
            "closeButton": true,
            "debug": false,
            "newestOnTop": true,
            "progressBar": true,
            "preventDuplicates": false,
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

    var showInfo = function(sMsg, sTitle) {
        toastr.info(sMsg,sTitle,{
            "positionClass": "toast-top-full-width",
            timeOut: 3000,
            "closeButton": true,
            "debug": false,
            "newestOnTop": true,
            "progressBar": true,
            "preventDuplicates": false,
            "onclick": null,
            "showDuration": "300",
            "hideDuration": "1000",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut",
            "tapToDismiss": false
        })
    }

    var showWarning = function(sMsg, sTitle) {
        toastr.warning(sMsg, sTitle,{
            "positionClass": "toast-top-full-width",
            timeOut: 3000,
            "closeButton": true,
            "debug": false,
            "newestOnTop": true,
            "progressBar": true,
            "preventDuplicates": false,
            "onclick": null,
            "showDuration": "300",
            "hideDuration": "1000",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut",
            "tapToDismiss": false
        })
    }

    var showComfirm = function(sText, sTitle, fnCallback) {
        swal({
                    title: sTitle,
                    text: sText,
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "确定",
                    cancelButtonText: "放弃",
                    closeOnConfirm: true
                },
                fnCallback
        );
    };
    var showText = function(sText, sTitle, fnCallback) {
        swal(sText,sTitle);
    };

    return {
        showSuccess: showSuccess,
        showError: showError,
        showWarning: showWarning,
        showInfo: showInfo,
        showComfirm: showComfirm,
        showText:showText
    };
}();
</script>