<?php
    mysql_connect("localhost","mainuser","password") or die("could not connect");
    mysql_select_db("Sript") or die("could not find db");

    if(isset($_POST['search'])) {
        $searchq = $_POST['search'];
        $searchq = preg_replace("#[^0-9a-z]#i",""$searchq);
        
        $query = mysql_query("SELECT * FROM users WHERE last_name LIKE '%$searchq%' OR first_name LIKE '%$searchq%'") or die("could not search");
        
        $count = my_sql_num_rows($query);
        if($count == 0) {
            $output = 'There was no search results!';
        } else {
            while($row = mysql_fetch_array($query)) {
                $fname = $row['first_name'];
                $lname = $row['last_name'];
                $id = $row['idusers'];
                
                $output .= '<div>'.$fname.' '.$lname.'</div>'; 
            }
        }
    }

?>
<!doctype html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html" charset="utf-8"/>
    <title>Search</title>
    
</head>
<body>
    <form action="index.php" method="post">
        <input type="text" name="search" placeholder="search for members"/>
        <input type="submit" value=">>" />
    </form>
    
    <?php print("$output");?>
</body>
</html>
