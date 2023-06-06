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

// Retrieve the product ID from the request parameters
$productId = $_GET['id'];

// Prepare the SQL statement
$stmt = $conn->prepare("DELETE FROM productos WHERE idProducto = ?");
$stmt->bind_param("i", $productId);
$success = $stmt->execute();

// Prepare the response array
$response = [
    'success' => $success
];

// Close the statement and the database connection
$stmt->close();
$conn->close();

// Send the response as JSON
header('Content-Type: application/json');
echo json_encode($response);
?>
