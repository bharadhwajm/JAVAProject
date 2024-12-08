<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="styles.css">
        <link rel="stylesheet" href="newRepo.css">
    </head>
    <body>
        <div class="menu">
			<h3>Code Management</h3>
			<form method="post" action="search.jsp">
				<input type="text" placeholder="search" name="search">
			</form>
		</div>
        <section class="user-section">
            <div class="container" style="width: 90%;">
            	<%if (session.getAttribute("newRepo")=="failed"){%>
					<h3>Repository name already exists</h3>
				<%}%>
				<form method="post" action="NewRepo">
				<p id="message"></p>
                <input type="text" id="reponame" name="reponame" placeholder="Repository name" onkeyup="check()">
                <h4>about:</h4>
                <textarea name="about" cols="30" rows="10"></textarea>
                <input type="submit" id="button" value="create repository" disabled>
				</form>
            </div>
        </section>
    </body>
    <script>
    	function check(){
	    	let repoName=document.getElementById("reponame").value;
	    	if (repoName.indexOf(' ')>=0){
	    		document.getElementById("message").innerHTML="Repository name cannot contain spaces"
	    		document.getElementById("button").disabled=true;
	    	}else{
	    		document.getElementById("message").innerHTML="";
		    	document.getElementById("button").disabled=false;
	    	}
    	}
    </script>
</html>