<%@page import="sql.InitDatabase"%>
<%@page import="jakarta.servlet.*"%>
<%@page import="java.sql.*" %>
<%@page import="java.io.*" %>
<!DOCTYPE html>
<head>
    <title>Sign-up form</title>
    <style>
        body,html{
        	height:100%;
            background-color: black;
            color: white;
            font-family: Verdana, Geneva, Tahoma, sans-serif;
        }
        #signup-form-container {
            height : 70%;
            width : 50%;
            padding: 10px;
            margin : auto;
            border : 2px solid white;
            border-radius: 10px;
            text-align:center;
            margin-top: 100px;
            background-color: rgb(27, 27, 27);
        }
        button{
            height: 30px;
            width: 100px;
            background-color: transparent;
            border-radius: 20px;
            color: white;
            border: 2px solid white;
            transition-property: width;
            transition-duration: 1s;
        }
        button:hover{
            width: 130px;
            border-color: rgb(137, 19, 255);

        }
        input{
            border-radius: 8px;
	    border:2px solid white;
            background-color: transparent;
            color:white;
	    height:30px;
        }
	input:focus{
		border:4px solid #4d004d;

	}
    </style>

</head>
<body>
    <div id="signup-form-container">
    <form action="SignUp" method="post">
        <h1>Sign Up</h1>
        <label>Username:</label><br>
        <input type="text" name="uname" id="uname" placeholder="Username" required><br><br>

        <label>Email:</label><br>
        <input type="email" name="mail" id="mail" placeholder="abcd@gmail.com" required><br><br>

        <label>Password:</label><br>
        <input type="password" name="pwd" id="pwd" placeholder="Password" onkeyup="check()" required><br><br>

        <label>Confirm Password:</label><br>
        <input type="password" name="cpwd" id="cpwd" placeholder="Confirm Password" onkeyup="check()" required><br><br>
        
		<%if (request.getAttribute("login")=="failed"){%>
		<h3>Username Already in use</h3>
		<%}%>
		
        <button type="submit" id="submit" disabled class="button">SIGN UP</button>
	</form>

        <p>Already have an account :<a href="login.jsp">Sign-in</a></p>

</div>
</body>
<script>
function check(){
	let pwd=document.getElementById("pwd").value;
	let cpwd=document.getElementById("cpwd").value;
	let button=document.getElementById("submit");
	if(pwd.length>=8){
		if(pwd==cpwd){
			document.getElementById("pwd").style.borderColor="green";
			document.getElementById("submit").style.borderColor="green";
			button.disabled=false;
		}
		else{
			document.getElementById("pwd").style.borderColor="red";
			document.getElementById("submit").style.borderColor="red";
			button.disabled=true;
		}
	}
	else{
		document.getElementById("pwd").style.borderColor="red";
		document.getElementById("submit").style.borderColor="red";
		button.disabled=true;
	}
}
</script>  
</html>