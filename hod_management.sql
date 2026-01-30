-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 27, 2026 at 08:27 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hod_management2`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `id` int(11) NOT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `hod_id` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `status` enum('present','absent','half_day','late','leave') NOT NULL,
  `check_in` time DEFAULT NULL,
  `check_out` time DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`id`, `staff_id`, `hod_id`, `date`, `status`, `check_in`, `check_out`, `remarks`, `created_at`) VALUES
(1, 12, NULL, '2026-01-02', 'present', '10:16:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(2, 13, NULL, '2026-01-01', 'present', '10:21:00', '16:19:00', 'On time', '2026-01-03 05:11:47'),
(3, 1, NULL, '2026-01-02', 'present', '09:23:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(4, 2, NULL, '2026-01-02', 'present', '09:55:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(5, 3, NULL, '2026-01-02', 'half_day', '09:00:00', '13:00:00', 'Half day', '2026-01-03 05:11:47'),
(6, 4, NULL, '2026-01-02', '', NULL, NULL, 'On leave', '2026-01-03 05:11:47'),
(7, 5, NULL, '2026-01-02', 'absent', NULL, NULL, 'Sick leave', '2026-01-03 05:11:47'),
(8, 6, NULL, '2026-01-02', 'absent', NULL, NULL, 'Sick leave', '2026-01-03 05:11:47'),
(9, 7, NULL, '2026-01-02', '', NULL, NULL, 'On leave', '2026-01-03 05:11:47'),
(10, 8, NULL, '2026-01-02', 'present', '10:45:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(11, 9, NULL, '2026-01-02', 'present', '10:57:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(12, 10, NULL, '2026-01-02', 'present', '10:10:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(13, 11, NULL, '2026-01-02', 'present', '09:31:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(14, 12, NULL, '2026-01-02', 'present', '09:58:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(15, 13, NULL, '2026-01-02', 'absent', NULL, NULL, 'Sick leave', '2026-01-03 05:11:47'),
(16, 14, NULL, '2026-01-02', '', NULL, NULL, 'On leave', '2026-01-03 05:11:47'),
(17, 15, NULL, '2026-01-02', 'present', '09:15:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(18, 16, NULL, '2026-01-02', 'present', '10:20:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(19, 17, NULL, '2026-01-02', 'present', '09:56:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(20, 18, NULL, '2026-01-02', 'present', '10:02:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(21, 19, NULL, '2026-01-02', 'present', '09:46:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(22, 1, NULL, '2026-01-01', 'present', '09:12:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(23, 2, NULL, '2026-01-01', 'present', '10:18:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(24, 3, NULL, '2026-01-01', 'present', '09:50:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(25, 4, NULL, '2026-01-01', 'present', '10:05:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(26, 5, NULL, '2026-01-01', 'half_day', '09:00:00', '13:00:00', 'Half day', '2026-01-03 05:11:47'),
(27, 6, NULL, '2026-01-01', '', NULL, NULL, 'On leave', '2026-01-03 05:11:47'),
(28, 7, NULL, '2026-01-01', 'present', '09:44:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(29, 8, NULL, '2026-01-01', '', NULL, NULL, 'On leave', '2026-01-03 05:11:47'),
(30, 9, NULL, '2026-01-01', 'present', '10:35:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(31, 10, NULL, '2026-01-01', 'present', '10:17:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(32, 11, NULL, '2026-01-01', 'half_day', '09:00:00', '13:00:00', 'Half day', '2026-01-03 05:11:47'),
(33, 12, NULL, '2026-01-01', 'absent', NULL, NULL, 'Sick leave', '2026-01-03 05:11:47'),
(34, 13, NULL, '2026-01-01', 'present', '10:13:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(35, 14, NULL, '2026-01-01', 'present', '10:52:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(36, 15, NULL, '2026-01-01', 'present', '09:20:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(37, 16, NULL, '2026-01-01', 'present', '10:53:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(38, 17, NULL, '2026-01-01', '', NULL, NULL, 'On leave', '2026-01-03 05:11:47'),
(39, 18, NULL, '2026-01-01', 'present', '09:12:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(40, 19, NULL, '2026-01-01', 'half_day', '09:00:00', '13:00:00', 'Half day', '2026-01-03 05:11:47'),
(41, 1, NULL, '2025-12-31', 'present', '10:09:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(42, 2, NULL, '2025-12-31', 'present', '09:24:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(43, 3, NULL, '2025-12-31', 'half_day', '09:00:00', '13:00:00', 'Half day', '2026-01-03 05:11:47'),
(44, 4, NULL, '2025-12-31', 'present', '10:36:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(45, 5, NULL, '2025-12-31', 'present', '09:24:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(46, 6, NULL, '2025-12-31', 'present', '09:43:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(47, 7, NULL, '2025-12-31', 'present', '10:32:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(48, 8, NULL, '2025-12-31', 'present', '10:48:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(49, 9, NULL, '2025-12-31', 'present', '09:09:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(50, 10, NULL, '2025-12-31', 'present', '09:59:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(51, 11, NULL, '2025-12-31', 'present', '09:33:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(52, 12, NULL, '2025-12-31', 'present', '09:17:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(53, 13, NULL, '2025-12-31', 'absent', NULL, NULL, 'Sick leave', '2026-01-03 05:11:47'),
(54, 14, NULL, '2025-12-31', 'present', '10:48:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(55, 15, NULL, '2025-12-31', 'half_day', '09:00:00', '13:00:00', 'Half day', '2026-01-03 05:11:47'),
(56, 16, NULL, '2025-12-31', 'present', '10:39:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(57, 17, NULL, '2025-12-31', 'half_day', '09:00:00', '13:00:00', 'Half day', '2026-01-03 05:11:47'),
(58, 18, NULL, '2025-12-31', 'half_day', '09:00:00', '13:00:00', 'Half day', '2026-01-03 05:11:47'),
(59, 19, NULL, '2025-12-31', '', NULL, NULL, 'On leave', '2026-01-03 05:11:47'),
(60, 1, NULL, '2025-12-30', 'absent', NULL, NULL, 'Sick leave', '2026-01-03 05:11:47'),
(61, 2, NULL, '2025-12-30', 'present', '09:49:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(62, 3, NULL, '2025-12-30', '', NULL, NULL, 'On leave', '2026-01-03 05:11:47'),
(63, 4, NULL, '2025-12-30', 'absent', NULL, NULL, 'Sick leave', '2026-01-03 05:11:47'),
(64, 5, NULL, '2025-12-30', '', NULL, NULL, 'On leave', '2026-01-03 05:11:47'),
(65, 6, NULL, '2025-12-30', 'present', '09:33:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(66, 7, NULL, '2025-12-30', 'present', '10:48:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(67, 8, NULL, '2025-12-30', 'absent', NULL, NULL, 'Sick leave', '2026-01-03 05:11:47'),
(68, 9, NULL, '2025-12-30', 'half_day', '09:00:00', '13:00:00', 'Half day', '2026-01-03 05:11:47'),
(69, 10, NULL, '2025-12-30', '', NULL, NULL, 'On leave', '2026-01-03 05:11:47'),
(70, 11, NULL, '2025-12-30', 'present', '10:14:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(71, 12, NULL, '2025-12-30', 'present', '09:28:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(72, 13, NULL, '2025-12-30', '', NULL, NULL, 'On leave', '2026-01-03 05:11:47'),
(73, 14, NULL, '2025-12-30', 'half_day', '09:00:00', '13:00:00', 'Half day', '2026-01-03 05:11:47'),
(74, 15, NULL, '2025-12-30', 'present', '09:49:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(75, 16, NULL, '2025-12-30', 'present', '10:49:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(76, 17, NULL, '2025-12-30', 'half_day', '09:00:00', '13:00:00', 'Half day', '2026-01-03 05:11:47'),
(77, 18, NULL, '2025-12-30', '', NULL, NULL, 'On leave', '2026-01-03 05:11:47'),
(78, 19, NULL, '2025-12-30', 'present', '10:26:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(79, 1, NULL, '2025-12-29', 'present', '10:19:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(80, 2, NULL, '2025-12-29', 'present', '10:01:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(81, 3, NULL, '2025-12-29', 'absent', NULL, NULL, 'Sick leave', '2026-01-03 05:11:47'),
(82, 4, NULL, '2025-12-29', 'present', '09:52:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(83, 5, NULL, '2025-12-29', 'present', '10:57:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(84, 6, NULL, '2025-12-29', 'present', '09:18:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(85, 7, NULL, '2025-12-29', 'present', '10:52:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(86, 8, NULL, '2025-12-29', 'half_day', '09:00:00', '13:00:00', 'Half day', '2026-01-03 05:11:47'),
(87, 9, NULL, '2025-12-29', 'present', '09:36:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(88, 10, NULL, '2025-12-29', 'present', '09:51:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(89, 11, NULL, '2025-12-29', 'present', '09:02:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(90, 12, NULL, '2025-12-29', 'half_day', '09:00:00', '13:00:00', 'Half day', '2026-01-03 05:11:47'),
(91, 13, NULL, '2025-12-29', 'half_day', '09:00:00', '13:00:00', 'Half day', '2026-01-03 05:11:47'),
(92, 14, NULL, '2025-12-29', '', NULL, NULL, 'On leave', '2026-01-03 05:11:47'),
(93, 15, NULL, '2025-12-29', '', NULL, NULL, 'On leave', '2026-01-03 05:11:47'),
(94, 16, NULL, '2025-12-29', 'half_day', '09:00:00', '13:00:00', 'Half day', '2026-01-03 05:11:47'),
(95, 17, NULL, '2025-12-29', 'present', '09:51:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(96, 18, NULL, '2025-12-29', 'present', '10:20:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(97, 19, NULL, '2025-12-29', '', NULL, NULL, 'On leave', '2026-01-03 05:11:47'),
(98, 1, NULL, '2025-12-28', 'present', '09:50:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(99, 2, NULL, '2025-12-28', 'present', '09:40:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(100, 3, NULL, '2025-12-28', 'present', '10:13:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(101, 4, NULL, '2025-12-28', 'present', '10:37:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(102, 5, NULL, '2025-12-28', 'present', '09:37:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(103, 6, NULL, '2025-12-28', 'present', '09:48:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(104, 7, NULL, '2025-12-28', '', NULL, NULL, 'On leave', '2026-01-03 05:11:47'),
(105, 8, NULL, '2025-12-28', 'present', '09:47:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(106, 9, NULL, '2025-12-28', '', NULL, NULL, 'On leave', '2026-01-03 05:11:47'),
(107, 10, NULL, '2025-12-28', 'present', '10:04:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(108, 11, NULL, '2025-12-28', 'present', '10:27:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(109, 12, NULL, '2025-12-28', 'present', '10:18:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(110, 13, NULL, '2025-12-28', 'absent', NULL, NULL, 'Sick leave', '2026-01-03 05:11:47'),
(111, 14, NULL, '2025-12-28', 'present', '09:27:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(112, 15, NULL, '2025-12-28', 'present', '09:53:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(113, 16, NULL, '2025-12-28', 'present', '10:13:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(114, 17, NULL, '2025-12-28', 'present', '09:01:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(115, 18, NULL, '2025-12-28', 'present', '09:19:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(116, 19, NULL, '2025-12-28', 'present', '09:45:00', '18:00:00', 'On time', '2026-01-03 05:11:47'),
(117, 1, NULL, '2026-01-03', 'present', '09:03:00', '17:30:00', 'Auto-generated for today', '2026-01-03 06:39:07'),
(118, 2, NULL, '2026-01-03', 'absent', NULL, NULL, 'Auto-generated for today', '2026-01-03 06:39:07'),
(119, 3, NULL, '2026-01-03', 'absent', NULL, NULL, 'Auto-generated for today', '2026-01-03 06:39:07'),
(120, 4, NULL, '2026-01-03', 'absent', NULL, NULL, 'Auto-generated for today', '2026-01-03 06:39:07'),
(121, 5, NULL, '2026-01-03', 'present', '09:29:00', '17:30:00', 'Auto-generated for today', '2026-01-03 06:39:07'),
(122, 6, NULL, '2026-01-03', 'present', '12:48:00', '18:00:00', 'Auto-generated for today', '2026-01-03 06:39:07'),
(123, 7, NULL, '2026-01-03', 'present', '12:14:00', '18:00:00', 'Auto-generated for today', '2026-01-03 06:39:07'),
(124, 8, NULL, '2026-01-03', 'absent', NULL, NULL, 'Auto-generated for today', '2026-01-03 06:39:07'),
(125, 9, NULL, '2026-01-03', 'present', '08:31:00', '17:30:00', 'Auto-generated for today', '2026-01-03 06:39:07'),
(126, 10, NULL, '2026-01-03', 'present', '12:42:00', '18:00:00', 'Auto-generated for today', '2026-01-03 06:39:07'),
(127, 11, NULL, '2026-01-03', 'half_day', '09:00:00', '13:00:00', 'Auto-generated for today', '2026-01-03 06:39:07'),
(128, 12, NULL, '2026-01-03', 'present', '08:47:00', '17:30:00', 'Auto-generated for today', '2026-01-03 06:39:07'),
(129, 13, NULL, '2026-01-03', 'present', '12:02:00', '18:00:00', 'Auto-generated for today', '2026-01-03 06:39:07'),
(130, 14, NULL, '2026-01-03', '', NULL, NULL, 'Auto-generated for today', '2026-01-03 06:39:07'),
(131, 15, NULL, '2026-01-03', 'present', '11:34:00', '18:00:00', 'Auto-generated for today', '2026-01-03 06:39:07'),
(132, 16, NULL, '2026-01-03', 'absent', NULL, NULL, 'Auto-generated for today', '2026-01-03 06:39:07'),
(133, 17, NULL, '2026-01-03', 'present', '08:39:00', '17:30:00', 'Auto-generated for today', '2026-01-03 06:39:07'),
(134, 18, NULL, '2026-01-03', 'present', '09:33:00', '17:30:00', 'Auto-generated for today', '2026-01-03 06:39:07'),
(135, 19, NULL, '2026-01-03', '', NULL, NULL, 'Auto-generated for today', '2026-01-03 06:39:07'),
(136, 1, NULL, '2026-01-12', 'present', '09:05:00', '18:00:00', 'On time', '2026-01-12 11:55:48'),
(137, 2, NULL, '2026-01-12', 'present', '09:20:00', '18:10:00', 'Late arrival', '2026-01-12 11:55:48'),
(138, 3, NULL, '2026-01-12', 'present', '09:00:00', '17:55:00', 'On time', '2026-01-12 11:55:48'),
(139, 12, NULL, '2026-01-12', 'present', '09:15:00', '18:05:00', 'On time', '2026-01-12 11:55:48'),
(140, 13, NULL, '2026-01-12', 'present', '09:30:00', '17:50:00', 'Late arrival', '2026-01-12 11:55:48'),
(141, 4, NULL, '2026-01-12', 'half_day', '09:00:00', '13:00:00', 'Personal work', '2026-01-12 11:55:48'),
(142, 5, NULL, '2026-01-12', 'absent', NULL, NULL, 'Absent', '2026-01-12 11:55:48'),
(143, 6, NULL, '2026-01-12', 'absent', NULL, NULL, 'Absent', '2026-01-12 11:55:48'),
(144, 7, NULL, '2026-01-12', 'absent', NULL, NULL, 'Absent', '2026-01-12 11:55:48'),
(145, 1, NULL, '2026-01-12', 'late', '09:40:00', '18:00:00', 'Late arrival', '2026-01-12 12:04:51'),
(146, 2, NULL, '2026-01-12', 'leave', '09:35:00', '18:05:00', 'Traffic delay', '2026-01-12 12:04:51'),
(147, 3, NULL, '2026-01-12', 'late', '09:50:00', '18:10:00', 'Late arrival', '2026-01-12 12:04:51'),
(148, 4, NULL, '2026-01-12', 'leave', '09:45:00', '18:00:00', 'Personal delay', '2026-01-12 12:04:51'),
(149, 5, NULL, '2026-01-12', 'leave', '10:00:00', '18:15:00', 'Late arrival', '2026-01-12 12:04:51'),
(150, 6, NULL, '2026-01-12', 'late', '09:55:00', '17:55:00', 'Late arrival', '2026-01-12 12:04:51'),
(151, 7, NULL, '2026-01-12', 'leave', '09:42:00', '18:05:00', 'Bus delay', '2026-01-12 12:04:51'),
(152, 12, NULL, '2026-01-12', 'late', NULL, NULL, 'Medical leave', '2026-01-12 12:04:51'),
(153, 13, NULL, '2026-01-12', 'leave', NULL, NULL, 'Personal leave', '2026-01-12 12:04:51'),
(154, 8, NULL, '2026-01-12', 'late', NULL, NULL, 'Sick leave', '2026-01-12 12:04:51'),
(155, 9, NULL, '2026-01-12', 'late', NULL, NULL, 'Family emergency', '2026-01-12 12:04:51'),
(156, 1, NULL, '2026-01-16', 'late', '09:40:00', '18:00:00', 'Late arrival', '2026-01-16 07:00:51'),
(157, 2, NULL, '2026-01-16', 'late', '09:35:00', '18:10:00', 'Traffic delay', '2026-01-16 07:00:51'),
(158, 3, NULL, '2026-01-16', 'late', '09:50:00', '18:05:00', 'Overslept', '2026-01-16 07:00:51'),
(159, 4, NULL, '2026-01-16', 'late', '09:45:00', '18:00:00', 'Late arrival', '2026-01-16 07:00:51'),
(161, 6, NULL, '2026-01-16', 'late', '09:55:00', '17:50:00', 'Late arrival', '2026-01-16 07:00:51'),
(162, 7, NULL, '2026-01-16', 'late', '09:42:00', '18:00:00', 'Bus delay', '2026-01-16 07:00:51'),
(163, 12, NULL, '2026-01-16', 'late', '09:48:00', '18:05:00', 'Traffic delay', '2026-01-16 07:00:51'),
(164, 13, NULL, '2026-01-16', 'late', '09:37:00', '17:55:00', 'Late arrival', '2026-01-16 07:00:51'),
(165, 8, NULL, '2026-01-16', 'late', '09:41:00', '18:00:00', 'Late arrival', '2026-01-16 07:00:51'),
(166, 9, NULL, '2026-01-16', 'late', '09:39:00', '18:10:00', 'Late arrival', '2026-01-16 07:00:51'),
(167, 1, NULL, '2026-01-16', 'present', '09:05:00', '18:00:00', 'On time', '2026-01-16 07:04:36'),
(168, 2, NULL, '2026-01-16', 'present', '09:10:00', '18:05:00', 'On time', '2026-01-16 07:04:36'),
(169, 3, NULL, '2026-01-16', 'late', '09:45:00', '18:00:00', 'On time', '2026-01-16 07:04:36'),
(171, 5, NULL, '2026-01-16', 'late', '10:31:00', '17:55:00', 'Late arrival', '2026-01-16 07:04:36'),
(172, 6, NULL, '2026-01-16', 'late', '10:40:00', '18:00:00', 'Bus delay', '2026-01-16 07:04:36'),
(173, 7, NULL, '2026-01-16', 'absent', NULL, NULL, 'Absent', '2026-01-16 07:04:36'),
(174, 8, NULL, '2026-01-16', 'absent', NULL, NULL, 'Absent', '2026-01-16 07:04:36'),
(175, 9, NULL, '2026-01-16', 'leave', NULL, NULL, 'Medical leave', '2026-01-16 07:04:36'),
(176, 12, NULL, '2026-01-16', 'leave', NULL, NULL, 'Personal leave', '2026-01-16 07:04:36'),
(177, 13, NULL, '2026-01-16', 'leave', NULL, NULL, 'Sick leave', '2026-01-16 07:04:36'),
(178, 10, NULL, '2026-01-23', 'present', '10:30:00', '16:54:00', '', '2026-01-23 10:25:03');

-- --------------------------------------------------------

--
-- Table structure for table `beneficiaries`
--

CREATE TABLE `beneficiaries` (
  `id` bigint(20) NOT NULL,
  `beneficiary_name` varchar(150) NOT NULL,
  `hod_id` int(11) DEFAULT NULL,
  `district_id` int(11) NOT NULL,
  `mandal_id` int(11) NOT NULL,
  `village_id` int(11) DEFAULT NULL,
  `scheme_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `mobile` varchar(20) DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT 0.00,
  `gender` varchar(20) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `aadhaar` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `beneficiaries`
--

INSERT INTO `beneficiaries` (`id`, `beneficiary_name`, `hod_id`, `district_id`, `mandal_id`, `village_id`, `scheme_id`, `created_at`, `mobile`, `amount`, `gender`, `dob`, `aadhaar`) VALUES
(1, 'Rama Rao', 11, 2, 64, 1, 9, '2025-12-14 21:30:00', '9876543210', 3050.10, 'male', '1996-01-01', '12345676890641'),
(2, 'Sita Devi', 11, 2, 64, NULL, 9, '2025-12-15 22:10:00', NULL, 0.00, NULL, NULL, NULL),
(3, 'Lakshmi', 12, 2, 65, NULL, 10, '2025-12-16 23:45:00', NULL, 0.00, NULL, NULL, NULL),
(4, 'Krishna', 12, 2, 66, NULL, 10, '2025-12-18 00:00:00', NULL, 0.00, NULL, NULL, NULL),
(5, 'Gopal', 13, 5, 1, NULL, 11, '2025-12-19 03:30:00', NULL, 0.00, NULL, NULL, NULL),
(6, 'Radha', 13, 5, 2, NULL, 11, '2025-12-19 21:00:00', NULL, 0.00, NULL, NULL, NULL),
(7, 'Mohan', 14, 5, 3, NULL, 12, '2025-12-20 22:20:00', NULL, 0.00, NULL, NULL, NULL),
(8, 'Suresh', 14, 5, 3, NULL, 12, '2025-12-21 23:50:00', NULL, 0.00, NULL, NULL, NULL),
(9, 'Anita', 15, 3, 2, NULL, 13, '2025-12-23 01:15:00', NULL, 0.00, NULL, NULL, NULL),
(10, 'Venkatesh', 16, 10, 59, NULL, 9, '2025-12-24 02:30:00', NULL, 0.00, NULL, NULL, NULL),
(11, 'Test Person', 11, 2, 64, 1, 9, '2026-01-03 08:29:46', '9999999999', 1000.00, 'female', '1990-01-01', '1111222233334444');

-- --------------------------------------------------------

--
-- Table structure for table `beneficiary_audit_logs`
--

CREATE TABLE `beneficiary_audit_logs` (
  `id` bigint(20) NOT NULL,
  `beneficiary_id` bigint(20) DEFAULT NULL,
  `action` varchar(50) NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `old_values` text DEFAULT NULL,
  `new_values` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `beneficiary_import_errors`
--

CREATE TABLE `beneficiary_import_errors` (
  `id` bigint(20) NOT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  `row_number` int(11) DEFAULT NULL,
  `error_message` text DEFAULT NULL,
  `row_data` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `beneficiary_import_jobs`
--

CREATE TABLE `beneficiary_import_jobs` (
  `id` bigint(20) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `status` enum('pending','processing','completed','failed') DEFAULT 'pending',
  `total_rows` int(11) DEFAULT 0,
  `processed_rows` int(11) DEFAULT 0,
  `successful_rows` int(11) DEFAULT 0,
  `failed_rows` int(11) DEFAULT 0,
  `uploaded_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `budget`
--

CREATE TABLE `budget` (
  `id` int(11) NOT NULL,
  `hod_id` int(11) DEFAULT NULL,
  `scheme_id` int(11) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `district_id` int(11) DEFAULT NULL,
  `mandal_id` int(11) DEFAULT NULL,
  `allocated_amount` decimal(15,2) DEFAULT 0.00,
  `spent_amount` decimal(15,2) DEFAULT 0.00,
  `utilized_amount` decimal(15,2) DEFAULT 0.00,
  `remaining_amount` decimal(15,2) DEFAULT 0.00,
  `financial_year` varchar(20) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `dao_id` int(11) DEFAULT NULL,
  `section` varchar(255) DEFAULT NULL,
  `budget_estimation_state` decimal(15,2) DEFAULT NULL,
  `budget_estimation_central` decimal(15,2) DEFAULT NULL,
  `budget_sanction_state` decimal(15,2) DEFAULT NULL,
  `budget_sanction_central` decimal(15,2) DEFAULT NULL,
  `budget_remaining_state` decimal(15,2) DEFAULT NULL,
  `budget_remaining_central` decimal(15,2) DEFAULT NULL,
  `budget_pending_state` decimal(15,2) DEFAULT NULL,
  `budget_pending_central` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `budget`
--

INSERT INTO `budget` (`id`, `hod_id`, `scheme_id`, `state_id`, `district_id`, `mandal_id`, `allocated_amount`, `spent_amount`, `utilized_amount`, `remaining_amount`, `financial_year`, `status`, `created_at`, `updated_at`, `dao_id`, `section`, `budget_estimation_state`, `budget_estimation_central`, `budget_sanction_state`, `budget_sanction_central`, `budget_remaining_state`, `budget_remaining_central`, `budget_pending_state`, `budget_pending_central`) VALUES
(1, NULL, NULL, 1, 1, NULL, 5000000.00, 3500000.00, 3500000.00, 1500000.00, '2025-26', 'active', '2026-01-05 07:02:11', '2026-01-05 07:02:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, NULL, NULL, 1, 1, NULL, 8000000.00, 6200000.00, 6200000.00, 1800000.00, '2025-26', 'active', '2026-01-05 07:02:11', '2026-01-05 07:02:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, NULL, NULL, 1, 2, NULL, 6500000.00, 4800000.00, 4800000.00, 1700000.00, '2025-26', 'active', '2026-01-05 07:02:11', '2026-01-05 07:02:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, NULL, NULL, 1, 3, NULL, 4500000.00, 3200000.00, 3200000.00, 1300000.00, '2025-26', 'active', '2026-01-05 07:02:11', '2026-01-05 07:02:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, NULL, NULL, 1, 4, NULL, 7000000.00, 5500000.00, 5500000.00, 1500000.00, '2025-26', 'active', '2026-01-05 07:02:11', '2026-01-05 07:02:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, NULL, NULL, 1, 5, NULL, 5500000.00, 4100000.00, 4100000.00, 1400000.00, '2025-26', 'active', '2026-01-05 07:02:11', '2026-01-05 07:02:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, NULL, NULL, 1, 6, NULL, 6000000.00, 4500000.00, 4500000.00, 1500000.00, '2025-26', 'active', '2026-01-05 07:02:11', '2026-01-05 07:02:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, NULL, NULL, 1, 7, NULL, 4800000.00, 3600000.00, 3600000.00, 1200000.00, '2025-26', 'active', '2026-01-05 07:02:11', '2026-01-05 07:02:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, NULL, NULL, 1, 8, NULL, 7500000.00, 5800000.00, 5800000.00, 1700000.00, '2025-26', 'active', '2026-01-05 07:02:11', '2026-01-05 07:02:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, NULL, NULL, 1, 9, NULL, 6200000.00, 4700000.00, 4700000.00, 1500000.00, '2025-26', 'active', '2026-01-05 07:02:11', '2026-01-05 07:02:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11, NULL, NULL, 1, 10, NULL, 5800000.00, 4300000.00, 4300000.00, 1500000.00, '2025-26', 'active', '2026-01-05 07:02:11', '2026-01-05 07:02:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(12, NULL, NULL, 1, 11, NULL, 4900000.00, 3700000.00, 3700000.00, 1200000.00, '2025-26', 'active', '2026-01-05 07:02:11', '2026-01-05 07:02:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(13, NULL, NULL, 1, 12, NULL, 6800000.00, 5200000.00, 5200000.00, 1600000.00, '2025-26', 'active', '2026-01-05 07:02:11', '2026-01-05 07:02:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(14, NULL, NULL, 1, 13, NULL, 5200000.00, 3900000.00, 3900000.00, 1300000.00, '2025-26', 'active', '2026-01-05 07:02:11', '2026-01-05 07:02:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(15, NULL, NULL, 1, 14, NULL, 7200000.00, 5600000.00, 5600000.00, 1600000.00, '2025-26', 'active', '2026-01-05 07:02:11', '2026-01-05 07:02:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(16, NULL, NULL, 1, 15, NULL, 6100000.00, 4600000.00, 4600000.00, 1500000.00, '2025-26', 'active', '2026-01-05 07:02:11', '2026-01-05 07:02:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(17, NULL, NULL, 1, 16, NULL, 5400000.00, 4000000.00, 4000000.00, 1400000.00, '2025-26', 'active', '2026-01-05 07:02:11', '2026-01-05 07:02:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(18, NULL, NULL, 1, 17, NULL, 6600000.00, 5000000.00, 5000000.00, 1600000.00, '2025-26', 'active', '2026-01-05 07:02:11', '2026-01-05 07:02:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(19, NULL, NULL, 1, 18, NULL, 5900000.00, 4400000.00, 4400000.00, 1500000.00, '2025-26', 'active', '2026-01-05 07:02:11', '2026-01-05 07:02:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(20, NULL, NULL, 1, 19, NULL, 7100000.00, 5500000.00, 5500000.00, 1600000.00, '2025-26', 'active', '2026-01-05 07:02:11', '2026-01-05 07:02:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Secretariat', 'Administrative and Secretariat departments', 'active', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(2, 'Directorate', 'Directorate level departments', 'active', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(3, 'University', 'Agricultural and Horticulture Universities', 'active', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(4, 'Training', 'Training and Extension institutes', 'active', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(5, 'Marketing', 'Marketing and Federation bodies', 'active', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(6, 'Development Corporation', 'State Development Corporations', 'active', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(7, 'Cooperative', 'Cooperative organizations and federations', 'active', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(8, 'Certification', 'Certification and Quality control bodies', 'active', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(9, 'Foundation', 'Research and innovation foundations', 'active', '2026-01-26 14:33:49', '2026-01-26 14:33:49');

-- --------------------------------------------------------

--
-- Table structure for table `dao`
--

CREATE TABLE `dao` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `department` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dao`
--

INSERT INTO `dao` (`id`, `name`, `department`, `email`, `phone`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Krishna Murthy', 'Agriculture', 'krishna.murthy@agri.gov.in', '9876543210', 'active', '2026-01-09 11:36:03', '2026-01-09 11:36:03'),
(2, 'Sampath Kumar', 'Horticulture', 'sampath.kumar@agri.gov.in', '9876543211', 'active', '2026-01-09 11:36:03', '2026-01-09 11:36:03'),
(3, 'Kavya Reddy', 'Animal Husbandry', 'kavya.reddy@agri.gov.in', '9876543212', 'active', '2026-01-09 11:36:03', '2026-01-09 11:36:03'),
(4, 'Rajesh Babu', 'Dairy Development', 'rajesh.babu@agri.gov.in', '9876543213', 'active', '2026-01-09 11:36:03', '2026-01-09 11:36:03'),
(5, 'Anjali Devi', 'Cooperative', 'anjali.devi@agri.gov.in', '9876543214', 'active', '2026-01-09 11:36:03', '2026-01-09 11:36:03'),
(6, 'Venkat Kumar', 'Extension Services', 'venkat.kumar@agri.gov.in', '9876543215', 'active', '2026-01-09 11:36:03', '2026-01-09 11:36:03'),
(7, 'Priya Singh', 'Soil Conservation', 'priya.singh@agri.gov.in', '9876543216', 'active', '2026-01-09 11:36:03', '2026-01-09 11:36:03'),
(8, 'Arun Prasad', 'Irrigation', 'arun.prasad@agri.gov.in', '9876543217', 'active', '2026-01-09 11:36:03', '2026-01-09 11:36:03'),
(9, 'Sneha Patel', 'Rural Development', 'sneha.patel@agri.gov.in', '9876543218', 'active', '2026-01-09 11:36:03', '2026-01-09 11:36:03'),
(10, 'Mahesh Gupta', 'Agricultural Marketing', 'mahesh.gupta@agri.gov.in', '9876543219', 'active', '2026-01-09 11:36:03', '2026-01-09 11:36:03');

-- --------------------------------------------------------

--
-- Table structure for table `districts`
--

CREATE TABLE `districts` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `state_id` int(11) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` varchar(20) DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `districts`
--

INSERT INTO `districts` (`id`, `name`, `state_id`, `created_date`, `updated_date`, `status`) VALUES
(1, 'ADILABAD', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(2, 'BHADRADRI KOTHAGUDEM', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(3, 'HANUMAKONDA', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(4, 'HYDERABAD', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(5, 'JAGITYAL', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(6, 'JANAGAON', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(7, 'JAYASHANKAR BHOOPALPALLY', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(8, 'JOGULAMBA GADWAL', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(9, 'KAMAREDDY', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(10, 'KARIMNAGAR', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(11, 'KHAMMAM', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(12, 'KOMARAM BHEEM ASIFABAD', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(13, 'MAHABUBABAD', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(14, 'MAHABUBNAGAR', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(15, 'MANCHERIAL', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(16, 'MEDAK', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(17, 'MEDCHAL-MALKAJGIRI', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(18, 'MULUGU', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(19, 'NAGARKURNOOL', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(20, 'NALGONDA', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(21, 'NARAYANPET', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(22, 'NIRMAL', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(23, 'NIZAMABAD', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(24, 'PEDDAPALLI', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(25, 'RAJANNA SIRCILLA', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(26, 'RANGA REDDY', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(27, 'SANGAREDDY', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(28, 'SIDDIPET', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(29, 'SURYAPET', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(30, 'VIKARABAD', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(31, 'WANAPARTHY', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(32, 'WARANGAL', 1, '2026-01-03 05:12:05', '2026-01-03 05:12:05', 'active'),
(33, 'YADADRI BHUVANAGIRI', 1, '2026-01-03 05:12:05', '2026-01-26 13:06:51', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `flagship_import_metadata`
--

CREATE TABLE `flagship_import_metadata` (
  `id` int(11) NOT NULL,
  `import_batch_id` varchar(255) NOT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_size` bigint(20) DEFAULT NULL,
  `total_records` int(11) DEFAULT NULL,
  `successful_records` int(11) DEFAULT NULL,
  `failed_records` int(11) DEFAULT NULL,
  `column_mapping` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `import_type` varchar(100) DEFAULT NULL,
  `status` enum('pending','processing','completed','failed') DEFAULT 'pending',
  `error_log` longtext DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flagship_import_metadata`
--

INSERT INTO `flagship_import_metadata` (`id`, `import_batch_id`, `file_name`, `file_size`, `total_records`, `successful_records`, `failed_records`, `column_mapping`, `import_type`, `status`, `error_log`, `created_by`, `created_at`) VALUES
(33, 'BATCH_1768992257491_7z87vkurg', 'Proformas1 (1).xlsx', NULL, 18, 1, 0, '[\"Sl. No.\",\"central_scheme_name\",\"scheme_name\",\"hod\",\"Allocation of GOI 2025-26(Cr) - allocation_goi_share\",\"allocation_state_share\",\"allocation_total\",\"SLSC Approved AAP(Cr) - slsc_goi_share\",\"slsc_state_share\",\"slsc_total\",\"Mother Sanction 2025-26 \\r\\n(50% of allocation )(Cr) - sanction_goi_share\",\"sanction_state_share\",\"sanction_total\",\"bro_released_amount\",\"dt_authorized_amount\",\"Bills Preferred - bills_preferred_count\",\"bills_preferred_amount\\r\\n(Cr)\",\"oldest_bill_date\",\"Bills Cleared - bills_cleared_count\",\"bills_cleared_amount\\r\\n(Cr)\",\"latest_bill_date\",\"Remark\",\"Remark_23\"]', 'programme', 'completed', '[]', 8, '2026-01-21 10:44:17'),
(34, 'BATCH_1768992371225_2hsppbca9', 'revenue.xlsx', NULL, 13, 1, 0, '[\"Sl. No. - 1\",\"Name of the Cooperation & Cooperatives - 2\",\"Loans - 3\",\"Revenue - 4\"]', 'report', 'completed', '[]', 8, '2026-01-21 10:46:11');

-- --------------------------------------------------------

--
-- Table structure for table `flagship_programmes`
--

CREATE TABLE `flagship_programmes` (
  `id` int(11) NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  `department_name` varchar(255) DEFAULT NULL,
  `programme_name` varchar(255) DEFAULT NULL,
  `import_batch_id` varchar(255) DEFAULT NULL,
  `data_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `name` varchar(255) DEFAULT NULL,
  `beneficiaries` int(11) DEFAULT 0,
  `budget` decimal(15,2) DEFAULT 0.00,
  `department` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flagship_programmes`
--

INSERT INTO `flagship_programmes` (`id`, `department_id`, `department_name`, `programme_name`, `import_batch_id`, `data_json`, `status`, `created_by`, `created_at`, `updated_at`, `name`, `beneficiaries`, `budget`, `department`) VALUES
(281, NULL, 'General', 'Proformas1 (1)', 'BATCH_1768992257491_7z87vkurg', '[{\"Sl. No.\":1,\"central_scheme_name\":\"Rashtriya Krishi Vikas Yojana (RKVY)\",\"scheme_name\":\"Per Drop More Crop -Micro Irrigation(PDMC)\",\"hod\":\"DoH\",\"Allocation of GOI 2025-26(Cr) - allocation_goi_share\":13,\"allocation_state_share\":13,\"allocation_total\":26,\"SLSC Approved AAP(Cr) - slsc_goi_share\":12,\"slsc_state_share\":12,\"slsc_total\":24,\"Mother Sanction 2025-26 \\r\\n(50% of allocation )(Cr) - sanction_goi_share\":12,\"sanction_state_share\":12,\"sanction_total\":24,\"bro_released_amount\":14,\"dt_authorized_amount\":144,\"Bills Preferred - bills_preferred_count\":12,\"bills_preferred_amount\\r\\n(Cr)\":12,\"oldest_bill_date\":46023,\"Bills Cleared - bills_cleared_count\":14,\"bills_cleared_amount\\r\\n(Cr)\":12,\"latest_bill_date\":\"14-01-2026\",\"Remark\":\"\",\"Remark_23\":\"\"},{\"Sl. No.\":2,\"central_scheme_name\":\"Rashtriya Krishi Vikas Yojana (RKVY)\",\"scheme_name\":\"Rashtriya Krishi Vikas Yojana (RKVY)\",\"hod\":\"DoA\",\"Allocation of GOI 2025-26(Cr) - allocation_goi_share\":12,\"allocation_state_share\":12,\"allocation_total\":24,\"SLSC Approved AAP(Cr) - slsc_goi_share\":12,\"slsc_state_share\":12,\"slsc_total\":24,\"Mother Sanction 2025-26 \\r\\n(50% of allocation )(Cr) - sanction_goi_share\":12,\"sanction_state_share\":12,\"sanction_total\":24,\"bro_released_amount\":12,\"dt_authorized_amount\":120.03,\"Bills Preferred - bills_preferred_count\":12,\"bills_preferred_amount\\r\\n(Cr)\":12,\"oldest_bill_date\":46024,\"Bills Cleared - bills_cleared_count\":12,\"bills_cleared_amount\\r\\n(Cr)\":12,\"latest_bill_date\":\"14-02-2026\",\"Remark\":\"\",\"Remark_23\":\"\"},{\"Sl. No.\":3,\"central_scheme_name\":\"Rashtriya Krishi Vikas Yojana (RKVY)\",\"scheme_name\":\"Sub-Mission on Agriculture Mechanization (SMAM)\",\"hod\":\"DoA\",\"Allocation of GOI 2025-26(Cr) - allocation_goi_share\":12,\"allocation_state_share\":13,\"allocation_total\":25,\"SLSC Approved AAP(Cr) - slsc_goi_share\":12,\"slsc_state_share\":12,\"slsc_total\":25,\"Mother Sanction 2025-26 \\r\\n(50% of allocation )(Cr) - sanction_goi_share\":12,\"sanction_state_share\":12,\"sanction_total\":24,\"bro_released_amount\":12,\"dt_authorized_amount\":120.03,\"Bills Preferred - bills_preferred_count\":12,\"bills_preferred_amount\\r\\n(Cr)\":12,\"oldest_bill_date\":46025,\"Bills Cleared - bills_cleared_count\":12,\"bills_cleared_amount\\r\\n(Cr)\":12,\"latest_bill_date\":\"14-01-2028\",\"Remark\":\"\",\"Remark_23\":\"\"},{\"Sl. No.\":4,\"central_scheme_name\":\"Rashtriya Krishi Vikas Yojana (RKVY)\",\"scheme_name\":\"National Project on Management of Soil Health & Fertility(SHF)\",\"hod\":\"DoA\",\"Allocation of GOI 2025-26(Cr) - allocation_goi_share\":12,\"allocation_state_share\":12,\"allocation_total\":24,\"SLSC Approved AAP(Cr) - slsc_goi_share\":12,\"slsc_state_share\":12,\"slsc_total\":24,\"Mother Sanction 2025-26 \\r\\n(50% of allocation )(Cr) - sanction_goi_share\":12,\"sanction_state_share\":12,\"sanction_total\":24,\"bro_released_amount\":12,\"dt_authorized_amount\":120.03,\"Bills Preferred - bills_preferred_count\":12,\"bills_preferred_amount\\r\\n(Cr)\":12,\"oldest_bill_date\":46026,\"Bills Cleared - bills_cleared_count\":12,\"bills_cleared_amount\\r\\n(Cr)\":12,\"latest_bill_date\":\"14-01-2029\",\"Remark\":\"\",\"Remark_23\":\"\"},{\"Sl. No.\":5,\"central_scheme_name\":\"Rashtriya Krishi Vikas Yojana (RKVY)\",\"scheme_name\":\"Paramparagat Krishi Vikas Yojana (PKVY)\",\"hod\":\"DoA\",\"Allocation of GOI 2025-26(Cr) - allocation_goi_share\":12,\"allocation_state_share\":12,\"allocation_total\":24,\"SLSC Approved AAP(Cr) - slsc_goi_share\":12,\"slsc_state_share\":12,\"slsc_total\":24,\"Mother Sanction 2025-26 \\r\\n(50% of allocation )(Cr) - sanction_goi_share\":12,\"sanction_state_share\":12,\"sanction_total\":25,\"bro_released_amount\":12,\"dt_authorized_amount\":120.03,\"Bills Preferred - bills_preferred_count\":12,\"bills_preferred_amount\\r\\n(Cr)\":12,\"oldest_bill_date\":46027,\"Bills Cleared - bills_cleared_count\":12,\"bills_cleared_amount\\r\\n(Cr)\":12,\"latest_bill_date\":\"14-01-2030\",\"Remark\":\"\",\"Remark_23\":\"\"},{\"Sl. No.\":6,\"central_scheme_name\":\"Rashtriya Krishi Vikas Yojana (RKVY)\",\"scheme_name\":\"Rainfed Area Development (RAD)\",\"hod\":\"DoH\",\"Allocation of GOI 2025-26(Cr) - allocation_goi_share\":12,\"allocation_state_share\":12,\"allocation_total\":24,\"SLSC Approved AAP(Cr) - slsc_goi_share\":12,\"slsc_state_share\":12,\"slsc_total\":24,\"Mother Sanction 2025-26 \\r\\n(50% of allocation )(Cr) - sanction_goi_share\":12,\"sanction_state_share\":12,\"sanction_total\":24,\"bro_released_amount\":12,\"dt_authorized_amount\":120.03,\"Bills Preferred - bills_preferred_count\":12,\"bills_preferred_amount\\r\\n(Cr)\":12,\"oldest_bill_date\":46028,\"Bills Cleared - bills_cleared_count\":12,\"bills_cleared_amount\\r\\n(Cr)\":12,\"latest_bill_date\":\"14-01-2031\",\"Remark\":\"\",\"Remark_23\":\"\"},{\"Sl. No.\":7,\"central_scheme_name\":\"Rashtriya Krishi Vikas Yojana (RKVY)\",\"scheme_name\":\"Agro Forestry\",\"hod\":\"DoH\",\"Allocation of GOI 2025-26(Cr) - allocation_goi_share\":12,\"allocation_state_share\":12,\"allocation_total\":24,\"SLSC Approved AAP(Cr) - slsc_goi_share\":12,\"slsc_state_share\":12,\"slsc_total\":24,\"Mother Sanction 2025-26 \\r\\n(50% of allocation )(Cr) - sanction_goi_share\":12,\"sanction_state_share\":12,\"sanction_total\":24,\"bro_released_amount\":12,\"dt_authorized_amount\":120.03,\"Bills Preferred - bills_preferred_count\":12,\"bills_preferred_amount\\r\\n(Cr)\":12,\"oldest_bill_date\":46029,\"Bills Cleared - bills_cleared_count\":12,\"bills_cleared_amount\\r\\n(Cr)\":12,\"latest_bill_date\":\"14-01-2032\",\"Remark\":\"\",\"Remark_23\":\"\"},{\"Sl. No.\":8,\"central_scheme_name\":\"Rashtriya Krishi Vikas Yojana (RKVY)\",\"scheme_name\":\"Crop Diverisifcation Programme (CDP)\",\"hod\":\"DoA\",\"Allocation of GOI 2025-26(Cr) - allocation_goi_share\":12,\"allocation_state_share\":12,\"allocation_total\":24,\"SLSC Approved AAP(Cr) - slsc_goi_share\":12,\"slsc_state_share\":12,\"slsc_total\":24,\"Mother Sanction 2025-26 \\r\\n(50% of allocation )(Cr) - sanction_goi_share\":12,\"sanction_state_share\":12,\"sanction_total\":24,\"bro_released_amount\":12,\"dt_authorized_amount\":120.03,\"Bills Preferred - bills_preferred_count\":12,\"bills_preferred_amount\\r\\n(Cr)\":12,\"oldest_bill_date\":46030,\"Bills Cleared - bills_cleared_count\":12,\"bills_cleared_amount\\r\\n(Cr)\":12,\"latest_bill_date\":\"14-01-2033\",\"Remark\":\"\",\"Remark_23\":\"\"},{\"Sl. No.\":9,\"central_scheme_name\":\"Krishonnati Yojana (KY)\",\"scheme_name\":\"National Mission on Edible Oil-Oilpalm (NMEO-OP)\",\"hod\":\"DoH\",\"Allocation of GOI 2025-26(Cr) - allocation_goi_share\":12,\"allocation_state_share\":12,\"allocation_total\":24,\"SLSC Approved AAP(Cr) - slsc_goi_share\":12,\"slsc_state_share\":12,\"slsc_total\":24,\"Mother Sanction 2025-26 \\r\\n(50% of allocation )(Cr) - sanction_goi_share\":12,\"sanction_state_share\":12,\"sanction_total\":24,\"bro_released_amount\":12,\"dt_authorized_amount\":120.03,\"Bills Preferred - bills_preferred_count\":12,\"bills_preferred_amount\\r\\n(Cr)\":12,\"oldest_bill_date\":46031,\"Bills Cleared - bills_cleared_count\":12,\"bills_cleared_amount\\r\\n(Cr)\":12,\"latest_bill_date\":\"14-01-2034\",\"Remark\":\"\",\"Remark_23\":\"\"},{\"Sl. No.\":10,\"central_scheme_name\":\"Krishonnati Yojana (KY)\",\"scheme_name\":\"Mission for Integrated Development ofHorticulture (MIDH)\",\"hod\":\"DoH\",\"Allocation of GOI 2025-26(Cr) - allocation_goi_share\":12,\"allocation_state_share\":12,\"allocation_total\":24,\"SLSC Approved AAP(Cr) - slsc_goi_share\":12,\"slsc_state_share\":12,\"slsc_total\":24,\"Mother Sanction 2025-26 \\r\\n(50% of allocation )(Cr) - sanction_goi_share\":12,\"sanction_state_share\":12,\"sanction_total\":24,\"bro_released_amount\":12,\"dt_authorized_amount\":120.03,\"Bills Preferred - bills_preferred_count\":12,\"bills_preferred_amount\\r\\n(Cr)\":12,\"oldest_bill_date\":46032,\"Bills Cleared - bills_cleared_count\":12,\"bills_cleared_amount\\r\\n(Cr)\":12,\"latest_bill_date\":\"14-01-2035\",\"Remark\":\"\",\"Remark_23\":\"\"},{\"Sl. No.\":11,\"central_scheme_name\":\"Krishonnati Yojana (KY)\",\"scheme_name\":\"National Food Security Nutrition Mission (NFSM)\",\"hod\":\"DoA\",\"Allocation of GOI 2025-26(Cr) - allocation_goi_share\":12,\"allocation_state_share\":12,\"allocation_total\":24,\"SLSC Approved AAP(Cr) - slsc_goi_share\":12,\"slsc_state_share\":12,\"slsc_total\":24,\"Mother Sanction 2025-26 \\r\\n(50% of allocation )(Cr) - sanction_goi_share\":12,\"sanction_state_share\":12,\"sanction_total\":24,\"bro_released_amount\":12,\"dt_authorized_amount\":120.03,\"Bills Preferred - bills_preferred_count\":12,\"bills_preferred_amount\\r\\n(Cr)\":12,\"oldest_bill_date\":46033,\"Bills Cleared - bills_cleared_count\":12,\"bills_cleared_amount\\r\\n(Cr)\":12,\"latest_bill_date\":\"14-01-2036\",\"Remark\":\"\",\"Remark_23\":\"\"},{\"Sl. No.\":12,\"central_scheme_name\":\"Krishonnati Yojana (KY)\",\"scheme_name\":\"Sub-Mission on Agricultural Extension (ATMA)\",\"hod\":\"DoA\",\"Allocation of GOI 2025-26(Cr) - allocation_goi_share\":12,\"allocation_state_share\":12,\"allocation_total\":24,\"SLSC Approved AAP(Cr) - slsc_goi_share\":12,\"slsc_state_share\":12,\"slsc_total\":24,\"Mother Sanction 2025-26 \\r\\n(50% of allocation )(Cr) - sanction_goi_share\":12,\"sanction_state_share\":12,\"sanction_total\":24,\"bro_released_amount\":12,\"dt_authorized_amount\":120.03,\"Bills Preferred - bills_preferred_count\":12,\"bills_preferred_amount\\r\\n(Cr)\":12,\"oldest_bill_date\":46034,\"Bills Cleared - bills_cleared_count\":12,\"bills_cleared_amount\\r\\n(Cr)\":12,\"latest_bill_date\":\"14-01-2037\",\"Remark\":\"\",\"Remark_23\":\"\"},{\"Sl. No.\":13,\"central_scheme_name\":\"Krishonnati Yojana (KY)\",\"scheme_name\":\"Sub-Mission on Seed and Planting material (SMSP)NFSNM- Seed Components\",\"hod\":\"DoA\",\"Allocation of GOI 2025-26(Cr) - allocation_goi_share\":12,\"allocation_state_share\":12,\"allocation_total\":24,\"SLSC Approved AAP(Cr) - slsc_goi_share\":12,\"slsc_state_share\":12,\"slsc_total\":24,\"Mother Sanction 2025-26 \\r\\n(50% of allocation )(Cr) - sanction_goi_share\":12,\"sanction_state_share\":12,\"sanction_total\":24,\"bro_released_amount\":12,\"dt_authorized_amount\":120.03,\"Bills Preferred - bills_preferred_count\":12,\"bills_preferred_amount\\r\\n(Cr)\":12,\"oldest_bill_date\":46035,\"Bills Cleared - bills_cleared_count\":12,\"bills_cleared_amount\\r\\n(Cr)\":12,\"latest_bill_date\":\"14-01-2038\",\"Remark\":\"\",\"Remark_23\":\"\"},{\"Sl. No.\":14,\"central_scheme_name\":\"Krishonnati Yojana (KY)\",\"scheme_name\":\"Digital Agriculture\",\"hod\":\"DoA\",\"Allocation of GOI 2025-26(Cr) - allocation_goi_share\":12,\"allocation_state_share\":12,\"allocation_total\":24,\"SLSC Approved AAP(Cr) - slsc_goi_share\":12,\"slsc_state_share\":12,\"slsc_total\":24,\"Mother Sanction 2025-26 \\r\\n(50% of allocation )(Cr) - sanction_goi_share\":12,\"sanction_state_share\":12,\"sanction_total\":24,\"bro_released_amount\":12,\"dt_authorized_amount\":120.03,\"Bills Preferred - bills_preferred_count\":12,\"bills_preferred_amount\\r\\n(Cr)\":12,\"oldest_bill_date\":46036,\"Bills Cleared - bills_cleared_count\":12,\"bills_cleared_amount\\r\\n(Cr)\":12,\"latest_bill_date\":\"14-01-2039\",\"Remark\":\"\",\"Remark_23\":\"\"},{\"Sl. No.\":15,\"central_scheme_name\":\"Krishonnati Yojana (KY)\",\"scheme_name\":\"National Mission on Edible Oils - Oil Seeds (NMEO-OS)\",\"hod\":\"DoA\",\"Allocation of GOI 2025-26(Cr) - allocation_goi_share\":12,\"allocation_state_share\":12,\"allocation_total\":24,\"SLSC Approved AAP(Cr) - slsc_goi_share\":12,\"slsc_state_share\":12,\"slsc_total\":24,\"Mother Sanction 2025-26 \\r\\n(50% of allocation )(Cr) - sanction_goi_share\":12,\"sanction_state_share\":12,\"sanction_total\":24,\"bro_released_amount\":12,\"dt_authorized_amount\":120.03,\"Bills Preferred - bills_preferred_count\":12,\"bills_preferred_amount\\r\\n(Cr)\":12,\"oldest_bill_date\":46037,\"Bills Cleared - bills_cleared_count\":12,\"bills_cleared_amount\\r\\n(Cr)\":12,\"latest_bill_date\":\"14-01-2040\",\"Remark\":\"\",\"Remark_23\":\"\"},{\"Sl. No.\":16,\"central_scheme_name\":\"Krishonnati Yojana (KY)\",\"scheme_name\":\"National Bamboo Mission (NBM)\",\"hod\":\"DoH\",\"Allocation of GOI 2025-26(Cr) - allocation_goi_share\":12,\"allocation_state_share\":12,\"allocation_total\":24,\"SLSC Approved AAP(Cr) - slsc_goi_share\":12,\"slsc_state_share\":12,\"slsc_total\":24,\"Mother Sanction 2025-26 \\r\\n(50% of allocation )(Cr) - sanction_goi_share\":12,\"sanction_state_share\":12,\"sanction_total\":24,\"bro_released_amount\":12,\"dt_authorized_amount\":120.03,\"Bills Preferred - bills_preferred_count\":12,\"bills_preferred_amount\\r\\n(Cr)\":12,\"oldest_bill_date\":46038,\"Bills Cleared - bills_cleared_count\":12,\"bills_cleared_amount\\r\\n(Cr)\":12,\"latest_bill_date\":\"14-01-2041\",\"Remark\":\"\",\"Remark_23\":\"\"},{\"Sl. No.\":17,\"central_scheme_name\":\"Krishonnati Yojana (KY)\",\"scheme_name\":\"Mission for Atmanirbharta in Pulses\",\"hod\":\"DoA\",\"Allocation of GOI 2025-26(Cr) - allocation_goi_share\":12,\"allocation_state_share\":12,\"allocation_total\":24,\"SLSC Approved AAP(Cr) - slsc_goi_share\":12,\"slsc_state_share\":12,\"slsc_total\":24,\"Mother Sanction 2025-26 \\r\\n(50% of allocation )(Cr) - sanction_goi_share\":12,\"sanction_state_share\":12,\"sanction_total\":24,\"bro_released_amount\":12,\"dt_authorized_amount\":120.03,\"Bills Preferred - bills_preferred_count\":12,\"bills_preferred_amount\\r\\n(Cr)\":12,\"oldest_bill_date\":46039,\"Bills Cleared - bills_cleared_count\":12,\"bills_cleared_amount\\r\\n(Cr)\":12,\"latest_bill_date\":\"14-01-2042\",\"Remark\":\"\",\"Remark_23\":\"\"},{\"Sl. No.\":18,\"central_scheme_name\":\"National Mission onNatural Farming(NMNF)\",\"scheme_name\":\"National Mission onNatural Farming(NMNF)\",\"hod\":\"DoA\",\"Allocation of GOI 2025-26(Cr) - allocation_goi_share\":12,\"allocation_state_share\":12,\"allocation_total\":24,\"SLSC Approved AAP(Cr) - slsc_goi_share\":12,\"slsc_state_share\":12,\"slsc_total\":24,\"Mother Sanction 2025-26 \\r\\n(50% of allocation )(Cr) - sanction_goi_share\":12,\"sanction_state_share\":12,\"sanction_total\":24,\"bro_released_amount\":12,\"dt_authorized_amount\":120.03,\"Bills Preferred - bills_preferred_count\":12,\"bills_preferred_amount\\r\\n(Cr)\":12,\"oldest_bill_date\":46040,\"Bills Cleared - bills_cleared_count\":12,\"bills_cleared_amount\\r\\n(Cr)\":12,\"latest_bill_date\":\"14-01-2043\",\"Remark\":\"\",\"Remark_23\":\"\"}]', 'active', 8, '2026-01-21 10:44:17', '2026-01-21 10:44:17', NULL, 0, 0.00, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `flagship_reports`
--

CREATE TABLE `flagship_reports` (
  `id` int(11) NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  `department_name` varchar(255) DEFAULT NULL,
  `report_name` varchar(255) DEFAULT NULL,
  `report_date` date DEFAULT NULL,
  `import_batch_id` varchar(255) DEFAULT NULL,
  `data_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flagship_reports`
--

INSERT INTO `flagship_reports` (`id`, `department_id`, `department_name`, `report_name`, `report_date`, `import_batch_id`, `data_json`, `status`, `created_by`, `created_at`, `updated_at`) VALUES
(70, NULL, 'General', 'revenue', '2026-01-21', 'BATCH_1768992371225_2hsppbca9', '[{\"Sl. No. - 1\":1,\"Name of the Cooperation & Cooperatives - 2\":\"TG AGROS\",\"Loans - 3\":200000,\"Revenue - 4\":0.3},{\"Sl. No. - 1\":2,\"Name of the Cooperation & Cooperatives - 2\":\"TG HDCL\",\"Loans - 3\":200000,\"Revenue - 4\":0.3},{\"Sl. No. - 1\":3,\"Name of the Cooperation & Cooperatives - 2\":\"TG SDCL\",\"Loans - 3\":200000,\"Revenue - 4\":0.3},{\"Sl. No. - 1\":4,\"Name of the Cooperation & Cooperatives - 2\":\"TG CRIC\",\"Loans - 3\":200000,\"Revenue - 4\":0.3},{\"Sl. No. - 1\":5,\"Name of the Cooperation & Cooperatives - 2\":\"TG HOUSEFED\",\"Loans - 3\":200000,\"Revenue - 4\":0.3},{\"Sl. No. - 1\":6,\"Name of the Cooperation & Cooperatives - 2\":\"HACA\",\"Loans - 3\":200000,\"Revenue - 4\":0.3},{\"Sl. No. - 1\":7,\"Name of the Cooperation & Cooperatives - 2\":\"TG MARKFED\",\"Loans - 3\":200000,\"Revenue - 4\":0.3},{\"Sl. No. - 1\":8,\"Name of the Cooperation & Cooperatives - 2\":\"TG OILFED\",\"Loans - 3\":200000,\"Revenue - 4\":0.3},{\"Sl. No. - 1\":9,\"Name of the Cooperation & Cooperatives - 2\":\"TG OCA\",\"Loans - 3\":200000,\"Revenue - 4\":0.3},{\"Sl. No. - 1\":10,\"Name of the Cooperation & Cooperatives - 2\":\"TG CU\",\"Loans - 3\":200000,\"Revenue - 4\":0.3},{\"Sl. No. - 1\":11,\"Name of the Cooperation & Cooperatives - 2\":\"TG SWC\",\"Loans - 3\":200000,\"Revenue - 4\":0.3},{\"Sl. No. - 1\":12,\"Name of the Cooperation & Cooperatives - 2\":\"PJTAU\",\"Loans - 3\":200000,\"Revenue - 4\":0.3},{\"Sl. No. - 1\":13,\"Name of the Cooperation & Cooperatives - 2\":\"SKLTGHU\",\"Loans - 3\":200000,\"Revenue - 4\":0.3}]', 'active', 8, '2026-01-21 10:46:11', '2026-01-21 10:46:11');

-- --------------------------------------------------------

--
-- Table structure for table `hods`
--

CREATE TABLE `hods` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `department` varchar(255) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hods`
--

INSERT INTO `hods` (`id`, `name`, `department`, `category_id`, `email`, `phone`, `status`, `created_at`, `updated_at`) VALUES
(24, 'Dr. B. Gopi, IAS', 'Director of Agriculture (DOA)', 2, 'svramana1998@gmail.com', '7995555005', 'active', '2026-01-26 12:20:54', '2026-01-26 17:53:15'),
(25, 'Yasmeen Basha, IAS', 'Director of Horticulture (DOH)', 2, 'Yasmeenbasha@gmail.com', '8977714488', 'active', '2026-01-26 12:22:54', '2026-01-26 14:55:45'),
(26, 'K. Surendra Mohan, IAS', 'Director of Agricultural Marketing (DAM)', 2, NULL, '9704666457', 'active', '2026-01-26 12:24:06', '2026-01-26 14:53:19'),
(34, 'V. Srinivasa Reddy', 'TG Cooperative Marketing Federation (TG MARKFED)', 7, NULL, '9949992929', 'active', '2026-01-26 12:47:53', '2026-01-26 14:45:39'),
(37, 'Dr. Kiran kumar', 'Telangana State Seed & Organic Certification Authority  (TG SOCA)', 8, NULL, '9440108930', 'active', '2026-01-26 12:49:06', '2026-01-26 14:43:37'),
(38, 'K. Ramulu', 'State Agro-Industries Development Corporation (AGROS)', 6, NULL, '8019300573', 'active', '2026-01-26 12:49:54', '2026-01-26 14:44:12'),
(41, 'Dr. K. Lakshmi, IAS', 'Telangana State Warehousing Corporation (TG WHC)', 6, NULL, '9100022959', 'active', '2026-01-26 12:51:01', '2026-01-26 14:43:00'),
(42, 'Chandra Sekhar Reddy, IAS', 'The Hyderabad Agricultural Co-operative Association  (HACA)', 7, NULL, '9100590019', 'active', '2026-01-26 12:51:31', '2026-01-26 14:29:38'),
(43, 'Dr. G Venkateshwarlu', 'AgHub Foundation (AGHUB)', 9, NULL, '9599766313', 'active', '2026-01-26 12:52:00', '2026-01-26 14:52:27'),
(45, 'Annapoorna', 'Telangana Co-operative Union (TCU)', 7, NULL, '9441605735', 'active', '2026-01-26 12:52:53', '2026-01-26 14:50:02'),
(46, 'Poorna Chander Rao', 'Telangana State Co-operative Housing Federation (TSCHF)', 7, NULL, '9866887123', 'active', '2026-01-26 12:53:15', '2026-01-26 14:55:25'),
(47, 'Dr. Aldas Janaiah', 'Professor Jayashankar Telangana Agriculutural University (PJTSAU)', 3, NULL, '9441180889', 'active', '2026-01-26 12:53:33', '2026-01-26 14:50:44'),
(48, 'Dr. Danda Raji Reddy', 'Sri Konda Laxman Telangana Horticultural University (SKLTHU)', 3, 'kotagirineeraj6@gmail.com', '9989625220', 'active', '2026-01-26 12:53:58', '2026-01-27 06:15:00');

-- --------------------------------------------------------

--
-- Table structure for table `hod_department_mapping`
--

CREATE TABLE `hod_department_mapping` (
  `id` int(11) NOT NULL,
  `hod_id` int(11) NOT NULL,
  `department_name` varchar(255) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `is_primary` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hod_department_mapping`
--

INSERT INTO `hod_department_mapping` (`id`, `hod_id`, `department_name`, `category_id`, `is_primary`, `created_at`, `updated_at`) VALUES
(1, 25, 'Director of Horticulture (DOH)', 2, 1, '2026-01-27 05:26:48', '2026-01-27 05:26:48'),
(2, 25, 'TG Seeds Development Corporation Ltd (TG SSDC)', 6, 0, '2026-01-27 05:26:48', '2026-01-27 05:26:48'),
(3, 25, 'TG Cooperative Oil seeds Growers Federation Ltd (TG  OILFED)', 7, 0, '2026-01-27 05:26:48', '2026-01-27 05:26:48'),
(4, 25, 'Telangana State Horticulture Development Corporation  Ltd., (TG SHDCL)', 6, 0, '2026-01-27 05:26:48', '2026-01-27 05:26:48'),
(5, 42, 'The Hyderabad Agricultural Co-operative Association  (HACA)', 7, 1, '2026-01-27 05:26:48', '2026-01-27 05:26:48'),
(6, 42, 'Telangana State Co-operative Rural Irrigation Corporation  Ltd., Hyderabad (TG CRIC)', 7, 0, '2026-01-27 05:26:48', '2026-01-27 05:26:48'),
(7, 24, 'Director of Agriculture (DOA)', 2, 1, '2026-01-27 05:26:48', '2026-01-27 05:26:48'),
(8, 24, 'Telangana Rythu Bandhu Samithi (TRBS)', 7, 0, '2026-01-27 05:26:48', '2026-01-27 05:26:48'),
(9, 26, 'Director of Agricultural Marketing (DAM)', 2, 1, '2026-01-27 05:26:48', '2026-01-27 05:26:48'),
(10, 26, 'Director of Cooperation & RCS (DC & RCS)', 2, 0, '2026-01-27 05:26:48', '2026-01-27 05:26:48');

-- --------------------------------------------------------

--
-- Table structure for table `kpis`
--

CREATE TABLE `kpis` (
  `id` int(11) NOT NULL,
  `hod_id` int(11) DEFAULT NULL,
  `kpi_name` varchar(255) NOT NULL,
  `target_value` decimal(15,2) DEFAULT NULL,
  `achieved_value` decimal(15,2) DEFAULT 0.00,
  `unit` varchar(50) DEFAULT NULL,
  `period` varchar(50) DEFAULT NULL,
  `status` enum('on_track','at_risk','behind','completed') DEFAULT 'on_track',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kpis`
--

INSERT INTO `kpis` (`id`, `hod_id`, `kpi_name`, `target_value`, `achieved_value`, `unit`, `period`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Farmers Benefited - Rythu Bandhu', 600000.00, 450000.00, 'Count', 'Yearly', 'on_track', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(2, 2, 'PM-KISAN Beneficiaries', 500000.00, 380000.00, 'Count', 'Yearly', 'on_track', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(3, 3, 'Horticulture Area Coverage', 50000.00, 35000.00, 'Hectares', 'Yearly', 'on_track', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(4, 4, 'Markets Modernized', 25.00, 18.00, 'Count', 'Yearly', 'on_track', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(5, 5, 'Cooperatives Strengthened', 500.00, 350.00, 'Count', 'Yearly', 'at_risk', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(6, 6, 'Students Supported', 5000.00, 3800.00, 'Count', 'Yearly', 'on_track', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(7, 7, 'Farmers Trained', 25000.00, 18000.00, 'Count', 'Yearly', 'on_track', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(8, 8, 'Extension Workers Trained', 2000.00, 1500.00, 'Count', 'Yearly', 'on_track', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(9, 9, 'Market Transactions Value', 500.00, 380.00, 'Crores', 'Yearly', 'on_track', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(10, 10, 'Certified Seeds Distributed', 100000.00, 72000.00, 'Quintals', 'Yearly', 'on_track', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(11, 11, 'Organic Farms Certified', 10000.00, 6500.00, 'Count', 'Yearly', 'at_risk', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(12, 12, 'Agro Units Established', 100.00, 65.00, 'Count', 'Yearly', 'at_risk', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(13, 13, 'Oilseed Production', 200000.00, 150000.00, 'Tonnes', 'Yearly', 'on_track', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(14, 14, 'Storage Capacity Added', 50000.00, 35000.00, 'MT', 'Yearly', 'on_track', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(15, 15, 'Loans Disbursed', 200.00, 145.00, 'Crores', 'Yearly', 'on_track', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(16, 16, 'Post-Harvest Units Built', 50.00, 32.00, 'Count', 'Yearly', 'at_risk', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(17, 17, 'Irrigation Coverage', 75000.00, 55000.00, 'Hectares', 'Yearly', 'on_track', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(18, 18, 'Unions Federated', 100.00, 75.00, 'Count', 'Yearly', 'on_track', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(19, 19, 'Houses Constructed', 10000.00, 7200.00, 'Count', 'Yearly', 'on_track', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(20, 20, 'Market Infrastructure Projects', 30.00, 22.00, 'Count', 'Yearly', 'on_track', '2026-01-03 05:11:47', '2026-01-03 05:11:47');

-- --------------------------------------------------------

--
-- Table structure for table `mandals`
--

CREATE TABLE `mandals` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `district_id` int(11) NOT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `updated_date` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` enum('active','inactive') DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mandals`
--

INSERT INTO `mandals` (`id`, `name`, `district_id`, `created_date`, `updated_date`, `status`) VALUES
(1, 'Adilabad Rural', 1, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(2, 'Adilabad Urban', 1, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(3, 'Bazarhatnoor', 1, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(4, 'Bela', 1, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(5, 'Boath', 1, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(6, 'Bheempoor', 1, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(7, 'Gudihathnur', 1, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(8, 'Ichoda', 1, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(9, 'Jainad', 1, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(10, 'Mavala', 1, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(11, 'Neradigonda', 1, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(12, 'Sirikonda', 1, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(13, 'Talamadagu', 1, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(14, 'Tamsi', 1, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(15, 'Gadiguda', 1, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(16, 'Inderavelly', 1, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(17, 'Narnoor', 1, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(18, 'Utnoor', 1, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(19, 'Allapalli', 2, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(20, 'Annapureddypally', 2, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(21, 'Aswaraopeta', 2, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(22, 'Chandrugonda', 2, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(23, 'Chunchupally', 2, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(24, 'Dammapeta', 2, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(25, 'Gundala', 2, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(26, 'Julurpad', 2, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(27, 'Kothagudem', 2, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(28, 'Laxmidevipalli', 2, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(29, 'Mulakalapalle', 2, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(30, 'Palvancha', 2, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(31, 'Sujathanagar', 2, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(32, 'Tekulapalle', 2, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(33, 'Yellandu', 2, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(34, 'Aswapuram', 2, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(35, 'Bhadrachalam', 2, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(36, 'Cherla', 2, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(37, 'Burgampahad', 2, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(38, 'Dummugudem', 2, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(39, 'Karakagudem', 2, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(40, 'Manuguru', 2, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(41, 'Pinapaka', 2, '2026-01-26 19:24:30', '2026-01-26 19:36:18', 'active'),
(42, 'Bheemadevarapalle', 3, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(43, 'Dharmasagar', 3, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(44, 'Elkathurthy', 3, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(45, 'Hanamkonda', 3, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(46, 'Hasanparthy', 3, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(47, 'Inavole', 3, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(48, 'Kamalapur', 3, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(49, 'Kazipet', 3, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(50, 'Velair', 3, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(51, 'Atmakur', 3, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(52, 'Damera', 3, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(53, 'Nadikuda', 3, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(54, 'Parkal', 3, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(55, 'Shayampet', 3, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(56, 'Amberpet', 4, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(57, 'Asif Nagar', 4, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(58, 'Bahadurpura', 4, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(59, 'Bandlaguda', 4, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(60, 'Charminar', 4, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(61, 'Golkonda', 4, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(62, 'Himayathnagar', 4, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(63, 'Nampally', 4, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(64, 'Saidabad', 4, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(65, 'Ameerpet', 4, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(66, 'Khairtabad', 4, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(67, 'Maredpally', 4, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(68, 'Musheerabad', 4, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(69, 'Secunderabad', 4, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(70, 'Shaikpet', 4, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(71, 'Tirumalgiri', 4, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(72, 'Beerpur', 5, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(73, 'Buggaram', 5, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(74, 'Dharmapuri', 5, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(75, 'Gollapalle', 5, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(76, 'Jagtial', 5, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(77, 'Jagtial Rural', 5, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(78, 'Kodimial', 5, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(79, 'Mallial', 5, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(80, 'Pegadapalle', 5, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(81, 'Raikal', 5, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(82, 'Sarangapur', 5, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(83, 'Velgatoor', 5, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(84, 'Ibrahimpatnam', 5, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(85, 'Mallapur', 5, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(86, 'Metpalli', 5, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(87, 'Kathlapur', 5, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(88, 'Korutla', 5, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(89, 'Medipalle', 5, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(90, 'Bachannapeta', 6, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(91, 'Devaruppala', 6, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(92, 'Jangaon', 6, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(93, 'Lingalaghanpur', 6, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(94, 'Narmetta', 6, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(95, 'Raghunathapalle', 6, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(96, 'Tharigoppula', 6, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(97, 'Chilpur', 6, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(98, 'Kodakandla', 6, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(99, 'Palakurthi', 6, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(100, 'Station Ghanpur', 6, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(101, 'Zaffergadh', 6, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(102, 'Bhupalpalle', 7, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(103, 'Chityal', 7, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(104, 'Ghanpur', 7, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(105, 'Kataram', 7, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(106, 'Mahadevpur', 7, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(107, 'Maha Mutharam', 7, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(108, 'Malharrao', 7, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(109, 'Mogullapalle', 7, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(110, 'Palimela', 7, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(111, 'Regonda', 7, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(112, 'Tekumatla', 7, '2026-01-26 19:25:41', '2026-01-26 19:36:18', 'active'),
(113, 'Kaloor Timmanadoddi', 8, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(114, 'Dharur', 8, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(115, 'Gadwal', 8, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(116, 'Itikyal', 8, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(117, 'Maldakal', 8, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(118, 'Ghattu', 8, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(119, 'Aiza', 8, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(120, 'Rajoli', 8, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(121, 'Waddepalle', 8, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(122, 'Manopad', 8, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(123, 'Undavelli', 8, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(124, 'Alampur', 8, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(125, 'Banswada', 9, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(126, 'Bichkunda', 9, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(127, 'Birkoor', 9, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(128, 'Jukkal', 9, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(129, 'Madnur', 9, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(130, 'Nasurullabad', 9, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(131, 'Nizamsagar', 9, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(132, 'Pedda Kodapgal', 9, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(133, 'Pitlam', 9, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(134, 'Dongli', 9, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(135, 'Bhiknoor', 9, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(136, 'Bibipet', 9, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(137, 'Domakonda', 9, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(138, 'Kamareddy', 9, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(139, 'Machareddy', 9, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(140, 'Rajampet', 9, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(141, 'Ramareddy', 9, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(142, 'Sadasivanagar', 9, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(143, 'Tadwai', 9, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(144, 'Gandhari', 9, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(145, 'Lingampet', 9, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(146, 'Naga Reddipet', 9, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(147, 'Yellareddy', 9, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(148, 'Chigurumamidi', 10, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(149, 'Choppadandi', 10, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(150, 'Gangadhara', 10, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(151, 'Ganneruvaram', 10, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(152, 'Karimnagar', 10, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(153, 'Karimnagar Rural-I', 10, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(154, 'Karimnagar Rural-II', 10, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(155, 'Manakondur', 10, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(156, 'Ramadugu', 10, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(157, 'Thimmapur', 10, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(158, 'Ellandakunta', 10, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(159, 'Huzurabad', 10, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(160, 'Jammikunta', 10, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(161, 'Shankarapatnam', 10, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(162, 'V Saidapur', 10, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(163, 'Veenavanka', 10, '2026-01-26 19:26:43', '2026-01-26 19:36:18', 'active'),
(164, 'Enkuru', 11, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(165, 'Kalluru', 11, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(166, 'Penuballi', 11, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(167, 'Sathupalli', 11, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(168, 'Thallada', 11, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(169, 'Vemsoor', 11, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(170, 'Bonakal', 11, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(171, 'Chinthakani', 11, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(172, 'Kamepalle', 11, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(173, 'Khammam Rural', 11, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(174, 'Khammam Urban', 11, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(175, 'Konijerla', 11, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(176, 'Kusumanchi', 11, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(177, 'Madhira', 11, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(178, 'Mudigonda', 11, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(179, 'Nelakondapalle', 11, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(180, 'Raghunadhapalem', 11, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(181, 'Singareni', 11, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(182, 'Thirumalayapalem', 11, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(183, 'Wyra', 11, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(184, 'Yerrupalem', 11, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(185, 'Asifabad', 12, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(186, 'Jainoor', 12, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(187, 'Kerameri', 12, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(188, 'Lingapur', 12, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(189, 'Rebbena', 12, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(190, 'Sirpur Urban', 12, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(191, 'Tiryani', 12, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(192, 'Wankidi', 12, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(193, 'Bejjur', 12, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(194, 'Chintalamanepally', 12, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(195, 'Dahegaon', 12, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(196, 'Kagaznagar', 12, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(197, 'Kouthala', 12, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(198, 'Penchikalpet', 12, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(199, 'Sirpur Town', 12, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(200, 'Bayyaram', 13, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(201, 'Dornakal', 13, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(202, 'Ganagavaram', 13, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(203, 'Garla', 13, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(204, 'Gudur', 13, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(205, 'Kesamudram', 13, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(206, 'Kothaguda', 13, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(207, 'Kuravi', 13, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(208, 'Mahabubabad', 13, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(209, 'Seerole', 13, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(210, 'Inugurthy', 13, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(211, 'Chinnagudur', 13, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(212, 'Danthalapalle', 13, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(213, 'Maripeda', 13, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(214, 'Narsimhulapet', 13, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(215, 'Nellikudur', 13, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(216, 'Peddavangara', 13, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(217, 'Thorrur', 13, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(218, 'Addakal', 14, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(219, 'Balanagar', 14, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(220, 'Bhoothpur', 14, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(221, 'Chinna Chintha Kunta', 14, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(222, 'Devarkadra', 14, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(223, 'Gandeed', 14, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(224, 'Hanwada', 14, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(225, 'Jadcherla', 14, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(226, 'Koilkonda', 14, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(227, 'Mahabubnagar Rural', 14, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(228, 'Mahabubnagar Urban', 14, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(229, 'Midjil', 14, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(230, 'Mohammadabad', 14, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(231, 'Musapet', 14, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(232, 'Nawabpet', 14, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(233, 'Rajapur', 14, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(234, 'Bheemaram', 15, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(235, 'Chennur', 15, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(236, 'Dandepally', 15, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(237, 'Hajipur', 15, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(238, 'Jaipur', 15, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(239, 'Jannaram', 15, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(240, 'Kotapally', 15, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(241, 'Luxettipet', 15, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(242, 'Mancherial', 15, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(243, 'Mandamarri', 15, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(244, 'Naspur', 15, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(245, 'Bellampally', 15, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(246, 'Bheemini', 15, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(247, 'Kannepally', 15, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(248, 'Kasipet', 15, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(249, 'Nennel', 15, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(250, 'Tandur', 15, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(251, 'Vempally', 15, '2026-01-26 19:28:00', '2026-01-26 19:36:18', 'active'),
(252, 'Alladurg', 16, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(253, 'Havelighanpur', 16, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(254, 'Medak', 16, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(255, 'Nizampet', 16, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(256, 'Papannapet', 16, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(257, 'Ramayampet', 16, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(258, 'Regode', 16, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(259, 'Shankarampet A', 16, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(260, 'Shankarampet R', 16, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(261, 'Tekmal', 16, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(262, 'Chilipched', 16, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(263, 'Kowdipalle', 16, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(264, 'Kulcharam', 16, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(265, 'Narsapur', 16, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(266, 'Shivampet', 16, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(267, 'Chegunta', 16, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(268, 'Manoharabad', 16, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(269, 'Masaipet', 16, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(270, 'Narsingi', 16, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(271, 'Tupran', 16, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(272, 'Yeldurthy', 16, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(273, 'Alwal', 17, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(274, 'Bachupally', 17, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(275, 'Balanagar', 17, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(276, 'Dundigal Gandimaisamma', 17, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(277, 'Kukatpally', 17, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(278, 'Malkajgiri', 17, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(279, 'Quthbullapur', 17, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(280, 'Ghatkesar', 17, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(281, 'Kapra', 17, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(282, 'Keesara', 17, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(283, 'Medchal', 17, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(284, 'Medipally', 17, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(285, 'Muduchintalpalli', 17, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(286, 'Shamirpet', 17, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(287, 'Uppal', 17, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(288, 'Eturnagaram', 18, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(289, 'Govindaraopet', 18, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(290, 'Kannaigudem', 18, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(291, 'Mangapet', 18, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(292, 'Mulugu', 18, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(293, 'Sammakka Saralamma Tadvai', 18, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(294, 'Venkatapur', 18, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(295, 'Venkatapuram', 18, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(296, 'Wazeed', 18, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(297, 'Achampet', 19, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(298, 'Amrabad', 19, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(299, 'Balmoor', 19, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(300, 'Lingal', 19, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(301, 'Padra', 19, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(302, 'Uppunuthala', 19, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(303, 'Charakonda', 19, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(304, 'Kalwakurthy', 19, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(305, 'Urkonda', 19, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(306, 'Vangoor', 19, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(307, 'Veldanda', 19, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(308, 'Kodair', 19, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(309, 'Kollapur', 19, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(310, 'Peddakothapalle', 19, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(311, 'Pentlavelli', 19, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(312, 'Bijinapalle', 19, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(313, 'Nagarkurnool', 19, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(314, 'Tadoor', 19, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(315, 'Telkapalle', 19, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(316, 'Thimmajipeta', 19, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(317, 'Chandampet', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(318, 'Chinthapalle', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(319, 'Devarakonda', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(320, 'Gundlapalle', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(321, 'Gurrampode', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(322, 'Kondamallapally', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(323, 'Marriguda', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(324, 'Nampalle', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(325, 'Neredugommu', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(326, 'Pedda Adiserlapalle', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(327, 'Adavi Devulapally', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(328, 'Anumula Haliya', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(329, 'Damaracherla', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(330, 'Madugulapally', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(331, 'Miryalaguda', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(332, 'Nidamanur', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(333, 'Peddavoora', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(334, 'Thripuraram', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(335, 'Tirumalagiri Sagar', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(336, 'Vemulapalle', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(337, 'Chandur', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(338, 'Chityala', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(339, 'Kangal', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(340, 'Kattangoor', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(341, 'Kethepalle', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(342, 'Munugode', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(343, 'Nakrekal', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(344, 'Narketpalle', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(345, 'Nalgonda', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(346, 'Saligouraram', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(347, 'Thipparthi', 20, '2026-01-26 19:29:01', '2026-01-26 19:36:18', 'active'),
(348, 'Damaragidda', 21, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(349, 'Dhanwada', 21, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(350, 'Gundumal', 21, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(351, 'Kosgi', 21, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(352, 'Krishna', 21, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(353, 'Kottha Pally', 21, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(354, 'Maddur', 21, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(355, 'Maganoor', 21, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(356, 'Makthal', 21, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(357, 'Marikal', 21, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(358, 'Narayanpet', 21, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(359, 'Narva', 21, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(360, 'Utkoor', 21, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(361, 'Basar', 22, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(362, 'Bhainsa', 22, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(363, 'Kubeer', 22, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(364, 'Kuntala', 22, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(365, 'Lokeshwaram', 22, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(366, 'Mudhole', 22, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(367, 'Tanoor', 22, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(368, 'Dastuarabad', 22, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(369, 'Dilawarpur', 22, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(370, 'Kaddampeddur', 22, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(371, 'Khanapur', 22, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(372, 'Laxmanchanda', 22, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(373, 'Mamada', 22, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(374, 'Narsapur G', 22, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(375, 'Nirmal Rural', 22, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(376, 'Nirmal Urban', 22, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(377, 'Pembi', 22, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(378, 'Sarangapur', 22, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(379, 'Soan', 22, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(380, 'Aloor', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(381, 'Armur', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(382, 'Balkonda', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(383, 'Bheemgal', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(384, 'Donkeshwar', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(385, 'Jakranpalle', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(386, 'Kammarpalle', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(387, 'Mendora', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(388, 'Mortad', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(389, 'Mupkal', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(390, 'Nandipet', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(391, 'Vailpur', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(392, 'Yergatla', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(393, 'Bodhan', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(394, 'Chandur', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(395, 'Kotgiri', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(396, 'Pothangal', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(397, 'Mosra', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(398, 'Ranjal', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(399, 'Rudrur', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(400, 'Saloora', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(401, 'Varni', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(402, 'Yedapalle', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(403, 'Dharpalle', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(404, 'Dichpalle', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(405, 'Indalwai', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(406, 'Makloor', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(407, 'Mugpal', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(408, 'Navipet', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(409, 'Nizamabad North', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(410, 'Nizamabad Rural', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(411, 'Nizamabad South', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(412, 'Sirkonda', 23, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(413, 'Kamanpur', 24, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(414, 'Manthani', 24, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(415, 'Mutharam', 24, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(416, 'Ramagiri', 24, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(417, 'Anthergoan', 24, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(418, 'Dharmaram', 24, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(419, 'Elgaid', 24, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(420, 'Julapalle', 24, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(421, 'Palakurthy', 24, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(422, 'Peddapalli', 24, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(423, 'Ramagundam', 24, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(424, 'Srirampur', 24, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(425, 'Sultanabad', 24, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(426, 'Odela', 24, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(427, 'Ellanthakunta', 25, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(428, 'Gambhiraopeta', 25, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(429, 'Mustabad', 25, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(430, 'Sircilla', 25, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(431, 'Thangallapalle', 25, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(432, 'Veernapalle', 25, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(433, 'Yellareddypeta', 25, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(434, 'Boinpalle', 25, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(435, 'Chandurthi', 25, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(436, 'Konaraopeta', 25, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(437, 'Rudrangi', 25, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(438, 'Vemulawada', 25, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(439, 'Vemulawada Rural', 25, '2026-01-26 19:29:54', '2026-01-26 19:36:18', 'active'),
(440, 'Chevella', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(441, 'Moinabad', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(442, 'Shabad', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(443, 'Shankarpalle', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(444, 'Abdullapurmet', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(445, 'Hayathnagar', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(446, 'Ibrahimpatnam', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(447, 'Madgul', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(448, 'Manchal', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(449, 'Yacharam', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(450, 'Amangal', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(451, 'Balapur', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(452, 'Kadthal', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(453, 'Kandukur', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(454, 'Maheshwaram', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(455, 'Saroornagar', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(456, 'Talakonapally', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(457, 'Gandipet', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(458, 'Rajendranagar', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(459, 'Serilingampally', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(460, 'Shamshabad', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(461, 'Farooqnagar', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(462, 'Jilled Chowdergudem', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(463, 'Keshampeta', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(464, 'Kondurg', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(465, 'Kothur', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(466, 'Nandigam', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(467, 'Shadnagar', 26, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(468, 'Kalher', 27, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(469, 'Kangti', 27, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(470, 'Manoor', 27, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(471, 'Nagilgidda', 27, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(472, 'Narayankhed', 27, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(473, 'Sirgapoor', 27, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(474, 'Ameenpur', 27, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(475, 'Andole', 27, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(476, 'Gummadidala', 27, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(477, 'Hathnoora', 27, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(478, 'Jinnaram', 27, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(479, 'Kandi', 27, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(480, 'Kondapur', 27, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(481, 'Munipally', 27, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(482, 'Patancheru', 27, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(483, 'Pulkal', 27, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(484, 'Ramchandrapuram', 27, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(485, 'Sadasivpet', 27, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(486, 'Sangareddy', 27, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(487, 'Vatpally', 27, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(488, 'Jharasangam', 27, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(489, 'Kohir', 27, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(490, 'Mogudampally', 27, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(491, 'Nyalkal', 27, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(492, 'Raikode', 27, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(493, 'Zaheerabad', 27, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(494, 'Dubbak', 28, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(495, 'Siddipet Rural', 28, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(496, 'Chinnakodur', 28, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(497, 'Nangnoor', 28, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(498, 'Siddipet Urban', 28, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(499, 'Thoguta', 28, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(500, 'Mirdoddi', 28, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(501, 'Doulthabad', 28, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(502, 'Komuravelli', 28, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(503, 'Cherial', 28, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(504, 'Narayanaraopet', 28, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(505, 'Akberpet Bhoompally', 28, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(506, 'Raipole', 28, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(507, 'Wargal', 28, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(508, 'Mulug', 28, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(509, 'Markook', 28, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(510, 'Jagdevpur', 28, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(511, 'Gajwel', 28, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(512, 'Kondapak', 28, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(513, 'Kukunoorpally', 28, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(514, 'Akkannapet', 28, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(515, 'Bejjanki', 28, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(516, 'Dhoolmitta', 28, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(517, 'Husnabad', 28, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(518, 'Koheda', 28, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(519, 'Maddur', 28, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(520, 'Atmakur S', 29, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(521, 'Chivvemla', 29, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(522, 'Jajireddygudem', 29, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(523, 'Maddirala', 29, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(524, 'Mothey', 29, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(525, 'Nagaram', 29, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(526, 'Nuthankal', 29, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(527, 'Penpahad', 29, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(528, 'Thirumalagiri', 29, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(529, 'Thungathurthy', 29, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(530, 'Suryapet', 29, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(531, 'Ananthagiri', 29, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(532, 'Chilkur', 29, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(533, 'Kodad', 29, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(534, 'Munagala', 29, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(535, 'Nadigudem', 29, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(536, 'Garidepally', 29, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(537, 'Huzurnagar', 29, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(538, 'Mallareddygudem', 29, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(539, 'Mattampally', 29, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(540, 'Mellachervu', 29, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(541, 'Neredcherla', 29, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(542, 'Palakeedu', 29, '2026-01-26 19:32:01', '2026-01-26 19:36:18', 'active'),
(543, 'Basheerabad', 30, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(544, 'Bommaraspet', 30, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(545, 'Doulthabad', 30, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(546, 'Kodangal', 30, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(547, 'Peddemul', 30, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(548, 'Tandur', 30, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(549, 'Yelal', 30, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(550, 'Bantwaram', 30, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(551, 'Doma', 30, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(552, 'Dharur', 30, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(553, 'Kotepally', 30, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(554, 'Kulkacherla', 30, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(555, 'Marpalle', 30, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(556, 'Mominpet', 30, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(557, 'Nawabpet', 30, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(558, 'Parigi', 30, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(559, 'Pudur', 30, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(560, 'Vikarabad', 30, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(561, 'Amarchinta', 31, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(562, 'Atmakur', 31, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(563, 'Chinnambavi', 31, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(564, 'Ghanpur Khilla', 31, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(565, 'Gopalpeta', 31, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(566, 'Kothakota', 31, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(567, 'Madanapur', 31, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(568, 'Pangal', 31, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(569, 'Pebbair', 31, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(570, 'Peddamandadi', 31, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(571, 'Revally', 31, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(572, 'Srirangapur', 31, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(573, 'Veepanagandla', 31, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(574, 'Wanaparthy', 31, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(575, 'Geesugonda', 32, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(576, 'Khila Warangal', 32, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(577, 'Parvathagiri', 32, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(578, 'Rayaparthy', 32, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(579, 'Wardhannapet', 32, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(580, 'Warangal', 32, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(581, 'Sangem', 32, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(582, 'Chennaraopet', 32, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(583, 'Duggondi', 32, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(584, 'Khanapur', 32, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(585, 'Nallabelly', 32, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(586, 'Narsampet', 32, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(587, 'Nekkonda', 32, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(588, 'Addaguduru', 33, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(589, 'Alair', 33, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(590, 'Atmakur M', 33, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(591, 'Bibinagar', 33, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(592, 'Bhongir', 33, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(593, 'Bommalaramaram', 33, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(594, 'Gundala', 33, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(595, 'Motakondur', 33, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(596, 'Mothkur', 33, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(597, 'Rajapet', 33, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(598, 'Turkapally', 33, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(599, 'Yadagirigutta', 33, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(600, 'Bhoodan Pochampally', 33, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(601, 'Choutuppal', 33, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(602, 'Narayanpur', 33, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(603, 'Ramannapet', 33, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active'),
(604, 'Valigonda', 33, '2026-01-26 19:32:59', '2026-01-26 19:36:18', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `nodal_officers`
--

CREATE TABLE `nodal_officers` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `scheme_id` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `purpose` text DEFAULT NULL,
  `district_id` int(11) NOT NULL,
  `mandal_id` int(11) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `total_days` int(11) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nodal_officers`
--

INSERT INTO `nodal_officers` (`id`, `name`, `designation`, `department`, `scheme_id`, `email`, `phone`, `status`, `created_at`, `updated_at`, `purpose`, `district_id`, `mandal_id`, `start_date`, `end_date`, `total_days`, `state_id`) VALUES
(0, 'Deepak', 'PKVY Nodal Officer', NULL, 12, 'deepakgummadi07@gmail.com', '9876543243', 'active', '2026-01-03 06:25:01', '2026-01-03 06:25:01', 'Organic cluster formation', 18, 267, '2024-01-12', '2024-12-11', 335, 1),
(1, 'Ramesh Kumar', 'Rythu Bandhu Nodal Officer', 'Horticulture', 1, 'ramesh.kumar@agri.gov.in', '9876543240', 'active', '2026-01-03 04:40:26', '2026-01-03 04:40:26', 'Farmer investment support', 0, 0, '2024-04-01', '2024-12-31', 275, 1),
(2, 'Sita Lakshmi', 'PM-KISAN Nodal Officer', 'Horticulture', 2, 'sita.lakshmi@agri.gov.in', '9876543241', 'active', '2026-01-03 04:40:26', '2026-01-03 04:40:26', 'Income support distribution', 0, 0, '2024-01-15', '2024-12-31', 351, 1),
(3, 'Ganesh Rao', 'Silk Samagra Nodal Officer', 'Sericulture', 3, 'ganesh.rao@agri.gov.in', '9876543242', 'active', '2026-01-03 04:40:26', '2026-01-03 04:40:26', 'Silk cluster coordination', 0, 0, '2024-02-01', '2024-11-30', 304, 1),
(4, 'Anitha Devi', 'Blue Revolution Nodal Officer', 'Fisheries', 222, 'anitha.devi@agri.gov.in', '9876543243', 'inactive', '2026-01-03 04:40:26', '2026-01-04 07:24:04', 'Inland fisheries promotion', 5, 63, '2024-02-20', '2024-09-05', 199, 1),
(5, 'Bharat Kumar', 'Gokul Mission Nodal Officer', 'Animal Husbandry', 216, 'bharat.kumar@agri.gov.in', '9876543244', 'active', '2026-01-03 04:40:26', '2026-01-05 06:34:21', 'Breed improvement support', 19, 273, '2024-01-09', '2024-10-30', 296, 1),
(6, 'Priya Reddy', 'PMFBY Nodal Officer', 'Soil Conservation', 6, 'priya.reddy@agri.gov.in', '9876543245', 'active', '2026-01-03 04:40:26', '2026-01-04 07:23:20', 'Crop insurance facilitation', 5, 56, '2024-02-14', '2024-12-30', 321, 1),
(7, 'Venkat Rao', 'Soil Health Card Nodal Officerssss', 'Soil Conservation', 7, 'venkat.rao2@agri.gov.in', '9876543246', 'active', '2026-01-03 04:40:26', '2026-01-03 05:05:52', 'Soil sample collection', 0, 0, '2024-01-19', '2024-09-29', 255, 1),
(8, 'Kavitha Singh', 'Oilseeds Mission Nodal Officer', 'Seed Certification', 8, 'kavitha.singh@agri.gov.in', '9876543247', 'active', '2026-01-03 04:40:26', '2026-01-03 04:40:26', 'Oilseed productivity drive', 0, 0, '2024-02-05', '2024-12-05', 305, 1),
(9, 'Suresh Babu', 'e-NAM Nodal Officer', 'Agricultural Marketing', 9, 'suresh.babu@agri.gov.in', '9876543248', 'active', '2026-01-03 04:40:26', '2026-01-03 04:40:26', 'Market linkage support', 0, 0, '2024-01-25', '2024-12-31', 371, 1),
(10, 'Lakshmi Rani', 'Micro Irrigation Nodal Officer', 'Irrigation', 10, 'lakshmi.rani@agri.gov.in', '9876543249', 'active', '2026-01-03 04:40:26', '2026-01-03 04:49:56', 'Micro irrigation rolloutfdzchadzh', 7, 0, '2024-03-09', '2024-12-30', 297, 1),
(11, 'Mohd. Saleem', 'PKVY Nodal Officer', 'Horticulture', 11, 'mohd.saleem@agri.gov.in', '9876543250', 'active', '2026-01-03 04:40:26', '2026-01-03 05:01:55', 'Organic cluster formation', 2, 67, '2024-02-19', '2024-12-19', 305, 1),
(12, 'Ravi Shankar', 'KCC Nodal Officer', 'Agricultural Marketing', 12, 'ravi.shankar@agri.gov.in', '9876543251', 'active', '2026-01-03 04:40:26', '2026-01-03 04:40:26', 'Credit enablement', 0, 0, '2024-01-05', '2024-12-31', 361, 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_otps`
--

CREATE TABLE `password_reset_otps` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `otp` varchar(6) NOT NULL,
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `used` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `revenue`
--

CREATE TABLE `revenue` (
  `id` int(11) NOT NULL,
  `hod_id` int(11) DEFAULT NULL,
  `scheme_id` int(11) DEFAULT NULL,
  `cooperative_name` varchar(255) DEFAULT NULL,
  `loans` decimal(15,2) DEFAULT NULL,
  `revenue` decimal(15,2) DEFAULT NULL,
  `financial_year` varchar(9) DEFAULT NULL,
  `amount` decimal(15,2) NOT NULL,
  `source` varchar(255) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` varchar(9) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `revenue`
--

INSERT INTO `revenue` (`id`, `hod_id`, `scheme_id`, `cooperative_name`, `loans`, `revenue`, `financial_year`, `amount`, `source`, `category`, `date`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, '2', 3.00, 4.00, '2025-26', 0.00, NULL, NULL, NULL, NULL, 'active', '2026-01-12 06:00:18', '2026-01-27 07:10:39'),
(2, NULL, NULL, 'TG AGROS', 200000.00, 0.30, '2025-26', 0.00, NULL, NULL, NULL, NULL, 'active', '2026-01-12 06:00:18', '2026-01-27 07:10:39'),
(3, NULL, NULL, 'TG HDCL', 200000.00, 0.30, '2025-26', 0.00, NULL, NULL, NULL, NULL, 'active', '2026-01-12 06:00:18', '2026-01-27 07:10:39'),
(4, NULL, NULL, 'TG SDCL', 200000.00, 0.30, '2025-26', 0.00, NULL, NULL, NULL, NULL, 'active', '2026-01-12 06:00:18', '2026-01-27 07:10:39'),
(5, NULL, NULL, 'TG CRIC', 200000.00, 0.30, '2025-26', 0.00, NULL, NULL, NULL, NULL, 'active', '2026-01-12 06:00:18', '2026-01-27 07:10:39'),
(6, NULL, NULL, 'TG HOUSEFED', 200000.00, 0.30, '2025-26', 0.00, NULL, NULL, NULL, NULL, 'active', '2026-01-12 06:00:18', '2026-01-27 07:10:39'),
(7, NULL, NULL, 'HACA', 200000.00, 0.30, '2025-26', 0.00, NULL, NULL, NULL, NULL, 'active', '2026-01-12 06:00:18', '2026-01-27 07:10:39'),
(8, NULL, NULL, 'TG MARKFED', 200000.00, 0.30, '2025-26', 0.00, NULL, NULL, NULL, NULL, 'active', '2026-01-12 06:00:18', '2026-01-27 07:10:39'),
(9, NULL, NULL, 'TG OILFED', 200000.00, 0.30, '2025-26', 0.00, NULL, NULL, NULL, NULL, 'active', '2026-01-12 06:00:18', '2026-01-27 07:10:39'),
(10, NULL, NULL, 'TG OCA', 200000.00, 0.30, '2025-26', 0.00, NULL, NULL, NULL, NULL, 'active', '2026-01-12 06:00:18', '2026-01-27 07:10:39'),
(11, NULL, NULL, 'TG CU', 200000.00, 0.30, '2025-26', 0.00, NULL, NULL, NULL, NULL, 'active', '2026-01-12 06:00:18', '2026-01-27 07:10:39'),
(12, NULL, NULL, 'TG SWC', 200000.00, 0.30, '2025-26', 0.00, NULL, NULL, NULL, NULL, 'active', '2026-01-12 06:00:18', '2026-01-27 07:10:39'),
(13, NULL, NULL, 'PJTAU', 200000.00, 0.30, '2025-26', 0.00, NULL, NULL, NULL, NULL, 'active', '2026-01-12 06:00:18', '2026-01-27 07:10:39'),
(14, NULL, NULL, 'SKLTGHU', 200000.00, 0.30, '2025-26', 0.00, NULL, NULL, NULL, NULL, 'active', '2026-01-12 06:00:18', '2026-01-27 07:10:39'),
(15, 1, NULL, NULL, NULL, NULL, NULL, 1500000.00, 'Internal Revenue', 'Budget', '2026-03-17', 'Revenue: Internal Revenue', NULL, '2026-01-13 08:27:57', '2026-01-27 07:10:39'),
(16, 2, NULL, NULL, NULL, NULL, NULL, 2250000.00, 'Lease', 'Non-Budget', '2025-08-07', 'Revenue: Lease', NULL, '2026-01-13 08:27:57', '2026-01-27 07:10:39'),
(17, 3, NULL, NULL, NULL, NULL, NULL, 1800000.00, 'Lease', 'Budget', '2025-10-01', 'Revenue: Lease', NULL, '2026-01-13 08:27:57', '2026-01-27 07:10:39'),
(18, 4, NULL, NULL, NULL, NULL, NULL, 950000.00, 'Internal Revenue', 'Budget', '2026-02-14', 'Revenue: Internal Revenue', NULL, '2026-01-13 08:27:57', '2026-01-27 07:10:39'),
(19, 5, NULL, NULL, NULL, NULL, NULL, 3200000.00, 'Donations', 'Transfer', '2025-08-07', 'Revenue: Donations', NULL, '2026-01-13 08:27:57', '2026-01-27 07:10:39'),
(20, 6, NULL, NULL, NULL, NULL, NULL, 1100000.00, 'Fees', 'Special Grant', '2025-06-10', 'Revenue: Fees', NULL, '2026-01-13 08:27:57', '2026-01-27 07:10:39'),
(21, 7, NULL, NULL, NULL, NULL, NULL, 890000.00, 'Interest', 'Budget', '2025-07-18', 'Revenue: Interest', NULL, '2026-01-13 08:27:57', '2026-01-27 07:10:39'),
(22, 8, NULL, NULL, NULL, NULL, NULL, 2450000.00, 'Internal Revenue', 'Direct Benefit', '2025-06-17', 'Revenue: Internal Revenue', NULL, '2026-01-13 08:27:57', '2026-01-27 07:10:39'),
(23, 9, NULL, NULL, NULL, NULL, NULL, 1350000.00, 'Internal Revenue', 'Transfer', '2026-03-02', 'Revenue: Internal Revenue', NULL, '2026-01-13 08:27:57', '2026-01-27 07:10:39'),
(24, 10, NULL, NULL, NULL, NULL, NULL, 2800000.00, 'Royalties', 'Budget', '2025-09-25', 'Revenue: Royalties', NULL, '2026-01-13 08:27:57', '2026-01-27 07:10:39'),
(25, 11, NULL, NULL, NULL, NULL, NULL, 1600000.00, 'Royalties', 'Non-Budget', '2026-01-09', 'Revenue: Royalties', NULL, '2026-01-13 08:27:57', '2026-01-27 07:10:39'),
(26, 12, NULL, NULL, NULL, NULL, NULL, 1200000.00, 'Government Grant', 'Direct Benefit', '2026-03-26', 'Revenue: Government Grant', NULL, '2026-01-13 08:27:57', '2026-01-27 07:10:39'),
(27, 13, NULL, NULL, NULL, NULL, NULL, 1750000.00, 'Royalties', 'Non-Budget', '2025-11-12', 'Revenue: Royalties', NULL, '2026-01-13 08:27:57', '2026-01-27 07:10:39'),
(28, 14, NULL, NULL, NULL, NULL, NULL, 2100000.00, 'Lease', 'Budget', '2025-08-28', 'Revenue: Lease', NULL, '2026-01-13 08:27:57', '2026-01-27 07:10:39'),
(29, 15, NULL, NULL, NULL, NULL, NULL, 1450000.00, 'Donations', 'Direct Benefit', '2026-01-04', 'Revenue: Donations', NULL, '2026-01-13 08:27:57', '2026-01-27 07:10:39'),
(30, 16, NULL, NULL, NULL, NULL, NULL, 1500000.00, 'Government Grant', 'Non-Budget', '2025-11-22', 'Revenue: Government Grant', NULL, '2026-01-13 08:27:57', '2026-01-27 07:10:39'),
(31, 17, NULL, NULL, NULL, NULL, NULL, 2250000.00, 'Tax Collection', 'Non-Budget', '2025-07-16', 'Revenue: Tax Collection', NULL, '2026-01-13 08:27:57', '2026-01-27 07:10:39'),
(32, 18, NULL, NULL, NULL, NULL, NULL, 1800000.00, 'Royalties', 'Direct Benefit', '2025-10-26', 'Revenue: Royalties', NULL, '2026-01-13 08:27:57', '2026-01-27 07:10:39'),
(33, 19, NULL, NULL, NULL, NULL, NULL, 950000.00, 'Internal Revenue', 'Special Grant', '2025-11-10', 'Revenue: Internal Revenue', NULL, '2026-01-13 08:27:57', '2026-01-27 07:10:39'),
(34, 20, NULL, NULL, NULL, NULL, NULL, 3200000.00, 'Government Grant', 'Non-Budget', '2025-11-26', 'Revenue: Government Grant', NULL, '2026-01-13 08:27:57', '2026-01-27 07:10:39');

-- --------------------------------------------------------

--
-- Table structure for table `schemes`
--

CREATE TABLE `schemes` (
  `id` int(11) NOT NULL,
  `scheme_name` varchar(255) NOT NULL,
  `central_scheme_name` varchar(255) DEFAULT NULL,
  `hod` varchar(100) NOT NULL,
  `financial_year` varchar(9) NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `allocation_goi_share` decimal(15,2) DEFAULT NULL,
  `allocation_state_share` decimal(15,2) DEFAULT NULL,
  `allocation_total` decimal(15,2) DEFAULT NULL,
  `slsc_goi_share` decimal(15,2) DEFAULT NULL,
  `slsc_state_share` decimal(15,2) DEFAULT NULL,
  `slsc_total` decimal(15,2) DEFAULT NULL,
  `sanction_goi_share` decimal(15,2) DEFAULT NULL,
  `sanction_state_share` decimal(15,2) DEFAULT NULL,
  `sanction_total` decimal(15,2) DEFAULT NULL,
  `bro_released_amount` decimal(15,2) DEFAULT NULL,
  `dt_authorized_amount` decimal(15,2) DEFAULT NULL,
  `bills_preferred_count` int(11) DEFAULT NULL,
  `bills_preferred_amount` decimal(15,2) DEFAULT NULL,
  `oldest_bill_date` date DEFAULT NULL,
  `bills_cleared_count` int(11) DEFAULT NULL,
  `bills_cleared_amount` decimal(15,2) DEFAULT NULL,
  `latest_bill_date` date DEFAULT NULL,
  `remark` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `schemes`
--

INSERT INTO `schemes` (`id`, `scheme_name`, `central_scheme_name`, `hod`, `financial_year`, `status`, `created_at`, `allocation_goi_share`, `allocation_state_share`, `allocation_total`, `slsc_goi_share`, `slsc_state_share`, `slsc_total`, `sanction_goi_share`, `sanction_state_share`, `sanction_total`, `bro_released_amount`, `dt_authorized_amount`, `bills_preferred_count`, `bills_preferred_amount`, `oldest_bill_date`, `bills_cleared_count`, `bills_cleared_amount`, `latest_bill_date`, `remark`) VALUES
(255, 'Per Drop More Crop -Micro Irrigation(PDMC)', 'Rashtriya Krishi Vikas Yojana (RKVY)', 'DoH', '2025-26', 'inactive', '2026-01-16 17:46:40', 13.00, 13.00, 26.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 14.00, 144.00, 12, 12.00, '1900-01-11', 14, 14.00, NULL, NULL),
(256, 'Rashtriya Krishi Vikas Yojana (RKVY)', 'Rashtriya Krishi Vikas Yojana (RKVY)', 'DoAc', '2025-26', 'active', '2026-01-16 17:46:40', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(257, 'Sub-Mission on Agriculture Mechanization (SMAM)', 'Rashtriya Krishi Vikas Yojana (RKVY)', 'DoA', '2025-26', 'active', '2026-01-16 17:46:40', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(258, 'National Project on Management of Soil Health & Fertility(SHF)', 'Rashtriya Krishi Vikas Yojana (RKVY)', 'DoA', '2025-26', 'active', '2026-01-16 17:46:40', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(259, 'Paramparagat Krishi Vikas Yojana (PKVY)', 'Rashtriya Krishi Vikas Yojana (RKVY)', 'DoA', '2025-26', 'active', '2026-01-16 17:46:40', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(260, 'Rainfed Area Development (RAD)', 'Rashtriya Krishi Vikas Yojana (RKVY)', 'DoH', '2025-26', 'active', '2026-01-16 17:46:40', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(261, 'Agro Forestry', 'Rashtriya Krishi Vikas Yojana (RKVY)', 'DoH', '2025-26', 'active', '2026-01-16 17:46:40', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(262, 'Crop Diverisifcation Programme (CDP)', 'Rashtriya Krishi Vikas Yojana (RKVY)', 'DoAb', '2025-26', 'active', '2026-01-16 17:46:40', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(263, 'National Mission on Edible Oil-Oilpalm (NMEO-OP)', 'Krishonnati Yojana (KY)', 'DoHe', '2025-26', 'active', '2026-01-16 17:46:40', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(264, 'Mission for Integrated Development ofHorticulture (MIDH)', 'Krishonnati Yojana (KY)', 'DoH', '2025-26', 'active', '2026-01-16 17:46:40', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(265, 'National Food Security Nutrition Mission (NFSM)', 'Krishonnati Yojana (KY)', 'DoA', '2025-26', 'active', '2026-01-16 17:46:40', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(266, 'Sub-Mission on Agricultural Extension (ATMA)', 'Krishonnati Yojana (KY)', 'DoA', '2025-26', 'active', '2026-01-16 17:46:40', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(267, 'Sub-Mission on Seed and Planting material (SMSP)NFSNM- Seed Components', 'Krishonnati Yojana (KY)', 'DoA', '2025-26', 'active', '2026-01-16 17:46:40', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(268, 'Digital Agriculture', 'Krishonnati Yojana (KY)', 'DoA', '2025-26', 'active', '2026-01-16 17:46:40', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(269, 'National Mission on Edible Oils - Oil Seeds (NMEO-OS)', 'Krishonnati Yojana (KY)', 'DoA', '2025-26', 'active', '2026-01-16 17:46:40', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(270, 'National Bamboo Mission (NBM)', 'Krishonnati Yojana (KY)', 'DoH', '2025-26', 'active', '2026-01-16 17:46:40', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(271, 'Mission for Atmanirbharta in Pulses', 'Krishonnati Yojana (KY)', 'DoA', '2025-26', 'active', '2026-01-16 17:46:40', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(272, 'National Mission onNatural Farming(NMNF)', 'National Mission onNatural Farming(NMNF)', 'DoA', '2025-26', 'active', '2026-01-16 17:46:40', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `scheme_budget_allocation`
--

CREATE TABLE `scheme_budget_allocation` (
  `id` int(11) NOT NULL,
  `scheme_id` int(11) NOT NULL,
  `hod_id` int(11) NOT NULL,
  `hod_name` varchar(255) NOT NULL,
  `allocated_amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `spent_amount` decimal(15,2) DEFAULT 0.00,
  `financial_year` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `scheme_budget_allocation`
--

INSERT INTO `scheme_budget_allocation` (`id`, `scheme_id`, `hod_id`, `hod_name`, `allocated_amount`, `spent_amount`, `financial_year`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Dr. Ramesh Kumar', 75000000.00, 52000000.00, '2024-25', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(2, 2, 2, 'Sri. Venkatesh Reddy', 60000000.00, 45000000.00, '2024-25', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(3, 3, 3, 'Smt. Lakshmi Devi', 35000000.00, 24000000.00, '2024-25', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(4, 4, 4, 'Sri. Suresh Babu', 25000000.00, 18000000.00, '2024-25', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(5, 5, 5, 'Dr. Prasad Rao', 18000000.00, 12000000.00, '2024-25', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(6, 6, 6, 'Prof. Jayashankar Rao', 22000000.00, 15000000.00, '2024-25', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(7, 7, 7, 'Prof. Konda Laxman', 15000000.00, 10000000.00, '2024-25', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(8, 8, 8, 'Dr. Anand Kumar', 12000000.00, 8500000.00, '2024-25', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(9, 9, 9, 'Sri. Nagaraju Goud', 45000000.00, 32000000.00, '2024-25', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(10, 10, 10, 'Smt. Padma Kumari', 30000000.00, 22000000.00, '2024-25', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(11, 261, 0, '', 5000000.00, 0.00, NULL, '2026-01-22 08:04:43', '2026-01-22 08:04:43'),
(12, 262, 0, '', 7500000.00, 0.00, NULL, '2026-01-22 08:04:43', '2026-01-22 08:04:43'),
(13, 268, 0, '', 3000000.00, 0.00, NULL, '2026-01-22 08:04:43', '2026-01-22 08:04:43'),
(14, 271, 0, '', 4000000.00, 0.00, NULL, '2026-01-22 08:04:43', '2026-01-22 08:04:43'),
(15, 264, 0, '', 6000000.00, 0.00, NULL, '2026-01-22 08:04:43', '2026-01-22 08:04:43'),
(16, 270, 0, '', 3500000.00, 0.00, NULL, '2026-01-22 08:04:43', '2026-01-22 08:04:43'),
(17, 265, 0, '', 8000000.00, 0.00, NULL, '2026-01-22 08:04:43', '2026-01-22 08:04:43'),
(18, 263, 0, '', 2000000.00, 0.00, NULL, '2026-01-22 08:04:43', '2026-01-22 08:04:43'),
(19, 269, 0, '', 4500000.00, 0.00, NULL, '2026-01-22 08:04:43', '2026-01-22 08:04:43'),
(20, 272, 0, '', 2500000.00, 0.00, NULL, '2026-01-22 08:04:43', '2026-01-22 08:04:43'),
(21, 258, 0, '', 9000000.00, 0.00, NULL, '2026-01-22 08:04:43', '2026-01-22 08:04:43'),
(22, 259, 0, '', 1000000.00, 0.00, NULL, '2026-01-22 08:04:43', '2026-01-22 08:04:43'),
(23, 255, 0, '', 1200000.00, 0.00, NULL, '2026-01-22 08:04:43', '2026-01-22 08:04:43'),
(24, 260, 0, '', 7000000.00, 0.00, NULL, '2026-01-22 08:04:43', '2026-01-22 08:04:43'),
(25, 256, 0, '', 6500000.00, 0.00, NULL, '2026-01-22 08:04:43', '2026-01-22 08:04:43'),
(26, 266, 0, '', 5500000.00, 0.00, NULL, '2026-01-22 08:04:43', '2026-01-22 08:04:43'),
(27, 257, 0, '', 4800000.00, 0.00, NULL, '2026-01-22 08:04:43', '2026-01-22 08:04:43'),
(28, 267, 0, '', 5200000.00, 0.00, NULL, '2026-01-22 08:04:43', '2026-01-22 08:04:43');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `employee_id` varchar(50) DEFAULT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `hod_id` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `joining_date` date DEFAULT NULL,
  `status` enum('active','inactive','on_leave') DEFAULT 'active',
  `employee_type` enum('regular','outsource') DEFAULT 'regular',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`id`, `name`, `employee_id`, `designation`, `department`, `category_id`, `hod_id`, `email`, `phone`, `joining_date`, `status`, `employee_type`, `created_at`, `updated_at`) VALUES
(1, 'Ajay Kumar', 'EMP001', 'Assistant Secretary', 'A&C Secretariat', 1, 1, 'ajay.kumar@agri.gov.in', '9000000001', '2020-01-14', 'active', 'regular', '2026-01-03 05:11:47', '2026-01-12 11:17:57'),
(2, 'Priya Sharma', 'EMP002', 'Deputy Director', 'Director of Agriculture', 2, 2, 'priya.sharma@agri.gov.in', '9000000002', '2019-06-20', 'active', 'regular', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(3, 'Ravi Teja', 'EMP003', 'Horticulture Officer', 'Horticulture and Sericulture', 2, 3, 'ravi.teja@agri.gov.in', '9000000003', '2018-03-10', 'active', 'outsource', '2026-01-03 05:11:47', '2026-01-03 06:35:13'),
(4, 'Meena Kumari', 'EMP004', 'Marketing Officer', 'Agricultural Marketing', 5, 4, 'meena.kumari@agri.gov.in', '9000000004', '2021-02-28', 'active', 'regular', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(5, 'Sanjay Reddy', 'EMP005', 'Cooperation Inspector', 'Cooperation', 7, 5, 'sanjay.reddy@agri.gov.in', '9000000005', '2020-07-15', 'active', 'regular', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(6, 'Deepika Rao', 'EMP006', 'Research Associate', 'PJTAU', 3, 6, 'deepika.rao@agri.gov.in', '9000000006', '2019-11-01', 'active', 'outsource', '2026-01-03 05:11:47', '2026-01-03 06:35:13'),
(7, 'Arun Prasad', 'EMP007', 'Lecturer', 'SKLTSHU', 3, 7, 'arun.prasad@agri.gov.in', '9000000007', '2018-09-15', 'active', 'regular', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(8, 'Neha Singh', 'EMP008', 'Training Coordinator', 'SAMETI', 4, 8, 'neha.singh@agri.gov.in', '9000000008', '2021-04-20', 'active', 'regular', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(9, 'Vinod Kumar', 'EMP009', 'Marketing Executive', 'TG MARKFED', 5, 9, 'vinod.kumar@agri.gov.in', '9000000009', '2020-08-10', 'active', 'outsource', '2026-01-03 05:11:47', '2026-01-03 06:35:13'),
(10, 'Anjali Devi', 'EMP010', 'Seed Officer', 'TGSDCL', 6, 10, 'anjali.devi@agri.gov.in', '9000000010', '2019-05-25', 'active', 'regular', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(11, 'Rajesh Naidu', 'EMP011', 'Certification Officer', 'TGSOCA', 8, 11, 'rajesh.naidu@agri.gov.in', '9000000011', '2018-12-01', 'active', 'regular', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(12, 'Pooja Reddy', 'EMP012', 'Industry Liaison', 'TGAGROS', 6, 12, 'pooja.reddy@agri.gov.in', '9000000012', '2021-01-10', 'active', 'outsource', '2026-01-03 05:11:47', '2026-01-03 06:35:13'),
(13, 'Sunil Goud', 'EMP013', 'Oil Federation Officer', 'TGOILFED', 7, 13, 'sunil.goud@agri.gov.in', '9000000013', '2020-03-18', 'active', 'regular', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(14, 'Lavanya Kumari', 'EMP014', 'Warehouse Manager', 'TGWC', 6, 14, 'lavanya.kumari@agri.gov.in', '9000000014', '2019-09-05', 'active', 'regular', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(15, 'Harish Varma', 'EMP015', 'Cooperative Officer', 'HACA', 7, 15, 'harish.varma@agri.gov.in', '9000000015', '2018-06-22', 'active', 'outsource', '2026-01-03 05:11:47', '2026-01-03 06:35:13'),
(16, 'Divya Rao', 'EMP016', 'Horticulture Officer', 'TGHDCL', 6, 16, 'divya.rao@agri.gov.in', '9000000016', '2021-05-30', 'active', 'regular', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(17, 'Ramana Reddy', 'EMP017', 'Irrigation Officer', 'TGRIC', 7, 17, 'ramana.reddy@agri.gov.in', '9000000017', '2020-10-12', 'active', 'regular', '2026-01-03 05:11:47', '2026-01-03 05:11:47'),
(18, 'Shilpa Devi', 'EMP018', 'Union Coordinator', 'TGCU', 7, 18, 'shilpa.devi@agri.gov.in', '9000000018', '2019-02-14', 'active', 'outsource', '2026-01-03 05:11:47', '2026-01-03 06:35:13'),
(19, 'Praveen Kumar', 'EMP019', 'Housing Officer', 'TG HOUSEFED', 7, 19, 'praveen.kumar@agri.gov.in', '9000000019', '2018-08-08', 'active', 'regular', '2026-01-03 05:11:47', '2026-01-03 05:11:47');

-- --------------------------------------------------------

--
-- Table structure for table `states`
--

CREATE TABLE `states` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `states`
--

INSERT INTO `states` (`id`, `name`, `created_date`, `updated_date`, `status`) VALUES
(1, 'Telangana', '2025-12-30 06:56:32', '2025-12-30 06:56:32', 1);

-- --------------------------------------------------------

--
-- Table structure for table `state_scheme_financials`
--

CREATE TABLE `state_scheme_financials` (
  `id` int(11) NOT NULL,
  `state_scheme_name` varchar(255) NOT NULL,
  `hod` varchar(150) NOT NULL,
  `budget_estimates` decimal(14,2) DEFAULT NULL,
  `bro_released_amount` decimal(14,2) DEFAULT NULL,
  `bills_preferred_count` int(11) DEFAULT 0,
  `bills_preferred_amount` decimal(14,2) DEFAULT NULL,
  `oldest_bill_date` date DEFAULT NULL,
  `bills_cleared_count` int(11) DEFAULT 0,
  `bills_cleared_amount` decimal(14,2) DEFAULT NULL,
  `latest_clearance_date` date DEFAULT NULL,
  `pending_bills_count` int(11) DEFAULT 0,
  `pending_bills_amount` decimal(14,2) DEFAULT NULL,
  `financial_year` varchar(9) NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `role` enum('superadmin','admin','hod','staff','district_officer') NOT NULL DEFAULT 'staff',
  `hod_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `password_changed` tinyint(1) DEFAULT 0,
  `last_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `reset_otp` varchar(6) DEFAULT NULL,
  `reset_otp_expiry` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `role`, `hod_id`, `staff_id`, `name`, `status`, `password_changed`, `last_login`, `created_at`, `updated_at`, `reset_otp`, `reset_otp_expiry`) VALUES
(1, 'admin', 'password123', 'admin@agri.gov.in', 'admin', NULL, NULL, 'System Administrator', 'active', 0, '2026-01-13 06:21:15', '2026-01-03 05:11:47', '2026-01-13 06:21:15', NULL, NULL),
(2, 'hod1', 'password123', 'ramesh.kumar@agri.gov.in', 'hod', 1, NULL, 'Dr. Ramesh Kumar', 'active', 0, '2026-01-26 16:24:23', '2026-01-03 05:11:47', '2026-01-26 16:24:23', NULL, NULL),
(3, 'hod2', 'password123', 'venkatesh.reddy@agri.gov.in', 'hod', 2, NULL, 'Sri. Venkatesh Reddy', 'active', 0, NULL, '2026-01-03 05:11:47', '2026-01-03 05:11:47', NULL, NULL),
(4, 'hod3', 'password123', 'lakshmi.devi@agri.gov.in', 'hod', 3, NULL, 'Smt. Lakshmi Devi', 'active', 0, NULL, '2026-01-03 05:11:47', '2026-01-03 05:11:47', NULL, NULL),
(5, 'staff1', 'password123', 'ajay.kumar@agri.gov.in', 'staff', 1, 1, 'Ajay Kumar', 'active', 0, NULL, '2026-01-03 05:11:47', '2026-01-03 05:11:47', NULL, NULL),
(6, 'staff2', 'password123', 'priya.sharma@agri.gov.in', 'staff', 2, 2, 'Priya Sharma', 'active', 0, NULL, '2026-01-03 05:11:47', '2026-01-03 05:11:47', NULL, NULL),
(7, 'staff3', 'password123', 'ravi.teja@agri.gov.in', 'staff', 3, 3, 'Ravi Teja', 'active', 0, NULL, '2026-01-03 05:11:47', '2026-01-03 05:11:47', NULL, NULL),
(8, 'superadmin', 'superadmin123', 'superadmin@agri.gov.in', 'superadmin', NULL, NULL, 'Super Admin', 'active', 1, '2026-01-27 07:26:44', '2026-01-09 10:26:31', '2026-01-27 07:26:44', NULL, NULL),
(13, 'manikumar', '1l4i63fzowXTLRZF4K0S', 'manikumar6634@gmail.com', 'hod', 23, NULL, 'mani', 'active', 0, NULL, '2026-01-22 12:27:30', '2026-01-22 12:27:30', NULL, NULL),
(14, 'dr..b..gopi,.ias', 'MDot#K%tG66@', 'svramana1998@gmail.com', 'hod', 24, NULL, 'Dr. B. Gopi, IAS', 'active', 0, NULL, '2026-01-26 17:04:56', '2026-01-27 05:46:37', '590786', '2026-01-26 17:43:53'),
(16, 'dr..danda.raji.reddy', 'eJ^Q8R#&lPb4', 'kotagirineeraj6@gmail.com', 'hod', 48, NULL, 'Dr. Danda Raji Reddy', 'active', 0, NULL, '2026-01-27 06:15:04', '2026-01-27 06:15:06', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `villages`
--

CREATE TABLE `villages` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `mandal_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `villages`
--

INSERT INTO `villages` (`id`, `name`, `mandal_id`) VALUES
(1, 'Ankamma Puram', 64),
(2, 'Bhadra Puram', 64),
(3, 'Chinna Palli', 65),
(4, 'Gopalapuram', 66),
(5, 'Kothla Village', 1),
(6, 'Radha Nagar', 2),
(7, 'Mohanpet', 3),
(8, 'Venkateshwara Puram', 59);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `staff_id` (`staff_id`),
  ADD KEY `hod_id` (`hod_id`);

--
-- Indexes for table `beneficiaries`
--
ALTER TABLE `beneficiaries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_location` (`district_id`,`mandal_id`,`village_id`),
  ADD KEY `idx_scheme` (`scheme_id`),
  ADD KEY `idx_hod` (`hod_id`);

--
-- Indexes for table `beneficiary_audit_logs`
--
ALTER TABLE `beneficiary_audit_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `beneficiary_import_errors`
--
ALTER TABLE `beneficiary_import_errors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `job_id` (`job_id`);

--
-- Indexes for table `beneficiary_import_jobs`
--
ALTER TABLE `beneficiary_import_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `budget`
--
ALTER TABLE `budget`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hod_id` (`hod_id`),
  ADD KEY `scheme_id` (`scheme_id`),
  ADD KEY `state_id` (`state_id`),
  ADD KEY `district_id` (`district_id`),
  ADD KEY `mandal_id` (`mandal_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `dao`
--
ALTER TABLE `dao`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `districts`
--
ALTER TABLE `districts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `state_id` (`state_id`);

--
-- Indexes for table `flagship_import_metadata`
--
ALTER TABLE `flagship_import_metadata`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `import_batch_id` (`import_batch_id`),
  ADD KEY `idx_batch` (`import_batch_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_created` (`created_at`);

--
-- Indexes for table `flagship_programmes`
--
ALTER TABLE `flagship_programmes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_department` (`department_id`,`department_name`),
  ADD KEY `idx_batch` (`import_batch_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_created` (`created_at`);

--
-- Indexes for table `flagship_reports`
--
ALTER TABLE `flagship_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_department` (`department_id`,`department_name`),
  ADD KEY `idx_batch` (`import_batch_id`),
  ADD KEY `idx_date` (`report_date`),
  ADD KEY `idx_created` (`created_at`);

--
-- Indexes for table `hods`
--
ALTER TABLE `hods`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `hod_department_mapping`
--
ALTER TABLE `hod_department_mapping`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `hod_id_2` (`hod_id`,`department_name`),
  ADD KEY `hod_id` (`hod_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `kpis`
--
ALTER TABLE `kpis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hod_id` (`hod_id`);

--
-- Indexes for table `mandals`
--
ALTER TABLE `mandals`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_mandal_district` (`name`,`district_id`),
  ADD KEY `district_id` (`district_id`);

--
-- Indexes for table `nodal_officers`
--
ALTER TABLE `nodal_officers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `scheme_id` (`scheme_id`);

--
-- Indexes for table `password_reset_otps`
--
ALTER TABLE `password_reset_otps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_otp` (`otp`),
  ADD KEY `idx_expires` (`expires_at`);

--
-- Indexes for table `revenue`
--
ALTER TABLE `revenue`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hod_id` (`hod_id`),
  ADD KEY `scheme_id` (`scheme_id`);

--
-- Indexes for table `schemes`
--
ALTER TABLE `schemes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `scheme_budget_allocation`
--
ALTER TABLE `scheme_budget_allocation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `scheme_id` (`scheme_id`),
  ADD KEY `hod_id` (`hod_id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employee_id` (`employee_id`),
  ADD KEY `hod_id` (`hod_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `states`
--
ALTER TABLE `states`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `state_scheme_financials`
--
ALTER TABLE `state_scheme_financials`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `staff_id` (`staff_id`),
  ADD KEY `fk_users_hod` (`hod_id`);

--
-- Indexes for table `villages`
--
ALTER TABLE `villages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_village_mandal` (`mandal_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=179;

--
-- AUTO_INCREMENT for table `beneficiaries`
--
ALTER TABLE `beneficiaries`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `beneficiary_audit_logs`
--
ALTER TABLE `beneficiary_audit_logs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `beneficiary_import_errors`
--
ALTER TABLE `beneficiary_import_errors`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `beneficiary_import_jobs`
--
ALTER TABLE `beneficiary_import_jobs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `budget`
--
ALTER TABLE `budget`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `dao`
--
ALTER TABLE `dao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `districts`
--
ALTER TABLE `districts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `flagship_import_metadata`
--
ALTER TABLE `flagship_import_metadata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `flagship_programmes`
--
ALTER TABLE `flagship_programmes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=282;

--
-- AUTO_INCREMENT for table `flagship_reports`
--
ALTER TABLE `flagship_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `hods`
--
ALTER TABLE `hods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `hod_department_mapping`
--
ALTER TABLE `hod_department_mapping`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `kpis`
--
ALTER TABLE `kpis`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `mandals`
--
ALTER TABLE `mandals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=605;

--
-- AUTO_INCREMENT for table `nodal_officers`
--
ALTER TABLE `nodal_officers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `password_reset_otps`
--
ALTER TABLE `password_reset_otps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `revenue`
--
ALTER TABLE `revenue`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `schemes`
--
ALTER TABLE `schemes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=273;

--
-- AUTO_INCREMENT for table `scheme_budget_allocation`
--
ALTER TABLE `scheme_budget_allocation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `states`
--
ALTER TABLE `states`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `state_scheme_financials`
--
ALTER TABLE `state_scheme_financials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `villages`
--
ALTER TABLE `villages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`hod_id`) REFERENCES `hods` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `beneficiary_import_errors`
--
ALTER TABLE `beneficiary_import_errors`
  ADD CONSTRAINT `beneficiary_import_errors_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `beneficiary_import_jobs` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `budget`
--
ALTER TABLE `budget`
  ADD CONSTRAINT `budget_ibfk_1` FOREIGN KEY (`hod_id`) REFERENCES `hods` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `budget_ibfk_2` FOREIGN KEY (`scheme_id`) REFERENCES `schemes` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `budget_ibfk_3` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `budget_ibfk_4` FOREIGN KEY (`district_id`) REFERENCES `districts` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `budget_ibfk_5` FOREIGN KEY (`mandal_id`) REFERENCES `mandals` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `hod_department_mapping`
--
ALTER TABLE `hod_department_mapping`
  ADD CONSTRAINT `hod_department_mapping_ibfk_1` FOREIGN KEY (`hod_id`) REFERENCES `hods` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `hod_department_mapping_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
