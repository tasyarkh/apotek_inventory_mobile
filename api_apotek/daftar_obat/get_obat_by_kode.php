<?php
include '../conn.php';
header("Access-Control-Allow-Origin: *");
header('Content-Type: application/json');

$kode_obat = $_GET['kode_obat'];
$result = $connect->query("SELECT stok FROM daftar_obat WHERE kode_obat = '$kode_obat'");
if ($result && $result->num_rows > 0) {
    $data = $result->fetch_assoc();
    echo json_encode($data);
} else {
    echo json_encode(["stok" => 0]);
}
