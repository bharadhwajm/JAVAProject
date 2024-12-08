<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="sql.InitDatabase"%>
<%@ page import="java.io.*"%>
<%@ page import="jakarta.servlet.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="styles.css"/>
		<link type="text/css" rel="stylesheet" href="webapp/repo.css"/>
	</head>
	<style>
		.repo-menu{
	padding:10px;
	height:70%;
	margin:1%;
	background-color:rgb(24,23,27);
	border-radius:10px;
}
.main-container{
	display:flex;
}
.container{
	margin:1%;
	width:50%;
	border-radius:10px;
	border:2px solid black;
	padding:10px;
}
.element{
	border:1px solid white;
	border-radius:10px;
	margin:5px;
	padding:5px;
	transition:200ms;
}
.element:hover{
	border:2px solid black;
}
.icon{
	width:20px;
	height:20px;
	border-radius:10px;
}
	</style>
	<body>
		<div class="menu">
			<h3>Code Management</h3>
			<form method="post" action="search.jsp">
				<input type="text" name="search" placeholder="search">
			</form>
		</div>
		<section class="repo-menu">
		<%if (session.getAttribute("user").equals(request.getParameter("user"))){ %>
			<%if (session.getAttribute("upload")=="failed"){%>
				<h2>File already exists</h2>
			<%}%>
			<form method="post" action="FileUpload">
				<p id="message"></p>
				<input style="height: 5%;" type="file" id="file" onchange="fileToText()">
				<input style="background-color: black;width: 10%;border:2px solid white;height: 30px;" type="submit" value="upload" id="upload" name="upload" disabled>
				<textarea style="display:none" id="content" name="textContent"></textarea>
				<textarea style="display:none" id="name" name="fileName"></textarea>
			</form>
			<%}%>
			<%
				HttpSession repo=request.getSession();
				String repoName=request.getParameter("repoName");
				repo.setAttribute("repoName", repoName);

				Connection con=InitDatabase.Getconnector();
				Statement statement=con.createStatement();
				
				ResultSet result=statement.executeQuery("select * from repos where username='"+request.getParameter("user")+"' and repoName='"+repoName+"'");
				String about="";
				String name="";
				while (result.next()){
					about=result.getString("about");
					name=result.getString("username");
					}
				if(session.getAttribute("user").equals(request.getParameter("user"))){
					result=statement.executeQuery("select fileName from "+repo.getAttribute("user")+" where repoName='"+repoName+"'");
				}else{
					result=statement.executeQuery("select fileName from "+request.getParameter("user")+" where repoName='"+repoName+"'");
				}
				%>
			<div class="info">
				<h4><%=repoName%></h4>
			</div>
			<div class="main-container">
			<div class="container">
						<%while (result.next()){
						String fileName=result.getString("fileName");
						String link="";
						if (session.getAttribute("user").equals(request.getParameter("user"))){
							link="code.jsp?file="+fileName+"&repoName="+repoName+"&user="+repo.getAttribute("user");
						}else{
							link="code.jsp?file="+fileName+"&repoName="+repoName+"&user="+request.getParameter("user");
						}
						%>
						<div class="element">
							<a href=<%=link%>><%=fileName%></a>
						</div>
						<%}%>
			</div>
			</div>
			<div>
				<h3>About</h3>
				<textarea readonly style="background-color: rgb(24,23,27); color: white;" id="about" cols="40%" rows="10" maxlength="500"><%=about%></textarea>
			</div>
		</section>
	</body>
	<script>
	function fileToText(){
		const [file]=document.getElementById("file").files;
		if (file.name.indexOf(' ')>=0){
			document.getElementById("message").innerHTML="File name cannot contain spaces";
			document.getElementById("upload").disabled=true;
			return;
		}
		document.getElementById("message").innerHTML="";
		document.getElementById("upload").disabled=false;
		document.getElementById("name").innerHTML=file.name;
		const reader=new FileReader();
		reader.addEventListener("load",()=>{
			document.getElementById("content").innerHTML=reader.result;
		},false);
		if (file){
			reader.readAsText(file,"UTF-8");
		}
	}
	</script>
</html>