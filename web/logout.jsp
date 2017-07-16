<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>Script Logout</title>
    </head>
    <body>
        <%request.getSession().setAttribute("user", null);%>
        Logged out successfully. Click <a href='index.html'>here</a> to login again.<br>
    </body>
</html>