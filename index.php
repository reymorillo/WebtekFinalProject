<?php
	include('login.php');
	if(isset($_SESSION['loggedin']) && $_SESSION['loggedin'] == true && $_SESSION['accountType'] == 'User') {
		header("Location: User/index.php");
	} else {
		$_SESSION["accountType"] = 'Invalid';
		session_destroy();
	}
?>
<!DOCTYPE html>
<html>
<head>
	<title>Community</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	 
	 <style>
	 	body{
   			background-color: #E4DFDA; 
		}

        #box{
    		border: 1px solid rgb(200, 200, 200);
    		box-shadow: rgba(0, 0, 0, 0.1) 0px 5px 5px 2px;
    		background: rgba(200, 200, 200, 0.1);
    		border-radius: 4px;
    		top:50px;
		}

		img{
			display: block;
    		margin: 0 auto;
		}

		h2{
    		text-align:center;
    		color:#d9534f;
		}

    </style>
	
</head>
	<img src="finallogo.png">
<body>
	<div class="container-fluid">
                <div class="row-fluid" >
                   
                      
                     <div class="col-md-offset-4 col-md-4" id="box">
                      <h2>Login</h2>
                       
                            <hr>
                           

                                <form class="form-horizontal" method="POST" id="contact_form">
                                    <fieldset>
                                        <!-- Form Name -->


                                        <!-- Text input-->

                                        <div class="form-group">

                                            <div class="col-md-12">
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                                    <input name="username" placeholder="Username" class="form-control" type="text">
                                                </div>
                                            </div>
                                        </div>


                                  
                                        <!-- Text input-->
                                        <div class="form-group">

                                            <div class="col-md-12">
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                                    <input name="password" placeholder="Password" class="form-control" type="password">
                                                </div>
                                            </div>
                                        </div>


                                    
                                   
                                        <div class="form-group">

                                            <div class="col-md-12">
                                                <button type="submit" class="btn btn-md btn-danger pull-right">Login </button>
                                            </div>
                                        </div>

                                    </fieldset>
                                </form>
                    </div> 
				</div>
	</div>
</body>
</html>