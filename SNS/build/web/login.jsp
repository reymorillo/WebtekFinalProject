<%@ page import ="java.sql.*" %>

<%
    String userid = request.getParameter("uname");
    String pwd = request.getParameter("pass");
    Connection conn = null;
    ResultSet result = null;
    Statement stmt = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
    } catch (Exception e) {
        System.out.println("Error occurred " + e);
    }
    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost/snsdb", "root", "");
    } catch (SQLException e) {
        System.out.println("Error occurred " + e);
    }
    try {
        Statement st = conn.createStatement();
        ResultSet rs;
        rs = st.executeQuery("select * from members where uname='" + userid + "' and pass='" + pwd + "'");
        if (rs.next()) {
            session.setAttribute("userid", userid);
            //out.println("welcome " + userid);
            //out.println("<a href='logout.jsp'>Log out</a>");
            response.sendRedirect("loginsuccess.jsp");
        } else {
            out.println("Invalid password <a href='index.jsp'>try again</a>");
        }
    } catch (SQLException e) {
        System.out.println("Error occurred " + e);
    }

%>