package my.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author japzdenver08
 */
@WebServlet(name = "updateAllow", urlPatterns = {"/updateAllow"})
@MultipartConfig
public class updateAllow extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String status = request.getParameter("status");
        int idno = Integer.parseInt((request.getParameter("idno")));

        try {
            Class.forName("com.mysql.jdbc.Driver");
            
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/community", "root", null);
            
            String sql = "UPDATE users SET status = ?, joinDate = ? WHERE idno = ?";
            
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, status);
            ps.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            ps.setInt(3, idno);
           
            int rowsAffected = ps.executeUpdate();
            
            if (rowsAffected == 1) {
                response.sendRedirect("main.jsp");
                return;
            }else
                response.sendRedirect("main.jsp");
        } catch (IOException | ClassNotFoundException | SQLException ex) {
            Logger.getLogger(SaveUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        
       // RequestDispatcher rd = request.getRequestDispatcher("success.html");
       // rd.forward(request, response);
    }
}