<?php
include '../conn.php';
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: POST");
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $kode_obat = $_POST['kode_obat'];

    $query = "DELETE FROM daftar_obat WHERE kode_obat = '$kode_obat'";

    if ($connect->query($query) === TRUE) {
        echo json_encode([
            "success" => true,
            "message" => "Data berhasil dihapus"
        ]);
    } else {
        echo json_encode([
            "success" => false,
            "message" => "Gagal menghapus data: " . $connect->error
        ]);
    }
} else {
    echo json_encode([
        "success" => false,
        "message" => "Invalid Request"
    ]);
}
?>
