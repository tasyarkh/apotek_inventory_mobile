<?php
include '../conn.php';

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: GET, POST, DELETE, PUT, OPTIONS");
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = isset($_POST['id']) ? intval($_POST['id']) : 0;

    if ($id > 0) {
        $stmt = $connect->prepare("DELETE FROM pelanggan WHERE id = ?");
        $stmt->bind_param("i", $id);

        if ($stmt->execute()) {
            http_response_code(200); // Harus 200 atau 201
            echo json_encode([
                "success" => true,
                "message" => "Data berhasil dihapus"
            ]);
        } else {
            http_response_code(500);
            echo json_encode([
                "success" => false,
                "message" => "Gagal menghapus data: " . $stmt->error
            ]);
        }

        $stmt->close();
    } else {
        http_response_code(400);
        echo json_encode([
            "success" => false,
            "message" => "ID tidak valid"
        ]);
    }
} else {
    http_response_code(405);
    echo json_encode([
        "success" => false,
        "message" => "Metode tidak diizinkan"
    ]);
}
?>
