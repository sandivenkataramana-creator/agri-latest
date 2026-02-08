-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 06, 2026 at 11:25 PM
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
  `status` varchar(250) NOT NULL,
  `working_hours` time DEFAULT NULL,
  `check_in` time DEFAULT NULL,
  `check_out` time DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `source` varchar(50) DEFAULT 'manual',
  `device_id` varchar(100) DEFAULT NULL,
  `device_ip` varchar(45) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `employee_type` varchar(50) DEFAULT NULL,
  `late_status` varchar(64) DEFAULT NULL,
  `total_hours` decimal(5,2) DEFAULT NULL,
  `record_timestamp` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`id`, `staff_id`, `hod_id`, `date`, `status`, `working_hours`, `check_in`, `check_out`, `remarks`, `created_at`, `updated_at`, `source`, `device_id`, `device_ip`, `department_id`, `employee_type`, `late_status`, `total_hours`, `record_timestamp`) VALUES
(209, 114, 48, '2026-06-01', 'leave', NULL, NULL, NULL, NULL, '2026-02-06 11:02:53', NULL, 'third_party', NULL, NULL, 84, NULL, NULL, NULL, '2026-02-06 11:02:56'),
(212, 122, 48, '2026-02-04', 'present', NULL, '08:30:41', NULL, NULL, '2026-02-06 11:02:53', NULL, 'third_party', NULL, NULL, 84, NULL, NULL, NULL, '2026-02-06 11:02:56'),
(214, 113, 48, '2026-02-05', '', '02:14:58', '12:30:22', '14:45:20', NULL, '2026-02-06 11:05:28', '2026-02-06 17:41:33', 'third_party', NULL, NULL, 84, NULL, NULL, NULL, '2026-02-06 12:11:35'),
(215, 117, 48, '2026-02-05', '', '01:31:10', '13:16:38', '14:47:48', NULL, '2026-02-06 11:05:28', '2026-02-06 17:41:33', 'third_party', NULL, NULL, 84, NULL, NULL, NULL, '2026-02-06 12:11:36'),
(216, 118, 48, '2026-02-05', '', NULL, '13:46:10', NULL, NULL, '2026-02-06 11:05:29', '2026-02-06 17:41:33', 'third_party', NULL, NULL, 84, NULL, NULL, NULL, '2026-02-06 12:11:36'),
(219, 112, 48, '2026-02-05', 'present', '00:18:47', '11:49:19', '12:08:06', '', '2026-02-06 11:05:31', '2026-02-06 17:02:06', 'third_party', NULL, NULL, 84, NULL, NULL, NULL, '2026-02-06 11:32:09'),
(220, 117, 48, '2026-02-06', '', '02:58:54', '11:51:02', '14:49:56', NULL, '2026-02-06 11:05:31', '2026-02-06 19:19:55', 'third_party', NULL, NULL, 84, NULL, NULL, NULL, '2026-02-06 13:49:58'),
(221, 113, 48, '2026-02-06', 'present', '06:29:38', '11:51:23', '18:21:01', NULL, '2026-02-06 11:05:32', '2026-02-06 18:28:16', 'third_party', NULL, NULL, 84, NULL, NULL, NULL, '2026-02-06 12:58:19'),
(222, 122, 48, '2026-02-05', 'present', NULL, '12:13:11', '17:52:00', '', '2026-02-06 11:30:19', '2026-02-06 17:41:34', 'third_party', NULL, NULL, 84, NULL, NULL, NULL, '2026-02-06 12:11:37'),
(223, 119, 48, '2026-02-05', 'present', NULL, '12:15:18', '00:00:00', '', '2026-02-06 11:30:19', '2026-02-06 17:41:35', 'third_party', NULL, NULL, 84, NULL, NULL, NULL, '2026-02-06 12:11:37'),
(224, 123, 48, '2026-02-06', '', '00:02:40', '12:36:22', '12:39:02', NULL, '2026-02-06 11:39:00', '2026-02-06 17:09:11', 'third_party', NULL, NULL, 84, NULL, NULL, NULL, '2026-02-06 11:39:14'),
(227, 115, 48, '2026-02-06', 'half', '01:05:23', '13:57:25', '15:02:48', NULL, '2026-02-06 12:09:18', '2026-02-07 00:15:57', 'third_party', NULL, NULL, 84, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(228, 114, 48, '2026-02-06', 'present', '09:00:00', '09:00:00', '18:00:00', NULL, '2026-02-06 12:09:43', '2026-02-06 18:17:02', 'third_party', NULL, NULL, 84, NULL, NULL, NULL, '2026-02-05 18:15:00'),
(229, 125, 48, '2026-02-06', 'present', '04:30:09', '13:11:17', '17:41:26', NULL, '2026-02-06 12:11:16', '2026-02-06 18:19:33', 'third_party', NULL, NULL, 84, NULL, NULL, NULL, '2026-02-06 12:49:35'),
(230, 126, 48, '2026-02-05', 'leave', NULL, '08:27:25', NULL, NULL, '2026-02-06 13:17:32', NULL, 'third_party', NULL, NULL, 84, NULL, NULL, NULL, '2026-02-06 13:17:34'),
(231, 126, 48, '2026-02-06', 'present', '01:05:23', '13:57:25', '15:02:48', NULL, '2026-02-06 13:27:39', '2026-02-06 19:59:05', 'third_party', NULL, NULL, 84, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(233, 115, 48, '2026-02-07', 'half', '01:05:23', '13:57:25', '15:02:48', NULL, '2026-02-06 18:47:52', NULL, 'third_party', NULL, NULL, 84, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(234, 112, 48, '2026-02-07', 'present', '01:05:23', '13:57:25', '15:02:48', NULL, '2026-02-06 18:56:23', NULL, 'third_party', NULL, NULL, 84, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(235, 113, 48, '2026-02-07', 'late', '01:05:23', '13:57:25', '15:02:48', NULL, '2026-02-06 18:56:35', '2026-02-07 00:27:26', 'third_party', NULL, NULL, 84, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(238, 114, 48, '2026-02-07', 'leave', '01:05:23', '13:57:25', '15:02:48', NULL, '2026-02-06 18:58:01', NULL, 'third_party', NULL, NULL, 84, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(246, 111, 48, '2026-02-06', 'absent', NULL, NULL, NULL, NULL, '2026-02-06 19:23:20', NULL, 'auto_absent', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(247, 112, 48, '2026-02-06', 'absent', NULL, NULL, NULL, NULL, '2026-02-06 19:23:20', NULL, 'auto_absent', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(248, 116, 48, '2026-02-06', 'absent', NULL, NULL, NULL, NULL, '2026-02-06 19:23:20', NULL, 'auto_absent', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(249, 118, 48, '2026-02-06', 'absent', NULL, NULL, NULL, NULL, '2026-02-06 19:23:20', NULL, 'auto_absent', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(250, 119, 48, '2026-02-06', 'absent', NULL, NULL, NULL, NULL, '2026-02-06 19:23:20', NULL, 'auto_absent', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(251, 122, 48, '2026-02-06', 'absent', NULL, NULL, NULL, NULL, '2026-02-06 19:23:20', NULL, 'auto_absent', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(252, 124, 48, '2026-02-06', 'absent', NULL, NULL, NULL, NULL, '2026-02-06 19:23:20', NULL, 'auto_absent', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(253, 111, 48, '2026-02-07', 'absent', NULL, NULL, NULL, NULL, '2026-02-06 19:27:37', NULL, 'auto_absent', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(254, 116, 48, '2026-02-07', 'absent', NULL, NULL, NULL, NULL, '2026-02-06 19:27:37', NULL, 'auto_absent', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(255, 117, 48, '2026-02-07', 'absent', NULL, NULL, NULL, NULL, '2026-02-06 19:27:37', NULL, 'auto_absent', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(256, 118, 48, '2026-02-07', 'leave', '01:05:23', '13:57:25', '15:02:48', NULL, '2026-02-06 19:27:37', '2026-02-07 00:59:04', 'third_party', NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(257, 119, 48, '2026-02-07', 'present', '01:05:23', '13:57:25', '15:02:48', NULL, '2026-02-06 19:27:37', '2026-02-07 03:45:02', 'third_party', NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(258, 122, 48, '2026-02-07', 'absent', NULL, NULL, NULL, NULL, '2026-02-06 19:27:37', NULL, 'auto_absent', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(259, 123, 48, '2026-02-07', 'absent', NULL, NULL, NULL, NULL, '2026-02-06 19:27:37', NULL, 'auto_absent', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(260, 124, 48, '2026-02-07', 'absent', NULL, NULL, NULL, NULL, '2026-02-06 19:27:37', NULL, 'auto_absent', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(261, 125, 48, '2026-02-07', 'absent', NULL, NULL, NULL, NULL, '2026-02-06 19:27:37', NULL, 'auto_absent', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(262, 126, 48, '2026-02-07', 'absent', NULL, NULL, NULL, NULL, '2026-02-06 19:27:37', NULL, 'auto_absent', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(267, 127, 48, '2026-02-07', 'late', '01:05:23', '13:57:25', '15:02:48', NULL, '2026-02-06 22:18:49', NULL, 'third_party', NULL, NULL, 84, NULL, NULL, NULL, '2026-02-06 14:02:49');

-- --------------------------------------------------------

--
-- Table structure for table `attendance_import_logs`
--

CREATE TABLE `attendance_import_logs` (
  `id` int(11) NOT NULL,
  `api_key_id` int(11) DEFAULT NULL,
  `employee_id` varchar(50) DEFAULT NULL,
  `attendance_date` date DEFAULT NULL,
  `check_in` time DEFAULT NULL,
  `check_out` time DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `device_id` varchar(100) DEFAULT NULL,
  `device_ip` varchar(45) DEFAULT NULL,
  `import_status` enum('success','failed') DEFAULT 'success',
  `error_message` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `hod_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `employee_type` varchar(50) DEFAULT NULL,
  `late_status` varchar(64) DEFAULT NULL,
  `total_hours` decimal(5,2) DEFAULT NULL,
  `record_timestamp` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance_import_logs`
--

INSERT INTO `attendance_import_logs` (`id`, `api_key_id`, `employee_id`, `attendance_date`, `check_in`, `check_out`, `status`, `device_id`, `device_ip`, `import_status`, `error_message`, `created_at`, `hod_id`, `department_id`, `employee_type`, `late_status`, `total_hours`, `record_timestamp`) VALUES
(376, NULL, '788', '2026-02-06', '11:51:23', '18:21:01', 'present', NULL, NULL, 'success', NULL, '2026-02-06 12:58:16', 48, 84, NULL, NULL, NULL, '2026-02-06 12:58:19'),
(377, NULL, '123456', '2026-02-05', '08:27:25', NULL, 'half', NULL, NULL, 'success', NULL, '2026-02-06 13:17:32', 48, 84, NULL, NULL, NULL, '2026-02-06 13:17:34'),
(378, NULL, '123456', '2026-02-06', '13:57:25', '14:27:21', 'half', NULL, NULL, 'success', NULL, '2026-02-06 13:27:39', 48, 84, NULL, NULL, NULL, '2026-02-06 13:27:40'),
(379, NULL, '123456', '2026-02-06', '13:57:25', '14:37:24', 'half', NULL, NULL, 'success', NULL, '2026-02-06 13:37:22', 48, 84, NULL, NULL, NULL, '2026-02-06 13:37:25'),
(380, NULL, '123456', '2026-02-06', '13:57:25', '14:38:35', 'half', NULL, NULL, 'success', NULL, '2026-02-06 13:38:34', 48, 84, NULL, NULL, NULL, '2026-02-06 13:38:36'),
(381, NULL, '123456', '2026-02-06', '13:57:25', '14:40:06', 'half', NULL, NULL, 'success', NULL, '2026-02-06 13:40:05', 48, 84, NULL, NULL, NULL, '2026-02-06 13:40:08'),
(382, NULL, '123456', '2026-02-06', '13:57:25', '14:43:41', 'half', NULL, NULL, 'success', NULL, '2026-02-06 13:43:46', 48, 84, NULL, NULL, NULL, '2026-02-06 13:43:48'),
(383, NULL, '2004', '2026-02-06', '11:51:02', '14:49:56', 'half', NULL, NULL, 'success', NULL, '2026-02-06 13:49:55', 48, 84, NULL, NULL, NULL, '2026-02-06 13:49:58'),
(384, NULL, '123456', '2026-02-06', '13:57:25', '14:50:52', 'half', NULL, NULL, 'success', NULL, '2026-02-06 13:50:51', 48, 84, NULL, NULL, NULL, '2026-02-06 13:50:53'),
(385, NULL, '123456', '2026-02-06', '13:57:25', '14:52:30', 'half', NULL, NULL, 'success', NULL, '2026-02-06 13:52:29', 48, 84, NULL, NULL, NULL, '2026-02-06 13:52:31'),
(386, NULL, '123456', '2026-02-06', '13:57:25', '14:57:09', 'half', NULL, NULL, 'success', NULL, '2026-02-06 13:57:08', 48, 84, NULL, NULL, NULL, '2026-02-06 13:57:11'),
(387, NULL, '123456', '2026-02-06', '13:57:25', '15:00:31', 'half', NULL, NULL, 'success', NULL, '2026-02-06 14:00:30', 48, 84, NULL, NULL, NULL, '2026-02-06 14:00:32'),
(388, NULL, '123456', '2026-02-06', '13:57:25', '15:02:48', 'half', NULL, NULL, 'success', NULL, '2026-02-06 14:02:47', 48, 84, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(389, NULL, '123456', '2026-02-06', '13:57:25', '15:10:38', 'half', NULL, NULL, 'success', NULL, '2026-02-06 14:10:38', 48, 84, NULL, NULL, NULL, '2026-02-06 14:10:40'),
(390, NULL, '123456', '2026-02-06', '13:57:25', '15:02:48', 'half', NULL, NULL, 'success', NULL, '2026-02-06 14:11:34', 48, 84, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(391, NULL, '123456', '2026-02-06', '13:57:25', '15:02:48', 'half', NULL, NULL, 'success', NULL, '2026-02-06 14:14:38', 48, 84, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(392, NULL, '123456', '2026-02-06', '13:57:25', '15:02:48', 'leave', NULL, NULL, 'success', NULL, '2026-02-06 14:27:31', 48, 84, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(393, NULL, '123456', '2026-02-06', '13:57:25', '15:02:48', 'present', NULL, NULL, 'success', NULL, '2026-02-06 14:28:27', 48, 84, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(394, NULL, '123456', '2026-02-06', '13:57:25', '15:02:48', 'present', NULL, NULL, 'success', NULL, '2026-02-06 14:29:05', 48, 84, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(395, NULL, '567', '2026-02-06', '13:57:25', '15:02:48', 'present', NULL, NULL, 'success', NULL, '2026-02-06 14:58:14', 48, 84, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(396, NULL, '567', '2026-02-06', '13:57:25', '15:02:48', 'half', NULL, NULL, 'success', NULL, '2026-02-06 17:58:20', 48, 84, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(397, NULL, '567', '2026-02-06', '13:57:25', '15:02:48', 'half', NULL, NULL, 'success', NULL, '2026-02-06 18:23:05', 48, 84, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(398, NULL, '567', '2026-02-06', '13:57:25', '15:02:48', 'half', NULL, NULL, 'success', NULL, '2026-02-06 18:45:57', 48, 84, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(399, NULL, '567', '2026-02-07', '13:57:25', '15:02:48', 'half', NULL, NULL, 'success', NULL, '2026-02-06 18:47:52', 48, 84, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(400, NULL, '789', '2026-02-07', '13:57:25', '15:02:48', 'present', NULL, NULL, 'success', NULL, '2026-02-06 18:56:23', 48, 84, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(401, NULL, '788', '2026-02-07', '13:57:25', '15:02:48', 'late', NULL, NULL, 'success', NULL, '2026-02-06 18:56:35', 48, 84, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(402, NULL, '788', '2026-02-07', '13:57:25', '15:02:48', 'absent', NULL, NULL, 'success', NULL, '2026-02-06 18:56:59', 48, 84, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(403, NULL, '788', '2026-02-07', '13:57:25', '15:02:48', 'late', NULL, NULL, 'success', NULL, '2026-02-06 18:57:26', 48, 84, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(404, NULL, '522', '2026-02-07', '13:57:25', '15:02:48', 'leave', NULL, NULL, 'success', NULL, '2026-02-06 18:58:01', 48, 84, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(405, NULL, '299', '2026-02-07', '13:57:25', '15:02:48', 'leave', NULL, NULL, 'success', NULL, '2026-02-06 19:29:04', 48, 84, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(406, NULL, '300', '2026-02-07', '13:57:25', '15:02:48', 'present', NULL, NULL, 'success', NULL, '2026-02-06 19:30:07', 48, 84, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(407, NULL, '300', '2026-02-07', '13:57:25', '15:02:48', 'present', NULL, NULL, 'success', NULL, '2026-02-06 21:07:39', 48, 84, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(408, NULL, '300', '2026-02-07', '13:57:25', '15:02:48', 'present', NULL, NULL, 'success', NULL, '2026-02-06 22:15:02', 48, 84, NULL, NULL, NULL, '2026-02-06 14:02:49'),
(409, NULL, '457', '2026-02-07', '13:57:25', '15:02:48', 'late', NULL, NULL, 'success', NULL, '2026-02-06 22:18:49', 48, 84, NULL, NULL, NULL, '2026-02-06 14:02:49');

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
  `performed_by` int(11) DEFAULT NULL,
  `details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`details`)),
  `changed_by` int(11) DEFAULT NULL,
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `old_values` text DEFAULT NULL,
  `new_values` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `beneficiary_audit_logs`
--

INSERT INTO `beneficiary_audit_logs` (`id`, `beneficiary_id`, `action`, `performed_by`, `details`, `changed_by`, `changed_at`, `old_values`, `new_values`) VALUES
(1, NULL, 'export_started', 8, '{\"filters\":{\"hodId\":null,\"districtId\":null,\"mandalId\":null,\"villageId\":null,\"villageName\":\"\",\"schemeId\":null,\"page\":0,\"size\":10}}', NULL, '2026-01-29 07:44:31', NULL, NULL),
(2, NULL, 'export_completed', 8, '{\"filters\":{\"hodId\":null,\"districtId\":null,\"mandalId\":null,\"villageId\":null,\"villageName\":\"\",\"schemeId\":null,\"page\":0,\"size\":10}}', NULL, '2026-01-29 07:44:31', NULL, NULL),
(3, NULL, 'export_started', 8, '{\"filters\":{\"hodId\":null,\"districtId\":null,\"mandalId\":null,\"villageId\":null,\"villageName\":\"\",\"schemeId\":null,\"page\":0,\"size\":10}}', NULL, '2026-01-29 07:44:36', NULL, NULL),
(4, NULL, 'export_completed', 8, '{\"filters\":{\"hodId\":null,\"districtId\":null,\"mandalId\":null,\"villageId\":null,\"villageName\":\"\",\"schemeId\":null,\"page\":0,\"size\":10}}', NULL, '2026-01-29 07:44:37', NULL, NULL),
(5, NULL, 'API_KEY_GENERATED: ACS', 8, '{\"system_name\":\"ACS\",\"description\":\"Agriculture Department\"}', NULL, '2026-02-01 13:25:49', NULL, NULL),
(6, NULL, 'API_KEY_GENERATED: vcs', 8, '{\"system_name\":\"vcs\",\"hod_id\":\"\",\"description\":\"\"}', NULL, '2026-02-01 15:45:10', NULL, NULL),
(7, NULL, 'API_KEY_GENERATED: acso', 8, '{\"system_name\":\"acso\",\"hod_id\":\"\",\"description\":\"vcs\"}', NULL, '2026-02-01 15:48:46', NULL, NULL),
(8, NULL, 'API_KEY_GENERATED: vcso', 8, '{\"system_name\":\"vcso\",\"hod_id\":\"\",\"description\":\"\"}', NULL, '2026-02-01 15:49:01', NULL, NULL),
(9, NULL, 'API_KEY_GENERATED: bcs', 8, '{\"system_name\":\"bcs\",\"hod_id\":\"\",\"description\":\"\"}', NULL, '2026-02-01 16:54:05', NULL, NULL),
(10, NULL, 'API_KEY_GENERATED: b', 8, '{\"system_name\":\"b\",\"hod_id\":\"\",\"description\":\"\"}', NULL, '2026-02-01 16:55:18', NULL, NULL),
(11, NULL, 'API_KEY_GENERATED: a', 8, '{\"system_name\":\"a\",\"hod_id\":\"\",\"description\":\"\"}', NULL, '2026-02-01 16:58:54', NULL, NULL),
(12, NULL, 'API_KEY_GENERATED: d', 8, '{\"system_name\":\"d\",\"hod_id\":\"\",\"description\":\"s\"}', NULL, '2026-02-01 17:09:30', NULL, NULL),
(13, NULL, 'API_KEY_REGENERATED: ACS', 8, '{\"system_name\":\"ACS\",\"old_key_id\":\"4\"}', NULL, '2026-02-01 17:23:22', NULL, NULL),
(14, NULL, 'API_KEY_STATUS_CHANGED: DEACTIVATED', 8, '{\"api_key_id\":\"14\"}', NULL, '2026-02-01 17:23:59', NULL, NULL),
(15, NULL, 'API_KEY_STATUS_CHANGED: ACTIVATED', 8, '{\"api_key_id\":\"14\"}', NULL, '2026-02-01 17:24:01', NULL, NULL),
(16, NULL, 'API_KEY_GENERATED: ACS_horiculture', 8, '{\"system_name\":\"ACS_horiculture\",\"hod_id\":\"48\",\"description\":\"Horiculture department , TGS\"}', NULL, '2026-02-01 17:54:15', NULL, NULL),
(17, NULL, 'API_KEY_REGENERATED: ACS_horiculture', 8, '{\"system_name\":\"ACS_horiculture\",\"old_key_id\":\"16\"}', NULL, '2026-02-01 18:44:05', NULL, NULL),
(18, NULL, 'API_KEY_REGENERATED: ACS', 8, '{\"system_name\":\"ACS\",\"old_key_id\":\"14\"}', NULL, '2026-02-01 18:50:36', NULL, NULL),
(19, NULL, 'API_KEY_GENERATED: acs_1', 8, '{\"system_name\":\"acs_1\",\"hod_id\":\"3\",\"description\":\"Agril.Marketing\"}', NULL, '2026-02-01 19:10:27', NULL, NULL),
(20, NULL, 'API_KEY_REGENERATED: acs_1', 8, '{\"system_name\":\"acs_1\",\"old_key_id\":\"19\"}', NULL, '2026-02-02 06:18:07', NULL, NULL),
(21, NULL, 'export_started', 8, '{\"filters\":{\"hodId\":null,\"districtId\":null,\"mandalId\":null,\"villageId\":null,\"villageName\":\"\",\"schemeId\":null,\"page\":0,\"size\":10}}', NULL, '2026-02-03 06:20:55', NULL, NULL),
(22, NULL, 'export_completed', 8, '{\"filters\":{\"hodId\":null,\"districtId\":null,\"mandalId\":null,\"villageId\":null,\"villageName\":\"\",\"schemeId\":null,\"page\":0,\"size\":10}}', NULL, '2026-02-03 06:20:55', NULL, NULL),
(23, NULL, 'export_started', 8, '{\"filters\":{\"hodId\":null,\"districtId\":null,\"mandalId\":null,\"villageId\":null,\"villageName\":\"\",\"schemeId\":null,\"page\":0,\"size\":10}}', NULL, '2026-02-03 07:00:15', NULL, NULL),
(24, NULL, 'export_completed', 8, '{\"filters\":{\"hodId\":null,\"districtId\":null,\"mandalId\":null,\"villageId\":null,\"villageName\":\"\",\"schemeId\":null,\"page\":0,\"size\":10}}', NULL, '2026-02-03 07:00:19', NULL, NULL),
(25, NULL, 'API_KEY_REGENERATED: ACS_horiculture', 8, '{\"system_name\":\"ACS_horiculture\",\"old_key_id\":\"17\"}', NULL, '2026-02-03 07:31:57', NULL, NULL),
(26, NULL, 'API_KEY_REGENERATED: ACS_horiculture', 8, '{\"system_name\":\"ACS_horiculture\",\"old_key_id\":\"21\"}', NULL, '2026-02-03 07:34:10', NULL, NULL),
(27, NULL, 'API_KEY_REGENERATED: ACS_horiculture', 8, '{\"system_name\":\"ACS_horiculture\",\"old_key_id\":\"22\"}', NULL, '2026-02-03 07:44:15', NULL, NULL);

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
(1, 6, NULL, 1, 1, NULL, 5000000.00, 3500000.00, 3500000.00, 1500000.00, '2025-26', 'active', '2026-01-05 07:02:11', '2026-01-28 12:16:25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
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
(1, 'Secretariat', 'Administrative and Secretariat departments', 'active', '2026-01-03 05:11:47', '2026-02-04 06:52:41'),
(2, 'Directorate', 'Directorate level departments', 'active', '2026-01-03 05:11:47', '2026-02-04 06:53:40'),
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
  `employee_name` varchar(150) NOT NULL,
  `district_name` varchar(100) DEFAULT NULL,
  `division_name` varchar(100) DEFAULT NULL,
  `mandal_name` varchar(100) DEFAULT NULL,
  `cadre` varchar(50) DEFAULT NULL,
  `regular_incharge` varchar(20) DEFAULT NULL,
  `present_cadre` varchar(150) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `office_mobile_no` varchar(15) DEFAULT NULL,
  `present_office` varchar(200) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dao`
--

INSERT INTO `dao` (`id`, `employee_name`, `district_name`, `division_name`, `mandal_name`, `cadre`, `regular_incharge`, `present_cadre`, `email`, `office_mobile_no`, `present_office`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Gatika Sreedhar Swamy', 'ADILABAD', NULL, NULL, 'DAO', 'FAC', 'Assistant Director of Agriculture', NULL, '8977742697', 'DAO Office ADILABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(2, 'Madupu Sridhar', 'ADILABAD', 'ADILABAD RURAL', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977742858', 'ADA Regular ADILABAD RURAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(3, 'Gatika Sreedhar Swamy', 'ADILABAD', 'BOATH', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977742859', 'ADA Regular BOATH\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(4, 'Giri Ram Kishan', 'ADILABAD', 'ICHODA', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977742860', 'ADA Regular ICHODA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(5, 'Asuri Ravinder', 'ADILABAD', 'TAMSI', NULL, 'ADA', 'Incharge', 'Agriculture Officer', NULL, '8977742920', 'ADA Regular ICHODA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(6, 'Rathod Ganesh', 'ADILABAD', 'UTNUR', NULL, 'ADA', 'Incharge', 'Agriculture Officer', NULL, '8977742912', 'ADA Regular ICHODA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(7, 'K Nagesh Reddy', 'ADILABAD', 'ADILABAD RURAL', 'ADILABAD (RURAL)', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977742879', 'ADA Regular ADILABAD RURAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(8, 'K Nagesh Reddy', 'ADILABAD', 'ADILABAD RURAL', 'ADILABAD (URBAN)', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977742880', 'ADA Regular ADILABAD RURAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(9, 'Gopidi Sai Teja', 'ADILABAD', 'ADILABAD RURAL', 'BELA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977742881', 'ADA Regular ADILABAD RURAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(10, 'Mohammed Ashraff Ahmed', 'ADILABAD', 'ADILABAD RURAL', 'Bhoraj', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977742882', 'ADA Regular ADILABAD RURAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(11, 'Jangamwar Pooja', 'ADILABAD', 'ADILABAD RURAL', 'JAINAD', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977742889', 'ADA Regular ADILABAD RURAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(12, 'Mohammed Ashraff Ahmed', 'ADILABAD', 'ADILABAD RURAL', 'MAVALA', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8464000340', 'ADA Regular ADILABAD RURAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(13, 'Jadhav Kailash', 'ADILABAD', 'ADILABAD RURAL', 'Satnala', 'AO', 'Regular', 'Agriculture Officer', NULL, '9949272737', 'ADA Regular ADILABAD RURAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(14, 'Mohammad Saud', 'ADILABAD', 'BOATH', 'BAZARHATHNOOR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977742906', 'ADA Regular BOATH\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(15, 'Lingampally Raviteja', 'ADILABAD', 'BOATH', 'BOATH', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977742907', 'ADA Regular BOATH\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(16, 'Kondoor Krishnaveni', 'ADILABAD', 'BOATH', 'NERADIGONDA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977742908', 'ADA Regular BOATH\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(17, 'Lingampally Raviteja', 'ADILABAD', 'BOATH', 'Sonala', 'AO', 'Incharge', 'Agriculture Officer', NULL, '9346093717', 'ADA Regular ADILABAD RURAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(18, 'Bhagath Ramesh', 'ADILABAD', 'ICHODA', 'GUDI HATHNUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8332801230', 'ADA Regular ICHODA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(19, 'Bhagath Ramesh', 'ADILABAD', 'ICHODA', 'ICHODA', 'AO', 'FAC', 'Agriculture Officer', NULL, '8977742910', 'ADA Regular ICHODA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(20, 'Rathod Shraddha Rani', 'ADILABAD', 'ICHODA', 'SIRIKONDA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977742913', 'ADA Regular ICHODA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(21, 'Yenugu Srinivas Reddy', 'ADILABAD', 'TAMSI', 'BHEEMPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977742909', 'ADA Regular ICHODA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(22, 'Merugu Pramod Reddy', 'ADILABAD', 'TAMSI', 'TALAMADUGU', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977742914', 'ADA Regular ICHODA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(23, 'Asuri Ravinder', 'ADILABAD', 'TAMSI', 'TAMSI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977742920', 'ADA Regular ICHODA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(24, 'Jatoth Yakanna', 'ADILABAD', 'UTNUR', 'GADIGUDA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977742883', 'ADA Regular ADILABAD RURAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(25, 'Rathod Ganesh', 'ADILABAD', 'UTNUR', 'INDERAVELLY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977742912', 'ADA Regular ICHODA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(26, 'Kendre Akash', 'ADILABAD', 'UTNUR', 'NARNOOR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977742890', 'ADA Regular ADILABAD RURAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(27, 'Gitte Ramesh', 'ADILABAD', 'UTNUR', 'UTNUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977743059', 'ADA Regular ICHODA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(28, 'Velpula Baburao', 'BHADRADRI KOTHAGUDEM', NULL, NULL, 'DAO', 'Regular', 'Assistant Director of Agriculture', NULL, '8977743066', 'DAO Office BHADRADRI KOTHAGUDEM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(29, 'Pentala Ravi Kumar', 'BHADRADRI KOTHAGUDEM', 'ASWARAOPETA', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977743920', 'ADA Regular ASWARAOPETA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(30, 'Bandarupalli Sudhakar Rao', 'BHADRADRI KOTHAGUDEM', 'BHADRACHALAM', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977743948', 'ADA Regular BHADRACHALAM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(31, 'Bandarupalli Sudhakar Rao', 'BHADRADRI KOTHAGUDEM', 'KOTHAGUDEM', NULL, 'ADA', 'FAC', 'Assistant Director of Agriculture', NULL, '8977743948', 'ADA Regular KOTHAGUDEM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(32, 'Bandaboina Tata Rao', 'BHADRADRI KOTHAGUDEM', 'MANUGURU', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977744038', 'ADA Regular MANUGURU\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(33, 'Guguloth Lal Chand', 'BHADRADRI KOTHAGUDEM', 'YELLANDU', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977744039', 'ADA Regular YELLANDU\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(34, 'Gorrepati Anusha', 'BHADRADRI KOTHAGUDEM', 'ASWARAOPETA', 'ANNAPUREDDYPALLI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744045', 'ADA Regular ASWARAOPETA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(35, 'Polimera Siva Rama Prasad', 'BHADRADRI KOTHAGUDEM', 'ASWARAOPETA', 'ASWARAOPETA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744046', 'ADA Regular ASWARAOPETA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(36, 'Gaddigopula Vinay', 'BHADRADRI KOTHAGUDEM', 'ASWARAOPETA', 'CHANDRUGONDA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744047', 'ADA Regular MANUGURU\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(37, 'Seelam Chandra Shekar Reddy', 'BHADRADRI KOTHAGUDEM', 'ASWARAOPETA', 'DAMMAPETA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744048', 'ADA Regular ASWARAOPETA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(38, 'Bandela Arun Babu', 'BHADRADRI KOTHAGUDEM', 'ASWARAOPETA', 'MULAKALAPALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744049', 'ADA Regular ASWARAOPETA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(39, 'Kori Naveen Kumar', 'BHADRADRI KOTHAGUDEM', 'BHADRACHALAM', 'BHADRACHALAM', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977744057', 'ADA Regular BHADRACHALAM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(40, 'Siliveri Lavanya', 'BHADRADRI KOTHAGUDEM', 'BHADRACHALAM', 'CHERLA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744051', 'ADA Regular BHADRACHALAM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(41, 'Kori Naveen Kumar', 'BHADRADRI KOTHAGUDEM', 'BHADRACHALAM', 'DUMMAGUDEM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744057', 'ADA Regular BHADRACHALAM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(42, 'Barigala Rajeswari', 'BHADRADRI KOTHAGUDEM', 'KOTHAGUDEM', 'CHUNCHUPALLY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744058', 'ADA Regular KOTHAGUDEM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(43, 'Gaddam Deepak Anand', 'BHADRADRI KOTHAGUDEM', 'KOTHAGUDEM', 'JULURPAD', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744059', 'ADA Regular KOTHAGUDEM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(44, 'Alajangi Karunamai', 'BHADRADRI KOTHAGUDEM', 'KOTHAGUDEM', 'KOTHAGUDEM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744060', 'ADA Regular KOTHAGUDEM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(45, 'Palapati Rakesh', 'BHADRADRI KOTHAGUDEM', 'KOTHAGUDEM', 'LAXMIDEVIPALLY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744893', 'ADA Regular KOTHAGUDEM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(46, 'Payam Shambo Shankar', 'BHADRADRI KOTHAGUDEM', 'KOTHAGUDEM', 'PALWANCHA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744894', 'ADA Regular KOTHAGUDEM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(47, 'Gandla Narmada', 'BHADRADRI KOTHAGUDEM', 'KOTHAGUDEM', 'SUJATHANAGAR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744895', 'ADA Regular KOTHAGUDEM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(48, 'Karpurapu Anil Kumar', 'BHADRADRI KOTHAGUDEM', 'MANUGURU', 'ALLAPALLI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744896', 'ADA Regular MANUGURU\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(49, 'Narlapati Mahesh Chandra Chaterjee', 'BHADRADRI KOTHAGUDEM', 'MANUGURU', 'ASWAPURAM', 'AO', 'FAC', 'Agriculture Officer', NULL, '8977744945', 'ADA Regular MANUGURU\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(50, 'Racherla Shankar', 'BHADRADRI KOTHAGUDEM', 'MANUGURU', 'BURGAMPADU', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977744919', 'ADA Regular MANUGURU\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(51, 'Challuri Venkata Ramana', 'BHADRADRI KOTHAGUDEM', 'MANUGURU', 'GUNDALA', 'AO', 'Regular', 'Agriculture Officer', NULL, '9494029923', 'ADA Regular MANUGURU\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(52, 'Narlapati Mahesh Chandra Chaterjee', 'BHADRADRI KOTHAGUDEM', 'MANUGURU', 'KARAKAGUDEM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744945', 'ADA Regular MANUGURU\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(53, 'Vadiyala Rahul Reddy', 'BHADRADRI KOTHAGUDEM', 'MANUGURU', 'MANUGURU', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744946', 'ADA Regular MANUGURU\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(54, 'Enukonda Venkateswarlu', 'BHADRADRI KOTHAGUDEM', 'MANUGURU', 'PINAPAKA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744947', 'ADA Regular MANUGURU\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(55, 'Neerudu Annapurna', 'BHADRADRI KOTHAGUDEM', 'YELLANDU', 'TEKULAPALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744948', 'ADA Regular YELLANDU\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(56, 'Pusuluri Satish', 'BHADRADRI KOTHAGUDEM', 'YELLANDU', 'YELLANDU', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744956', 'ADA Regular YELLANDU\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(57, 'Bondili Ravinder Singh', 'HANMAKONDA', NULL, NULL, 'DAO', 'On Deputation', 'Deputy Director of Agriculture', NULL, '8977756346', 'DAO Office HANMAKONDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(58, 'Doma Adi Reddy', 'HANMAKONDA', 'HANAMKONDA', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977744964', 'ADA Regular HANMAKONDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(59, 'K Jagadeeshwar Reddy', 'HANMAKONDA', 'PARKAL', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977744976', 'ADA Regular PARKAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(60, 'Lokini Padma', 'HANMAKONDA', 'HANAMKONDA', 'BHEEMADEVARPALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744965', 'ADA Regular HANMAKONDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(61, 'Palakurthi Rajesh', 'HANMAKONDA', 'HANAMKONDA', 'DHARMASAGAR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744966', 'ADA Regular HANMAKONDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(62, 'Mandala Rajkumar', 'HANMAKONDA', 'HANAMKONDA', 'ELKATHURTHI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744967', 'ADA Regular HANMAKONDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(63, 'Annaladasu Srilatha', 'HANMAKONDA', 'HANAMKONDA', 'HANAMKONDA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744968', 'ADA Regular HANMAKONDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(64, 'Adluri Anuradha', 'HANMAKONDA', 'HANAMKONDA', 'HASANPARTHY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744969', 'ADA Regular HANMAKONDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(65, 'Chandupatla Sunil Kumar', 'HANMAKONDA', 'HANAMKONDA', 'INAVOLU', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744970', 'ADA Regular HANMAKONDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(66, 'Bavandlapelli Venu', 'HANMAKONDA', 'HANAMKONDA', 'KAMALAPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744975', 'ADA Regular HANMAKONDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(67, 'Munukuntla Santhosh', 'HANMAKONDA', 'HANAMKONDA', 'KHAZIPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744971', 'ADA Regular HANMAKONDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(68, 'Adapa Kavitha', 'HANMAKONDA', 'HANAMKONDA', 'VELAIR', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977744974', 'ADA Regular HANMAKONDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(69, 'Ponugoti Yadagiri', 'HANMAKONDA', 'PARKAL', 'ATMAKUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744977', 'ADA Regular PARKAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(70, 'Alle Rakesh', 'HANMAKONDA', 'PARKAL', 'DAMERA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744978', 'ADA Regular PARKAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(71, 'Porika Jaisingh', 'HANMAKONDA', 'PARKAL', 'Nadikuda', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744979', 'ADA Regular PARKAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(72, 'Somarathi Srinivas', 'HANMAKONDA', 'PARKAL', 'PARKAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977744980', 'ADA Regular PARKAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(73, 'Kyatham Gangajamuna', 'HANMAKONDA', 'PARKAL', 'SHAYAMPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745013', 'ADA Regular PARKAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(74, 'Vaddepally Bhaskar', 'JAGTIAL', NULL, NULL, 'DAO', 'On Deputation', 'Assistant Director of Agriculture', NULL, '8977745435', 'DAO Office JAGTIAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(75, 'Chilumula Ramchandar', 'JAGTIAL', 'DHARMAPURI', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977745017', 'ADA Regular DHARMAPURI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(76, 'A Thirupathi Naik', 'JAGTIAL', 'JAGTIAL', NULL, 'ADA', 'Incharge', 'Agriculture Officer', NULL, '8977745018', 'ADA Regular JAGTIAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(77, 'Danda Ramesh', 'JAGTIAL', 'KORUTLA', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977745019', 'ADA Regular KORUTLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(78, 'Nerella Akshitha', 'JAGTIAL', 'DHARMAPURI', 'BUGGARAM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745020', 'ADA Regular DHARMAPURI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(79, 'Mandala Rajakumar', 'JAGTIAL', 'DHARMAPURI', 'DHARMAPURI', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977745148', 'ADA Regular DHARMAPURI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(80, 'Kamalla Mahesh', 'JAGTIAL', 'DHARMAPURI', 'Endapalli', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745149', 'ADA Regular DHARMAPURI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(81, 'Botla Karuna', 'JAGTIAL', 'DHARMAPURI', 'GOLLAPALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745150', 'ADA Regular DHARMAPURI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(82, 'Oruganti Srikanth', 'JAGTIAL', 'DHARMAPURI', 'PEGADAPALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745203', 'ADA Regular DHARMAPURI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(83, 'Pendyala Sai Kiran', 'JAGTIAL', 'DHARMAPURI', 'VELGATOOR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745204', 'ADA Regular DHARMAPURI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(84, 'Pogula Pradeep Reddy', 'JAGTIAL', 'JAGTIAL', 'BEERPUR', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977745447', 'ADA Regular JAGTIAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(85, 'Ellendula Keerthi Kumari', 'JAGTIAL', 'JAGTIAL', 'Bheemaram', 'AO', 'Regular', 'Agriculture Officer', NULL, '9346733256', 'ADA Regular JAGTIAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(86, 'Bulla Vaneela', 'JAGTIAL', 'JAGTIAL', 'JAGTIAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745207', 'ADA Regular JAGTIAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(87, 'A Thirupathi Naik', 'JAGTIAL', 'JAGTIAL', 'JAGTIAL RURAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745206', 'ADA Regular JAGTIAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(88, 'Parlapally Jyothi', 'JAGTIAL', 'JAGTIAL', 'KODIMIAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745208', 'ADA Regular JAGTIAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(89, 'K Chandra Deepak', 'JAGTIAL', 'JAGTIAL', 'MALLIAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745209', 'ADA Regular JAGTIAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(90, 'Md Shahid Ali Thabraz', 'JAGTIAL', 'JAGTIAL', 'MEDIPALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745445', 'ADA Regular JAGTIAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(91, 'K Muktheshwar', 'JAGTIAL', 'JAGTIAL', 'RAIKAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745446', 'ADA Regular JAGTIAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(92, 'Pogula Pradeep Reddy', 'JAGTIAL', 'JAGTIAL', 'SARANGAPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745447', 'ADA Regular JAGTIAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(93, 'Aaku Raj Kumar', 'JAGTIAL', 'KORUTLA', 'IBRAHIMPATNAM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745448', 'ADA Regular KORUTLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(94, 'Kannem Yogitha', 'JAGTIAL', 'KORUTLA', 'KATHLAPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745449', 'ADA Regular KORUTLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(95, 'Ramella Nagamani', 'JAGTIAL', 'KORUTLA', 'KORUTLA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745477', 'ADA Regular KORUTLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(96, 'Vanatadapula Lavanya', 'JAGTIAL', 'KORUTLA', 'MALLAPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745478', 'ADA Regular KORUTLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(97, 'Ananthula Deepika', 'JAGTIAL', 'KORUTLA', 'METPALLI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745479', 'ADA Regular KORUTLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(98, 'Katta Ambica Soni', 'JANGOAN', NULL, NULL, 'DAO', 'Regular', 'Deputy Director of Agriculture', NULL, '8977745480', 'DAO Office JANGOAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(99, 'N Vasantha Suguna', 'JANGOAN', 'GHANPURSTN', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977745501', 'ADA Regular GHANPURSTN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(100, 'Manikonda Aparna', 'JANGOAN', 'JANGAON', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977745483', 'ADA Regular JANGAON\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(101, 'Ajmera Parushram', 'JANGOAN', 'PALAKURTHI', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977745514', 'ADA Regular PALAKURTHI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(102, 'Shaik Nazeeroddin', 'JANGOAN', 'GHANPURSTN', 'CHILPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745507', 'ADA Regular GHANPURSTN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(103, 'Kotha Chandran Kumar', 'JANGOAN', 'GHANPURSTN', 'GHANPUR(STN)', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745502', 'ADA Regular GHANPURSTN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(104, 'Burra Mamatha', 'JANGOAN', 'GHANPURSTN', 'LINGALA GHANPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745508', 'ADA Regular GHANPURSTN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(105, 'Kaki Srinivas Reddy', 'JANGOAN', 'GHANPURSTN', 'RAGHUNATHA PALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745509', 'ADA Regular GHANPURSTN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(106, 'Kotha Chandran Kumar', 'JANGOAN', 'GHANPURSTN', 'ZAFFERGADH', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977745510', 'ADA Regular GHANPURSTN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(107, 'Cherupally Vidyakar Reddy', 'JANGOAN', 'JANGAON', 'BACHANNAPETA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745498', 'ADA Regular JANGAON\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(108, 'Kunduru Vijay Reddy', 'JANGOAN', 'JANGAON', 'JANGAON', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977745495', 'ADA Regular JANGAON\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(109, 'Akkireddy Karnakar', 'JANGOAN', 'JANGAON', 'NARMETTA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745496', 'ADA Regular GHANPURSTN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(110, 'Pechetti Manohith Vikrama Rao', 'JANGOAN', 'JANGAON', 'THARIGOPPULA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745497', 'ADA Regular JANGAON\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(111, 'Bajjuri Divya', 'JANGOAN', 'PALAKURTHI', 'DEVARUPPULA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745516', 'ADA Regular PALAKURTHI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(112, 'Kunduru Vijay Reddy', 'JANGOAN', 'PALAKURTHI', 'KODAKANDLA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745517', 'ADA Regular PALAKURTHI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(113, 'Singarapu Karunakar', 'JANGOAN', 'PALAKURTHI', 'PALAKURTHI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745515', 'ADA Regular JANGAON\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(114, 'Jadi Bapu', 'JAYASHANKAR BHUPALPALLI', NULL, NULL, 'DAO', 'FAC', 'Assistant Director of Agriculture', NULL, '8977745518', 'DAO Office JAYASHANKAR BHUPALPALLI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(115, 'Nerella Ramesh', 'JAYASHANKAR BHUPALPALLI', 'BHUPALPALLY', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977745527', 'ADA Regular BHUPALPALLY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(116, 'Kante Sripal', 'JAYASHANKAR BHUPALPALLI', 'MAHADEVPUR', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977745541', 'ADA Regular MAHADEVPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(117, 'Maloth Sathishkumar', 'JAYASHANKAR BHUPALPALLI', 'BHUPALPALLY', 'BHUPALPALLY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745528', 'ADA Regular BHUPALPALLY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(118, 'Chittireddy Srinivasreddy', 'JAYASHANKAR BHUPALPALLI', 'BHUPALPALLY', 'CHITYAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745530', 'ADA Regular BHUPALPALLY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(119, 'Deshaboina Ilaiah', 'JAYASHANKAR BHUPALPALLI', 'BHUPALPALLY', 'GHANAPUR MULUG', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745531', 'ADA Regular BHUPALPALLY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(120, 'Gudikandula Saraiah', 'JAYASHANKAR BHUPALPALLI', 'BHUPALPALLY', 'Kothapallegori', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745532', 'ADA Regular BHUPALPALLY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(121, 'Pingili Surenderreddy', 'JAYASHANKAR BHUPALPALLI', 'BHUPALPALLY', 'MOGULLAPALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745534', 'ADA Regular BHUPALPALLY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(122, 'Peddhi Vasudevareddy', 'JAYASHANKAR BHUPALPALLI', 'BHUPALPALLY', 'REGONDA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745539', 'ADA Regular BHUPALPALLY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(123, 'Mearugu Kalyani', 'JAYASHANKAR BHUPALPALLI', 'BHUPALPALLY', 'TEKUMATLA', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977745540', 'ADA Regular BHUPALPALLY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(124, 'Sms Poornima', 'JAYASHANKAR BHUPALPALLI', 'MAHADEVPUR', 'KATARAM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745542', 'ADA Regular MAHADEVPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(125, 'Chilakabathini Suprajyothi', 'JAYASHANKAR BHUPALPALLI', 'MAHADEVPUR', 'MAHADEVPUR', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977745543', 'ADA Regular MAHADEVPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(126, 'Bollapelli Srija', 'JAYASHANKAR BHUPALPALLI', 'MAHADEVPUR', 'MALHARRAO', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745561', 'ADA Regular MAHADEVPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(127, 'Gaddam Anusha', 'JAYASHANKAR BHUPALPALLI', 'MAHADEVPUR', 'MUTHARAM MAHADEVPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745560', 'ADA Regular MAHADEVPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(128, 'Chilakabathini Suprajyothi', 'JAYASHANKAR BHUPALPALLI', 'MAHADEVPUR', 'PALIMELA', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977745543', 'ADA Regular MAHADEVPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(129, 'Mudavath Sakriya Naik', 'JOGULAMBA GADWAL', NULL, NULL, 'DAO', 'FAC', 'Assistant Director of Agriculture', NULL, '8977745995', 'DAO Office JOGULAMBA GADWAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(130, 'Mudavath Sakriya Naik', 'JOGULAMBA GADWAL', 'ALAMPUR', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977745631', 'ADA Regular ALAMPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(131, 'Cheruku Sangeetha Laxmi', 'JOGULAMBA GADWAL', 'GADWAL', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977745996', 'ADA Regular GADWAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(132, 'Mudavath Sakriya Naik', 'JOGULAMBA GADWAL', 'IEEJA', NULL, 'ADA', 'Incharge', 'Assistant Director of Agriculture', NULL, '8977745631', 'ADA Regular ALAMPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(133, 'Gujjala Nagarjuna Reddy', 'JOGULAMBA GADWAL', 'ALAMPUR', 'ALAMPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745645', 'ADA Regular ALAMPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(134, 'Musini Ravi Kumar', 'JOGULAMBA GADWAL', 'ALAMPUR', 'ITIKYALA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745647', 'ADA Regular ALAMPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(135, 'Tripathi Sandeep Kumar', 'JOGULAMBA GADWAL', 'ALAMPUR', 'MANOPAD', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745648', 'ADA Regular ALAMPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(136, 'Chintakunta Anitha', 'JOGULAMBA GADWAL', 'ALAMPUR', 'UNDAVELLY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745650', 'ADA Regular ALAMPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(137, 'Musini Ravi Kumar', 'JOGULAMBA GADWAL', 'ALAMPUR', 'Yerravalli', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977745647', 'ADA Regular ALAMPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(138, 'Shaata Srilatha', 'JOGULAMBA GADWAL', 'GADWAL', 'DHAROOR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745658', 'ADA Regular GADWAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(139, 'Gudiselapati Prathap Kumar', 'JOGULAMBA GADWAL', 'GADWAL', 'GADWAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745659', 'ADA Regular GADWAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(140, 'Yenametla Rajavardhan Reddy', 'JOGULAMBA GADWAL', 'GADWAL', 'KALOOR TIMMANADODDI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745685', 'ADA Regular GADWAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(141, 'Kalingiri Rajashekhar', 'JOGULAMBA GADWAL', 'GADWAL', 'MALDAKAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746043', 'ADA Regular GADWAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(142, 'Mulkapalalli Hanmanth Reddy', 'JOGULAMBA GADWAL', 'IEEJA', 'GHATTU', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745684', 'ADA Regular GADWAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(143, 'Kotha Janardhan', 'JOGULAMBA GADWAL', 'IEEJA', 'IEEJA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745646', 'ADA Regular ALAMPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(144, 'Vankadhara Surekha', 'JOGULAMBA GADWAL', 'IEEJA', 'RAJOLI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745649', 'ADA Regular ALAMPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(145, 'Jinkala Radha', 'JOGULAMBA GADWAL', 'IEEJA', 'WADDEPALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977745657', 'ADA Regular ALAMPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(146, 'Nakkireddy Mohan Reddy', 'KAMAREDDY', NULL, NULL, 'DAO', 'On Deputation', 'Deputy Director of Agriculture', NULL, '8977746046', 'DAO Office KAMAREDDY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(147, 'Kalali Aruna', 'KAMAREDDY', 'BANSWADA', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977746233', 'ADA Regular BANSWADA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(148, 'Gonegandla Ameena Bi', 'KAMAREDDY', 'BICHKUNDA', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977746238', 'ADA Regular YELLAREDDY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(149, 'Kuppa Aparna', 'KAMAREDDY', 'KAMAREDDY', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977746267', 'ADA Regular KAMAREDDY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(150, 'Mudigapally Sudha Madhuri', 'KAMAREDDY', 'YELLAREDDY', NULL, 'ADA', 'Regular', 'Agriculture Officer', NULL, '8977746296', 'ADA Regular YELLAREDDY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(151, 'Md Mifta Faizullah', 'KAMAREDDY', 'BANSWADA', 'BANSWADA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746235', 'ADA Regular BANSWADA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(152, 'Bukya Karthik', 'KAMAREDDY', 'BANSWADA', 'BIRKUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746236', 'ADA Regular BANSWADA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(153, 'Rapelly Bhavani', 'KAMAREDDY', 'BANSWADA', 'NASRULLABAD', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746237', 'ADA Regular BANSWADA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(154, 'Kottam Amar Prasad', 'KAMAREDDY', 'BICHKUNDA', 'BICHKUNDA', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977746239', 'ADA Regular BICHKUNDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(155, 'Kesta Shiva Kumar', 'KAMAREDDY', 'BICHKUNDA', 'Dongli', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746240', 'ADA Regular BICHKUNDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(156, 'Banoth Maheshwari', 'KAMAREDDY', 'BICHKUNDA', 'JUKKAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746247', 'ADA Regular BICHKUNDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(157, 'Vislavath Raju', 'KAMAREDDY', 'BICHKUNDA', 'MADNOOR', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977746248', 'ADA Regular BICHKUNDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(158, 'Md Mifta Faizullah', 'KAMAREDDY', 'BICHKUNDA', 'Mohammadnagar', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977746249', 'ADA Regular BANSWADA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(159, 'Kottam Amar Prasad', 'KAMAREDDY', 'BICHKUNDA', 'NIZAMSAGAR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746250', 'ADA Regular BICHKUNDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(160, 'Kethavath Kishan', 'KAMAREDDY', 'BICHKUNDA', 'PEDDA KODAPGAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746252', 'ADA Regular BICHKUNDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(161, 'Bukya Vinod', 'KAMAREDDY', 'BICHKUNDA', 'PITLAM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746251', 'ADA Regular BICHKUNDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(162, 'Gardas Narendra', 'KAMAREDDY', 'KAMAREDDY', 'BHIKNOOR', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977746268', '\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(163, 'Gardas Narendra', 'KAMAREDDY', 'KAMAREDDY', 'BIBIPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746269', 'ADA Regular KAMAREDDY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(164, 'Thallapally Manideepika', 'KAMAREDDY', 'KAMAREDDY', 'DOMAKONDA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746270', 'ADA Regular KAMAREDDY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(165, 'Munthala Pavan Kumar', 'KAMAREDDY', 'KAMAREDDY', 'KAMAREDDY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746283', 'ADA Regular KAMAREDDY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(166, 'Vadla Pavan Kumar', 'KAMAREDDY', 'KAMAREDDY', 'MACHAREDDY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746284', 'ADA Regular KAMAREDDY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(167, 'Suddala Srinivasa Rao', 'KAMAREDDY', 'KAMAREDDY', 'Palvancha', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746294', 'ADA Regular KAMAREDDY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(168, 'Anagandula Shruthi', 'KAMAREDDY', 'KAMAREDDY', 'RAJAMPET', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977746295', 'ADA Regular KAMAREDDY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(169, 'Korivi Rajalingam', 'KAMAREDDY', 'YELLAREDDY', 'GANDHARI', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977746297', 'ADA Regular YELLAREDDY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(170, 'Neeli Anil Kumar', 'KAMAREDDY', 'YELLAREDDY', 'LINGAMPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746298', 'ADA Regular YELLAREDDY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(171, 'Vadla Sai Kiran', 'KAMAREDDY', 'YELLAREDDY', 'NAGIREDDYPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746301', 'ADA Regular YELLAREDDY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(172, 'Baddipadige Bhanusri', 'KAMAREDDY', 'YELLAREDDY', 'RAMAREDDY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746302', 'ADA Regular YELLAREDDY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(173, 'Konda Prajapathi', 'KAMAREDDY', 'YELLAREDDY', 'SADASIVANAGAR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746303', 'ADA Regular YELLAREDDY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(174, 'Shanigaram Narsimulu', 'KAMAREDDY', 'YELLAREDDY', 'TADWAI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746304', 'ADA Regular YELLAREDDY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(175, 'Mohammed Nadeem Uddin', 'KAMAREDDY', 'YELLAREDDY', 'YELLAREDDY', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977746305', 'ADA Regular YELLAREDDY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(176, 'Jannela Bhagyalakshmi', 'KARIMNAGAR', NULL, NULL, 'DAO', 'Regular', 'Deputy Director of Agriculture', NULL, '8977746334', 'DAO Office KARIMNAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(177, 'Neerati Priyadarshini', 'KARIMNAGAR', 'CHOPPADANDI', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977746340', 'ADA Regular CHOPPADANDI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(178, 'Gunda Sunitha', 'KARIMNAGAR', 'HUZURABAD', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977746356', 'ADA Regular HUZURABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(179, 'Katangur Randheer Kumar', 'KARIMNAGAR', 'KARIMNAGAR', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977746365', 'ADA Regular KARIMNAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(180, 'Naredla Sridhar', 'KARIMNAGAR', 'MANAKONDUR', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977746370', 'ADA Regular MANAKONDUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(181, 'Veldandi Vamshi Krishna', 'KARIMNAGAR', 'CHOPPADANDI', 'CHOPPADANDI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746348', 'ADA Regular CHOPPADANDI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(182, 'Rachakonda Sreenivas', 'KARIMNAGAR', 'CHOPPADANDI', 'GANGADHARA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746349', 'ADA Regular CHOPPADANDI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(183, 'Enjapuri Thrivedika', 'KARIMNAGAR', 'CHOPPADANDI', 'RAMADUGU', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746350', 'ADA Regular CHOPPADANDI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(184, 'Muppidi Suryanarayana', 'KARIMNAGAR', 'HUZURABAD', 'ELLANDAKUNTA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746359', 'ADA Regular HUZURABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(185, 'Chada Bhoomireddy', 'KARIMNAGAR', 'HUZURABAD', 'HUZURABAD', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746360', 'ADA Regular HUZURABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(186, 'Shaik Khadar Hussain', 'KARIMNAGAR', 'HUZURABAD', 'JAMMIKUNTA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746361', 'ADA Regular HUZURABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(187, 'Rai Vydehi', 'KARIMNAGAR', 'HUZURABAD', 'V.SAIDAPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746364', 'ADA Regular HUZURABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(188, 'Cherala Ganesh', 'KARIMNAGAR', 'HUZURABAD', 'VEENAVANKA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746362', 'ADA Regular HUZURABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(189, 'Marri Haritha', 'KARIMNAGAR', 'KARIMNAGAR', 'KARIMNAGAR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746367', 'ADA Regular KARIMNAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(190, 'Boddu Satyam', 'KARIMNAGAR', 'KARIMNAGAR', 'KARIMNAGAR RURAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746368', 'ADA Regular KARIMNAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(191, 'Kota Santhosh  Kumar', 'KARIMNAGAR', 'KARIMNAGAR', 'KOTHAPALLY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746369', 'ADA Regular KARIMNAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(192, 'Tula Ramya Shri', 'KARIMNAGAR', 'MANAKONDUR', 'CHIGURUMAMIDI', 'AO', 'FAC', 'Agriculture Officer', NULL, '8977746414', 'ADA Regular MANAKONDUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(193, 'Jaida Kiranmai', 'KARIMNAGAR', 'MANAKONDUR', 'GANNERUVARAM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746417', 'ADA Regular MANAKONDUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(194, 'Kallem Srinivas Reddy', 'KARIMNAGAR', 'MANAKONDUR', 'MANAKONDUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746418', 'ADA Regular MANAKONDUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(195, 'Gyadanaveni Venkatesh', 'KARIMNAGAR', 'MANAKONDUR', 'SHANKARAPATNAM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746419', 'ADA Regular MANAKONDUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(196, 'Jarupula Surender', 'KARIMNAGAR', 'MANAKONDUR', 'THIMMAPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746435', 'ADA Regular MANAKONDUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(197, 'Danasari Pullaiah', 'KHAMMAM', NULL, NULL, 'DAO', 'Regular', 'Assistant Director of Agriculture', NULL, '8977747500', 'DAO Office KHAMMAM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(198, 'Kongara Venkateswara Rao', 'KHAMMAM', 'KHAMMAM URBAN', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977746617', 'ADA Regular KHAMMAM URBAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(199, 'Mittapalli Sathish', 'KHAMMAM', 'KUSUMANCHI', NULL, 'ADA', 'FAC', 'Assistant Director of Agriculture', NULL, '8977747212', 'ADA Regular KUSUMANCHI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(200, 'Swarna Vijaya Chandra', 'KHAMMAM', 'MADHIRA', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977746574', 'ADA Regular MADHIRA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(201, 'Vemireddy Srinivasa Reddy', 'KHAMMAM', 'SATHUPALLE', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977748722', 'ADA Regular SATHUPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(202, 'Tummalapalli Karunasri', 'KHAMMAM', 'WYRA', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977748708', 'ADA Regular WYRA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(203, 'Bhukya Taradevi', 'KHAMMAM', 'KHAMMAM URBAN', 'KAMEPALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746620', 'ADA Regular KHAMMAM URBAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(204, 'Balusu Kishore Babu', 'KHAMMAM', 'KHAMMAM URBAN', 'KHAMMAM URBAN', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746618', 'ADA Regular KHAMMAM URBAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(205, 'Karnati Umamaheswar Reddy', 'KHAMMAM', 'KHAMMAM URBAN', 'RAGHUNADHAPALEM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746619', 'ADA Regular KHAMMAM URBAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(206, 'Jangirala Umanagesh', 'KHAMMAM', 'KUSUMANCHI', 'KHAMMAM RURAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977747218', 'ADA Regular KUSUMANCHI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(207, 'Ramadugu Vani', 'KHAMMAM', 'KUSUMANCHI', 'KUSUMANCHI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977747217', 'ADA Regular KUSUMANCHI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(208, 'Mandula Radha', 'KHAMMAM', 'KUSUMANCHI', 'NELAKONDAPALLE', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977747216', 'ADA Regular KUSUMANCHI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(209, 'Nareddy Seethramareddy', 'KHAMMAM', 'KUSUMANCHI', 'THIRUMALAYAPALEM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977747219', 'ADA Regular KUSUMANCHI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(210, 'Pasunuri Vinay Kumar', 'KHAMMAM', 'MADHIRA', 'BONAKAL', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977746576', 'ADA Regular MADHIRA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(211, 'Somulapalli Manasa', 'KHAMMAM', 'MADHIRA', 'CHINTHAKANI', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977746578', 'ADA Regular MADHIRA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(212, 'Kanakam Sai Deekshith', 'KHAMMAM', 'MADHIRA', 'MADHIRA', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977746575', 'ADA Regular MADHIRA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(213, 'Sarvasudi Saritha', 'KHAMMAM', 'MADHIRA', 'MUDIGONDA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746579', 'ADA Regular MADHIRA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(214, 'Boinapally Sai Siva', 'KHAMMAM', 'MADHIRA', 'YERRUPALEM', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977746580', 'ADA Regular MADHIRA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(215, 'Madabattula Rupa', 'KHAMMAM', 'SATHUPALLE', 'KALLUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977748728', 'ADA Regular SATHUPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(216, 'Avs Prasad Raju', 'KHAMMAM', 'SATHUPALLE', 'PENUBALLI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977748725', 'ADA Regular SATHUPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(217, 'Yarapathaneni Srinivasa Rao', 'KHAMMAM', 'SATHUPALLE', 'SATHUPALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977748723', 'ADA Regular SATHUPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(218, 'Mohammad Tajuddin', 'KHAMMAM', 'SATHUPALLE', 'THALLADA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977748729', 'ADA Regular SATHUPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(219, 'Patchala Ram Mohan', 'KHAMMAM', 'SATHUPALLE', 'VEMSOOR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977748724', 'ADA Regular SATHUPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(220, 'Avuku Narasimha Rao', 'KHAMMAM', 'WYRA', 'ENKOOR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746597', 'ADA Regular WYRA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(221, 'Doddigarla Balaji', 'KHAMMAM', 'WYRA', 'KONIJERLA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977748710', 'ADA Regular WYRA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(222, 'Battu Ashok Kumar', 'KHAMMAM', 'WYRA', 'SINGARENI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977746598', 'ADA Regular WYRA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(223, 'Mayana Manju Khan', 'KHAMMAM', 'WYRA', 'WYRA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977748709', 'ADA Regular WYRA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(224, 'Borkut Venkati', 'KUMURAM BHEEM ASIFABAD', NULL, NULL, 'DAO', 'Incharge', 'Assistant Director of Agriculture', NULL, '8977748730', 'DAO Office KUMURAM BHEEM (ASIFABAD)\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(225, 'Jadi Milind Kumar', 'KUMURAM BHEEM ASIFABAD', 'ASIFABAD', NULL, 'ADA', 'Incharge', 'Agriculture Officer', NULL, '8977748810', 'ADA Regular ASIFABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(226, 'Jatoth Manohar', 'KUMURAM BHEEM ASIFABAD', 'KAGAZ NAGAR', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977748816', 'ADA Regular KAGAZ NAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(227, 'Jatoth Manohar', 'KUMURAM BHEEM ASIFABAD', 'PENCHIKALPET', NULL, 'ADA', 'Incharge', 'Assistant Director of Agriculture', NULL, '8977748816', 'ADA Regular KAGAZ NAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(228, 'Borkut Venkati', 'KUMURAM BHEEM ASIFABAD', 'SIRPUR U', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977748819', 'ADA Regular SIRPUR U\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(229, 'Jadi Milind Kumar', 'KUMURAM BHEEM ASIFABAD', 'ASIFABAD', 'ASIFABAD', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977748820', 'ADA Regular ASIFABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(230, 'Deva Dileep Kumar', 'KUMURAM BHEEM ASIFABAD', 'ASIFABAD', 'REBBENA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977748846', 'ADA Regular ASIFABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(231, 'Kuthuru Vinay', 'KUMURAM BHEEM ASIFABAD', 'ASIFABAD', 'TIRYANI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977748869', 'ADA Regular ASIFABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(232, 'Nalaboyini Gopikanth', 'KUMURAM BHEEM ASIFABAD', 'ASIFABAD', 'WANKDI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977748870', 'ADA Regular ASIFABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(233, 'Gorlapalli Ramakrishna', 'KUMURAM BHEEM ASIFABAD', 'KAGAZ NAGAR', 'KAGAZ NAGAR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977748836', 'ADA Regular KAGAZ NAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11');
INSERT INTO `dao` (`id`, `employee_name`, `district_name`, `division_name`, `mandal_name`, `cadre`, `regular_incharge`, `present_cadre`, `email`, `office_mobile_no`, `present_office`, `status`, `created_at`, `updated_at`) VALUES
(234, 'Pendam Premalatha', 'KUMURAM BHEEM ASIFABAD', 'KAGAZ NAGAR', 'KOUTHALA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977748842', 'ADA Regular KAGAZ NAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(235, 'Bhukyaa Girishan', 'KUMURAM BHEEM ASIFABAD', 'KAGAZ NAGAR', 'SIRPUR (T)', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977748860', 'ADA Regular KAGAZ NAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(236, 'Bhanoth Nagaraju', 'KUMURAM BHEEM ASIFABAD', 'PENCHIKALPET', 'BEJJUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977748826', 'ADA Regular PENCHIKALPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(237, 'Kaleshwaram Karthiesha', 'KUMURAM BHEEM ASIFABAD', 'PENCHIKALPET', 'CHINTALA MANEPALLY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977748827', 'ADA Regular KAGAZ NAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(238, 'Gorlapalli Ramakrishna', 'KUMURAM BHEEM ASIFABAD', 'PENCHIKALPET', 'DAHEGAON', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977748834', 'ADA Regular PENCHIKALPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(239, 'Miriyala Manisha', 'KUMURAM BHEEM ASIFABAD', 'PENCHIKALPET', 'PENCHIKALPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977748845', 'ADA Regular PENCHIKALPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(240, 'Gurram Ananda Rao', 'KUMURAM BHEEM ASIFABAD', 'SIRPUR U', 'JAINOOR', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977748835', 'ADA Regular SIRPUR U\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(241, 'Kamera Ugendar', 'KUMURAM BHEEM ASIFABAD', 'SIRPUR U', 'KERAMERI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977748837', 'ADA Regular SIRPUR U\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(242, 'Lingamalla Sanjay Kumar', 'KUMURAM BHEEM ASIFABAD', 'SIRPUR U', 'LINGAPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977748843', 'ADA Regular SIRPUR U\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(243, 'Gurram Ananda Rao', 'KUMURAM BHEEM ASIFABAD', 'SIRPUR U', 'SIRPUR (U)', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977748867', 'ADA Regular SIRPUR U\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(244, 'Mundlapati Vijaya Nirmala', 'MAHABUBABAD', NULL, NULL, 'DAO', 'Regular', 'Joint Director of Agriculture', NULL, '8977749210', 'DAO Office MAHABUBABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(245, 'Azmeera Srinivasa Rao', 'MAHABUBABAD', 'MAHABUBABAD', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977749213', 'ADA Regular MAHABUBABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(246, 'Verpula Vijay Chandra', 'MAHABUBABAD', 'MARIPEDA', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977749214', 'ADA Regular MARIPEDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(247, 'Banoth Ramji', 'MAHABUBABAD', 'MAHABUBABAD', 'BAYYARAM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977749194', 'ADA Regular MAHABUBABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(248, 'Thodusu Venu Yadav', 'MAHABUBABAD', 'MAHABUBABAD', 'GANGARAM', 'AO', 'Regular', 'Agriculture Officer', NULL, '9494720147', 'ADA Regular MAHABUBABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(249, 'Kavati Ramarao', 'MAHABUBABAD', 'MAHABUBABAD', 'GARLA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977749193', 'ADA Regular MAHABUBABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(250, 'Mohammed Abdul Malik', 'MAHABUBABAD', 'MAHABUBABAD', 'GUDUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977749192', 'ADA Regular MAHABUBABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(251, 'Bhookya Mahender', 'MAHABUBABAD', 'MAHABUBABAD', 'Inugurthy', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977749196', 'ADA Regular MAHABUBABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(252, 'Banoth Venkanna', 'MAHABUBABAD', 'MAHABUBABAD', 'KESAMUDRAM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977749186', 'ADA Regular MAHABUBABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(253, 'Jakkula Uday', 'MAHABUBABAD', 'MAHABUBABAD', 'KOTHAGUDA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977749197', 'ADA Regular MAHABUBABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(254, 'Nareddy Thirupathi Reddy', 'MAHABUBABAD', 'MAHABUBABAD', 'MAHABUBABAD', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977749176', 'ADA Regular MAHABUBABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(255, 'Shaik Yashmin', 'MAHABUBABAD', 'MAHABUBABAD', 'NELLIKUDUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977749195', 'ADA Regular MAHABUBABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(256, 'Azmeera Bhasker', 'MAHABUBABAD', 'MARIPEDA', 'CHINNAGUDUR', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977749175', 'ADA Regular MARIPEDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(257, 'Azmeera Bhasker', 'MAHABUBABAD', 'MARIPEDA', 'CHINNAGUDUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977749175', 'ADA Regular MARIPEDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(258, 'Pilli Vahini', 'MAHABUBABAD', 'MARIPEDA', 'DANTHALAPALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977749015', 'ADA Regular MARIPEDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(259, 'Akkaladevi Murali Mohan', 'MAHABUBABAD', 'MARIPEDA', 'DORNAKAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977749163', 'ADA Regular MARIPEDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(260, 'Guntaka Narasimha Rao', 'MAHABUBABAD', 'MARIPEDA', 'KURAVI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977749164', 'ADA Regular MARIPEDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(261, 'Boda Veerasingh', 'MAHABUBABAD', 'MARIPEDA', 'MARIPEDA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977749013', 'ADA Regular MARIPEDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(262, 'Gandham Vinay Kumar', 'MAHABUBABAD', 'MARIPEDA', 'NARSIMHULAPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977749014', 'ADA Regular MARIPEDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(263, 'Gugulothu Swamy', 'MAHABUBABAD', 'MARIPEDA', 'PEDDAVANGARA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977749174', 'ADA Regular MARIPEDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(264, 'Tummeda Chayaraj', 'MAHABUBABAD', 'MARIPEDA', 'Seerole', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977749165', 'ADA Regular MARIPEDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(265, 'Durgam Ramnarsaiah', 'MAHABUBABAD', 'MARIPEDA', 'THORRUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977749173', 'ADA Regular MARIPEDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(266, 'Bovolla Venkatesh', 'MAHABUBNAGAR', NULL, NULL, 'DAO', 'FAC', 'Deputy Director of Agriculture', NULL, '8977749229', 'DDA FTC MAHABUBNAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(267, 'Nanavath Rajendar Agarwal', 'MAHABUBNAGAR', 'DEVARKADARA', NULL, 'ADA', 'FAC', 'Assistant Director of Agriculture', NULL, '8977749231', 'ADA Regular DEVARKADARA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(268, 'Baddula Gopinath', 'MAHABUBNAGAR', 'JADCHERLA', NULL, 'ADA', 'FAC', 'Assistant Director of Agriculture', NULL, '8977749232', 'ADA Regular JADCHERLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(269, 'Bontha Rampal', 'MAHABUBNAGAR', 'MAHABUBNAGAR RURAL', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977749233', 'ADA Regular MAHABUBNAGAR RURAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(270, 'Chennuri Beaulaha', 'MAHABUBNAGAR', 'DEVARKADARA', 'ADDAKAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750622', 'ADA Regular DEVARKADARA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(271, 'Gopi Muralidhar', 'MAHABUBNAGAR', 'DEVARKADARA', 'BHOOTHPUR', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977750623', 'ADA Regular DEVARKADARA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(272, 'Macherla Rajesh Khanna', 'MAHABUBNAGAR', 'DEVARKADARA', 'CHINNA CHINTHA KUNTA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750624', 'ADA Regular DEVARKADARA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(273, 'Nanavath Rajendar Agarwal', 'MAHABUBNAGAR', 'DEVARKADARA', 'DEVARKADARA', 'AO', 'Regular', 'Assistant Director of Agriculture', NULL, '8977750625', 'ADA Regular DEVARKADARA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(274, 'Balija Shiva Kumar', 'MAHABUBNAGAR', 'DEVARKADARA', 'Koukuntla', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750628', 'ADA Regular DEVARKADARA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(275, 'Borra Anil Kumar', 'MAHABUBNAGAR', 'DEVARKADARA', 'MOOSAPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750626', 'ADA Regular DEVARKADARA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(276, 'Mahendra Sujatha', 'MAHABUBNAGAR', 'JADCHERLA', 'BALANGAR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750655', 'ADA Regular JADCHERLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(277, 'Baddula Gopinath', 'MAHABUBNAGAR', 'JADCHERLA', 'JADCHERLA', 'AO', 'Regular', 'Assistant Director of Agriculture', NULL, '8977750656', 'ADA Regular JADCHERLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(278, 'Gajjula Siddartha', 'MAHABUBNAGAR', 'JADCHERLA', 'MIDJIL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750657', 'ADA Regular JADCHERLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(279, 'V Krishna Kishore', 'MAHABUBNAGAR', 'JADCHERLA', 'NAWABPET', 'AO', 'Regular', 'Assistant Director of Agriculture', NULL, '8977750658', 'ADA Regular JADCHERLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(280, 'Karnati Pradeep Kumar', 'MAHABUBNAGAR', 'JADCHERLA', 'RAJAPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750659', 'ADA Regular JADCHERLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(281, 'Jallari Narender', 'MAHABUBNAGAR', 'MAHABUBNAGAR RURAL', 'GANDEED', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977750714', 'ADA Regular MAHABUBNAGAR RURAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(282, 'Akula Kiran Kumar', 'MAHABUBNAGAR', 'MAHABUBNAGAR RURAL', 'HANWADA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750715', 'ADA Regular MAHABUBNAGAR RURAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(283, 'D Yama Reddy', 'MAHABUBNAGAR', 'MAHABUBNAGAR RURAL', 'KOILKONDA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750716', 'ADA Regular MAHABUBNAGAR RURAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(284, 'Peddamandadi Srinivasulu', 'MAHABUBNAGAR', 'MAHABUBNAGAR RURAL', 'MAHABUBANAGAR (URBAN)', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750719', 'ADA Regular MAHABUBNAGAR RURAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(285, 'Kotakonda Sruthi', 'MAHABUBNAGAR', 'MAHABUBNAGAR RURAL', 'MAHABUBNAGAR RURAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750717', 'ADA Regular MAHABUBNAGAR RURAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(286, 'Jallari Narender', 'MAHABUBNAGAR', 'MAHABUBNAGAR RURAL', 'Mohammadabad', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750720', 'ADA Regular JADCHERLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(287, 'Bhukya Chatru', 'MANCHERIAL', NULL, NULL, 'DAO', '-', 'Deputy Director of Agriculture', NULL, '8977750735', 'DAO Office MANCHERIAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(288, 'Elturi Surekha', 'MANCHERIAL', NULL, NULL, 'DAO', 'FAC', 'Assistant Director of Agriculture', NULL, '8977750735', 'DAO Office MANCHERIAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(289, 'Vuppula Rajanarender', 'MANCHERIAL', 'BELLAMPALLE', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977750745', 'ADA Regular BELLAMPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(290, 'Elturi Surekha', 'MANCHERIAL', 'BHEEMINI', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977750749', 'ADA Regular BHEEMINI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(291, 'Banoth Prasad', 'MANCHERIAL', 'CHENNUR', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977750760', 'ADA Regular CHENNUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(292, 'Mamidi Krishna', 'MANCHERIAL', 'MANCHERIAL', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977750778', 'ADA Regular MANCHERIAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(293, 'Suddala Prem Kumar', 'MANCHERIAL', 'BELLAMPALLE', 'BELLAMPALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750746', 'ADA Regular BELLAMPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(294, 'Challa Prabhakar', 'MANCHERIAL', 'BELLAMPALLE', 'KASIPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750747', 'ADA Regular BELLAMPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(295, 'Kondle Sushma', 'MANCHERIAL', 'BELLAMPALLE', 'TANDUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750748', 'ADA Regular BELLAMPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(296, 'Nune Yamuna Durga', 'MANCHERIAL', 'BHEEMINI', 'BHEEMINI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750756', 'ADA Regular BHEEMINI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(297, 'Chiramshetti Sai Prashanth', 'MANCHERIAL', 'BHEEMINI', 'KANNEPALLI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750757', 'ADA Regular BHEEMINI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(298, 'Puppala Srujana', 'MANCHERIAL', 'BHEEMINI', 'NENNEL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750758', 'ADA Regular BHEEMINI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(299, 'Sodari Veeranna', 'MANCHERIAL', 'BHEEMINI', 'VEMANPALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750759', 'ADA Regular BHEEMINI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(300, 'Atte Sudhakar', 'MANCHERIAL', 'CHENNUR', 'BHEEMARAM', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977750761', 'ADA Regular CHENNUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(301, 'Kolipaka Yamini', 'MANCHERIAL', 'CHENNUR', 'CHENNUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750762', 'ADA Regular CHENNUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(302, 'Kori Mark Gladston', 'MANCHERIAL', 'CHENNUR', 'JAIPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750763', 'ADA Regular CHENNUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(303, 'Ratna Sai Krishna', 'MANCHERIAL', 'CHENNUR', 'KOTAPALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750764', 'ADA Regular CHENNUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(304, 'Gadarla Kiran Mai', 'MANCHERIAL', 'CHENNUR', 'MANDAMARRI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750765', 'ADA Regular CHENNUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(305, 'Gorla Anjith Kumar', 'MANCHERIAL', 'MANCHERIAL', 'DANDEPALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750780', 'ADA Regular MANCHERIAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(306, 'Duta Krishna', 'MANCHERIAL', 'MANCHERIAL', 'HAJIPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750781', 'ADA Regular MANCHERIAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(307, 'Panaganti Sangeetha', 'MANCHERIAL', 'MANCHERIAL', 'JANNARAM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750782', 'ADA Regular MANCHERIAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(308, 'Ramagiri Srikanth', 'MANCHERIAL', 'MANCHERIAL', 'LUXETTIPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750783', 'ADA Regular MANCHERIAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(309, 'Thaduri Mahendar', 'MANCHERIAL', 'MANCHERIAL', 'MANCHERIAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750784', 'ADA Regular MANCHERIAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(310, 'Thaduri Mahendar', 'MANCHERIAL', 'MANCHERIAL', 'NASPUR', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977750784', 'ADA Regular MANCHERIAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(311, 'Kanchupati Devkumar', 'MEDAK', NULL, NULL, 'DAO', 'Regular', 'Deputy Director of Agriculture', NULL, '8977750785', 'DAO Office MEDAK\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(312, 'Vangpally Punyavathi', 'MEDAK', 'KOWDIPALLE', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977750827', 'ADA Regular KOWDIPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(313, 'Ragi Vijaya Nirmala', 'MEDAK', 'MEDAK', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977750869', 'ADA Regular MEDAK\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(314, 'Ragi Sandhya Rani', 'MEDAK', 'NARSAPUR', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977750942', 'ADA Regular NARSAPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(315, 'Thadakamadla Rajnarayana', 'MEDAK', 'RAMAYAMPET', NULL, 'ADA', 'FAC', 'Agriculture Officer', NULL, '8977750947', 'ADA Regular MEDAK\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(316, 'Donthi Venkata Rajashekhar', 'MEDAK', 'KOWDIPALLE', 'CHILIPCHED', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750830', 'ADA Regular KOWDIPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(317, 'Jadhav Swapna', 'MEDAK', 'KOWDIPALLE', 'KOWDIPALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750828', 'ADA Regular KOWDIPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(318, 'Mangali Swetha Kumari', 'MEDAK', 'KOWDIPALLE', 'KULCHARAM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750856', 'ADA Regular KOWDIPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(319, 'Vemula Kavitha', 'MEDAK', 'KOWDIPALLE', 'Masaipet', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750866', 'ADA Regular KOWDIPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(320, 'P Jhansi', 'MEDAK', 'KOWDIPALLE', 'YELDURTHY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750868', 'ADA Regular KOWDIPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(321, 'S Balreddy', 'MEDAK', 'MEDAK', 'HAVELI GHANPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750878', 'ADA Regular MEDAK\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(322, 'Nugurwar Srinivas', 'MEDAK', 'MEDAK', 'MEDAK', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750871', 'ADA Regular MEDAK\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(323, 'Prathigudupu Srinivasa Raju', 'MEDAK', 'MEDAK', 'PAPANNAPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750880', 'ADA Regular MEDAK\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(324, 'Veeragandham Laxmi Praveen', 'MEDAK', 'MEDAK', 'SHANKARAMPET(R)', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750940', 'ADA Regular MEDAK\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(325, 'Gajjala Sravanthi', 'MEDAK', 'NARSAPUR', 'MANOHARABAD', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750944', 'ADA Regular NARSAPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(326, 'Mittapally Deepika', 'MEDAK', 'NARSAPUR', 'NARSAPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750943', 'ADA Regular NARSAPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(327, 'Nagula Lavanya', 'MEDAK', 'NARSAPUR', 'SHIVAMPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750945', 'ADA Regular NARSAPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(328, 'Pashapu Gangamallu', 'MEDAK', 'NARSAPUR', 'TOOPRAN', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750946', 'ADA Regular NARSAPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(329, 'J Rajesh Kumar', 'MEDAK', 'RAMAYAMPET', 'ALLADURG', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750948', 'DAO Office MEDAK\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(330, 'Madoori Hariprasad', 'MEDAK', 'RAMAYAMPET', 'CHEGUNTA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750829', 'ADA Regular KOWDIPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(331, 'Nagavelli Bharathkumar', 'MEDAK', 'RAMAYAMPET', 'NARSINGI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750867', 'ADA Regular KOWDIPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(332, 'Madduri Somalinga Reddy', 'MEDAK', 'RAMAYAMPET', 'NIZAMPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750879', 'ADA Regular MEDAK\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(333, 'Thadakamadla Rajnarayana', 'MEDAK', 'RAMAYAMPET', 'RAMAYAMPET', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977750939', 'ADA Regular MEDAK\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(334, 'Mohammad Javeed', 'MEDAK', 'RAMAYAMPET', 'REGODE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977750949', 'DAO Office MEDAK\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(335, 'Kyatham Nagama Krishna', 'MEDAK', 'RAMAYAMPET', 'SHANKARAMPET(A)', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977751029', 'DAO Office MEDAK\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(336, 'Nunsavath Ram Prasad', 'MEDAK', 'RAMAYAMPET', 'TEKMAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751030', 'DAO Office MEDAK\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(337, 'Khethavath Chandrakala', 'MEDCHAL-MALKAJIGIRI', NULL, NULL, 'DAO', 'FAC', 'Assistant Director of Agriculture', NULL, '8977751031', 'ADA Regular MALKAJGIRI URBAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(338, 'Khethavath Chandrakala', 'MEDCHAL-MALKAJIGIRI', 'MALKAJGIRI', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '9440553334', 'ADA Regular MALKAJGIRI URBAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(339, 'Narsapally Venkatram Reddy', 'MEDCHAL-MALKAJIGIRI', 'MEDCHAL', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977751064', 'ADA Regular MALKAJGIRI URBAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(340, 'Gruddanti Krupakar Reddy', 'MEDCHAL-MALKAJIGIRI', 'MALKAJGIRI', 'ALWAL', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977751035', 'ADA Regular MALKAJGIRI URBAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(341, 'Sayamolla Yadagiri', 'MEDCHAL-MALKAJIGIRI', 'MALKAJGIRI', 'BACHUPALLY', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977751034', 'ADA Regular MALKAJGIRI URBAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(342, 'Gullaiahgari Sai Ramesh Kumar', 'MEDCHAL-MALKAJIGIRI', 'MALKAJGIRI', 'BALANAGAR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751033', 'ADA Regular MALKAJGIRI URBAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(343, 'Sayamolla Yadagiri', 'MEDCHAL-MALKAJIGIRI', 'MALKAJGIRI', 'GANDIMAISAMMA DUNDIGAL', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977751034', 'ADA Regular MALKAJGIRI URBAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(344, 'Gullaiahgari Sai Ramesh Kumar', 'MEDCHAL-MALKAJIGIRI', 'MALKAJGIRI', 'KUKATPALLY', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977751033', 'ADA Regular MALKAJGIRI URBAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(345, 'Gruddanti Krupakar Reddy', 'MEDCHAL-MALKAJIGIRI', 'MALKAJGIRI', 'MALKAJGIRI', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977751035', 'ADA Regular MALKAJGIRI URBAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(346, 'Sayamolla Yadagiri', 'MEDCHAL-MALKAJIGIRI', 'MALKAJGIRI', 'QUTHBULLAPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751034', 'ADA Regular MALKAJGIRI URBAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(347, 'Gruddanti Krupakar Reddy', 'MEDCHAL-MALKAJIGIRI', 'MALKAJGIRI', 'UPPAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751035', 'ADA Regular MALKAJGIRI URBAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(348, 'Samarthapu Lavanya', 'MEDCHAL-MALKAJIGIRI', 'MEDCHAL', 'GHATKESAR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751065', 'ADA Regular MALKAJGIRI URBAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(349, 'Chinnola Ramesh', 'MEDCHAL-MALKAJIGIRI', 'MEDCHAL', 'KAPRA', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977751069', 'ADA Regular MEDCHAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(350, 'Vaddella Madhavi Latha', 'MEDCHAL-MALKAJIGIRI', 'MEDCHAL', 'KEESARA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751066', 'ADA Regular MEDCHAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(351, 'Sama Madhav Reddy', 'MEDCHAL-MALKAJIGIRI', 'MEDCHAL', 'MEDCHAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977741647', 'ADA Regular MALKAJGIRI URBAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(352, 'Samarthapu Lavanya', 'MEDCHAL-MALKAJIGIRI', 'MEDCHAL', 'MEDIPALLY', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977751065', 'ADA Regular MALKAJGIRI URBAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(353, 'Kayithy Ramaswamy Ravikumar', 'MEDCHAL-MALKAJIGIRI', 'MEDCHAL', 'Muduchinthalapally', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977751068', 'ADA Regular MEDCHAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(354, 'Chinnola Ramesh', 'MEDCHAL-MALKAJIGIRI', 'MEDCHAL', 'SHAMIRPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751069', 'ADA Regular MEDCHAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(355, 'Vimmadeshetty Suresh Kumar', 'MULUG', NULL, NULL, 'DAO', 'Incharge', 'Assistant Director of Agriculture', NULL, '8977751139', 'DAO Office MULUG\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(356, 'Jaligapu Avinash Varma', 'MULUG', 'ETURNAGARAM', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977751141', 'ADA Regular ETURNAGARAM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(357, 'Vimmadeshetty Suresh Kumar', 'MULUG', 'MULUG', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977751156', 'ADA Regular MULUG\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(358, 'Ravula Venugopal', 'MULUG', 'ETURNAGARAM', 'ETURNAGARAM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751142', 'ADA Regular ETURNAGARAM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(359, 'Kaitha Jithender Reddy', 'MULUG', 'ETURNAGARAM', 'GOVINDARAOPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751149', 'ADA Regular ETURNAGARAM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(360, 'Munja Mahesh', 'MULUG', 'ETURNAGARAM', 'KANNAIGUDEM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751150', 'ADA Regular ETURNAGARAM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(361, 'Ravula Venugopal', 'MULUG', 'ETURNAGARAM', 'MANGAPET', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977751151', 'ADA Regular ETURNAGARAM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(362, 'Kasani Soma Kumar Yadav', 'MULUG', 'ETURNAGARAM', 'TADVAI (SAMMAKKA SARAKKA)', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977751152', 'ADA Regular ETURNAGARAM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(363, 'Nanaboina Naveen', 'MULUG', 'ETURNAGARAM', 'VENKATAPURAM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751153', 'ADA Regular ETURNAGARAM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(364, 'Munja Mahesh', 'MULUG', 'ETURNAGARAM', 'WAZEED', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977751154', 'ADA Regular ETURNAGARAM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(365, 'Nallella Sreedhar', 'MULUG', 'MULUG', 'Mallampally', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '9866153803', 'ADA Regular MULUG\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(366, 'Rendla Parameshwar', 'MULUG', 'MULUG', 'MULUG', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751161', 'ADA Regular MULUG\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(367, 'Maduri Shailaja', 'MULUG', 'MULUG', 'VENKATAPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751162', 'ADA Regular MULUG\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(368, 'Namaji Yeshwanth Rao', 'NAGARKURNOOL', NULL, NULL, 'DAO', 'Regular', 'Assistant Director of Agriculture', NULL, '8977751163', 'DAO Office NAGARKURNOOL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(369, 'Mangali Chandra Shekar', 'NAGARKURNOOL', 'ACHAMPET', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977751182', 'ADA Regular ACHAMPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(370, 'Sundari Kiran Kumar', 'NAGARKURNOOL', 'KALWAKURTHY', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977751202', 'ADA Regular KALWAKURTHY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(371, 'Chetamoni Chinna Hussain', 'NAGARKURNOOL', 'KOLLAPUR', NULL, 'ADA', 'FAC', 'Agriculture Officer', NULL, '8977751213', 'ADA Regular KOLLAPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(372, 'Boojala Purna Chandra Reddy', 'NAGARKURNOOL', 'NAGARKURNOOL', NULL, 'ADA', 'FAC', 'Assistant Director of Agriculture', NULL, '8977751270', 'ADA Regular NAGARKURNOOL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(373, 'Kondreddy Krishnaiah', 'NAGARKURNOOL', 'ACHAMPET', 'ACHAMPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751180', 'ADA Regular ACHAMPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(374, 'Goli Mahesh Reddy', 'NAGARKURNOOL', 'ACHAMPET', 'AMRABAD', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751183', 'ADA Regular ACHAMPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(375, 'Kaveti Naresh', 'NAGARKURNOOL', 'ACHAMPET', 'BALMOOR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751184', 'ADA Regular ACHAMPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(376, 'Gunduru Anil', 'NAGARKURNOOL', 'ACHAMPET', 'LINGAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751185', 'ADA Regular ACHAMPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(377, 'Goli Mahesh Reddy', 'NAGARKURNOOL', 'ACHAMPET', 'PADARA', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977751186', 'ADA Regular ACHAMPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(378, 'Korra Ramesh', 'NAGARKURNOOL', 'ACHAMPET', 'UPPUNUNTHALA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751187', 'ADA Regular ACHAMPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(379, 'Adepu Priyadarshini', 'NAGARKURNOOL', 'ACHAMPET', 'VANGOOR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751201', 'ADA Regular ACHAMPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(380, 'Chevuri Tanuja Raju', 'NAGARKURNOOL', 'KALWAKURTHY', 'CHARAKONDA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751204', 'ADA Regular KALWAKURTHY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(381, 'Sarakonda Suresh', 'NAGARKURNOOL', 'KALWAKURTHY', 'KALWAKURTHY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751209', 'ADA Regular KALWAKURTHY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(382, 'Koppu Prabhakar Deepthi', 'NAGARKURNOOL', 'KALWAKURTHY', 'URKONDA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751210', 'ADA Regular KALWAKURTHY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(383, 'Shakhapaty Shobha Rani', 'NAGARKURNOOL', 'KALWAKURTHY', 'VELDANDA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751211', 'ADA Regular KALWAKURTHY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(384, 'Banothu Nagajyothi', 'NAGARKURNOOL', 'KOLLAPUR', 'KODAIR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751266', 'ADA Regular KOLLAPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(385, 'Chetamoni Chinna Hussain', 'NAGARKURNOOL', 'KOLLAPUR', 'KOLLAPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751267', 'ADA Regular KOLLAPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(386, 'Kethavath Shireesha', 'NAGARKURNOOL', 'KOLLAPUR', 'PEDDAKOTHAPALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751268', 'ADA Regular KOLLAPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(387, 'Chittem Vikas', 'NAGARKURNOOL', 'KOLLAPUR', 'PENTLAVELLI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751269', 'ADA Regular KOLLAPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(388, 'Akumalla Elezar Kamal Kumar', 'NAGARKURNOOL', 'NAGARKURNOOL', 'BIJINAPALLY', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977751271', 'ADA Regular NAGARKURNOOL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(389, 'Charagonda Raju', 'NAGARKURNOOL', 'NAGARKURNOOL', 'NAGARKURNOOL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751272', 'ADA Regular NAGARKURNOOL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(390, 'Dendi Sandeepkumar Reddy', 'NAGARKURNOOL', 'NAGARKURNOOL', 'TADOOR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751273', 'ADA Regular NAGARKURNOOL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(391, 'Potharapally Naramada', 'NAGARKURNOOL', 'NAGARKURNOOL', 'TELKAPALLY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751274', 'ADA Regular NAGARKURNOOL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(392, 'Akumalla Elezar Kamal Kumar', 'NAGARKURNOOL', 'NAGARKURNOOL', 'THIMMAJILPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751293', 'ADA Regular NAGARKURNOOL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(393, 'Palvai Shravan Kumar', 'NALGONDA', NULL, NULL, 'DAO', 'FAC', 'Assistant Director of Agriculture', NULL, '8977751294', 'DAO Office NALGONDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(394, 'Madana Saritha', 'NALGONDA', 'ANUMULA', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977751330', 'ADA Regular HALIYA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(395, 'Racha Sreelakshmi', 'NALGONDA', 'DEVARAKONDA', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977751306', 'ADA Regular DEVARAKONDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(396, 'Dheeravath Saida Naik', 'NALGONDA', 'MIRYALAGUDA', NULL, 'ADA', 'Incharge', 'Agriculture Officer', NULL, '8977751358', 'ADA Regular MIRYALAGUDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(397, 'Bheemanapally Venugopal', 'NALGONDA', 'MUNUGODE', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977751370', 'ADA Regular MUNUGODE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(398, 'Mohammad Jani Mia', 'NALGONDA', 'NAKREKAL', NULL, 'ADA', 'Incharge', 'Agriculture Officer', NULL, '8977751426', 'ADA Regular NAKREKAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(399, 'Palvai Shravan Kumar', 'NALGONDA', 'NALGONDA', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977751449', 'ADA Regular NALGONDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(400, 'Parsagoni Mallesh', 'NALGONDA', 'ANUMULA', 'ANUMULA', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977751343', 'ADA Regular HALIYA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(401, 'Kanchaerla Madhav Reddy', 'NALGONDA', 'ANUMULA', 'GURRAMPODE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751344', 'ADA Regular HALIYA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(402, 'Siddapanga Venkanna', 'NALGONDA', 'ANUMULA', 'NIDAMANUR', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8877751348', 'ADA Regular HALIYA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(403, 'Lankela Sandeep Kumar', 'NALGONDA', 'ANUMULA', 'PEDDAVOORA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751349', 'ADA Regular HALIYA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(404, 'Ganta Harshitha', 'NALGONDA', 'ANUMULA', 'TIRUMALAGIRI (SAGAR)', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751350', 'ADA Regular HALIYA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(405, 'Mood Parwathi Chawhan', 'NALGONDA', 'ANUMULA', 'TRIPURARAM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751357', 'ADA Regular HALIYA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(406, 'Kethavath Lakpathi', 'NALGONDA', 'DEVARAKONDA', 'CHANDAMPETA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751308', 'ADA Regular DEVARAKONDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(407, 'Polishetti Sravana Kumari', 'NALGONDA', 'DEVARAKONDA', 'CHINTHA PALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751309', 'ADA Regular DEVARAKONDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(408, 'Karri Ravi Kumar', 'NALGONDA', 'DEVARAKONDA', 'DEVARAKONDA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751310', 'ADA Regular DEVARAKONDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(409, 'Ravula Pandu', 'NALGONDA', 'DEVARAKONDA', 'Gudipally', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977751460', 'ADA Regular DEVARAKONDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(410, 'Shaik Rehana', 'NALGONDA', 'DEVARAKONDA', 'GUNDLA PALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751311', 'ADA Regular DEVARAKONDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(411, 'Yerramshetty Janaki Ramulu', 'NALGONDA', 'DEVARAKONDA', 'KONDA MALLEPALLY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751327', 'ADA Regular DEVARAKONDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(412, 'Ravula Yadagiri', 'NALGONDA', 'DEVARAKONDA', 'NEREDUGOMMU', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751328', 'ADA Regular DEVARAKONDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(413, 'Ravula Pandu', 'NALGONDA', 'DEVARAKONDA', 'PEDA ADISHARLA PALLI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751329', 'ADA Regular DEVARAKONDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(414, 'Gurram Sarita', 'NALGONDA', 'MIRYALAGUDA', 'ADAVIDEVULAPALLY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751360', 'ADA Regular MIRYALAGUDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(415, 'Mekala Rushendramani', 'NALGONDA', 'MIRYALAGUDA', 'DAMERCHERLA', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977751366', 'ADA Regular MIRYALAGUDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(416, 'Maraboina Shivaram Kumar', 'NALGONDA', 'MIRYALAGUDA', 'MADUGULAPALLY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751367', 'ADA Regular MIRYALAGUDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(417, 'Dheeravath Saida Naik', 'NALGONDA', 'MIRYALAGUDA', 'MIRYALAGUDA', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977751368', 'ADA Regular MIRYALAGUDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(418, 'Ramavath Kishore Naik', 'NALGONDA', 'MIRYALAGUDA', 'VEMULAPALLY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751369', 'ADA Regular MIRYALAGUDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(419, 'Vadla Chandrika', 'NALGONDA', 'MUNUGODE', 'CHANDUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751372', 'ADA Regular MUNUGODE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(420, 'Maila Revathi', 'NALGONDA', 'MUNUGODE', 'Gattuppal', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751400', 'ADA Regular MUNUGODE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(421, 'Marru Sahas', 'NALGONDA', 'MUNUGODE', 'MARRI GUDA', 'AO', 'Regular', 'Agriculture Extension Officer Grade-II', NULL, '8977751411', 'ADA Regular MUNUGODE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(422, 'Saraswathi Padmaja', 'NALGONDA', 'MUNUGODE', 'MUNUGODE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751412', 'ADA Regular MUNUGODE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(423, 'Bandaru Shiva', 'NALGONDA', 'MUNUGODE', 'NAMPALLY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751413', 'ADA Regular MUNUGODE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(424, 'Pagidimarri Giri Babu', 'NALGONDA', 'NAKREKAL', 'CHITYAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751428', 'ADA Regular NAKREKAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(425, 'Yedavalli Giri Prasad', 'NALGONDA', 'NAKREKAL', 'KATTANGUR', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977751429', 'ADA Regular NAKREKAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(426, 'Bokka Purushotham', 'NALGONDA', 'NAKREKAL', 'KETHEPALLY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751430', 'ADA Regular NAKREKAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(427, 'Mohammad Jani Mia', 'NALGONDA', 'NAKREKAL', 'NAKREKAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751431', 'ADA Regular NAKREKAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(428, 'Kanuku Goutham', 'NALGONDA', 'NAKREKAL', 'NARKETPALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751432', 'ADA Regular NAKREKAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(429, 'Nagella Soumya Shruthi', 'NALGONDA', 'NAKREKAL', 'SHALIGOURARAM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751448', 'ADA Regular NAKREKAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(430, 'Bejawada Amarender Goud', 'NALGONDA', 'NALGONDA', 'KANGAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751451', 'ADA Regular NALGONDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(431, 'Sunkoju Srinivas', 'NALGONDA', 'NALGONDA', 'NALGONDA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751452', 'ADA Regular NALGONDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(432, 'Boska Sunny Raj', 'NALGONDA', 'NALGONDA', 'TIPPARTHY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751457', 'ADA Regular NALGONDA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(433, 'Maale John Sudhakar', 'NARAYANPET', NULL, NULL, 'DAO', 'FAC', 'Assistant Director of Agriculture', NULL, '8977751549', 'DAO Office NARAYANPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(434, 'Bantroth Rama Krishna', 'NARAYANPET', 'KOSGI', NULL, 'ADA', 'Incharge', 'Agriculture Officer', NULL, '8977751562', 'ADA Regular KOSGI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(435, 'Ponnagandla Nagesh Kumar', 'NARAYANPET', 'MAKTHAL', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977751611', 'ADA Regular MAKTHAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(436, 'Maale John Sudhakar', 'NARAYANPET', 'NARAYANPET', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977751690', 'ADA Regular NARAYANPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(437, 'Onteddu Reshma', 'NARAYANPET', 'KOSGI', 'Gundumal', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977751563', 'ADA Regular KOSGI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(438, 'Onteddu Reshma', 'NARAYANPET', 'KOSGI', 'Gundumal', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751563', 'ADA Regular KOSGI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(439, 'Bantroth Rama Krishna', 'NARAYANPET', 'KOSGI', 'KOSGI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751564', 'ADA Regular KOSGI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(440, 'K Ramesh', 'NARAYANPET', 'KOSGI', 'Kothapalle', 'AO', 'Regular', 'Agriculture Extension Officer Grade-II', NULL, '8977751565', 'ADA Regular KOSGI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(441, 'Bantroth Rama Krishna', 'NARAYANPET', 'KOSGI', 'MADDUR', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977751580', 'ADA Regular KOSGI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(442, 'Sudarshan Goud', 'NARAYANPET', 'MAKTHAL', 'KRISHNA', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977751612', 'ADA Regular MAKTHAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(443, 'Sudarshan Goud', 'NARAYANPET', 'MAKTHAL', 'MAGANOOR', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977751613', 'ADA Regular MAKTHAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(444, 'Dandu Mithun Chakarvarthy', 'NARAYANPET', 'MAKTHAL', 'MAKTHAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751618', 'ADA Regular MAKTHAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(445, 'Chinnola Akhila Reddy', 'NARAYANPET', 'MAKTHAL', 'NARWA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751619', 'ADA Regular MAKTHAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(446, 'Mula Ganesh Reddy', 'NARAYANPET', 'MAKTHAL', 'UTKOOR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751620', 'ADA Regular MAKTHAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(447, 'Mandula Manichander', 'NARAYANPET', 'NARAYANPET', 'DAMARAGIDDA', 'AO', 'Regular', 'Agriculture Extension Officer Grade-II', NULL, '8977751734', 'ADA Regular NARAYANPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(448, 'Bussu Naveen Kumar', 'NARAYANPET', 'NARAYANPET', 'DHANWADA', 'AO', 'Regular', 'Agriculture Extension Officer Grade-II', NULL, '8977751735', 'ADA Regular NARAYANPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(449, 'Shaik Moizur Rahman', 'NARAYANPET', 'NARAYANPET', 'MARIKAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751746', 'ADA Regular NARAYANPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(450, 'Rekhala Bala Dinakar', 'NARAYANPET', 'NARAYANPET', 'NARAYANPET', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977751747', 'ADA Regular NARAYANPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(451, 'Pabbiraju Anji Prasad', 'NIRMAL', NULL, NULL, 'DAO', 'Regular', 'Deputy Director of Agriculture', NULL, '8977751748', 'DAO Office NIRMAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(452, 'Salvaji Veena', 'NIRMAL', 'BHAINSA', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977751782', 'ADA Regular BHAINSA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(453, 'Bhuthapati Sujatha', 'NIRMAL', 'KHANAPUR', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977751784', 'ADA Regular KHANAPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(454, 'Rachakatla Srinivas Raju', 'NIRMAL', 'MUDHOLE', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977751783', 'ADA Regular MUDHOLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(455, 'Voorugonda Vidya Sagar', 'NIRMAL', 'NIRAMAL II', NULL, 'ADA', 'FAC', 'Assistant Director of Agriculture', NULL, '8977751781', 'ADA Regular NIRMAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(456, 'Voorugonda Vidya Sagar', 'NIRMAL', 'NIRMALU', NULL, 'ADA', 'FAC', 'Assistant Director of Agriculture', NULL, '8977751781', 'ADA Regular NIRMAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(457, 'Maskari Ganesh', 'NIRMAL', 'BHAINSA', 'BHAINSA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751753', 'ADA Regular MUDHOLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(458, 'Badakala Sarika', 'NIRMAL', 'BHAINSA', 'KUBEER', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751844', 'ADA Regular BHAINSA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(459, 'Dilari Vikram', 'NIRMAL', 'BHAINSA', 'KUNTALA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751845', 'ADA Regular BHAINSA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(460, 'Polkam Dinesh', 'NIRMAL', 'KHANAPUR', 'DASTURABAD', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977751847', 'ADA Regular KHANAPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(461, 'Polkam Dinesh', 'NIRMAL', 'KHANAPUR', 'KADDAM PEDDUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751846', 'ADA Regular KHANAPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(462, 'Srigadde Jagadeeshwar', 'NIRMAL', 'KHANAPUR', 'KHANAPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751916', 'ADA Regular KHANAPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(463, 'Nunavath Naveen', 'NIRMAL', 'KHANAPUR', 'PEMBI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751749', 'ADA Regular KHANAPUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(464, 'Dasari Rachana', 'NIRMAL', 'MUDHOLE', 'BASAR', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977751750', 'ADA Regular MUDHOLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(465, 'Karrolla Giri Raj', 'NIRMAL', 'MUDHOLE', 'LOKESHWARAM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751771', 'ADA Regular MUDHOLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(466, 'Dasari Rachana', 'NIRMAL', 'MUDHOLE', 'MUDHOLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751755', 'ADA Regular MUDHOLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(467, 'Rathod Manisha', 'NIRMAL', 'MUDHOLE', 'TANUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751770', 'ADA Regular MUDHOLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11');
INSERT INTO `dao` (`id`, `employee_name`, `district_name`, `division_name`, `mandal_name`, `cadre`, `regular_incharge`, `present_cadre`, `email`, `office_mobile_no`, `present_office`, `status`, `created_at`, `updated_at`) VALUES
(468, 'Desam Rajasekhar Reddy', 'NIRMAL', 'NIRAMAL II', 'DILAWARPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751922', 'ADA Regular NIRMAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(469, 'Dharamsoath Ramchander Rao Naik', 'NIRMAL', 'NIRAMAL II', 'NARSAPUR (G)', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751923', 'ADA Regular BHAINSA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(470, 'Ahmad Viquar', 'NIRMAL', 'NIRAMAL II', 'SARANGAPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751920', 'ADA Regular BHAINSA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(471, 'Gollapalli Vinod Kumar', 'NIRMAL', 'NIRAMAL II', 'SOAN', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751917', 'ADA Regular NIRMAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(472, 'Amraji Vasanth Rao', 'NIRMAL', 'NIRMALU', 'LAXMANCHANDA', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977751924', 'ADA Regular NIRMAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(473, 'Jadav Sandya Rani', 'NIRMAL', 'NIRMALU', 'MAMADA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751925', 'ADA Regular NIRMAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(474, 'Amraji Vasanth Rao', 'NIRMAL', 'NIRMALU', 'NIRMAL RURAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751850', 'ADA Regular NIRMAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(475, 'Balne Nagaraju', 'NIRMAL', 'NIRMALU', 'NIRMAL(U)', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977751918', 'ADA Regular NIRMAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(476, 'Mekala Govindu', 'NIZAMABAD', NULL, NULL, 'DAO', 'On Deputation', 'Deputy Director of Agriculture', NULL, '8977751940', 'DAO Office NIZAMABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(477, 'A Vijaya Lakshmi', 'NIZAMABAD', 'ARMOOR', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977751979', 'ADA Regular ARMOOR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(478, 'Gummula Saikrishna', 'NIZAMABAD', 'BALKONDA', NULL, 'ADA', 'FAC', 'Agriculture Officer', NULL, '8096548489', 'ADA Regular BHEEMGAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(479, 'Gummula Saikrishna', 'NIZAMABAD', 'BHEEMGAL', NULL, 'ADA', 'FAC', 'Agriculture Officer', NULL, '8096548489', 'ADA Regular BHEEMGAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(480, 'Mohammed Abdul Aleem Ahmed', 'NIZAMABAD', 'BODHAN', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977752259', 'ADA Regular BODHAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(481, 'Manda Krishna', 'NIZAMABAD', 'INDALWAI', NULL, 'ADA', 'FAC', 'Assistant Director of Agriculture', NULL, '8977752260', 'DAO Office NIZAMABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(482, 'Manda Krishna', 'NIZAMABAD', 'NIZAMABAD RURAL', NULL, 'ADA', 'FAC', 'Assistant Director of Agriculture', NULL, '8977752260', 'DAO Office NIZAMABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(483, 'Gousula Veeraswamy', 'NIZAMABAD', 'NIZAMABAD SOUTH', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977752261', 'ADA Regular NIZAMABAD URBAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(484, 'Mohammed Abdul Aleem Ahmed', 'NIZAMABAD', 'RUDRUR', NULL, 'ADA', 'FAC', 'Assistant Director of Agriculture', NULL, '8977752259', 'ADA Regular BODHAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(485, 'Gali Rambabu', 'NIZAMABAD', 'ARMOOR', 'Aloor', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752269', 'ADA Regular ARMOOR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(486, 'Annam Hari Krishna', 'NIZAMABAD', 'ARMOOR', 'ARMOOR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752270', 'ADA Regular ARMOOR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(487, 'Barla Madhusudhan', 'NIZAMABAD', 'ARMOOR', 'Donkeshwar', 'AO', 'Regular', 'Agriculture Officer', NULL, '8464804090', 'ADA Regular ARMOOR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(488, 'Pinnaka Padma', 'NIZAMABAD', 'ARMOOR', 'MAKLOOR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752278', 'ADA Regular ARMOOR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(489, 'Gali Rambabu', 'NIZAMABAD', 'ARMOOR', 'NANDIPET', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977752269', 'ADA Regular ARMOOR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(490, 'Baddam Lavanya', 'NIZAMABAD', 'BALKONDA', 'BALKONDA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752280', 'ADA Regular BHEEMGAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(491, 'Yerram Vasanth', 'NIZAMABAD', 'BALKONDA', 'MENDORA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752384', 'ADA Regular BHEEMGAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(492, 'Gummula Saikrishna', 'NIZAMABAD', 'BALKONDA', 'MUPKAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752386', 'ADA Regular BHEEMGAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(493, 'Sheri Vaishnav', 'NIZAMABAD', 'BALKONDA', 'YERGATLA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752406', 'ADA Regular BHEEMGAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(494, 'Baddam Lavanya', 'NIZAMABAD', 'BHEEMGAL', 'BHEEMGAL', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977752280', 'ADA Regular BHEEMGAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(495, 'Talla Ramyashree', 'NIZAMABAD', 'BHEEMGAL', 'KAMMARPALLY', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977752383', 'ADA Regular BHEEMGAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(496, 'Soma Hareesh Kumar', 'NIZAMABAD', 'BHEEMGAL', 'MORTHAD', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752385', 'ADA Regular BHEEMGAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(497, 'Borrem Raju', 'NIZAMABAD', 'BHEEMGAL', 'VAILPOOR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752405', 'ADA Regular BHEEMGAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(498, 'K Santosh', 'NIZAMABAD', 'BODHAN', 'BODHAN', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752407', 'ADA Regular BODHAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(499, 'Sirigadha Naveen Kumar', 'NIZAMABAD', 'BODHAN', 'NAVIPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752408', 'ADA Regular BODHAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(500, 'Rachawar Sidrameshwar', 'NIZAMABAD', 'BODHAN', 'RENJAL', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977752422', 'ADA Regular BODHAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(501, 'Kethavath Swetha', 'NIZAMABAD', 'BODHAN', 'Saloora', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752410', 'ADA Regular BODHAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(502, 'Rachawar Sidrameshwar', 'NIZAMABAD', 'BODHAN', 'YEDAPALLY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752422', 'ADA Regular BODHAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(503, 'Jadi Venkatesh', 'NIZAMABAD', 'INDALWAI', 'DHARPALLY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752423', 'ADA Regular NIZAMABAD RURAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(504, 'Boddu Srikanth', 'NIZAMABAD', 'INDALWAI', 'INDALWAI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752445', 'ADA Regular NIZAMABAD RURAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(505, 'Talari Narsaiah', 'NIZAMABAD', 'INDALWAI', 'SIRKONDA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752449', 'ADA Regular NIZAMABAD RURAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(506, 'Marampally Anjaneyulu', 'NIZAMABAD', 'NIZAMABAD RURAL', 'DICHPALLY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752425', 'ADA Regular NIZAMABAD RURAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(507, 'Kola Devika', 'NIZAMABAD', 'NIZAMABAD RURAL', 'JAKRANPALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752446', 'ADA Regular NIZAMABAD RURAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(508, 'Jadav Heera', 'NIZAMABAD', 'NIZAMABAD RURAL', 'MUGPAL', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977752448', 'ADA Regular NIZAMABAD RURAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(509, 'Jadav Heera', 'NIZAMABAD', 'NIZAMABAD RURAL', 'NIZAMABAD RURAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752448', 'ADA Regular NIZAMABAD RURAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(510, 'Sandula Mahender', 'NIZAMABAD', 'NIZAMABAD SOUTH', 'NIZAMABAD NORTH', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977752450', 'ADA Regular NIZAMABAD URBAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(511, 'Sandula Mahender', 'NIZAMABAD', 'NIZAMABAD SOUTH', 'NIZAMABAD SOUTH', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977752450', 'ADA Regular NIZAMABAD URBAN\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(512, 'Ampelli Kiran', 'NIZAMABAD', 'RUDRUR', 'Chandur', 'AO', 'Regular', 'Agriculture Officer', NULL, '9014963016', 'DAO Office NIZAMABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(513, 'Thonduru Raju', 'NIZAMABAD', 'RUDRUR', 'KOTAGIRI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752547', 'DAO Office NIZAMABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(514, 'Banoth Venkatesh', 'NIZAMABAD', 'RUDRUR', 'Mosra', 'AO', 'Regular', 'Agriculture Officer', NULL, '9550600249', 'DAO Office NIZAMABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(515, 'Balapuram Nishitha', 'NIZAMABAD', 'RUDRUR', 'Pothangal', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752548', 'DAO Office NIZAMABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(516, 'Gangone Saikrishna', 'NIZAMABAD', 'RUDRUR', 'RUDRUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752549', 'DAO Office NIZAMABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(517, 'Muthyala Raja Shekar', 'NIZAMABAD', 'RUDRUR', 'VARNI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752550', 'DAO Office NIZAMABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(518, 'Bathina Srinivas', 'PEDDAPALLI', NULL, NULL, 'DAO', 'Regular', 'Deputy Director of Agriculture', NULL, '8977752780', 'DAO Office PEDDAPALLI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(519, 'Narasimhulu Anjani', 'PEDDAPALLI', 'MANTHANI', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977752806', 'ADA Regular MANTHANI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(520, 'Madikonda Srinadh', 'PEDDAPALLI', 'PEDDAPALLE', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977752820', 'ADA Regular PEDDAPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(521, 'Madikonda Srinadh', 'PEDDAPALLI', 'RAMAGUNDAM', NULL, 'ADA', 'Incharge', 'Assistant Director of Agriculture', NULL, '8977752820', 'ADA Regular PEDDAPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(522, 'Giri Ramakrishna', 'PEDDAPALLI', 'MANTHANI', 'KAMANPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752821', 'ADA Regular MANTHANI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(523, 'Dasari Navya', 'PEDDAPALLI', 'MANTHANI', 'MANTHANI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752822', 'ADA Regular MANTHANI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(524, 'Jinka Anusha', 'PEDDAPALLI', 'MANTHANI', 'MUTHARAM MANTHANI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752823', 'ADA Regular MANTHANI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(525, 'Chindam Srikanth', 'PEDDAPALLI', 'MANTHANI', 'RAMAGIRI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752824', 'ADA Regular MANTHANI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(526, 'Merugu Umapathi', 'PEDDAPALLI', 'PEDDAPALLE', 'ELIGAID', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752829', 'ADA Regular PEDDAPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(527, 'Tamba Prathyusha', 'PEDDAPALLI', 'PEDDAPALLE', 'JULAPALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752830', 'ADA Regular PEDDAPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(528, 'Birru Bhasker', 'PEDDAPALLI', 'PEDDAPALLE', 'ODELA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752831', 'ADA Regular PEDDAPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(529, 'Kanthala Aliveni', 'PEDDAPALLI', 'PEDDAPALLE', 'PEDDAPALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752839', 'ADA Regular PEDDAPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(530, 'Dammala Nagarjuna', 'PEDDAPALLI', 'PEDDAPALLE', 'SRIRAMPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752856', 'ADA Regular PEDDAPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(531, 'Dammala Nagarjuna', 'PEDDAPALLI', 'PEDDAPALLE', 'SULTANABAD', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977752880', 'ADA Regular PEDDAPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(532, 'Kaluvala Sathish', 'PEDDAPALLI', 'RAMAGUNDAM', 'ANTHERGAON', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752825', 'ADA Regular PEDDAPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(533, 'Birru Bhasker', 'PEDDAPALLI', 'RAMAGUNDAM', 'DHARMARAM', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977752827', 'ADA Regular PEDDAPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(534, 'Bandi Pramod Kumar', 'PEDDAPALLI', 'RAMAGUNDAM', 'PALAKURTHY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752838', 'ADA Regular PEDDAPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(535, 'Koppula Prakash', 'PEDDAPALLI', 'RAMAGUNDAM', 'RAMAGUNDAM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977752840', 'ADA Regular PEDDAPALLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(536, 'Smt Afzal Begum', 'RAJANNA SIRCILLA', NULL, NULL, 'DAO', 'FAC', 'Assistant Director of Agriculture', NULL, '8977755264', 'DAO Office RAJANNA SIRCILLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(537, 'Smt Afzal Begum', 'RAJANNA SIRCILLA', 'SIRSILLA', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977755278', 'ADA Regular SIRSILLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(538, 'Thutuku Srinivasa Rao', 'RAJANNA SIRCILLA', 'VEMULAWADA', NULL, 'ADA', 'On Deputation', 'Assistant Director of Agriculture', NULL, '8977755279', 'ADA Regular VEMULAWADA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(539, 'Mohammad Salauddin', 'RAJANNA SIRCILLA', 'SIRSILLA', 'GAMBHIRAOPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755283', 'ADA Regular SIRSILLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(540, 'Medulla Suresh Reddy', 'RAJANNA SIRCILLA', 'SIRSILLA', 'ILLANTHAKUNTA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755284', 'ADA Regular SIRSILLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(541, 'Kasthuri Anusha', 'RAJANNA SIRCILLA', 'SIRSILLA', 'MUSTABAD', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755285', 'ADA Regular SIRSILLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(542, 'Kasu Sandeep', 'RAJANNA SIRCILLA', 'SIRSILLA', 'SIRSILLA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755286', 'ADA Regular SIRSILLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(543, 'Kanaveni Sanjeev', 'RAJANNA SIRCILLA', 'SIRSILLA', 'THANGALLAPALLI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755287', 'ADA Regular SIRSILLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(544, 'Kothapelly Jaya', 'RAJANNA SIRCILLA', 'SIRSILLA', 'VEERNAPALLI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755358', 'ADA Regular SIRSILLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(545, 'Kasam Rajashekar', 'RAJANNA SIRCILLA', 'SIRSILLA', 'YELLA REDDI PETA', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977755359', 'ADA Regular SIRSILLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(546, 'Kasireddy Pranitha', 'RAJANNA SIRCILLA', 'VEMULAWADA', 'BOINPALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755360', 'ADA Regular VEMULAWADA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(547, 'Chelpuri Durgaraju', 'RAJANNA SIRCILLA', 'VEMULAWADA', 'CHANDURTHI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755361', 'ADA Regular VEMULAWADA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(548, 'Palakurthy Sandeep', 'RAJANNA SIRCILLA', 'VEMULAWADA', 'KONARAOPETA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755362', 'ADA Regular VEMULAWADA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(549, 'Marka Priyadarshini', 'RAJANNA SIRCILLA', 'VEMULAWADA', 'RUDRANGI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755363', 'ADA Regular VEMULAWADA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(550, 'Ganji Sai Kiran', 'RAJANNA SIRCILLA', 'VEMULAWADA', 'VEMULAWADA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755370', 'ADA Regular VEMULAWADA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(551, 'Vancha Vineetha', 'RAJANNA SIRCILLA', 'VEMULAWADA', 'VEMULAWADA RURAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755371', 'ADA Regular VEMULAWADA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(552, 'Dayala Usha', 'RANGAREDDY', NULL, NULL, 'DAO', 'Regular', 'Joint Director of Agriculture', NULL, '8977753329', 'DAO Office RANGAREDDY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(553, 'Kandala Shobha Rani', 'RANGAREDDY', 'AMANGAL', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977753524', 'ADA Regular AMANGAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(554, 'Bhyrava Josyula Suresh Babu', 'RANGAREDDY', 'CHEVELLA', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977753559', 'ADA Regular CHEVELLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(555, 'Muthadi Sujatha', 'RANGAREDDY', 'IBRAHIMPATNAM', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977753707', 'ADA Regular IBRAHIMPATNAM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(556, 'Mareboina Sudha Rani', 'RANGAREDDY', 'MAHESHWARAM', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977753833', 'ADA Regular MAHESHWARAM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(557, 'Narra Kavitha', 'RANGAREDDY', 'RAJENDRANAGAR', NULL, 'ADA', 'FAC', 'Agriculture Officer', NULL, '8977753840', 'ADA Regular RAJENDRANAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(558, 'D Ramadevi', 'RANGAREDDY', 'SHADNAGAR', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977753901', 'ADA Regular SHADNAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(559, 'Peddi Srinivas Goud', 'RANGAREDDY', 'AMANGAL', 'AMANGAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977753540', 'ADA Regular AMANGAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(560, 'P Kavitha', 'RANGAREDDY', 'AMANGAL', 'KADTHAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977753551', 'ADA Regular AMANGAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(561, 'D Aruna Kumari', 'RANGAREDDY', 'AMANGAL', 'MADGUL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977753552', 'ADA Regular AMANGAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(562, 'Vadde Renuka Chakravarthini', 'RANGAREDDY', 'AMANGAL', 'TALAKONDAPALLY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977753558', 'ADA Regular AMANGAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(563, 'Sabavath Shankarlal', 'RANGAREDDY', 'CHEVELLA', 'CHEVELLA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977753561', 'ADA Regular CHEVELLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(564, 'Patlolla Anuradha', 'RANGAREDDY', 'CHEVELLA', 'MOINABAD', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977753562', 'ADA Regular CHEVELLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(565, 'Dandem Vijayachandra', 'RANGAREDDY', 'CHEVELLA', 'SHABAD', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977753590', 'ADA Regular CHEVELLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(566, 'Chanti Chaitanya', 'RANGAREDDY', 'CHEVELLA', 'SHANKARPALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977753589', 'ADA Regular CHEVELLA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(567, 'Inupanuri Pallavi', 'RANGAREDDY', 'IBRAHIMPATNAM', 'ABDULLAPURMET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977753709', 'ADA Regular IBRAHIMPATNAM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(568, 'B Solman Nayak Rathod', 'RANGAREDDY', 'IBRAHIMPATNAM', 'HAYATHNAGAR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977753719', 'ADA Regular IBRAHIMPATNAM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(569, 'Madduri Vidyadhari', 'RANGAREDDY', 'IBRAHIMPATNAM', 'IBRAHIMPATNAM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977753720', 'ADA Regular IBRAHIMPATNAM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(570, 'A Srilatha', 'RANGAREDDY', 'IBRAHIMPATNAM', 'MANCHAL', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977753830', 'ADA Regular IBRAHIMPATNAM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(571, 'R Ravinath', 'RANGAREDDY', 'IBRAHIMPATNAM', 'YACHARAM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977753831', 'ADA Regular IBRAHIMPATNAM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(572, 'A Sakalesh', 'RANGAREDDY', 'MAHESHWARAM', 'BALAPUR', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977753839', 'ADA Regular MAHESHWARAM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(573, 'Yadlapally Lavanya', 'RANGAREDDY', 'MAHESHWARAM', 'KANDUKUR', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977753836', 'ADA Regular MAHESHWARAM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(574, 'Desu Nagamani', 'RANGAREDDY', 'MAHESHWARAM', 'MAHESHWARAM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977753837', 'ADA Regular MAHESHWARAM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(575, 'A Sakalesh', 'RANGAREDDY', 'MAHESHWARAM', 'SAROORNAGAR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977753839', 'ADA Regular MAHESHWARAM\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(576, 'Narra Kavitha', 'RANGAREDDY', 'RAJENDRANAGAR', 'GANDIPET', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977753887', 'ADA Regular RAJENDRANAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(577, 'Narra Kavitha', 'RANGAREDDY', 'RAJENDRANAGAR', 'RAJENDRANAGAR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977753887', 'ADA Regular RAJENDRANAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(578, 'Narra Kavitha', 'RANGAREDDY', 'RAJENDRANAGAR', 'SERILINGAMPALLE', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977753887', 'ADA Regular RAJENDRANAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(579, 'Racha Shvetha', 'RANGAREDDY', 'RAJENDRANAGAR', 'SHAMSHABAD', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977753890', 'ADA Regular RAJENDRANAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(580, 'Nishanth Kumar Nishanth Kumar', 'RANGAREDDY', 'SHADNAGAR', 'FAROOQNAGAR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977753903', 'ADA Regular SHADNAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(581, 'Aidhalapally Rajender Reddy', 'RANGAREDDY', 'SHADNAGAR', 'JILLED CHOWDERGUDEM', 'AO', 'Regular', 'Agriculture Officer', NULL, '7658990390', 'ADA Regular SHADNAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(582, 'Putta Shirisha', 'RANGAREDDY', 'SHADNAGAR', 'KESHAMPETA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977753923', 'ADA Regular SHADNAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(583, 'Gundreddy Suresh  Reddy', 'RANGAREDDY', 'SHADNAGAR', 'KONDURG', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977753924', 'ADA Regular SHADNAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(584, 'Palthyavath Gopal', 'RANGAREDDY', 'SHADNAGAR', 'KOTHUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977753925', 'ADA Regular SHADNAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(585, 'Pasupuleti Rama Siva Rao', 'RANGAREDDY', 'SHADNAGAR', 'NANDIGAMA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977753926', 'ADA Regular SHADNAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(586, 'Korrapati Siva Prasad', 'SANGAREDDY', NULL, NULL, 'DAO', 'Regular', 'Deputy Director of Agriculture', NULL, '8977754689', 'DAO Office SANGAREDDY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(587, 'Ghanta Ramadevi', 'SANGAREDDY', 'ANDOLE', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977754340', 'ADA Regular ANDOLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(588, 'Kodirekka Nuthan Kumar', 'SANGAREDDY', 'NARAYANKHED', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977754358', 'ADA Regular NARAYANKHED\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(589, 'Nagaram Manohara', 'SANGAREDDY', 'PATANCHERU', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977754457', 'ADA Regular PATANCHERU\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(590, 'Donthula Satyanarayana', 'SANGAREDDY', 'RAIKODE', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977754497', 'ADA Regular RAIKODE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(591, 'Kottakota Venkata Laxmi', 'SANGAREDDY', 'SANGAREDDY', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977754537', 'ADA Regular SANGAREDDY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(592, 'Bingi Bikshapathi', 'SANGAREDDY', 'ZAHIRABAD', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977754553', 'ADA Regular ZAHIRABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(593, 'Hasthavaram Sree Hari', 'SANGAREDDY', 'ANDOLE', 'ANDOLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754342', 'ADA Regular ANDOLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(594, 'Toluchuri Praveena', 'SANGAREDDY', 'ANDOLE', 'Chowtakur', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754344', 'ADA Regular ANDOLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(595, 'Bathula Srinivasa Rao', 'SANGAREDDY', 'ANDOLE', 'HATHNOOR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754356', 'ADA Regular ANDOLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(596, 'Bommu Chaitanya', 'SANGAREDDY', 'ANDOLE', 'PULKAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754357', 'ADA Regular ANDOLE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(597, 'V Venkatesham', 'SANGAREDDY', 'NARAYANKHED', 'KALHER', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754438', 'ADA Regular NARAYANKHED\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(598, 'Vislavath Harish Pawar', 'SANGAREDDY', 'NARAYANKHED', 'KANGTI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754439', 'ADA Regular NARAYANKHED\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(599, 'Korra Mahesh Chowhan', 'SANGAREDDY', 'NARAYANKHED', 'MANOOR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754450', 'ADA Regular NARAYANKHED\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(600, 'Avusala Praveen Chary', 'SANGAREDDY', 'NARAYANKHED', 'NAGALGIDDA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754451', 'ADA Regular NARAYANKHED\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(601, 'Kota Shankar', 'SANGAREDDY', 'NARAYANKHED', 'NARAYANKHED', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754452', 'ADA Regular NARAYANKHED\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(602, 'Smt Asiya Begum', 'SANGAREDDY', 'NARAYANKHED', 'Nizampet', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754453', 'ADA Regular NARAYANKHED\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(603, 'Ganta Harikrishna', 'SANGAREDDY', 'NARAYANKHED', 'SIRGAPOOR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754454', 'ADA Regular NARAYANKHED\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(604, 'Avgk Prasad', 'SANGAREDDY', 'PATANCHERU', 'AMEENPUR', 'AO', 'FAC', 'Agriculture Officer', NULL, '8977754496', 'ADA Regular PATANCHERU\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(605, 'Divvala Srinivasa Rao', 'SANGAREDDY', 'PATANCHERU', 'GUMMADIDALA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754458', 'ADA Regular PATANCHERU\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(606, 'Vanipentala Ravindranath Reddy', 'SANGAREDDY', 'PATANCHERU', 'JINNARAM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754459', 'ADA Regular PATANCHERU\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(607, 'Cheelam Shivakumar', 'SANGAREDDY', 'PATANCHERU', 'PATANCHERU', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754460', 'ADA Regular PATANCHERU\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(608, 'Avgk Prasad', 'SANGAREDDY', 'PATANCHERU', 'RAMACHANDRAPURAM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754496', 'ADA Regular PATANCHERU\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(609, 'Ashannagari Anitha', 'SANGAREDDY', 'RAIKODE', 'MUNIPALLY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754498', 'ADA Regular RAIKODE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(610, 'Middela Sarika', 'SANGAREDDY', 'RAIKODE', 'RAIKODE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754500', 'ADA Regular RAIKODE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(611, 'Kakkerawada Srinivas Reddy', 'SANGAREDDY', 'RAIKODE', 'VATPALLY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754536', 'ADA Regular RAIKODE\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(612, 'Adikam Srinivas', 'SANGAREDDY', 'SANGAREDDY', 'KANDI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754539', 'ADA Regular SANGAREDDY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(613, 'Peddanna Ganesh', 'SANGAREDDY', 'SANGAREDDY', 'KONDAPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754550', 'ADA Regular SANGAREDDY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(614, 'Goshke Ramesh', 'SANGAREDDY', 'SANGAREDDY', 'SADASIVPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754551', 'ADA Regular SANGAREDDY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(615, 'Yerubandi Jhansi Laxmi Bhai', 'SANGAREDDY', 'SANGAREDDY', 'SANGAREDDY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754552', 'ADA Regular SANGAREDDY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(616, 'Mangali Venkateshwar', 'SANGAREDDY', 'ZAHIRABAD', 'JHARASANGAM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754657', 'ADA Regular ZAHIRABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(617, 'Police Naveen Kumar', 'SANGAREDDY', 'ZAHIRABAD', 'KOHIR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754658', 'ADA Regular ZAHIRABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(618, 'Maohammed Hasnuddin', 'SANGAREDDY', 'ZAHIRABAD', 'MOGUDAMPALLY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754659', 'ADA Regular ZAHIRABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(619, 'Narra Abhinash Varma', 'SANGAREDDY', 'ZAHIRABAD', 'NYALKAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754660', 'ADA Regular ZAHIRABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(620, 'Neeradi Lavanya', 'SANGAREDDY', 'ZAHIRABAD', 'ZAHIRABAD', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977754667', 'ADA Regular ZAHIRABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(621, 'Jaidupally Swaroopa Rani', 'SIDDIPET', NULL, NULL, 'DAO', 'Regular', 'Deputy Director of Agriculture', NULL, '8977754775', 'DAO Office SIDDIPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(622, 'Takkolu Radhika', 'SIDDIPET', 'CHERIYAL', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977754908', 'ADA Regular GAJWEL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(623, 'Kampati Mallaiah', 'SIDDIPET', 'DUBBAK', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977754909', 'ADA Regular DUBBAK\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(624, 'Lunavath Babu', 'SIDDIPET', 'GAJWEL', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977754910', 'ADA Regular GAJWEL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(625, 'Kampati Mallaiah', 'SIDDIPET', 'HUSNABAD', NULL, 'ADA', 'Incharge', 'Assistant Director of Agriculture', NULL, '8977754909', 'ADA Regular HUSNABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(626, 'Sangishetty Anilkumar', 'SIDDIPET', 'MULUG', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977755099', 'ADA Regular MULUG\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(627, 'Yerasani Padma', 'SIDDIPET', 'SIDDIPET', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977755100', 'ADA Regular SIDDIPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(628, 'Puli Bhogeshwara Swamy', 'SIDDIPET', 'CHERIYAL', 'CHERIYAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755101', 'ADA Regular HUSNABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(629, 'Mohammed Afroz', 'SIDDIPET', 'CHERIYAL', 'Dhoolmitta', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755146', 'ADA Regular GAJWEL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(630, 'Kunduru Venkatravamma', 'SIDDIPET', 'CHERIYAL', 'KOMURAVELLI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755145', 'ADA Regular GAJWEL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(631, 'Burela Ramakrishna', 'SIDDIPET', 'CHERIYAL', 'MADDUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755144', 'ADA Regular HUSNABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(632, 'Bathini Sathyanvesh', 'SIDDIPET', 'DUBBAK', 'Akbarpet-Bhoompally', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755179', 'ADA Regular DUBBAK\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(633, 'Jadhav Saikiran', 'SIDDIPET', 'DUBBAK', 'DOULTABAD', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755150', 'ADA Regular DUBBAK\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(634, 'Mamindla Praveen Kumar', 'SIDDIPET', 'DUBBAK', 'DUBBAK', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755147', 'ADA Regular DUBBAK\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(635, 'Bonala Mallesham', 'SIDDIPET', 'DUBBAK', 'MIRDODDI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755148', 'ADA Regular DUBBAK\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(636, 'Sirigadi Mohan', 'SIDDIPET', 'DUBBAK', 'THOGUTA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755149', 'ADA Regular DUBBAK\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(637, 'Gundu Nagaraju', 'SIDDIPET', 'GAJWEL', 'GAJWEL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755197', 'ADA Regular GAJWEL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(638, 'Gudikandula Shivaramakrishna', 'SIDDIPET', 'GAJWEL', 'KONDAPAK', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755198', 'ADA Regular GAJWEL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(639, 'Gangishetty Govindaraju', 'SIDDIPET', 'GAJWEL', 'Kukunoorpally', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755200', 'ADA Regular GAJWEL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(640, 'Rasala Naresha', 'SIDDIPET', 'GAJWEL', 'RAIPOLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755199', 'ADA Regular GAJWEL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(641, 'Tasleema Sultana', 'SIDDIPET', 'HUSNABAD', 'AKKANNAPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755215', 'ADA Regular HUSNABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(642, 'Banda Santhosh', 'SIDDIPET', 'HUSNABAD', 'BEJJANKI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755216', 'ADA Regular HUSNABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(643, 'Kothagattu Shreya', 'SIDDIPET', 'HUSNABAD', 'HUSNABAD', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977755202', 'ADA Regular HUSNABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(644, 'Navath Satish', 'SIDDIPET', 'HUSNABAD', 'KOHEDA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755217', 'ADA Regular HUSNABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(645, 'Uppala Vasantha Rao', 'SIDDIPET', 'MULUG', 'JAGDEVPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755243', 'ADA Regular MULUG\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(647, 'Goli Pragathi', 'SIDDIPET', 'MULUG', 'MULUG', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755242', 'ADA Regular MULUG\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(648, 'Srirangam Seshasayana', 'SIDDIPET', 'MULUG', 'WARGAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755244', 'ADA Regular MULUG\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(649, 'Aila Jayanth Kumar', 'SIDDIPET', 'SIDDIPET', 'CHINNAKODUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755261', 'ADA Regular SIDDIPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(650, 'Vadlakonda Geetha', 'SIDDIPET', 'SIDDIPET', 'NANGANOOR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755262', 'ADA Regular SIDDIPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(651, 'Bathula Parshuram', 'SIDDIPET', 'SIDDIPET', 'Narayanraopet', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755263', 'ADA Regular SIDDIPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(652, 'Boddhula Srinath', 'SIDDIPET', 'SIDDIPET', 'SIDDIPET (URBAN)', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755249', 'ADA Regular SIDDIPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(653, 'Marupaka Naresh', 'SIDDIPET', 'SIDDIPET', 'SIDDIPET RURAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755248', 'ADA Regular SIDDIPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(654, 'Gogula Sridhar Reddy', 'SURYAPET', NULL, NULL, 'DAO', 'FAC', 'Assistant Director of Agriculture', NULL, '8977755833', 'DAO Office SURYAPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(655, 'Ramavath Ravi', 'SURYAPET', 'HUZURNAGAR', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977755631', 'ADA Regular HUZURNAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(656, 'Peddakotla Prasanthi', 'SURYAPET', 'KODAD', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977755710', 'ADA Regular KODAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(657, 'Gogula Sridhar Reddy', 'SURYAPET', 'SURYAPET', NULL, 'ADA', 'FAC', 'Assistant Director of Agriculture', NULL, '8977755781', 'DAO Office SURYAPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(658, 'Lakshimalla Ramesh Babu', 'SURYAPET', 'THUNGATHURTHY', NULL, 'ADA', 'On Deputation', 'Assistant Director of Agriculture', NULL, '8977755831', 'ADA Regular THUNGATHURTHY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(659, 'Dara Shashank', 'SURYAPET', 'HUZURNAGAR', 'CHINTHALAPALEM (MALLAREDDYGUDEM)', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755632', 'ADA Regular HUZURNAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(660, 'Damalla Priyatham Kumar', 'SURYAPET', 'HUZURNAGAR', 'GARIDE PALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755633', 'ADA Regular HUZURNAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(661, 'Rairala Swarna', 'SURYAPET', 'HUZURNAGAR', 'HUZURNAGAR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755686', 'ADA Regular HUZURNAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(662, 'Bolishetty Srinivas', 'SURYAPET', 'HUZURNAGAR', 'MATTAMPALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755687', 'ADA Regular HUZURNAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(663, 'Jatothu Padma', 'SURYAPET', 'HUZURNAGAR', 'MELLACHERUVU', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755707', 'ADA Regular HUZURNAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(664, 'Shaik Javed', 'SURYAPET', 'HUZURNAGAR', 'NEREDUCHERLA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755708', 'ADA Regular HUZURNAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(665, 'Bollepaka Kalyan Chakravarthy', 'SURYAPET', 'HUZURNAGAR', 'PALAKEEDU', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755709', 'ADA Regular HUZURNAGAR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(666, 'Ande Sathish', 'SURYAPET', 'KODAD', 'ANANTHAGIRI', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977755712', 'ADA Regular KODAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(667, 'Zagabathuni Sreedhar', 'SURYAPET', 'KODAD', 'CHILKUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755713', 'ADA Regular KODAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(668, 'Palem Rajani', 'SURYAPET', 'KODAD', 'KODAD', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755742', 'ADA Regular KODAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(669, 'Anireddy Aruna', 'SURYAPET', 'KODAD', 'MOTHEY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755743', 'ADA Regular KODAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(670, 'Bunga Raju', 'SURYAPET', 'KODAD', 'MUNAGALA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755744', 'ADA Regular KODAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(671, 'Rayapu Deva Prasad', 'SURYAPET', 'KODAD', 'NADIGUDEM', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977755780', 'ADA Regular KODAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(672, 'Danthala Divya', 'SURYAPET', 'SURYAPET', 'ATHMAKUR (S)', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755783', 'ADA Regular SURYAPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(673, 'Dharavath Venkateswarlu', 'SURYAPET', 'SURYAPET', 'CHIVVEMLA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755790', 'ADA Regular SURYAPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(674, 'Banothu Anil Kumar', 'SURYAPET', 'SURYAPET', 'PENPAHAD', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755829', 'ADA Regular SURYAPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(675, 'Barmavath Krishna Sandeep', 'SURYAPET', 'SURYAPET', 'SURYAPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755830', 'ADA Regular SURYAPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(676, 'Pendota Ganesh', 'SURYAPET', 'THUNGATHURTHY', 'JAJIREDDY GUDEM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755373', 'ADA Regular THUNGATHURTHY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(677, 'Shaik Anisa Roohi', 'SURYAPET', 'THUNGATHURTHY', 'MADDIRALA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755844', 'ADA Regular THUNGATHURTHY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(678, 'Pandula Krishnakanth', 'SURYAPET', 'THUNGATHURTHY', 'NAGARAM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755845', 'ADA Regular THUNGATHURTHY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(679, 'Khammam Malla Reddy', 'SURYAPET', 'THUNGATHURTHY', 'NOOTHANAKAL', 'AO', 'FAC', 'Agriculture Officer', NULL, '8977755846', 'ADA Regular THUNGATHURTHY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(680, 'Chandaluri Nageswara Rao', 'SURYAPET', 'THUNGATHURTHY', 'THIRUMALAGIRI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755847', 'ADA Regular THUNGATHURTHY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(681, 'Lakshimalla Ramesh Babu', 'SURYAPET', 'THUNGATHURTHY', 'THUNGATHURTHY', 'AO', 'FAC', 'Assistant Director of Agriculture', NULL, '8977755848', 'ADA Regular THUNGATHURTHY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(682, 'Thummalapally Rajaratnam', 'VIKARABAD', NULL, NULL, 'DAO', 'Regular', 'Assistant Director of Agriculture', NULL, '8977755890', 'DAO Office VIKARABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(683, 'Kethavath Shankar Rathod', 'VIKARABAD', 'KODANGAL', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977755946', 'ADA Regular KODANGAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(684, 'Dara Soubhagya Laxmi Kumari', 'VIKARABAD', 'PARGI', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977755951', 'ADA Regular PARGI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(685, 'Banda Komuraiah', 'VIKARABAD', 'TANDUR', NULL, 'ADA', 'FAC', 'Agriculture Officer', NULL, '8977755981', 'ADA Regular TANDUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(686, 'Bolla Venkatesham', 'VIKARABAD', 'VIKARABAD', NULL, 'ADA', 'Regular', 'Agriculture Officer', NULL, '8977756005', 'ADA Regular VIKARABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(687, 'Kistapuran Polappa', 'VIKARABAD', 'KODANGAL', 'BOMRASPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8919663181', 'ADA Regular KODANGAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(688, 'Peddinti Lavanya', 'VIKARABAD', 'KODANGAL', 'DOULATABAD', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755948', 'ADA Regular KODANGAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(689, 'Sadula Nagaraju', 'VIKARABAD', 'KODANGAL', 'Dudyal', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755949', 'ADA Regular KODANGAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(690, 'G Tulasi', 'VIKARABAD', 'KODANGAL', 'KODANGAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755950', 'ADA Regular KODANGAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(691, 'Golla Parimala', 'VIKARABAD', 'PARGI', 'Chowdapur', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755961', 'ADA Regular PARGI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(692, 'Ravipati Prabhakar', 'VIKARABAD', 'PARGI', 'DOMA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755962', 'ADA Regular PARGI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(693, 'Juttiga Veera Swamy', 'VIKARABAD', 'PARGI', 'KULKACHARLA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755963', 'ADA Regular PARGI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(694, 'Begari Rajitha', 'VIKARABAD', 'PARGI', 'PARGI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755979', 'ADA Regular PARGI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(695, 'Mundai Tulasi Ram', 'VIKARABAD', 'PARGI', 'PUDUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755980', 'ADA Regular PARGI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(696, 'Neethirajan Anitha', 'VIKARABAD', 'TANDUR', 'BASHEERABAD', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977755983', 'ADA Regular TANDUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(697, 'Padmati Pavan Preetham', 'VIKARABAD', 'TANDUR', 'PEDDEMUL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756002', 'ADA Regular TANDUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(698, 'Banda Komuraiah', 'VIKARABAD', 'TANDUR', 'TANDUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756003', 'ADA Regular TANDUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(699, 'Aligya Shwetha Rani', 'VIKARABAD', 'TANDUR', 'YELAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756004', 'ADA Regular TANDUR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(700, 'Peddini Sravya', 'VIKARABAD', 'VIKARABAD', 'BANTWARAM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756037', 'ADA Regular VIKARABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(701, 'Mannela Surya Prakash', 'VIKARABAD', 'VIKARABAD', 'DHARUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756038', 'ADA Regular VIKARABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(702, 'Chenvalli Karnakar Reddy', 'VIKARABAD', 'VIKARABAD', 'KOTEPALLY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756051', 'ADA Regular VIKARABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(703, 'Kummari Srikanth', 'VIKARABAD', 'VIKARABAD', 'MARPALLE', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756058', 'ADA Regular VIKARABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(704, 'Bhupati Jaya Sankar', 'VIKARABAD', 'VIKARABAD', 'MOMINPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756059', 'ADA Regular VIKARABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(705, 'Marampudi Jyothi', 'VIKARABAD', 'VIKARABAD', 'NAWABPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756072', 'ADA Regular VIKARABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11');
INSERT INTO `dao` (`id`, `employee_name`, `district_name`, `division_name`, `mandal_name`, `cadre`, `regular_incharge`, `present_cadre`, `email`, `office_mobile_no`, `present_office`, `status`, `created_at`, `updated_at`) VALUES
(706, 'Golkonda Prasanna Laxmi', 'VIKARABAD', 'VIKARABAD', 'VIKARABAD', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756073', 'ADA Regular VIKARABAD\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(707, 'Puppala Anjaneyulu Goud', 'WANAPARTHY', NULL, NULL, 'DAO', 'Regular', 'Deputy Director of Agriculture', NULL, '8977756108', 'DAO Office WANAPARTHY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(708, 'Kakkarla Damodhar', 'WANAPARTHY', 'KOTHAKOTA', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977756116', 'ADA Regular Kothakota\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(709, 'Sugali Thippeswamy', 'WANAPARTHY', 'PANGAL', NULL, 'ADA', 'Regular', 'Agriculture Officer', NULL, '8977756139', 'ADA Regular PANGAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(710, 'Bowinpally Prabhakar Reddy', 'WANAPARTHY', 'WANAPARTHY', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977756140', 'ADA Regular WANAPARTHY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(711, 'Aravindu Aravindu', 'WANAPARTHY', 'KOTHAKOTA', 'AMARCHINTHA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756168', 'ADA Regular Kothakota\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(712, 'Owk Vinay Kumar', 'WANAPARTHY', 'KOTHAKOTA', 'ATMAKUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756169', 'ADA Regular Kothakota\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(713, 'C Jasmine', 'WANAPARTHY', 'KOTHAKOTA', 'KOTHAKOTA', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977756170', 'ADA Regular Kothakota\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(714, 'R Gayathri Goud', 'WANAPARTHY', 'KOTHAKOTA', 'MADANAPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756192', 'ADA Regular Kothakota\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(715, 'Mandem Muralidhar', 'WANAPARTHY', 'PANGAL', 'CHINNAMBAVI', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977756193', 'ADA Regular PANGAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(716, 'Anantha Dhakeshwer Goud', 'WANAPARTHY', 'PANGAL', 'PANGAL', 'AO', 'Incharge', 'Agriculture Officer', NULL, '8977756194', 'ADA Regular PANGAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(717, 'Anantha Dhakeshwer Goud', 'WANAPARTHY', 'PANGAL', 'WEEPANAGANDLA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756195', 'ADA Regular PANGAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(718, 'Madhugani Mallaiah', 'WANAPARTHY', 'WANAPARTHY', 'GHANPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756196', 'ADA Regular WANAPARTHY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(719, 'Kurva Karunasri', 'WANAPARTHY', 'WANAPARTHY', 'GOPALPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756200', 'ATMA  WANAPARTHY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(720, 'Shaik Munna', 'WANAPARTHY', 'WANAPARTHY', 'PEBBAIR', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977756206', 'ADA Regular WANAPARTHY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(721, 'Beesam Saidulu', 'WANAPARTHY', 'WANAPARTHY', 'PEDDAMANDADI', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977756209', 'ADA Regular WANAPARTHY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(722, 'P Vineeth Sagar', 'WANAPARTHY', 'WANAPARTHY', 'REVALLY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756210', 'ADA Regular WANAPARTHY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(723, 'Mekala Hymavathi', 'WANAPARTHY', 'WANAPARTHY', 'SRIRANGAPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756211', 'ADA Regular WANAPARTHY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(724, 'Jeripeti Kurmaiah', 'WANAPARTHY', 'WANAPARTHY', 'WANAPARTHY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756212', 'ADA Regular WANAPARTHY\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(726, 'Kunumalla Anuradha', 'WARANGAL', NULL, NULL, 'DAO', 'Regular', 'Deputy Director of Agriculture', NULL, '8977756214', 'DAO Office WARANGAL RURAL\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(727, 'Kethidi Damodar Reddy', 'WARANGAL', 'NARSAMPET', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977756239', 'ADA Regular NARSAMPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(728, 'Gajjela Narsingam', 'WARANGAL', 'WARDHANNAPET', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977756275', 'ADA Regular WARDHANNAPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(729, 'Chittireddy Gopalreddy', 'WARANGAL', 'NARSAMPET', 'CHENNARAOPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756242', 'ADA Regular NARSAMPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(730, 'Banoth Madhavi', 'WARANGAL', 'NARSAMPET', 'DUGGONDI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756243', 'ADA Regular NARSAMPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(731, 'Boga Srinivas', 'WARANGAL', 'NARSAMPET', 'KHANAPUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756244', 'ADA Regular NARSAMPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(732, 'Banna Rajitha', 'WARANGAL', 'NARSAMPET', 'NALLABELLY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756273', 'ADA Regular NARSAMPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(733, 'Thallapalli Krishna Kumar', 'WARANGAL', 'NARSAMPET', 'NARSAMPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756241', 'ADA Regular NARSAMPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(734, 'Aggidi Nagaraju', 'WARANGAL', 'NARSAMPET', 'NEKKONDA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756274', 'ADA Regular NARSAMPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(735, 'Pottabathini Hariprasad Babu', 'WARANGAL', 'WARDHANNAPET', 'GEESUGONDA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756278', 'ADA Regular WARDHANNAPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(736, 'Guguloth Vignan', 'WARANGAL', 'WARDHANNAPET', 'KHILA WARANGAL', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '9492782879', 'ADA Regular WARDHANNAPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(737, 'Tirunagari Venkata Ranganayaka Rajinikanth Prashanth Kumar', 'WARANGAL', 'WARDHANNAPET', 'PARVATHAGIRI', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756279', 'ADA Regular WARDHANNAPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(738, 'Gummadi Veerabhadram', 'WARANGAL', 'WARDHANNAPET', 'RAIPARTHY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756280', 'ADA Regular WARDHANNAPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(739, 'Nagul Jyotsna Bhavani', 'WARANGAL', 'WARDHANNAPET', 'SANGEM', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977756334', 'ADA Regular WARDHANNAPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(740, 'Nelakurthy Ravinder', 'WARANGAL', 'WARDHANNAPET', 'WARANGAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756335', 'ADA Regular WARDHANNAPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(741, 'Pilli Vijay Kumar', 'WARANGAL', 'WARDHANNAPET', 'WARDHANNAPET', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756277', 'ADA Regular WARDHANNAPET\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(742, 'Punyala Venkata Ramana Reddy', 'YADADRI BHUVANAGIRI', NULL, NULL, 'DAO', 'Regular', 'Deputy Director of Agriculture', NULL, '8977756419', 'DAO Office YADADRI BHUVANAGIRI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(743, 'Sudagani Srinivas', 'YADADRI BHUVANAGIRI', 'ALAIR', NULL, 'ADA', 'FAC', 'Agriculture Officer', NULL, '8977756438', 'ADA Regular ALAIR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(744, 'Bantu Venkateswara Rao', 'YADADRI BHUVANAGIRI', 'BHONGIR', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977756451', 'ADA Regular BHONGIR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(745, 'Vadhri Shanti Nirmala', 'YADADRI BHUVANAGIRI', 'YADAGIRIGUTTA', NULL, 'ADA', 'Regular', 'Assistant Director of Agriculture', NULL, '8977756925', 'ADA Regular YADAGIRIGUTTA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(746, 'Pulimamidi Pandu Ranga Chary', 'YADADRI BHUVANAGIRI', 'ALAIR', 'ADDAGUDUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756440', 'ADA Regular ALAIR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(747, 'Sudagani Srinivas', 'YADADRI BHUVANAGIRI', 'ALAIR', 'ALAIR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756441', 'ADA Regular ALAIR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(748, 'Bochu Pooja', 'YADADRI BHUVANAGIRI', 'ALAIR', 'ATHMAKUR(M)', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756442', 'ADA Regular ALAIR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(749, 'Sathupati Srinivasulu', 'YADADRI BHUVANAGIRI', 'ALAIR', 'GUNDALA', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977756443', 'ADA Regular ALAIR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(750, 'Vaddemanu Keerthi', 'YADADRI BHUVANAGIRI', 'ALAIR', 'MOTHKUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756450', 'ADA Regular ALAIR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(751, 'Annapureddy Shailaja', 'YADADRI BHUVANAGIRI', 'BHONGIR', 'B.POCHAMPALLY', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977756915', 'ADA Regular BHONGIR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(752, 'Dende Mallesh', 'YADADRI BHUVANAGIRI', 'BHONGIR', 'BHONGIR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756454', 'ADA Regular BHONGIR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(753, 'Chilakaraju Padma', 'YADADRI BHUVANAGIRI', 'BHONGIR', 'BIBINAGAR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756455', 'ADA Regular BHONGIR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(754, 'Muthyala Nagaraju', 'YADADRI BHUVANAGIRI', 'BHONGIR', 'CHOUTUPPAL', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756916', 'DAO Office YADADRI BHUVANAGIRI\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(755, 'K Varshitha', 'YADADRI BHUVANAGIRI', 'BHONGIR', 'NARAYANAPOOR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756917', 'ADA Regular BHONGIR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(756, 'Mohammad Ajaz Ali Khan', 'YADADRI BHUVANAGIRI', 'BHONGIR', 'RAMANNAPETA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756918', 'ADA Regular BHONGIR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(757, 'Bandi Anjani Devi', 'YADADRI BHUVANAGIRI', 'BHONGIR', 'VALIGONDA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756924', 'ADA Regular BHONGIR\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(758, 'Namini Durgeshwari', 'YADADRI BHUVANAGIRI', 'YADAGIRIGUTTA', 'BOMMALARAMARAM', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756988', 'ADA Regular YADAGIRIGUTTA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(759, 'Marajoth Ramadevi', 'YADADRI BHUVANAGIRI', 'YADAGIRIGUTTA', 'MOTAKONDUR', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756989', 'ADA Regular YADAGIRIGUTTA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(760, 'Gollapally Padmaja', 'YADADRI BHUVANAGIRI', 'YADAGIRIGUTTA', 'RAJAPET', 'AO', 'On Deputation', 'Agriculture Officer', NULL, '8977756990', 'ADA Regular YADAGIRIGUTTA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(761, 'K Sri Uma', 'YADADRI BHUVANAGIRI', 'YADAGIRIGUTTA', 'THURKAPALLY', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756991', 'ADA Regular YADAGIRIGUTTA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11'),
(762, 'Indrakanti Sudharani', 'YADADRI BHUVANAGIRI', 'YADAGIRIGUTTA', 'YADAGIRIGUTTA', 'AO', 'Regular', 'Agriculture Officer', NULL, '8977756993', 'ADA Regular YADAGIRIGUTTA\r', 'active', '2026-01-28 08:09:11', '2026-01-28 08:09:11');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`, `created_at`) VALUES
(52, 'Director of Agriculture', '2026-02-04 12:35:06'),
(53, 'Director of Horticulture', '2026-02-04 12:35:06'),
(54, 'Director of Agril. Marketing', '2026-02-04 12:35:06'),
(55, 'Director of Cooperation & RCS', '2026-02-04 12:35:06'),
(56, 'TG Cooperative Marketing Federation (TG MARKFED)', '2026-02-04 12:35:06'),
(57, 'Telangana Rythu Bandhu Samithi', '2026-02-04 12:35:06'),
(58, 'Telangana State Seed & Organic Certification Authority (TG SOCA)', '2026-02-04 12:35:06'),
(59, 'State Agro-Industries Development Corporation (AGROS)', '2026-02-04 12:35:06'),
(60, 'TG Cooperative Oil Seeds Growers Federation Ltd (TG OILFED)', '2026-02-04 12:35:06'),
(61, 'Telangana State Horticulture Development Corporation Ltd (TG SHDCL)', '2026-02-04 12:35:06'),
(62, 'Telangana State Warehousing Corporation (TG WHC)', '2026-02-04 12:35:06'),
(63, 'The Hyderabad Agricultural Co-operative Association (HACA)', '2026-02-04 12:35:06'),
(64, 'AgHub Foundation', '2026-02-04 12:35:06'),
(65, 'Telangana State Co-operative Rural Irrigation Corporation Ltd (TG CRIC)', '2026-02-04 12:35:06'),
(66, 'Telangana Co-operative Union', '2026-02-04 12:35:06'),
(67, 'Telangana State Co-operative Housing Federation', '2026-02-04 12:35:06'),
(68, 'Professor Jayashankar Telangana Agricultural University', '2026-02-04 12:35:06'),
(83, 'TG Seeds Development Corporation Ltd (TG SSDC)', '2026-02-04 12:41:32'),
(84, 'Sri Konda Laxman Telangana Horticultural University', '2026-02-04 12:41:32');

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
-- Table structure for table `file_deletion_logs`
--

CREATE TABLE `file_deletion_logs` (
  `id` int(11) NOT NULL,
  `file_id` int(11) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `hod_id` int(11) DEFAULT NULL,
  `hod_name` varchar(255) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `upload_type` varchar(50) DEFAULT NULL,
  `deletion_reason` text DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `deleted_by_name` varchar(255) DEFAULT NULL,
  `deleted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `file_deletion_logs`
--

INSERT INTO `file_deletion_logs` (`id`, `file_id`, `file_name`, `hod_id`, `hod_name`, `department`, `upload_type`, `deletion_reason`, `deleted_by`, `deleted_by_name`, `deleted_at`) VALUES
(31, 9, 'BMA Report of Offices Under the Control of Director of Agriculture - 20-01-2026.xlsx', 48, NULL, NULL, 'flagship_program', 'hii', 16, 'Dr. Danda Raji Reddy', '2026-01-30 07:14:45'),
(32, 11, 'Contacts List of All AMCs.xlsx', 48, NULL, NULL, 'report', 'res\n', 16, 'Dr. Danda Raji Reddy', '2026-01-30 07:14:57'),
(33, 14, 'sql.pdf', 48, 'Dr. Danda Raji Reddy', 'Sri Konda Laxman Telangana Horticultural University', 'flagship_program', 'tr', 16, 'Dr. Danda Raji Reddy', '2026-01-30 10:20:35'),
(34, 12, 'sql.pdf', 48, 'Dr. Danda Raji Reddy', 'Sri Konda Laxman Telangana Horticultural University', 'flagship_program', 'wer', 16, 'Dr. Danda Raji Reddy', '2026-01-30 13:37:19'),
(35, 13, 'sql.pdf', 48, 'Dr. Danda Raji Reddy', 'Sri Konda Laxman Telangana Horticultural University', 'report', 'wer', 16, 'Dr. Danda Raji Reddy', '2026-01-30 13:37:24'),
(36, 8, 'BMA Report of Offices Under the Control of Director of Agriculture - 20-01-2026.xlsx', 48, 'Dr. Danda Raji Reddy', 'Sri Konda Laxman Telangana Horticultural University', 'flagship_program', 'swer', 16, 'Dr. Danda Raji Reddy', '2026-01-30 14:52:24');

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
(34, 'BATCH_1768992371225_2hsppbca9', 'revenue.xlsx', NULL, 13, 1, 0, '[\"Sl. No. - 1\",\"Name of the Cooperation & Cooperatives - 2\",\"Loans - 3\",\"Revenue - 4\"]', 'report', 'completed', '[]', 8, '2026-01-21 10:46:11'),
(35, 'BATCH_1769669002882_7uj0sxomt', 'dashboard_export_2025-12-31.xlsx', NULL, 12, 12, 0, '[\"Dashboard Statistics\",\"\"]', 'report', 'completed', '[]', 8, '2026-01-29 06:43:22');

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
  `department` varchar(255) DEFAULT NULL,
  `delete_reason` text DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `department_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hods`
--

INSERT INTO `hods` (`id`, `name`, `department`, `category_id`, `email`, `phone`, `status`, `created_at`, `updated_at`, `department_id`) VALUES
(1, 'Dr. B. Gopi, IAS', 'Director of Agriculture', 1, NULL, '7995555005', 'active', '2026-01-28 12:08:57', '2026-02-04 12:35:06', 52),
(2, 'Yasmeen Basha, IAS', 'Director of Horticulture', 1, NULL, '8977714488', 'active', '2026-01-28 12:08:57', '2026-02-04 12:35:06', 53),
(3, 'K. Surendra Mohan, IAS', 'Director of Agril. Marketing', 1, NULL, '9704666457', 'active', '2026-01-28 12:08:57', '2026-02-04 12:35:06', 54),
(4, 'K. Surendra Mohan, IAS', 'Director of Cooperation & RCS', 1, NULL, '9704666457', 'active', '2026-01-28 12:08:57', '2026-02-04 12:35:06', 55),
(5, 'V. Srinivasa Reddy', 'TG Cooperative Marketing Federation (TG MARKFED)', 2, NULL, '9949992929', 'active', '2026-01-28 12:08:57', '2026-02-04 12:35:06', 56),
(6, 'Dr. B. Gopi, IAS', 'Telangana Rythu Bandhu Samithi', 2, NULL, '7995555005', 'active', '2026-01-28 12:08:57', '2026-02-04 12:35:06', 57),
(7, 'Yasmeen Basha, IAS', 'TG Seeds Development Corporation Ltd (TG SSDC)', 3, NULL, '8977714488', 'active', '2026-01-28 12:08:57', '2026-02-04 12:35:06', 6),
(8, 'Dr. Kiran Kumar', 'Telangana State Seed & Organic Certification Authority (TG SOCA)', 4, NULL, '9440108930', 'active', '2026-01-28 12:08:57', '2026-02-04 12:35:06', 58),
(9, 'K. Ramulu', 'State Agro-Industries Development Corporation (AGROS)', 3, NULL, '8019300573', 'active', '2026-01-28 12:08:57', '2026-02-04 12:35:06', 59),
(10, 'Yasmeen Basha, IAS', 'TG Cooperative Oil Seeds Growers Federation Ltd (TG OILFED)', 2, NULL, '8977714488', 'active', '2026-01-28 12:08:57', '2026-02-04 12:35:06', 60),
(11, 'Yasmeen Basha, IAS', 'Telangana State Horticulture Development Corporation Ltd (TG SHDCL)', 3, NULL, '8977714488', 'active', '2026-01-28 12:08:57', '2026-02-04 12:35:06', 61),
(12, 'Dr. K. Lakshmi, IAS', 'Telangana State Warehousing Corporation (TG WHC)', 3, NULL, '9100022959', 'active', '2026-01-28 12:08:57', '2026-02-04 12:35:06', 62),
(13, 'Chandra Sekhar Reddy, IAS', 'The Hyderabad Agricultural Co-operative Association (HACA)', 2, NULL, '9100590019', 'active', '2026-01-28 12:08:57', '2026-02-04 12:35:06', 63),
(14, 'Dr. G Venkateshwarlu', 'AgHub Foundation', 6, NULL, '9599766313', 'active', '2026-01-28 12:08:57', '2026-02-04 12:35:06', 64),
(15, 'Chandra Sekhar Reddy, IAS', 'Telangana State Co-operative Rural Irrigation Corporation Ltd (TG CRIC)', 2, NULL, '9100590019', 'active', '2026-01-28 12:08:57', '2026-02-04 12:35:06', 65),
(16, 'Annapoorna', 'Telangana Co-operative Union', 2, NULL, '9441605735', 'active', '2026-01-28 12:08:57', '2026-02-04 12:35:06', 66),
(17, 'Poorna Chander Rao', 'Telangana State Co-operative Housing Federation', 2, NULL, '9866887123', 'active', '2026-01-28 12:08:57', '2026-02-04 12:35:06', 67),
(18, 'Dr. Aldas Janaiah', 'Professor Jayashankar Telangana Agricultural University', 5, NULL, '9441180889', 'active', '2026-01-28 12:08:57', '2026-02-04 12:35:06', 68),
(48, 'Dr. Danda Raji Reddy', 'Sri Konda Laxman Telangana Horticultural University', 5, NULL, '9989625220', 'active', '2026-01-28 12:08:57', '2026-02-04 12:35:06', 48);

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
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `department_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hod_department_mapping`
--

INSERT INTO `hod_department_mapping` (`id`, `hod_id`, `department_name`, `category_id`, `is_primary`, `created_at`, `updated_at`, `department_id`) VALUES
(1, 25, 'Director of Horticulture (DOH)', 2, 1, '2026-01-27 05:26:48', '2026-02-04 12:36:34', 64),
(2, 25, 'TG Seeds Development Corporation Ltd (TG SSDC)', 6, 0, '2026-01-27 05:26:48', '2026-02-04 12:36:34', 64),
(3, 25, 'TG Cooperative Oil seeds Growers Federation Ltd (TG  OILFED)', 7, 0, '2026-01-27 05:26:48', '2026-02-04 12:36:34', 64),
(4, 25, 'Telangana State Horticulture Development Corporation  Ltd., (TG SHDCL)', 6, 0, '2026-01-27 05:26:48', '2026-02-04 12:36:34', 64),
(5, 42, 'The Hyderabad Agricultural Co-operative Association  (HACA)', 7, 1, '2026-01-27 05:26:48', '2026-02-04 12:36:34', 64),
(6, 42, 'Telangana State Co-operative Rural Irrigation Corporation  Ltd., Hyderabad (TG CRIC)', 7, 0, '2026-01-27 05:26:48', '2026-02-04 12:36:34', 64),
(7, 24, 'Director of Agriculture (DOA)', 2, 1, '2026-01-27 05:26:48', '2026-02-04 12:36:34', 64),
(8, 24, 'Telangana Rythu Bandhu Samithi (TRBS)', 7, 0, '2026-01-27 05:26:48', '2026-02-04 12:36:34', 64),
(9, 26, 'Director of Agricultural Marketing (DAM)', 2, 1, '2026-01-27 05:26:48', '2026-02-04 12:36:34', 64),
(10, 26, 'Director of Cooperation & RCS (DC & RCS)', 2, 0, '2026-01-27 05:26:48', '2026-02-04 12:36:34', 64);

-- --------------------------------------------------------

--
-- Table structure for table `hod_uploads`
--

CREATE TABLE `hod_uploads` (
  `id` int(11) NOT NULL,
  `hod_id` int(11) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_format` varchar(50) DEFAULT NULL,
  `upload_type` enum('flagship_program','report','budget') NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` enum('active','deleted') DEFAULT 'active',
  `deleted_reason` text DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hod_uploads`
--

INSERT INTO `hod_uploads` (`id`, `hod_id`, `file_name`, `file_path`, `file_format`, `upload_type`, `description`, `created_at`, `updated_at`, `status`, `deleted_reason`, `deleted_at`) VALUES
(4, 48, 'state 1.xlsx', 'D:\\Avniya projects\\Agriculture\\agri-latest\\backend\\uploads\\1769684344593-7404121.xlsx', 'xlsx', 'flagship_program', '', '2026-01-29 10:59:04', '2026-01-30 06:21:31', 'deleted', NULL, NULL),
(7, 48, 'ATTENDANCE.xlsx', 'D:\\Avniya projects\\Agriculture\\agri-latest\\backend\\uploads\\1769685867046-604281853.xlsx', 'xlsx', 'report', '', '2026-01-29 11:24:27', '2026-01-29 11:24:27', 'active', NULL, NULL),
(8, 48, 'BMA Report of Offices Under the Control of Director of Agriculture - 20-01-2026.xlsx', 'D:\\Avniya projects\\Agriculture\\agri-latest\\backend\\uploads\\1769687244839-729979137.xlsx', 'xlsx', 'flagship_program', '', '2026-01-29 11:47:24', '2026-01-30 14:52:24', 'deleted', 'swer', NULL),
(9, 48, 'BMA Report of Offices Under the Control of Director of Agriculture - 20-01-2026.xlsx', 'D:\\Avniya projects\\Agriculture\\agri-latest\\backend\\uploads\\1769719686350-613991794.xlsx', 'xlsx', 'flagship_program', '', '2026-01-29 20:48:06', '2026-01-30 07:14:45', 'deleted', 'hii', NULL),
(11, 48, 'Contacts List of All AMCs.xlsx', 'D:\\Avniya projects\\Agriculture\\agri-latest\\backend\\uploads\\1769723066010-177608645.xlsx', 'xlsx', 'report', '', '2026-01-29 21:44:26', '2026-01-30 07:14:57', 'deleted', 'res\n', '2026-01-30 12:44:57'),
(12, 48, 'sql.pdf', 'E:\\agri\\maniupdates git\\agri\\agricultureproject2\\backend\\uploads\\1769758355701-837428477.pdf', 'pdf', 'flagship_program', '', '2026-01-30 07:32:35', '2026-01-30 13:37:19', 'deleted', 'wer', NULL),
(13, 48, 'sql.pdf', 'E:\\agri\\maniupdates git\\agri\\agricultureproject2\\backend\\uploads\\1769758366332-21068600.pdf', 'pdf', 'report', '', '2026-01-30 07:32:46', '2026-01-30 13:37:24', 'deleted', 'wer', '2026-01-30 19:07:24'),
(14, 48, 'sql.pdf', 'E:\\agri\\maniupdates git\\agri\\agricultureproject2\\backend\\uploads\\1769768425038-271457783.pdf', 'pdf', 'flagship_program', '', '2026-01-30 10:20:25', '2026-01-30 10:20:35', 'deleted', 'tr', NULL),
(15, 48, 'revenue.xlsx', 'E:\\agri\\maniupdates git\\agri-latestmaniui\\backend\\uploads\\1769780266354-546802795.xlsx', 'xlsx', 'flagship_program', '', '2026-01-30 13:37:46', '2026-01-30 13:37:46', 'active', NULL, NULL),
(16, 48, 'Proformas1 (1).xlsx', 'E:\\agri\\maniupdates git\\agri-latestmaniui\\backend\\uploads\\1769780275814-60910892.xlsx', 'xlsx', 'report', '', '2026-01-30 13:37:55', '2026-01-30 13:37:55', 'active', NULL, NULL);

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
(37, 'Per Drop More Crop -Micro Irrigation(PDMC)', 'Rashtriya Krishi Vikas Yojana (RKVY)', 'DoH', '2025-26', 'active', '2026-02-02 11:08:01', 13.00, 13.00, 26.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 14.00, 144.00, 12, 12.00, '1900-01-11', 14, 14.00, NULL, NULL),
(38, 'Rashtriya Krishi Vikas Yojana (RKVY)', 'Rashtriya Krishi Vikas Yojana (RKVY)', 'DoA', '2025-26', 'active', '2026-02-02 11:08:01', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(39, 'Sub-Mission on Agriculture Mechanization (SMAM)', 'Rashtriya Krishi Vikas Yojana (RKVY)', 'DoA', '2025-26', 'active', '2026-02-02 11:08:01', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(40, 'National Project on Management of Soil Health & Fertility(SHF)', 'Rashtriya Krishi Vikas Yojana (RKVY)', 'DoA', '2025-26', 'active', '2026-02-02 11:08:01', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(41, 'Paramparagat Krishi Vikas Yojana (PKVY)', 'Rashtriya Krishi Vikas Yojana (RKVY)', 'DoA', '2025-26', 'active', '2026-02-02 11:08:01', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(42, 'Rainfed Area Development (RAD)', 'Rashtriya Krishi Vikas Yojana (RKVY)', 'DoH', '2025-26', 'active', '2026-02-02 11:08:01', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(43, 'Agro Forestry', 'Rashtriya Krishi Vikas Yojana (RKVY)', 'DoH', '2025-26', 'active', '2026-02-02 11:08:01', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(44, 'Crop Diverisifcation Programme (CDP)', 'Rashtriya Krishi Vikas Yojana (RKVY)', 'DoA', '2025-26', 'active', '2026-02-02 11:08:01', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(45, 'National Mission on Edible Oil-Oilpalm (NMEO-OP)', 'Krishonnati Yojana (KY)', 'DoH', '2025-26', 'active', '2026-02-02 11:08:01', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(46, 'Mission for Integrated Development ofHorticulture (MIDH)', 'Krishonnati Yojana (KY)', 'DoH', '2025-26', 'active', '2026-02-02 11:08:01', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(47, 'National Food Security Nutrition Mission (NFSM)', 'Krishonnati Yojana (KY)', 'DoA', '2025-26', 'active', '2026-02-02 11:08:01', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(48, 'Sub-Mission on Agricultural Extension (ATMA)', 'Krishonnati Yojana (KY)', 'DoA', '2025-26', 'active', '2026-02-02 11:08:01', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(49, 'Sub-Mission on Seed and Planting material (SMSP)NFSNM- Seed Components', 'Krishonnati Yojana (KY)', 'DoA', '2025-26', 'active', '2026-02-02 11:08:01', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(50, 'Digital Agriculture', 'Krishonnati Yojana (KY)', 'DoA', '2025-26', 'active', '2026-02-02 11:08:01', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(51, 'National Mission on Edible Oils - Oil Seeds (NMEO-OS)', 'Krishonnati Yojana (KY)', 'DoA', '2025-26', 'active', '2026-02-02 11:08:01', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(52, 'National Bamboo Mission (NBM)', 'Krishonnati Yojana (KY)', 'DoH', '2025-26', 'active', '2026-02-02 11:08:01', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(53, 'Mission for Atmanirbharta in Pulses', 'Krishonnati Yojana (KY)', 'DoA', '2025-26', 'active', '2026-02-02 11:08:01', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL),
(54, 'National Mission onNatural Farming(NMNF)', 'National Mission onNatural Farming(NMNF)', 'DoA', '2025-26', 'active', '2026-02-02 11:08:01', 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 12.00, 24.00, 12.00, 120.03, 12, 12.00, '1900-01-11', 12, 12.00, NULL, NULL);

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
  `hod_id` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `joining_date` date DEFAULT NULL,
  `status` enum('active','inactive','on_leave') DEFAULT 'active',
  `employee_type` enum('regular','outsource','contract') DEFAULT 'regular',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `department_id` int(11) NOT NULL,
  `person_id` int(11) DEFAULT NULL,
  `role` varchar(128) DEFAULT NULL,
  `shift` varchar(128) DEFAULT NULL,
  `job_type` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`id`, `name`, `employee_id`, `designation`, `hod_id`, `email`, `phone`, `joining_date`, `status`, `employee_type`, `created_at`, `updated_at`, `department_id`, `person_id`, `role`, `shift`, `job_type`) VALUES
(111, 'vamshi', 'EMP05', 'Jr HR', 48, 'vamshi@gmail.com', NULL, NULL, 'active', 'regular', '2026-02-05 10:35:26', '2026-02-05 12:34:51', 84, 17, 'Jr HR', 'New', 'Full Time'),
(112, 'neeraj', '789', 'Jr HR', 48, 'neer@gmail.com', NULL, NULL, 'active', 'contract', '2026-02-05 10:50:23', '2026-02-06 10:58:21', 84, 18, 'Jr HR', 'New', 'contract'),
(113, 'venkat', '788', 'Jr HR', 48, 'venkat@gmail.com', '54454554', NULL, 'active', 'regular', '2026-02-05 11:29:27', '2026-02-06 20:56:09', 84, 19, 'Jr HR', 'New', 'part time'),
(114, 'vamshi', '522', 'Jr HR', 48, 'sanjaybairy2001@gmail.com', NULL, NULL, 'active', 'outsource', '2026-02-05 12:05:19', '2026-02-06 22:12:25', 84, 13, 'Jr HR', 'New', 'out source'),
(115, 'John Doe', '567', NULL, 48, 'john.doe@company.com', '3214569787', '2026-02-07', 'active', 'outsource', '2026-02-05 12:05:19', '2026-02-06 22:15:09', 84, NULL, 'Developer', 'Morning (09:00 - 18:00)', 'outsource'),
(116, 'vdgmgtp', '9708', 'Jr HR', 48, 'vam@gmail.com', NULL, NULL, 'active', 'regular', '2026-02-05 12:05:19', '2026-02-05 12:05:19', 84, 22, 'Jr HR', 'New', 'part time'),
(117, 'uajpdm', '2004', 'Jr HR', 48, 'svjjh@gmail.com', NULL, NULL, 'active', 'regular', '2026-02-05 12:16:17', '2026-02-05 12:34:51', 84, 23, 'Jr HR', 'New', 'full time'),
(118, 'pavan', '299', 'Jr HR', 48, 'pavan@gmail.com', NULL, NULL, 'active', 'regular', '2026-02-05 13:05:00', '2026-02-05 13:05:00', 84, 25, 'Jr HR', 'New', 'full-time'),
(119, 'mukesh', '300', 'Jr HR', 48, 'mukesh@gmail.com', NULL, NULL, 'active', 'regular', '2026-02-05 13:05:00', '2026-02-05 13:05:00', 84, 24, 'Jr HR', 'New', 'Full-Time'),
(122, 'Sanjay', '98u3498', NULL, 48, 'sanju@gmail.com', NULL, '2026-02-06', 'active', 'regular', '2026-02-06 11:02:53', '2026-02-06 11:02:53', 84, 26, 'Jr HR', 'New', NULL),
(123, 'Lamgmg', '54231`', NULL, 48, 'neerajkotagiri8@gmail.com', NULL, '2026-02-06', 'active', 'regular', '2026-02-06 11:37:55', '2026-02-06 11:37:55', 84, 27, 'Jr HR', 'New', 'Full-Time'),
(124, 'Jngjm', '3214', NULL, 48, 'sanjaybairy2001@gmail.com', NULL, '2026-02-06', 'active', 'contract', '2026-02-06 11:47:28', '2026-02-06 11:47:28', 84, 28, 'Jr HR', 'New', 'contract'),
(125, 'Neeraj', '6345715', NULL, 48, 'neerajkotagiri8@gmail.com', NULL, '2026-02-06', 'active', 'regular', '2026-02-06 11:56:27', '2026-02-06 12:10:58', 84, 30, 'Jr HR', 'New', NULL),
(126, 'Dagmq', '123456', NULL, 48, 'n@gmail.com', NULL, '2026-02-06', 'active', 'regular', '2026-02-06 12:57:00', '2026-02-06 12:57:00', 84, 31, 'Jr HR', 'New', 'full time'),
(127, 'John Doe', '457', NULL, 48, 'john.doe@company.com', '3214569787', '2026-02-07', 'active', 'regular', '2026-02-06 22:15:44', '2026-02-06 22:15:44', 84, NULL, 'Developer', 'Morning (09:00 - 18:00)', 'full time');

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

--
-- Dumping data for table `state_scheme_financials`
--

INSERT INTO `state_scheme_financials` (`id`, `state_scheme_name`, `hod`, `budget_estimates`, `bro_released_amount`, `bills_preferred_count`, `bills_preferred_amount`, `oldest_bill_date`, `bills_cleared_count`, `bills_cleared_amount`, `latest_clearance_date`, `pending_bills_count`, `pending_bills_amount`, `financial_year`, `status`, `created_at`, `updated_at`) VALUES
(1, 'No. of Bills', 'Amount\r\n(Cr)', NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, NULL, '2025-26', 'active', '2026-01-27 08:20:36', '2026-01-27 08:28:11'),
(2, 'Rythu Bharosa', 'DoA', 100.00, 500.00, 1, 1000.00, '2025-03-12', 3, 2000.00, '2025-07-12', 5, 3000.00, '2025-26', 'active', '2026-01-27 08:20:36', '2026-01-27 08:28:11'),
(3, 'Rythu Bima', 'DoA', NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, NULL, '2025-26', 'active', '2026-01-27 08:20:36', '2026-01-27 08:28:11'),
(4, 'Crop Insurance', 'DoA', NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, NULL, '2025-26', 'active', '2026-01-27 08:20:36', '2026-01-27 08:28:11'),
(5, 'Supply of Seeds', 'DoA', NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, NULL, '2025-26', 'active', '2026-01-27 08:20:36', '2026-01-27 08:28:11'),
(6, 'Farm Mechanisation', 'DoA', NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, NULL, '2025-26', 'active', '2026-01-27 08:20:36', '2026-01-27 08:28:11'),
(7, 'Rythu Vedikas', 'DoA', NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, NULL, '2025-26', 'active', '2026-01-27 08:20:36', '2026-01-27 08:28:11'),
(8, 'Strengthening of IT Infrastructure', 'DoA', NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, NULL, '2025-26', 'active', '2026-01-27 08:20:36', '2026-01-27 08:28:11'),
(9, 'Strengthening of labs and INM', 'DoA', NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, NULL, '2025-26', 'active', '2026-01-27 08:20:36', '2026-01-27 08:28:11'),
(10, 'Extension', 'DoA', NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, NULL, '2025-26', 'active', '2026-01-27 08:20:36', '2026-01-27 08:28:11'),
(11, 'Telangana Agriculture Farmers Welfare Commission', 'DoA', NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, NULL, '2025-26', 'active', '2026-01-27 08:20:36', '2026-01-27 08:28:11'),
(12, 'Market Intervention Fund', 'DoAM', NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, NULL, '2025-26', 'active', '2026-01-27 08:20:36', '2026-01-27 08:28:11'),
(13, 'Promotion of Horitculture Activites', 'DoH', NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, NULL, '2025-26', 'active', '2026-01-27 08:20:36', '2026-01-27 08:28:11'),
(14, 'Oilpalm - Top up Subsidy for Micro Irrigation', 'DoH', NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, NULL, '2025-26', 'active', '2026-01-27 08:20:36', '2026-01-27 08:28:11'),
(15, 'Micro Irrigation  - Top up Subsidy', 'DoH', NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, NULL, '2025-26', 'active', '2026-01-27 08:20:36', '2026-01-27 08:28:11'),
(16, 'Poly House Scheme', 'DoH', NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, NULL, '2025-26', 'active', '2026-01-27 08:20:36', '2026-01-27 08:28:11'),
(17, 'Integrated Development of Sericulture', 'DoH', NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, NULL, '2025-26', 'active', '2026-01-27 08:20:36', '2026-01-27 08:28:11'),
(18, 'Development  of Government Gardens', 'DoH', NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, NULL, '2025-26', 'active', '2026-01-27 08:20:36', '2026-01-27 08:28:11'),
(19, 'Sericulture - Assistance to farmers for supply of BV Layings', 'DoH', NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, NULL, '2025-26', 'active', '2026-01-27 08:20:36', '2026-01-27 08:28:11'),
(20, 'Sericulture - Materials & Supplies', 'DoH', NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, NULL, '2025-26', 'active', '2026-01-27 08:20:36', '2026-01-27 08:28:11'),
(21, 'Cooperation - Ease of Doing Business(EODB)', 'RCS', NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, NULL, '2025-26', 'active', '2026-01-27 08:20:36', '2026-01-27 08:28:11'),
(22, 'Training of Members of MC', 'RCS', NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, NULL, '2025-26', 'active', '2026-01-27 08:20:36', '2026-01-27 08:28:11'),
(23, 'Assistance to Cooperative Union', 'RCS', NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, NULL, '2025-26', 'active', '2026-01-27 08:20:36', '2026-01-27 08:28:11'),
(24, 'PJTAU - Scheme Expenditure', 'PJTAU', NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, NULL, '2025-26', 'active', '2026-01-27 08:20:36', '2026-01-27 08:28:11'),
(25, 'SKLTGHU - Scheme Expenditure', 'SKLTGHU', NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, NULL, '2025-26', 'active', '2026-01-27 08:20:36', '2026-01-27 08:28:11');

-- --------------------------------------------------------

--
-- Table structure for table `third_party_api_keys`
--

CREATE TABLE `third_party_api_keys` (
  `id` int(11) NOT NULL,
  `system_name` varchar(255) NOT NULL,
  `hod_id` int(11) DEFAULT NULL,
  `api_key_hash` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_used_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `third_party_api_keys`
--

INSERT INTO `third_party_api_keys` (`id`, `system_name`, `hod_id`, `api_key_hash`, `description`, `is_active`, `created_at`, `last_used_at`) VALUES
(18, 'ACS', 48, '0397e32b88bf74359b2b4a53ac6020504c416b86796bcb8d1c6f0a80c58e5011', 'Agriculture Department', 1, '2026-02-01 18:50:36', '2026-02-03 13:42:49'),
(20, 'acs_1', NULL, '1f0eaa52f0ac1208cb1eb7dd48308eeb6d498c0aed87caaf4b2cdab99ab84f19', 'Agril.Marketing', 1, '2026-02-02 06:18:07', NULL),
(23, 'ACS_horiculture', NULL, '323a275d39886f40217b9faff391f0dcde8ee7e4415d02dee8ae9fac6b15207e', 'Horiculture department , TGSSri Konda Laxman Telangana Horticultural University', 1, '2026-02-03 07:44:15', NULL);

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
(1, 'admin', 'password123', 'admin@agri.gov.in', 'admin', NULL, NULL, 'System Administrator', 'active', 0, '2026-01-31 14:05:44', '2026-01-03 05:11:47', '2026-01-31 14:05:44', NULL, NULL),
(2, 'hod1', 'password123', 'ramesh.kumar@agri.gov.in', 'hod', 1, NULL, 'Dr. Ramesh Kumar', 'active', 0, '2026-01-29 09:47:51', '2026-01-03 05:11:47', '2026-01-29 09:47:51', NULL, NULL),
(3, 'hod2', 'password123', 'venkatesh.reddy@agri.gov.in', 'hod', 2, NULL, 'Sri. Venkatesh Reddy', 'active', 0, NULL, '2026-01-03 05:11:47', '2026-01-03 05:11:47', NULL, NULL),
(4, 'hod3', 'password123', 'lakshmi.devi@agri.gov.in', 'hod', 3, NULL, 'Smt. Lakshmi Devi', 'active', 0, NULL, '2026-01-03 05:11:47', '2026-01-03 05:11:47', NULL, NULL),
(5, 'staff1', 'password123', 'ajay.kumar@agri.gov.in', 'staff', 1, 1, 'Ajay Kumar', 'active', 0, NULL, '2026-01-03 05:11:47', '2026-01-03 05:11:47', NULL, NULL),
(6, 'staff2', 'password123', 'priya.sharma@agri.gov.in', 'staff', 2, 2, 'Priya Sharma', 'active', 0, NULL, '2026-01-03 05:11:47', '2026-01-03 05:11:47', NULL, NULL),
(7, 'staff3', 'password123', 'ravi.teja@agri.gov.in', 'staff', 3, 3, 'Ravi Teja', 'active', 0, NULL, '2026-01-03 05:11:47', '2026-01-03 05:11:47', NULL, NULL),
(8, 'superadmin', 'superadmin123', 'superadmin@agri.gov.in', 'superadmin', NULL, NULL, 'Super Admin', 'active', 1, '2026-02-06 19:25:15', '2026-01-09 10:26:31', '2026-02-06 19:25:15', NULL, NULL),
(13, 'manikumar', '1l4i63fzowXTLRZF4K0S', 'manikumar6634@gmail.com', 'hod', 23, NULL, 'mani', 'active', 0, NULL, '2026-01-22 12:27:30', '2026-01-22 12:27:30', NULL, NULL),
(14, 'dr..b..gopi,.ias', 'MDot#K%tG66@', 'svramana1998@gmail.com', 'hod', 24, NULL, 'Dr. B. Gopi, IAS', 'active', 0, '2026-01-29 11:09:36', '2026-01-26 17:04:56', '2026-01-29 11:09:36', '590786', '2026-01-26 17:43:53'),
(16, 'dr..danda.raji.reddy', 'test', 'kotagirineeraj6@gmail.com', 'hod', 48, NULL, 'Dr. Danda Raji Reddy', 'active', 0, '2026-02-06 19:39:44', '2026-01-27 06:15:04', '2026-02-06 19:39:44', NULL, NULL),
(17, 'dr..b..gopi,.ias1', '1hk$z3qStM!6', 'mukeshmarkonda1999@gmail.com', 'hod', 6, NULL, 'Dr. B. Gopi, IAS', 'active', 0, NULL, '2026-01-30 06:22:41', '2026-01-30 06:22:44', NULL, NULL);

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
  ADD UNIQUE KEY `idx_attendance_staff_date` (`staff_id`,`date`),
  ADD KEY `staff_id` (`staff_id`),
  ADD KEY `hod_id` (`hod_id`),
  ADD KEY `idx_source` (`source`),
  ADD KEY `idx_attendance_hod_department` (`hod_id`,`department_id`),
  ADD KEY `fk_attendance_department_id` (`department_id`);

--
-- Indexes for table `attendance_import_logs`
--
ALTER TABLE `attendance_import_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_api_key_id` (`api_key_id`),
  ADD KEY `idx_employee_id` (`employee_id`),
  ADD KEY `idx_attendance_date` (`attendance_date`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_import_status` (`import_status`),
  ADD KEY `idx_imports_hod_id` (`hod_id`),
  ADD KEY `idx_imports_department_id` (`department_id`),
  ADD KEY `idx_attendance_import_logs_hod_id` (`hod_id`),
  ADD KEY `idx_attendance_import_logs_department_id` (`department_id`),
  ADD KEY `idx_attendance_import_logs_hod_dept` (`hod_id`,`department_id`),
  ADD KEY `idx_attendance_import_logs_hod_department` (`hod_id`,`department_id`);

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
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `districts`
--
ALTER TABLE `districts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `state_id` (`state_id`);

--
-- Indexes for table `file_deletion_logs`
--
ALTER TABLE `file_deletion_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `deleted_at` (`deleted_at`),
  ADD KEY `upload_type` (`upload_type`),
  ADD KEY `fk_file_deletion_file` (`file_id`);

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
  ADD KEY `category_id` (`category_id`),
  ADD KEY `idx_hdm_hod_id` (`hod_id`),
  ADD KEY `idx_hdm_department_id` (`department_id`);

--
-- Indexes for table `hod_uploads`
--
ALTER TABLE `hod_uploads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hod_id` (`hod_id`,`upload_type`),
  ADD KEY `created_at` (`created_at`);

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
  ADD UNIQUE KEY `uniq_employee_id` (`employee_id`),
  ADD KEY `hod_id` (`hod_id`),
  ADD KEY `idx_staff_department_id` (`department_id`),
  ADD KEY `idx_staff_hod_department` (`hod_id`,`department_id`),
  ADD KEY `idx_staff_employee_hod_dept` (`employee_id`,`hod_id`,`department_id`);

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
-- Indexes for table `third_party_api_keys`
--
ALTER TABLE `third_party_api_keys`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `system_name` (`system_name`),
  ADD UNIQUE KEY `api_key_hash` (`api_key_hash`),
  ADD KEY `idx_api_key_hash` (`api_key_hash`),
  ADD KEY `idx_system_name` (`system_name`),
  ADD KEY `idx_is_active` (`is_active`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=268;

--
-- AUTO_INCREMENT for table `attendance_import_logs`
--
ALTER TABLE `attendance_import_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=410;

--
-- AUTO_INCREMENT for table `beneficiaries`
--
ALTER TABLE `beneficiaries`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `beneficiary_audit_logs`
--
ALTER TABLE `beneficiary_audit_logs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=763;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `districts`
--
ALTER TABLE `districts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `file_deletion_logs`
--
ALTER TABLE `file_deletion_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `flagship_import_metadata`
--
ALTER TABLE `flagship_import_metadata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `flagship_programmes`
--
ALTER TABLE `flagship_programmes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=282;

--
-- AUTO_INCREMENT for table `flagship_reports`
--
ALTER TABLE `flagship_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `hods`
--
ALTER TABLE `hods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `hod_department_mapping`
--
ALTER TABLE `hod_department_mapping`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `hod_uploads`
--
ALTER TABLE `hod_uploads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `scheme_budget_allocation`
--
ALTER TABLE `scheme_budget_allocation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=128;

--
-- AUTO_INCREMENT for table `states`
--
ALTER TABLE `states`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `state_scheme_financials`
--
ALTER TABLE `state_scheme_financials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `third_party_api_keys`
--
ALTER TABLE `third_party_api_keys`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

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
  ADD CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`hod_id`) REFERENCES `hods` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_attendance_department_id` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `attendance_import_logs`
--
ALTER TABLE `attendance_import_logs`
  ADD CONSTRAINT `attendance_import_logs_ibfk_1` FOREIGN KEY (`api_key_id`) REFERENCES `third_party_api_keys` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ail_department_id` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `fk_ail_hod_id` FOREIGN KEY (`hod_id`) REFERENCES `hods` (`id`);

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
-- Constraints for table `file_deletion_logs`
--
ALTER TABLE `file_deletion_logs`
  ADD CONSTRAINT `fk_file_deletion_file` FOREIGN KEY (`file_id`) REFERENCES `hod_uploads` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `hod_department_mapping`
--
ALTER TABLE `hod_department_mapping`
  ADD CONSTRAINT `fk_hdm_department_id` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `hod_department_mapping_ibfk_1` FOREIGN KEY (`hod_id`) REFERENCES `hods` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `hod_department_mapping_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
