-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 26, 2024 at 03:26 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cafe`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `hitung_bonus_staf` (IN `staf_id` INT, IN `target_penjualan` INT)   BEGIN
    DECLARE total_penjualan INT;

    -- Hitung total penjualan staf
    SELECT SUM(total_harga) INTO total_penjualan
    FROM pesanan
    WHERE staf_id = staf_id;

    -- Periksa apakah mencapai target
    IF total_penjualan >= target_penjualan THEN
        SELECT 'Bonus diberikan' AS status;
    ELSE
        SELECT 'Bonus tidak diberikan' AS status;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `p_getAllMenu` ()   BEGIN
	DECLARE total_menu INT;
    
    SELECT COUNT(*) INTO total_menu FROM menu;
    
    IF total_menu > 0 THEN
    	SELECT * FROM menu;
    ELSE
    	SELECT "Menu kosong!";
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `detail_pesanan`
--

CREATE TABLE `detail_pesanan` (
  `id` int NOT NULL,
  `menu_id` int NOT NULL,
  `pesanan_id` int NOT NULL,
  `jumlah` int NOT NULL,
  `harga_satuan` int NOT NULL,
  `subtotal` int NOT NULL,
  `tanggal_dibuat` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tanggal_diperbarui` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detail_pesanan`
--

INSERT INTO `detail_pesanan` (`id`, `menu_id`, `pesanan_id`, `jumlah`, `harga_satuan`, `subtotal`, `tanggal_dibuat`, `tanggal_diperbarui`) VALUES
(1, 1, 1, 1, 20000, 20000, '2024-07-25 22:24:59', '2024-07-25 22:24:59'),
(2, 4, 1, 1, 30000, 30000, '2024-07-25 22:24:59', '2024-07-25 22:24:59'),
(3, 4, 2, 1, 30000, 30000, '2024-07-25 22:24:59', '2024-07-25 22:24:59'),
(4, 5, 2, 1, 15000, 15000, '2024-07-25 22:24:59', '2024-07-25 22:24:59'),
(5, 2, 3, 1, 19500, 19500, '2024-07-25 22:24:59', '2024-07-25 22:24:59'),
(6, 4, 3, 1, 30000, 30000, '2024-07-25 22:24:59', '2024-07-25 22:24:59'),
(7, 4, 4, 1, 30000, 30000, '2024-07-25 22:24:59', '2024-07-25 22:24:59'),
(8, 1, 5, 3, 20000, 60000, '2024-07-25 22:24:59', '2024-07-25 22:24:59'),
(9, 6, 1, 1, 5000, 5000, '2024-07-26 06:49:54', '2024-07-26 06:49:54');

-- --------------------------------------------------------

--
-- Stand-in structure for view `detail_pesanan_lengkap`
-- (See below for the actual view)
--
CREATE TABLE `detail_pesanan_lengkap` (
`harga_satuan` int
,`id_detail_pesanan` int
,`id_pesanan` int
,`jumlah` int
,`nama_menu` varchar(255)
,`subtotal` int
);

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `id` int NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `tanggal_dibuat` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tanggal_diperbarui` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`id`, `nama`, `tanggal_dibuat`, `tanggal_diperbarui`) VALUES
(1, 'Coffee', '2024-07-25 22:02:39', '2024-07-25 22:02:39'),
(2, 'Non Coffee', '2024-07-25 22:02:39', '2024-07-25 22:02:39'),
(3, 'Juice', '2024-07-25 22:02:39', '2024-07-25 22:02:39'),
(4, 'Makanan', '2024-07-25 22:02:39', '2024-07-25 22:02:39'),
(5, 'Snack', '2024-07-25 22:02:39', '2024-07-25 22:02:39');

-- --------------------------------------------------------

--
-- Table structure for table `log_perubahan`
--

CREATE TABLE `log_perubahan` (
  `id` int NOT NULL,
  `aksi` varchar(50) DEFAULT NULL,
  `tabel_yang_terpengaruh` varchar(50) DEFAULT NULL,
  `detail_perubahan` text,
  `waktu_perubahan` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `id` int NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `deskripsi` text COLLATE utf8mb4_general_ci NOT NULL,
  `kategori` int NOT NULL,
  `harga` int NOT NULL,
  `gambar` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `tanggal_dibuat` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tanggal_diperbarui` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`id`, `nama`, `deskripsi`, `kategori`, `harga`, `gambar`, `tanggal_dibuat`, `tanggal_diperbarui`) VALUES
(1, 'Americano', 'Espresso tambah air putih', 1, 20000, 'americano.jpg', '2024-07-25 22:08:19', '2024-07-25 22:08:19'),
(2, 'Cappuccino', 'Kopi susu ini mah', 1, 19500, 'cappuccino.jpg', '2024-07-25 22:08:19', '2024-07-25 22:08:19'),
(3, 'Juice Jambu', 'Jambu diblender bangg', 2, 13000, 'jambu.jpg', '2024-07-25 22:08:19', '2024-07-25 22:08:19'),
(4, 'Nasi Goreng', 'Nasi goreng dengan ayam dan telur', 4, 30000, 'nasi_goreng.jpg', '2024-07-25 22:08:19', '2024-07-25 22:08:19'),
(5, 'Ice Cream', 'Ice cream vanilla dengan topping cokelat', 5, 15000, 'ice_cream.jpg', '2024-07-25 22:08:19', '2024-07-25 22:08:19'),
(6, 'Keripik Singkong', 'Keripik singkong renyah', 5, 5000, 'keripik.jpg', '2024-07-25 22:08:19', '2024-07-25 22:08:19');

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id` int NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `no_tlp` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `tanggal_dibuat` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tanggal_diperbarui` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`id`, `nama`, `no_tlp`, `tanggal_dibuat`, `tanggal_diperbarui`) VALUES
(1, 'Wisnu', '08123456789', '2024-07-25 22:09:54', '2024-07-25 22:09:54'),
(2, 'Nadia', '08129876543', '2024-07-25 22:09:54', '2024-07-25 22:09:54'),
(3, 'Humam', '08134567890', '2024-07-25 22:09:54', '2024-07-25 22:09:54'),
(4, 'Afiq', '08145678901', '2024-07-25 22:09:54', '2024-07-25 22:09:54'),
(5, 'Si item', '08156789012', '2024-07-25 22:09:54', '2024-07-25 22:09:54'),
(6, 'wawan', '09123923213', '2024-07-26 05:25:25', '2024-07-26 05:25:25');

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id` int NOT NULL,
  `pesanan_id` int NOT NULL,
  `metode_pembayaran` enum('cash','ewallet','kartu_kredit','QRIS') COLLATE utf8mb4_general_ci NOT NULL,
  `jumlah` int NOT NULL,
  `tanggal_pembayaran` datetime DEFAULT NULL,
  `tanggal_dibuat` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tanggal_diperbarui` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pembayaran`
--

INSERT INTO `pembayaran` (`id`, `pesanan_id`, `metode_pembayaran`, `jumlah`, `tanggal_pembayaran`, `tanggal_dibuat`, `tanggal_diperbarui`) VALUES
(1, 1, 'cash', 50000, '2024-07-25 22:18:45', '2024-07-25 22:18:45', '2024-07-25 22:18:45'),
(2, 2, 'ewallet', 45000, '2024-07-25 22:18:45', '2024-07-25 22:18:45', '2024-07-25 22:18:45'),
(3, 3, 'kartu_kredit', 49500, '2024-07-25 22:18:45', '2024-07-25 22:18:45', '2024-07-25 22:18:45'),
(4, 4, 'QRIS', 30000, '2024-07-25 22:18:45', '2024-07-25 22:18:45', '2024-07-25 22:18:45'),
(5, 5, 'cash', 60000, '2024-07-25 22:18:45', '2024-07-25 22:18:45', '2024-07-25 22:18:45');

-- --------------------------------------------------------

--
-- Table structure for table `pesanan`
--

CREATE TABLE `pesanan` (
  `id` int NOT NULL,
  `pelanggan_id` int NOT NULL,
  `staf_id` int NOT NULL,
  `total_harga` int NOT NULL,
  `tanggal_dibuat` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tanggal_diperbarui` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pesanan`
--

INSERT INTO `pesanan` (`id`, `pelanggan_id`, `staf_id`, `total_harga`, `tanggal_dibuat`, `tanggal_diperbarui`) VALUES
(1, 1, 1, 55000, '2024-07-25 22:18:05', '2024-07-26 06:45:31'),
(2, 2, 1, 45000, '2024-07-25 22:18:05', '2024-07-25 22:18:05'),
(3, 3, 6, 49500, '2024-07-25 22:18:05', '2024-07-25 22:18:05'),
(4, 4, 6, 30000, '2024-07-25 22:18:05', '2024-07-25 22:18:05'),
(5, 5, 6, 60000, '2024-07-25 22:18:05', '2024-07-25 22:18:05');

--
-- Triggers `pesanan`
--
DELIMITER $$
CREATE TRIGGER `after_delete_pesanan` AFTER DELETE ON `pesanan` FOR EACH ROW BEGIN
    INSERT INTO log_perubahan (aksi, tabel_yang_terpengaruh, detail_perubahan, waktu_perubahan)
    VALUES ('AFTER DELETE', 'pesanan', CONCAT('Pelanggan ID: ', OLD.pelanggan_id), NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_pesanan` AFTER INSERT ON `pesanan` FOR EACH ROW BEGIN
    INSERT INTO log_perubahan (aksi, tabel_yang_terpengaruh, detail_perubahan, waktu_perubahan)
    VALUES ('AFTER INSERT', 'pesanan', CONCAT('Pelanggan ID: ', NEW.pelanggan_id, ', Staf ID: ', NEW.staf_id), NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_pesanan` AFTER UPDATE ON `pesanan` FOR EACH ROW BEGIN
    INSERT INTO log_perubahan (aksi, tabel_yang_terpengaruh, detail_perubahan, waktu_perubahan)
    VALUES ('AFTER UPDATE', 'pesanan', CONCAT('Pelanggan ID: ', OLD.pelanggan_id, ' ke ', NEW.pelanggan_id), NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_delete_pesanan` BEFORE DELETE ON `pesanan` FOR EACH ROW BEGIN
    INSERT INTO log_perubahan (aksi, tabel_yang_terpengaruh, detail_perubahan, waktu_perubahan)
    VALUES ('DELETE', 'pesanan', CONCAT('Pelanggan ID: ', OLD.pelanggan_id), NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_insert_pesanan` BEFORE INSERT ON `pesanan` FOR EACH ROW BEGIN
    INSERT INTO log_perubahan (aksi, tabel_yang_terpengaruh, detail_perubahan, waktu_perubahan)
    VALUES ('INSERT', 'pesanan', CONCAT('Pelanggan ID: ', NEW.pelanggan_id, ', Staf ID: ', NEW.staf_id), NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_update_pesanan` BEFORE UPDATE ON `pesanan` FOR EACH ROW BEGIN
    INSERT INTO log_perubahan (aksi, tabel_yang_terpengaruh, detail_perubahan, waktu_perubahan)
    VALUES ('UPDATE', 'pesanan', CONCAT('Pelanggan ID: ', OLD.pelanggan_id, ' ke ', NEW.pelanggan_id), NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `pesanan_lengkap`
-- (See below for the actual view)
--
CREATE TABLE `pesanan_lengkap` (
`id_pesanan` int
,`jumlah` int
,`nama_menu` varchar(255)
,`nama_pelanggan` varchar(255)
,`nama_staf` varchar(255)
,`subtotal` int
,`tanggal_dibuat` datetime
,`total_harga` int
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `pesanan_sebulan`
-- (See below for the actual view)
--
CREATE TABLE `pesanan_sebulan` (
`id` int
,`pelanggan_id` int
,`staf_id` int
,`tanggal_dibuat` datetime
,`tanggal_diperbarui` datetime
,`total_harga` int
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `pesanan_sebulan_detail`
-- (See below for the actual view)
--
CREATE TABLE `pesanan_sebulan_detail` (
`harga_satuan` int
,`id` int
,`jumlah` int
,`menu_id` int
,`pesanan_id` int
,`subtotal` int
,`tanggal_dibuat` datetime
,`tanggal_diperbarui` datetime
);

-- --------------------------------------------------------

--
-- Table structure for table `staf`
--

CREATE TABLE `staf` (
  `id` int NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `no_tlp` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `password` text COLLATE utf8mb4_general_ci NOT NULL,
  `role` enum('kasir','pelayan','koki') COLLATE utf8mb4_general_ci NOT NULL,
  `tanggal_dibuat` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tanggal_diperbarui` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staf`
--

INSERT INTO `staf` (`id`, `nama`, `no_tlp`, `password`, `role`, `tanggal_dibuat`, `tanggal_diperbarui`) VALUES
(1, 'Anton', '08123456789', 'akucahkerjo', 'kasir', '2024-07-25 22:12:44', '2024-07-25 22:12:44'),
(2, 'Linus Torvalds', '08129876543', 'rahasia', 'pelayan', '2024-07-25 22:12:44', '2024-07-25 22:12:44'),
(3, 'Gordon Ramsay', '08134567890', 'bismillah', 'koki', '2024-07-25 22:12:44', '2024-07-25 22:12:44'),
(4, 'Udin', '08145678901', '12345678', 'kasir', '2024-07-25 22:12:44', '2024-07-25 22:12:44'),
(5, 'Budi', '08156789012', 'budianakbaikcoy', 'pelayan', '2024-07-25 22:12:44', '2024-07-25 22:12:44'),
(6, 'Aryo', '08123456789', 'incorrect', 'kasir', '2024-07-25 22:14:14', '2024-07-25 22:14:14');

-- --------------------------------------------------------

--
-- Structure for view `detail_pesanan_lengkap`
--
DROP TABLE IF EXISTS `detail_pesanan_lengkap`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `detail_pesanan_lengkap`  AS SELECT `dp`.`id` AS `id_detail_pesanan`, `p`.`id` AS `id_pesanan`, `m`.`nama` AS `nama_menu`, `dp`.`jumlah` AS `jumlah`, `dp`.`harga_satuan` AS `harga_satuan`, `dp`.`subtotal` AS `subtotal` FROM ((`detail_pesanan` `dp` join `pesanan` `p` on((`dp`.`pesanan_id` = `p`.`id`))) join `menu` `m` on((`dp`.`menu_id` = `m`.`id`)))  ;

-- --------------------------------------------------------

--
-- Structure for view `pesanan_lengkap`
--
DROP TABLE IF EXISTS `pesanan_lengkap`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pesanan_lengkap`  AS SELECT `p`.`id` AS `id_pesanan`, `plg`.`nama` AS `nama_pelanggan`, `s`.`nama` AS `nama_staf`, `m`.`nama` AS `nama_menu`, `dp`.`jumlah` AS `jumlah`, `dp`.`subtotal` AS `subtotal`, `p`.`total_harga` AS `total_harga`, `p`.`tanggal_dibuat` AS `tanggal_dibuat` FROM ((((`pesanan` `p` join `pelanggan` `plg` on((`p`.`pelanggan_id` = `plg`.`id`))) join `staf` `s` on((`p`.`staf_id` = `s`.`id`))) join `detail_pesanan` `dp` on((`p`.`id` = `dp`.`pesanan_id`))) join `menu` `m` on((`dp`.`menu_id` = `m`.`id`)))  ;

-- --------------------------------------------------------

--
-- Structure for view `pesanan_sebulan`
--
DROP TABLE IF EXISTS `pesanan_sebulan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pesanan_sebulan`  AS SELECT `pesanan`.`id` AS `id`, `pesanan`.`pelanggan_id` AS `pelanggan_id`, `pesanan`.`staf_id` AS `staf_id`, `pesanan`.`total_harga` AS `total_harga`, `pesanan`.`tanggal_dibuat` AS `tanggal_dibuat`, `pesanan`.`tanggal_diperbarui` AS `tanggal_diperbarui` FROM `pesanan` WHERE (`pesanan`.`tanggal_dibuat` >= (now() - interval 1 month)) WITH CASCADED CHECK OPTION  ;

-- --------------------------------------------------------

--
-- Structure for view `pesanan_sebulan_detail`
--
DROP TABLE IF EXISTS `pesanan_sebulan_detail`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pesanan_sebulan_detail`  AS SELECT `detail_pesanan`.`id` AS `id`, `detail_pesanan`.`menu_id` AS `menu_id`, `detail_pesanan`.`pesanan_id` AS `pesanan_id`, `detail_pesanan`.`jumlah` AS `jumlah`, `detail_pesanan`.`harga_satuan` AS `harga_satuan`, `detail_pesanan`.`subtotal` AS `subtotal`, `detail_pesanan`.`tanggal_dibuat` AS `tanggal_dibuat`, `detail_pesanan`.`tanggal_diperbarui` AS `tanggal_diperbarui` FROM `detail_pesanan` WHERE `detail_pesanan`.`pesanan_id` in (select `pesanan_sebulan`.`id` from `pesanan_sebulan`) WITH LOCAL CHECK OPTION  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `detail_pesanan`
--
ALTER TABLE `detail_pesanan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `detail_pesanan_pesanan_id_foreign` (`pesanan_id`),
  ADD KEY `detail_pesanan_menu_id_foreign` (`menu_id`);

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `log_perubahan`
--
ALTER TABLE `log_perubahan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menu_kategori_foreign` (`kategori`),
  ADD KEY `index_nama_menu` (`nama`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `search_in_pelanggan` (`nama`,`no_tlp`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pesanan_id` (`pesanan_id`);

--
-- Indexes for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pesanan_pelanggan_id_foreign` (`pelanggan_id`),
  ADD KEY `pesanan_staf_id_foreign` (`staf_id`);

--
-- Indexes for table `staf`
--
ALTER TABLE `staf`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `detail_pesanan`
--
ALTER TABLE `detail_pesanan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `log_perubahan`
--
ALTER TABLE `log_perubahan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
