<?php
include '../conn.php';
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: POST");
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $kode_perusahaan = $_POST['kode_perusahaan'];

    $query = "DELETE FROM pemasok WHERE kode_perusahaan='$kode_perusahaan'";

    if ($connect->query($query) === TRUE) {
        echo json_encode(["success" => true, "message" => "Data berhasil dihapus"]);
    } else {
        echo json_encode(["success" => false, "message" => "Gagal menghapus data: " . $conn->error]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Invalid Request"]);
}
?>
