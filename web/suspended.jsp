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
        <title>Script Community</title>
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
                                <form class="navbar-form" role="search" method = "POST" action = "search.php">
                                <div class="input-group">
                                        <input type="text" class="form-control" placeholder="Enter friends name..." name="searchValue">
                                </div>
                                </form>    
                        </li>
                        <li><a href="main.jsp" style="cursor: default"><strong><i>ADMIN</i></strong></a></li>
                </ul>

                 <ul class="nav navbar-nav navbar-right">
                        <li><a href="logout.jsp"><i>Sign out</i></a></li>
                </ul>
                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
            </nav>
            </div>
	</header>
            <%
                try { 
                connection = DriverManager.getConnection(connectionUrl+dbName, 
                        userId, password);
                statement=connection.createStatement();
                String sql ="SELECT idno, CONCAT(fName, ' ', lName) AS name, "
                        + "username, joinDate, image FROM users WHERE status = 'suspended'";

                resultSet = statement.executeQuery(sql);
                while(resultSet.next()){
            %>
             <div class="col-lg-4 col-sm-6 text-center">
                <img class="img-circle img-responsive img-center" 
                     src="#" 
                     alt="" width="200" height="200">
                <h3><%=resultSet.getString("name") %>
                    <small>(<%=resultSet.getString("idno") %>)</small>
                </h3>
                    <p>Used the username <strong><%=resultSet.getString("username") %>.</strong></p>
                    <hr>
                      <tr>
                    <td><%=resultSet.getString("idno") %></td>
                    <td><%=resultSet.getString("name") %></td>
                    <td><%=resultSet.getString("username") %></td>
                    <td>
                        <form action="updateAllow" method="POST">
                            <select name="status">
                                <option value="Active">Allow</option>
                                <option value="Suspended">Suspend</option>
  
                            </select>
                            <input name='idno' type='hidden' oncopy='return false' onpaste='return false' value='<%=resultSet.getString("idno") %>'/>
                            <button type="submit" value="Change">Change</button>
                        </form>
                    </td>
                </tr>
                    
            </div>
               <% 
                }

                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>

    </body>
</html>
