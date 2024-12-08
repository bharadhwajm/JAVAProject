import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import sql.InitDatabase;
import java.sql.*;

@WebServlet("FileUpload")
public class FileUpload extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FileUpload() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fileContent=request.getParameter("textContent");
		String fileName=request.getParameter("fileName");
		Connection con=InitDatabase.Getconnector();
		HttpSession user=request.getSession();
		try {
			Statement st=con.createStatement();
			ResultSet result=st.executeQuery("select fileName from "+user.getAttribute("user")+" where fileName='"+fileName+"'");
			if (!result.isBeforeFirst()) {
				PreparedStatement statement=con.prepareStatement("insert into "+user.getAttribute("user")+" values(?,?,?)");
				user.setAttribute("user", user.getAttribute("user"));
				statement.setString(1, (String)user.getAttribute("repoName"));
				statement.setString(2, fileName);
				statement.setString(3, fileContent);
				statement.executeUpdate();
				statement.close();
				con.close();
				user.setAttribute("upload", "pass");
				response.sendRedirect("repo.jsp?repoName="+user.getAttribute("repoName")+"&user="+user.getAttribute("user"));				
			}else {
				user.setAttribute("upload", "failed");
				response.sendRedirect("repo.jsp?repoName="+user.getAttribute("repoName")+"&user="+user.getAttribute("user"));
			}
		}catch(Exception e) {
			System.out.print(e);
		}
		
	}

}
