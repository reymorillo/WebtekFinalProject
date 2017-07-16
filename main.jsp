<%-- 
    Document   : pending
    Created on : Jul 14, 2017, 3:24:07 AM
    Author     : Cerezo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%
    String id = request.getParameter("userId");
    String driverName = "com.mysql.jdbc.Driver";
    String connectionUrl = "jdbc:mysql://localhost:3306/";
    String dbName = "community";
    String userId = "root";
    String password = "";

    try {
    Class.forName(driverName);
    } catch (ClassNotFoundException e) {
    e.printStackTrace();
    }

    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Community</title>
    </head>
    <body>
        <header>
            <br/><br/>
    <form method="post" name="frm" action="Search">
      <table border="0" width="300" align="center" bgcolor="#e9f">
        <tr><td colspan=2 style="font-size:12pt;" align="center">
        <h3>Search User</h3></td></tr>
        <tr><td ><b>User Name</b></td>
          <td>: <input  type="text" name="pid" id="pid">
        </td></tr>        
        <tr><td colspan=2 align="center">
        <input  type="submit" name="submit" value="Search"></td></tr>
      </table>
    </form>
            <nav>
                <ul>
                    <li>Home</li>
                    <li>Users</li>
                    <li><a href = "logout.jsp">Log out</a></li>
                </ul>
            </nav>
        </header>
        <h1>Pending Accounts</h1>
        <table>
            <thead>
                <tr>
                    <th>ID Number</th>
                    <th>Name</th>
                    <th>Username</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try { 
                    connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
                    statement=connection.createStatement();
                    String sql ="SELECT idno, CONCAT(fName, ' ', lName) AS name, username, joinDate FROM users WHERE status = 'Pending'";

                    resultSet = statement.executeQuery(sql);
                    while(resultSet.next()){
                %>
                <tr>
                    <td><%=resultSet.getString("idno") %></td>
                    <td><%=resultSet.getString("name") %></td>
                    <td><%=resultSet.getString("username") %></td>
                    <td>
                        <form action="UpdateStatus" method="POST">
                            <select name="status">
                                <option value="Pending">Pending</option>
                                <option value="Active">Allow</option>
                                <option value="Declined">Decline</option>
                            </select>
                            <input name='idno' type='hidden' oncopy='return false' onpaste='return false' value='<%=resultSet.getString("idno") %>'/>
                            <button type="submit" value="Change">Change</button>
                        </form>
                    </td>
                </tr>
                <% 
                    }

                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>
    </body>
</html>
