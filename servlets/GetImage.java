package my.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "GetImage", urlPatterns = {"/images/*"})
public class GetImage extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idno = request.getPathInfo().substring(1);
        
        ServletContext context = this.getServletContext();
        Connection connection = (Connection) context.getAttribute("connection");

        String sql = "SELECT image FROM users WHERE idno = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, idno);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.first()) {
                byte[] imagedata = rs.getBytes("image");
                
                response.setStatus(HttpServletResponse.SC_OK);
                response.setContentType("image/jpg");
                response.setContentLength(imagedata.length);
                ServletOutputStream sos = response.getOutputStream();
                sos.write(imagedata);
                sos.close();
                return;
            }
        } catch (SQLException ex) {
            Logger.getLogger(GetImage.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
    }
}
