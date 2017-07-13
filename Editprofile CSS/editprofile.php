<!DOCTYPE html>
<html>
    <head>
<link rel="stylesheet" href ="style/style1.css">
</head>
<?php
include('config.php');
session_start();


$sql = "SELECT * from users u JOIN accounts a on u.accountID = a.accountID where a.accountID ='".$_SESSION["userID"]."'";

$result = mysqli_query($db, $sql);
    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()){
            echo" <form name='editprofile' action='update2.php' method='POST'>
                <div class='container'>
                    <div class='main-login main-center'>
        
                        <div class='form-group'>
                            <small>First Name</small>
                                <div>
                                    <input class='form-control' type='text' name='fName' value='$row[fName]'>
                                </div>
                        </div>

                        <div class='form-group'>
                            <small>Middle Name</small>
                                <div>
                                    <input class='form-control' type='text' name='mName' value='$row[mName]'>
                                </div>
                        </div>
         
                        <div class='form-group'>
                            <small>Last Name</small>
                                <div>
                                    <input class='form-control' type='text' name='lName' value='$row[lName]'>
                                </div>
                        </div>

                        <div class='form-group'>
                            <small>Username</small>
                                <div>
                                    <input class='form-control' type='text' name='username' value='$row[username]'>
                            </div>      
                        </div>
            
                        <div class='form-group'>
                            <small>Password</small>
                                <div>
                                    <input class='form-control' type='text' name='password' value='$row[password]'>
                                </div>
                        </div>
            
                        <div class='form-group'>
                            <small>Upload Profile Photo:</small>
                                <div>
                                    <img id='myImg' src='data:image/jpeg;base64,".base64_encode($row["photo"])."' height='200px' width='auto' />
	                   	            <input class='form-control' name='image' type='file' multiple accept='image/gif, image/jpeg, image/png'>
				                </div>
                        <div class='form-group'>
                             <button class='btn btn-default btn-block submit-button' type='Submit' value='Submit' id='submit'>Save Changes</button>
                        </div>
                    </div>
                </div>
            </form>";
                    
        }
    }
?>
</html>