<?php
	session_start();
	include('config.php');

	$sql = "SELECT DISTINCT(p.id), u.idno, p.post, p.postedOn, CONCAT(u.fName, '&nbsp;', u.lName) AS name FROM friends f
			INNER JOIN users u ON f.friendsWith = u.idno OR f.friendOf= u.idno AND NOT (f.friendsWith != u.idno AND f.friendOf != u.idno)
			INNER JOIN posts p ON p.idno = u.idno WHERE (u.idno != '".$_SESSION["userID"]."' OR u.idno = '".$_SESSION["userID"]."')
			AND (f.friendsWith = '".$_SESSION["userID"]."' OR f.friendOf = '".$_SESSION["userID"]."') AND p.visibility = 'Public' ORDER BY p.postedOn DESC";
	$result = mysqli_query($db, $sql);
    
    $sql2 ="SELECT c.id, CONCAT(u.fName, '&nbsp;', u.lName) AS name, c.comment, c.datePublished, c.postID FROM comments c INNER JOIN users u ON c.user = u.idno";
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
			<input name="searchValue" type="search" placeholder="Search for more friends" required>
			<noscript><input type='submit' value='Submit'></noscript>
		</form>
         
		<nav>
			<ul>
				<li><a href="index.php">Home</a></li>
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
                <input name="image" id="image" type="file" accept="image/gif, image/jpeg, image/png">
                <input name="file" id="file" type="file" accept="file_extension">
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
	                                <textarea name='comment' placeholder='Leave Comments Here...' ></textarea>
	                                <input name='postID' type='hidden' oncopy='return false' onpaste='return false' onkeyup='javascript:this.value=this.value.replace(/[<,>]/g,'');' value='$row[id]'/>
	                                <input type='submit' value='Submit'>
                                </form>";
                            if($result2->num_rows > 0 ){
	                            while($rows=mysqli_fetch_array($result2)) {
	                            	if($rows['postID'] == $row['id']){
	                            		echo "<hr>";
		                                echo "<div class='comments_content'>";
		                                echo "<small><a href='delete.php?id=".$rows['id']."'> X</a></small>";
		                                echo"<p>".$row['name']."</p>";
		                                echo "<small>".$rows['datePublished']."</small></br></br>";
		                                echo "<p>".$rows['comment']."</p>";
		                                echo "</div>";
	                            	}
	                            }
                            }
						echo"</article>"; 
				}
			}
		?>
	</div>
	<footer>
		<div>
			<p>Copyright &copy; 2017 <a href="index.php">Community</a></p>
		</div>
	</footer>
</body>
</html>