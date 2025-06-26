-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 26, 2025 at 06:57 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `app_apotek`
--

-- --------------------------------------------------------

--
-- Table structure for table `daftar_obat`
--

CREATE TABLE `daftar_obat` (
  `kode_obat` int(11) NOT NULL,
  `nama_obat` varchar(100) NOT NULL,
  `stock` int(11) NOT NULL,
  `tgl_kadaluarsa` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `daftar_obat`
--

INSERT INTO `daftar_obat` (`kode_obat`, `nama_obat`, `stock`, `tgl_kadaluarsa`) VALUES
(1, 'Amlodipine', 100, '2026-06-19'),
(2, 'Teosal', 123, '2026-10-15');

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `no_hp` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`id`, `nama`, `alamat`, `no_hp`) VALUES
(1, 'Anton Suronto', 'Jl. Baru 23', '08726256221'),
(2, 'Jiraya Huna', 'Jl. Merdeka 4', '082929372372');

-- --------------------------------------------------------

--
-- Table structure for table `pemasok`
--

CREATE TABLE `pemasok` (
  `kode_perusahaan` int(11) NOT NULL,
  `nama_perusahaan` varchar(100) DEFAULT NULL,
  `alamat_perusahaan` text DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `no_kontak` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pemasok`
--

INSERT INTO `pemasok` (`kode_perusahaan`, `nama_perusahaan`, `alamat_perusahaan`, `email`, `no_kontak`) VALUES
(1, 'PT. Javas Mandiri', 'Jl. Merdeka Mandiri 2', 'javas@gmail.com', '02138232111');

-- --------------------------------------------------------

--
-- Table structure for table `staf_apotek`
--

CREATE TABLE `staf_apotek` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `tgl_lahir` date NOT NULL,
  `tmp_lahir` varchar(100) NOT NULL,
  `no_hp` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staf_apotek`
--

INSERT INTO `staf_apotek` (`id`, `nama`, `alamat`, `tgl_lahir`, `tmp_lahir`, `no_hp`) VALUES
(1, 'Ramadhinte Khoi', 'Jl. Bina Marga 51', '2015-06-01', 'Jakarta', '082132435421');

-- --------------------------------------------------------

--
-- Table structure for table `stock_obat`
--

CREATE TABLE `stock_obat` (
  `id_stock` int(11) NOT NULL,
  `kode_obat` int(11) NOT NULL,
  `jumlah_obat_masuk` int(11) NOT NULL,
  `jumlah_obat_dipesan` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stock_obat`
--

INSERT INTO `stock_obat` (`id_stock`, `kode_obat`, `jumlah_obat_masuk`, `jumlah_obat_dipesan`) VALUES
(1, 1, 100, 80);

-- --------------------------------------------------------

--
-- Table structure for table `stock_obat_in_out`
--

CREATE TABLE `stock_obat_in_out` (
  `id_stock` int(11) NOT NULL,
  `kode_obat` int(11) NOT NULL,
  `jenis_obat` enum('padat','cair','serbuk') NOT NULL,
  `kode_perusahaan` int(11) NOT NULL,
  `jumlah_obat_masuk` int(11) NOT NULL,
  `no_rak_obat` varchar(10) DEFAULT NULL,
  `tgl_obat_masuk` date DEFAULT NULL,
  `kode_pemesan` varchar(20) DEFAULT NULL,
  `nama_pemesan` varchar(100) DEFAULT NULL,
  `jumlah_pesanan_obat` int(11) DEFAULT NULL,
  `tgl_obat_keluar` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `daftar_obat`
--
ALTER TABLE `daftar_obat`
  ADD PRIMARY KEY (`kode_obat`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pemasok`
--
ALTER TABLE `pemasok`
  ADD PRIMARY KEY (`kode_perusahaan`);

--
-- Indexes for table `staf_apotek`
--
ALTER TABLE `staf_apotek`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_obat`
--
ALTER TABLE `stock_obat`
  ADD PRIMARY KEY (`id_stock`),
  ADD KEY `kode_obat` (`kode_obat`);

--
-- Indexes for table `stock_obat_in_out`
--
ALTER TABLE `stock_obat_in_out`
  ADD PRIMARY KEY (`id_stock`),
  ADD KEY `kode_obat` (`kode_obat`),
  ADD KEY `kode_perusahaan` (`kode_perusahaan`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `daftar_obat`
--
ALTER TABLE `daftar_obat`
  MODIFY `kode_obat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pemasok`
--
ALTER TABLE `pemasok`
  MODIFY `kode_perusahaan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `staf_apotek`
--
ALTER TABLE `staf_apotek`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `stock_obat`
--
ALTER TABLE `stock_obat`
  MODIFY `id_stock` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `stock_obat_in_out`
--
ALTER TABLE `stock_obat_in_out`
  MODIFY `id_stock` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `stock_obat`
--
ALTER TABLE `stock_obat`
  ADD CONSTRAINT `stock_obat_ibfk_1` FOREIGN KEY (`kode_obat`) REFERENCES `daftar_obat` (`kode_obat`);

--
-- Constraints for table `stock_obat_in_out`
--
ALTER TABLE `stock_obat_in_out`
  ADD CONSTRAINT `stock_obat_in_out_ibfk_1` FOREIGN KEY (`kode_obat`) REFERENCES `daftar_obat` (`kode_obat`),
  ADD CONSTRAINT `stock_obat_in_out_ibfk_2` FOREIGN KEY (`kode_perusahaan`) REFERENCES `pemasok` (`kode_perusahaan`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
