<%--
  Created by IntelliJ IDEA.
  User: silenus
  Date: 2019/6/12
  Time: 21:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if(session.getAttribute("username")==null || ((String)session.getAttribute("username")).length()==0)
    {
        response.sendRedirect("../login.jsp");
        return;
    }
%>