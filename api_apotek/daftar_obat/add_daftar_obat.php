<?php
include '../conn.php';
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: POST");
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nama_obat = $_POST['nama_obat'];
    $stock = $_POST['stock'];
    $tgl_kadaluarsa = $_POST['tgl_kadaluarsa'];

    $query = "INSERT INTO daftar_obat (nama_obat, stock, tgl_kadaluarsa) VALUES ('$nama_obat', $stock, '$tgl_kadaluarsa')";

    if ($connect->query($query) === TRUE) {
        $last_id = $connect->insert_id;
        $result = $connect->query("SELECT * FROM daftar_obat WHERE kode_obat = $last_id");

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
