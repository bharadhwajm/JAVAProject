<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="sql.InitDatabase"%>
<%@ page import="java.io.*"%>
<%@ page import="jakarta.servlet.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <head>
        <link rel="stylesheet" href="styles.css">
        <link rel="stylesheet" href="search.css">
    </head>
</head>
<style>
.repos{
    width: 90%;
    height: 15%;
    background-color: rgb(24,23,27);
    border-radius: 20px;
    margin: 1%;
    padding: 10px;
}
.container{
    width: 100%;
    height: 90%;
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
}
</style>
<body>
    <body>
        <div class="menu">
			<h3>Code Management</h3>
			<form method="post" action="search.jsp">
				<input type="text" placeholder="search" name="search">
			</form>
		</div>
        <%
		String toSearch=request.getParameter("search");
		
        ResultSet result=null;
            try {
                Connection con=InitDatabase.Getconnector();
                Statement statement=con.createStatement();
                result=statement.executeQuery("select * from repos where username like '%"+toSearch+"%' or repoName like '%"+toSearch+"%'");
            }catch(Exception e){
            		System.out.println(e);
            	}
        %>
        <div class="container">
        <%
        if (!result.isBeforeFirst()){%>
        <h2>No results found</h2>
        <%}%>
        <%
        while (result.next()){%>
            <div class="repos">
            	<%String userpagelink="userPage.jsp?user="+result.getString("username");
            	String repolink="repo.jsp?repoName="+result.getString("RepoName")+"&user="+result.getString("username");%>
            	<a href=<%=userpagelink%> style="color:white;">User:<%=result.getString("username")%></a><br><br>
            	<a href=<%=repolink%> style="color:white;">Repository:<%=result.getString("RepoName")%></a>
            	<p>About:<%=result.getString("about")%></p>
            </div>
	    <%}%>
        </div>
</body>
</html>