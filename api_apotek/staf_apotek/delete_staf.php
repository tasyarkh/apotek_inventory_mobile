<?php
include '../conn.php';
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: POST");
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = $_POST['id'];

    $query = "DELETE FROM staf_apotek WHERE id=$id";

    if ($connect->query($query) === TRUE) {
        echo json_encode(["success" => true, "message" => "Data berhasil dihapus"]);
    } else {
        echo json_encode(["success" => false, "message" => "Data gagal dihapus: " . $connect->error]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Invalid Request"]);
}
?>
