-- XAMPP-Lite
-- version 8.4.6
-- https://xampplite.sf.net/
--
-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 26, 2025 at 07:43 AM
-- Server version: 11.4.5-MariaDB-log
-- PHP Version: 8.4.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `expenses`
--

-- --------------------------------------------------------

--
-- Table structure for table `expense`
--

CREATE TABLE `expense` (
  `id` smallint(6) UNSIGNED NOT NULL,
  `user_id` smallint(6) UNSIGNED NOT NULL,
  `item` varchar(50) NOT NULL,
  `paid` mediumint(9) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expense`
--

INSERT INTO `expense` (`id`, `user_id`, `item`, `paid`, `date`) VALUES
(1, 1, 'Keyboard', 2500, '2025-08-21 03:38:16'),
(2, 2, 'Laptop', 28000, '2025-08-20 10:38:17'),
(3, 1, 'Bike', 36000, '2025-08-14 10:41:38'),
(4, 2, 'coffee', 70, '2025-08-21 03:41:37'),
(6, 3, 'water', 6, '2025-08-26 10:04:31'),
(7, 1, 'kfc', 200, '2025-08-26 10:18:34'),
(9, 2, 'Iphone', 30000, '2025-08-26 06:12:48');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` smallint(6) UNSIGNED NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`) VALUES
(1, 'Koe', '$2b$10$lEVGux3eHlbyiCKf65mcf.ON9kq3r83ouSnuVOrlMn36arSD4CyE2'),
(2, 'Jay', '$2b$10$IuA3vEVPItzX6qGy.ydhYOaUquIDEjIRT.VgKkCOrmWdG9IJKaoKO'),
(3, 'Cat', '$2b$10$XXg1SWTbE.g1GltbujgXEeE2uFHsFLqUSkt0b5XcQkyMFxWn.o70i');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `expense`
--
ALTER TABLE `expense`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `expense`
--
ALTER TABLE `expense`
  MODIFY `id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `expense`
--
ALTER TABLE `expense`
  ADD CONSTRAINT `expense_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
