<%@page import="sql.InitDatabase"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="styles.css">
		<link rel="stylesheet" href="code.css">
	</head>
	<body>
		<div class="menu">
			<h3>Code Management</h3>
			<form method="post" action="search.jsp">
				<input type="text" placeholder="search" name="search">
			</form>
		</div>
		<%String file=request.getParameter("file");%>
		<section class="code-display" style="background-color:rgb(24,23,27);">
			<div class="info">
			<%session.setAttribute("deleteFile", file);
			session.setAttribute("repoName", request.getParameter("repoName"));
			if (session.getAttribute("user").equals(request.getParameter("user"))){%>
				<form method="post" action=DeleteFile><input style="border:2px solid white ;width:120px; font-family:sans-serif " type="submit" value="delete file"></form>
			<%}%>
			<h3 id="fileName"><%=file%></h3>
			</div>
			<%Connection con=InitDatabase.Getconnector();
				Statement statement=con.createStatement();
				ResultSet result=statement.executeQuery("select code from "+request.getParameter("user")+" where fileName='"+file+"'");
				String content="";
				while (result.next()){
					content=result.getString("code");
				}
			%>
			<textarea style="background-color:rgb(24,23,27);" readonly>
			<%=content%>
			</textarea>
		</section>
	</body>
</html>