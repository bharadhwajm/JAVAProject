import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

import sql.InitDatabase;
import java.sql.*;

@WebServlet("DeleteFile")
public class DeleteFile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DeleteFile() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession user=request.getSession();
		try {
			Connection con=InitDatabase.Getconnector();
			PreparedStatement statement=con.prepareStatement("delete from "+(String)user.getAttribute("user")+" where fileName=?");
			statement.setString(1, (String)user.getAttribute("deleteFile"));
			statement.executeUpdate();
			statement.close();
			con.close();
			response.sendRedirect("repo.jsp?repoName="+user.getAttribute("repoName")+"&user="+user.getAttribute("user"));
		}catch(Exception e) {
			PrintWriter pw=response.getWriter();
			pw.print(e);
		}
	}

}
