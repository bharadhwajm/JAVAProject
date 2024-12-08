import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import sql.InitDatabase;

@WebServlet("/SignUp")
public class SignUp extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        try {
        	PrintWriter pw=response.getWriter();
        	pw.print(request.getParameter("uname"));
            Connection con=InitDatabase.Getconnector();
            
            Statement statement=con.createStatement();
            ResultSet result=statement.executeQuery("select username from users where username='"+request.getParameter("uname")+"'");
            
            if (!result.isBeforeFirst()) {
            	PreparedStatement st = con.prepareStatement("insert into users values(?, ?, ?)");
  
            	st.setString(1, request.getParameter("uname"));
            	st.setString(2, request.getParameter("mail"));
            	st.setString(3, request.getParameter("pwd"));
            	st.executeUpdate();
            	statement.executeUpdate("create table "+request.getParameter("uname")+"(repoName varchar(255),fileName varchar(255),code mediumtext)");
            	statement.close();
            	st.close();
            	con.close();
            
            	HttpSession session=request.getSession();
            	session.setAttribute("user", request.getParameter("uname"));
            	response.sendRedirect("userPage.jsp?user="+request.getParameter("uname"));
            }else {
            	request.setAttribute("login", "failed");
            	request.getRequestDispatcher("signup.jsp").forward(request, response);
            }
        }
        catch (Exception e) {
            System.out.print(e);
        }
    }
}