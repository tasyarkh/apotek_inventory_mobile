<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

include '../conn.php';

$queryResult = $connect->query("SELECT * FROM stock_obat");

$result = array();
if ($queryResult) {
    while ($fetchData = $queryResult->fetch_assoc()) {
        $result[] = $fetchData;
    }
    echo json_encode($result);
} else {
    echo json_encode(['error' => 'Query failed: ' . $connect->error]);
}

?>
