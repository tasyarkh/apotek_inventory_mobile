<?php
include '../conn.php';
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: POST");
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
$id_stock = $_POST['id_stock'];

$query = "DELETE FROM stock_obat_in_out WHERE id_stock='$id_stock'";

if ($connect->query($query) === TRUE) {
    echo json_encode(["success" => true, "message" => "Data berhasil dihapus"]);
} else {
    echo json_encode(["success" => false, "message" => "Gagal menghapus data: " . $conn->error]);
}
} else {
echo json_encode(["success" => false, "message" => "Invalid Request"]);
}
?>
