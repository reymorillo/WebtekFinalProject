<%@page import="java.io.OutputStream"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.io.*"%>
  <%@ page import="java.sql.*"%>
 <%@ page import="java.util.*"%>
   <%@ page import="java.text.*"%>
   <%@ page import="javax.servlet.*"%>
   <%@ page import="javax.servlet.http.*"%>
   <%@ page import="javax.servlet.http.HttpSession"%>
   <%@ page language="java"%>
   <%@ page session="true"%>
   <%@ page import="java.sql.*"%>
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
<html lang="en">

<head>
    <meta charset="utf-8">
    
    <title>Registered Users</title>

    <!-- Bootstrap Core CSS -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="bootstrap/css/round-about.css" rel="stylesheet">
    <link href="bootstrap/css/style.css" rel="stylesheet">

</head>

<body>

    <!-- Navigation -->
        <header>
            <div class="container">
            <nav class="navbar navbar-default" role="navigation">
            <div class="container-fluid navbar-border">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <a class="navbar-brand" href="main.jsp"><i>Pending Users</i></a>
                </div>
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                        <li><a href="suspended.jsp"><i>Suspended Users</i></a></li>
                        <li><a href="allusers.jsp"><i>All Users</i></a></li>
                        <li class="dropdown">
                        <li>
                            <form class="navbar-form" method="post" name="frm" action="Search">
                                <div class="input-group">
                                    <input class="form-control" type="text" name="pid" id="pid"
                                          placeholder="Enter User's Name...">
                                </div>
                            </form>
                        </li>
                        <li><a href="main.jsp" style="cursor: default"><strong><i>ADMIN</i></strong></a></li>
                </ul>

                 <ul class="nav navbar-nav navbar-right">
                        <li><a href="logout.jsp"><i>Log Out</i></a></li>
                </ul>
                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
            </nav>
            </div>
	</header>
	
	
    <!-- Page Content -->
    <div class="container">
	
       <!-- Team Members Row -->
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">All Registered Users:</h1>
            </div>
            <%
                try { 
                connection = DriverManager.getConnection(connectionUrl+dbName, 
                        userId, password);
                statement=connection.createStatement();
                String sql ="SELECT idno, CONCAT(fName, ' ', lName) AS name, "
                        + "username, joinDate, image FROM users WHERE status = 'active'";

                resultSet = statement.executeQuery(sql);
                while(resultSet.next()){
                    
            %>
            <div class="col-lg-4 col-sm-6 text-center">
                <img class="img-circle img-responsive img-center" 
                     src="#" 
                     alt="" width="200" height="200">
                 <tr>
                    <td><%=resultSet.getString("idno") %></td>
                    <td><%=resultSet.getString("name") %></td>
                    <td><%=resultSet.getString("username") %></
                    <td>
                        <form action="updateSuspend" method="POST">
                            <select name="status">
                                <option value="Suspended">Suspend</option>
                                <option value="Active">Allow</option>
                                <option value="Declined">Decline</option>
                            </select>
                            <input name='idno' type='hidden' oncopy='return false' onpaste='return false' value='<%=resultSet.getString("idno") %>'/>
                            <button type="submit" value="Change">Change</button>
                        </form>
                    </td>
                </tr>
               <% 
Blob image1 = null;
Connection con = null;
Statement stmt = null;
ResultSet rs = null;
String iurl1=null;

try {
Class.forName("com.mysql.jdbc.Driver");
con =           DriverManager.getConnection("jdbc:mysql://localhost:3306/community","root","");
stmt = con.createStatement();
rs = stmt.executeQuery("select image from users where fname='dhea'");%>
<table border="2">
<tr><td>
<%while(rs.next()){%>
<img src="<%=image1 %>" width="100" height="100"/>
 <%}%>
</td></tr>
</table>
<%}
catch (Exception e) {
out.println("DB problem"); 
return;
}
finally {
try {
rs.close();
stmt.close();
con.close();
}
catch (SQLException e) {
e.printStackTrace();
}
}
%>
                <h3>
               
                    <small>(<%=resultSet.getString("idno") %>)</small>
                </h3>
                    <p>Used the username <strong><%=resultSet.getString("username") %>.</strong></p>
                    <hr>
            </div>
            <% 
                }

                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </div>

	</div>
    <!-- /.container -->

    <!-- jQuery -->
    <script src="bootstrap/js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="bootstrap/js/bootstrap.min.js"></script>

</body>

</html>
