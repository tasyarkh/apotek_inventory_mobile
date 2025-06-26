<?php
include '../conn.php';
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: POST");
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nama = $_POST['nama'];
    $alamat = $_POST['alamat'];
    $no_hp = $_POST['no_hp'];

    $query = "INSERT INTO pelanggan (nama, alamat, no_hp) VALUES ('$nama', '$alamat', '$no_hp')";

    if ($connect->query($query) === TRUE) {
        $last_id = $connect->insert_id;
        $result = $connect->query("SELECT * FROM pelanggan WHERE id = $last_id");

        if ($result && $row = $result->fetch_assoc()) {
            echo json_encode([
                "success" => true,
                "message" => "Data berhasil ditambahkan",
                "data" => $row
            ]);
        } else {
            echo json_encode([
                "success" => false,
                "message" => "Gagal mengambil data setelah insert"
            ]);
        }
    } else {
        echo json_encode([
            "success" => false,
            "message" => "Data gagal ditambahkan: " . $connect->error
        ]);
    }
} else {
    echo json_encode([
        "success" => false,
        "message" => "Invalid Request"
    ]);
}
?>
