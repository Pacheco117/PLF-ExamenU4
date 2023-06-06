<?php
// Connect to the database (replace the connection details with your own)
$servername = "127.0.0.1";
$username = "root";
$password = "";
$dbname = "tienda";
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Fetch categories from the database
$sql = "SELECT idCategoria, categoria FROM categoria";
$result = $conn->query($sql);

// Prepare the response array
$categories = [];

if ($result->num_rows > 0) {
    // Fetch categories as associative array
    while ($row = $result->fetch_assoc()) {
        $categories[] = $row;
    }
}

// Close the database connection
$conn->close();

// Send the response as JSON
header('Content-Type: application/json');
echo json_encode($categories);
?>
