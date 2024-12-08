<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="sql.InitDatabase"%>
<%@ page import="java.io.*"%>
<%@ page import="jakarta.servlet.*"%>
<%@ page import="java.sql.*" %>

<% Connection con=InitDatabase.Getconnector(); %>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="styles.css">
	</head>
	<body>
		<div class="menu">
			<h3>Code Management</h3>
			<form method="post" action="search.jsp">
				<input type="text" name="search" placeholder="search">
			</form>
		</div>
		<%
		if (session.getAttribute("user").equals(request.getParameter("user"))){%>
		<center style="height: 5%;">
		<h2>Hello, <%=request.getParameter("user")%></h2>
		<a href="newRepo.jsp"><input style="width: 20%;height: 100%; border:2px solid white" type="button" value="New Repository"></a>
		</center>
		<%}%>
		<section class="user-section">
		<%
			if (session.getAttribute("user")==null){
				response.sendRedirect("login.html");
			}
			ResultSet result=null;
			Statement statement=con.createStatement();
			result=statement.executeQuery("Select * from repos where username='"+request.getParameter("user")+"'");
		%>
			<div class="space">
				<h2>Your repositories</h2>
				<%
					if (!result.isBeforeFirst()){
				%>
					<h3>You do not have any repositories</h3>
				<%}%>
				<%
					while (result.next()){
						String link="repo.jsp?repoName="+result.getString("repoName")+"&user="+result.getString("username");
				%>
				<a href=<%=link%>><%=result.getString("repoName")%></a><br>
				<%}%>
			</div>
		</section>
	</body>
</html>