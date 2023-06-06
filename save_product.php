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

// Retrieve the product data from the request body
$productData = json_decode(file_get_contents('php://input'), true);

// Prepare the SQL statement
$stmt = $conn->prepare("INSERT INTO productos (idProducto, producto, precio, idCategoria) VALUES (?, ?, ?, ?)");

// Bind parameters and execute the statement
$stmt->bind_param("issi", $productData['idProducto'], $productData['producto'], $productData['precio'], $productData['idCategoria']);
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
