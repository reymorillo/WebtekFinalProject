package my.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class login extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String username = request.getParameter("username");
            String password = request.getParameter("password");
           try{
               if(username!=null){
                   Class.forName("com.mysql.jdbc.Driver").newInstance();
                   Connection conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/community", "root" , "");
                   String query = "SELECT * FROM users WHERE username=? AND password=? AND accountType = 'Admin'";
                   PreparedStatement pst = (PreparedStatement) conn.prepareStatement(query);
                   pst.setString(1, username);
                   pst.setString(2, password);
                   ResultSet rs = pst.executeQuery();
                   
                   if(rs.next()){
                       response.sendRedirect("main.jsp");
                   }else{
                       response.sendRedirect("index.html");
                   }
                   
               }
           }catch(IOException | ClassNotFoundException | IllegalAccessException | InstantiationException | SQLException ex){
               out.println("Exception :" + ex.getMessage());
           }
        }

    }

   

}
