<?php
	session_start();
	include('config.php');

	$sql = "SELECT p.id, CONCAT(u.fName, '&nbsp;', u.lName) as name, p.post, p.postedOn 
			FROM posts p INNER JOIN users u ON p.accountID = u.accountID 
			WHERE p.visibility = 'Public' ORDER BY p.postedOn DESC";
	$result = mysqli_query($db, $sql);
    $sql2 ="SELECT c.id, c.name, c.comments, c.date_publish from comment_box c ";
    $result2 = mysqli_query($db, $sql2);
?>
<!DOCTYPE html>
<html>
<head>
	<title>Community</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="style/style.css">
	
	

</head>
<body>
	<header>
     
		<form method="POST" action="search.php">
    
			<input type="search" placeholder="Search for more friends">
			<noscript><input type='submit' value='Submit'></noscript>
		</form>
         
		<nav>
			<ul>
				<li>Login As
					<?php
						echo "".$_SESSION['username']."";
					?>
				</li>
				<li><a href="requests.php">Requests</a></li>
				<li><a href="messages.php">Messages</a></li>
				<li><a href="profile.php">Profile</a></li> <!--insert php code to fetch user's name (optional)-->
				<li><a href="logout.php">Log out</a></li>
			</ul>
		</nav>
	</header>
	<div class="body">
		<div class="post">
			<form class="form-post" method = "POST" action="post.php" enctype="multipart/form-data">
				<textarea class="form-control" name="textarea" type="text" placeholder="Write what's on your mind."></textarea>
                <input name="image" id="image" type="file" multiple accept="image/gif, image/jpeg, image/png">
				<select name="visibility">
					<option name="option1" value="Public">Public</option>
					<option name="option2" value="Private">Private</option>
				</select>
                <button type="submit">Post</button>
			</form>
		</div>
		<?php
			if($result->num_rows > 0) {
				while($row = mysqli_fetch_array($result)) {
					echo "<article class='post'>
							<h3>".$row['name']."</h3>
							<small>".$row['postedOn']."</small>
							<p>".$row['post']."</p>";
                            echo "<form action='insert.php' method='POST' enctype='multipart/form-data'>
                            
                                <textarea name='comments' placeholder='Leave Comments Here...' ></textarea>
                                <input name='postid' type='hidden' oncopy='return false' onpaste='return false' onkeyup='javascript:this.value=this.value.replace(/[<,>]/g,'');' value='$row[id]'/>
                                <input type='submit' value='Submit'>";
                            if($result2->num_rows > 0 ){
                            while($rows=mysqli_fetch_array($result2)){
                                echo "<div class='comments_content'>";
                                echo "<h4><a href='delete.php?id=" . $rows['id'] . "'> X</a></h4>";
                                echo "<h1>" . $rows['name'] . "</h1>";
                                echo "<h2>" . $rows['date_publish'] . "</h2></br></br>";
                                echo "<h3>" . $rows['comments'] . "</h3>";
                                echo "</div>";
                                }
                            }
						echo"</article>"; 
				}
			}
		?>
	</div>
	<footer>
		<div>
			<p>Copyright &copy; 2017 <a href="">Community</a></p>
		</div>
	</footer>
</body>
</html>