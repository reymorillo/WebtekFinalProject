<%-- 
    Document   : logout
    Created on : Jul 16, 2017, 4:39:48 PM
    Author     : japzdenver08
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    session.invalidate();
    response.sendRedirect(request.getContextPath());
    %>
