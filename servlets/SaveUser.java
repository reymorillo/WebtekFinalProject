package my.servlets;

import java.io.IOException;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet(name = "SaveUser", urlPatterns = {"/SaveUser"})
@MultipartConfig
public class SaveUser extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int idno = Integer.parseInt((request.getParameter("idno")));
        String fName = request.getParameter("fName");
        String mName = request.getParameter("mName");
        String lName = request.getParameter("lName");
          String gender = request.getParameter("gender");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
    
      
        Part image = request.getPart("image");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/community", "root", null);
            
            String sql = "INSERT INTO users(idno, fName, mName, lName,gender, username, password,accountType,status,joinDate,image) VALUES(?, ?,?, ?,?, ?, ?, ?, ?,?,?)";
            
            PreparedStatement ps = connection.prepareStatement(sql);
            
            ps.setInt(1, idno);
            ps.setString(2, fName);
            ps.setString(3, mName);
            ps.setString(4, lName);
            ps.setString(5, gender);
            ps.setString(6, username);
            ps.setString(7, password);
            
            String accountType="User";
            ps.setString(8, accountType);
            
            String status= "Pending";
            ps.setString(9, status);
            
            String joinDate = null;
            ps.setString(10, joinDate);     
            
            ps.setBlob(11, image.getInputStream());
           
            int rowsAffected = ps.executeUpdate();
            
            String path = this.getServletContext().getRealPath("/productimages");
            String filename = path + "/" + idno + ".jpg";
            image.write(filename);
            
            if (1 == rowsAffected) {
                response.sendRedirect("main.jsp");
                return;
            }else
                response.sendRedirect("index.html");
        } catch (IOException | ClassNotFoundException | SQLException ex) {
            Logger.getLogger(SaveUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        
       RequestDispatcher rd = request.getRequestDispatcher("success.html");
       rd.forward(request, response);
    }
}

    