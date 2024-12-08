import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import sql.InitDatabase;

@WebServlet("/NewRepo")
public class NewRepo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public NewRepo() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String rname=request.getParameter("reponame");
		String about=request.getParameter("about");
		HttpSession session = request.getSession();
		String user=(String)session.getAttribute("user");
		PrintWriter pw=response.getWriter();
		pw.print(user);
		try {
			Connection con=InitDatabase.Getconnector();
			Statement statement=con.createStatement();
			ResultSet result=statement.executeQuery("select repoName from repos where username='"+user+"' and repoName='"+rname+"'");
			if (!result.isBeforeFirst()) {
				PreparedStatement st = con.prepareStatement("insert into repos values(?, ?, ?)");
				st.setString(1, user);
				st.setString(2, rname);
				st.setString(3, about);
				st.executeUpdate();
				st.close();
				con.close();
				pw.print(user);
				response.sendRedirect("repo.jsp?user="+user+"&repoName="+rname);
			}else {
				request.setAttribute("newRepo", "failed");
				request.getRequestDispatcher("newRepo.jsp").forward(request, response);
			}
		}catch(Exception e){
			System.out.print(e);
		}
	}

}
