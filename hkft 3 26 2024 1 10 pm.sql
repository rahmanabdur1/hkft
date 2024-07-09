-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 26, 2024 at 07:10 AM
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
-- Database: `hkft`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts_accesses`
--

CREATE TABLE `accounts_accesses` (
  `id` bigint UNSIGNED NOT NULL,
  `manager_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accounts_accesses`
--

INSERT INTO `accounts_accesses` (`id`, `manager_name`, `created_at`, `updated_at`) VALUES
(12, 'manage', '2023-08-30 03:42:04', '2023-08-30 03:42:04'),
(13, 'mana', '2023-08-30 03:42:15', '2023-08-30 03:42:15');

-- --------------------------------------------------------

--
-- Table structure for table `account_heads`
--

CREATE TABLE `account_heads` (
  `id` bigint UNSIGNED NOT NULL,
  `account_head` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `opening_balance` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `account_heads`
--

INSERT INTO `account_heads` (`id`, `account_head`, `account_code`, `opening_balance`, `type_name`, `created_at`, `updated_at`, `date`) VALUES
(1, 'Piller quantity', '04044545', '0', 'capital', '2023-03-03 14:09:44', '2023-03-03 14:09:44', NULL),
(2, 'Loan & Advance', '1234', '50000', 'Asset', '2023-03-03 23:21:49', '2023-03-03 23:21:49', NULL),
(3, 'fdsfds', '464564', '60000', 'Expense', '2023-03-04 12:03:20', '2023-03-04 12:03:20', NULL),
(4, 'Rod', '464646', '0', 'Income', '2023-03-18 14:25:55', '2023-03-18 14:25:55', NULL),
(5, 'Accounts Receivable', '145646', '0', 'Asset', '2023-03-24 03:32:04', '2023-03-24 03:32:04', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `account_types`
--

CREATE TABLE `account_types` (
  `id` bigint UNSIGNED NOT NULL,
  `type_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `account_types`
--

INSERT INTO `account_types` (`id`, `type_name`, `type_status`, `created_at`, `updated_at`) VALUES
(1, 'Asset', 'inactive', '2023-03-03 07:28:46', '2023-03-03 07:28:46'),
(2, 'capital', 'active', '2023-03-03 07:47:49', '2023-03-03 07:47:49'),
(3, 'Expense', 'active', '2023-03-03 12:37:27', '2023-03-03 12:37:27'),
(4, 'Income', 'active', '2023-03-03 12:47:47', '2023-03-03 12:47:47'),
(5, 'Liability', 'active', '2023-03-04 00:06:57', '2023-03-04 00:06:57'),
(6, 'test', 'active', '2023-03-04 12:02:19', '2023-03-04 12:02:19');

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint UNSIGNED NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `email_verified_at` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_verified` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `username`, `email`, `guard`, `password`, `created_at`, `updated_at`, `email_verified_at`, `remember_token`, `is_verified`) VALUES
(45, 'admin1234', 'adminlogin123@gvd.fdvj', 'admin', '$2y$10$PF6s68gr4XzvSp9IUrKjheufYtEPB2XnZL9QBljEuYPjMwqx3jWve', '2024-01-28 10:11:33', '2024-01-28 10:11:33', NULL, NULL, '0'),
(46, 'admin1', 'admin@gmail.com', 'admin', '$2y$10$lTFRUc8.qNuxvNlfuT0Uc.PgMPyQxqutFWIWUnD3N58ylrfkvL2c2', '2024-01-30 08:20:02', '2024-01-30 08:20:02', NULL, NULL, '0'),
(47, 'admin2', 'admin2@ggg.vvv', 'admin', '$2y$10$Tb1uhuowXyriw98c4gf6veLOq2iGsPajNZTyKUwfSsSgGL5DCUuFW', '2024-01-30 08:20:40', '2024-01-30 08:20:40', NULL, NULL, '0'),
(48, 'admin3', 'admin123@ffggf', 'admin', '$2y$10$WnBNsaXeAw1X3tOwvWJnYuTwMbQYBVfV2CeCN8MmFPMWXlNvzEsni', '2024-01-30 08:21:13', '2024-01-30 08:21:13', NULL, NULL, '0'),
(49, 'admin5', 'admin4@tgfg', 'admin', '$2y$10$FXkU9eygqUbaab5MADdsn.kbdEnNV1v76gntqnsx./JFVEo8es7yO', '2024-01-30 08:22:16', '2024-01-30 08:22:16', NULL, NULL, '0'),
(50, 'admin6', 'admin5@ff', 'admin', '$2y$10$7E9QX2Cgwm1Zecyvj2bT7eaR8KSu4iCIg.yMWIy8O2Egr0.nrakCC', '2024-01-30 08:25:07', '2024-01-30 08:25:07', NULL, NULL, '0');

-- --------------------------------------------------------

--
-- Table structure for table `advance_pays`
--

CREATE TABLE `advance_pays` (
  `id` bigint UNSIGNED NOT NULL,
  `basic_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selectedProject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selectedBuilding` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `apledgers`
--

CREATE TABLE `apledgers` (
  `id` bigint UNSIGNED NOT NULL,
  `supplier_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `due` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `return_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `balance` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `account_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `financialYear` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `apledgers`
--

INSERT INTO `apledgers` (`id`, `supplier_name`, `payment_id`, `product_name`, `paid`, `due`, `cash`, `bank`, `date`, `return_amount`, `balance`, `created_at`, `updated_at`, `account_type`, `financialYear`) VALUES
(546, 'not appicable', 'UdLIn-75333', 'Rod', '0', '-4394937', 'Cash', NULL, '2024-03-21', '0', '-4394937', '2024-03-21 03:37:35', '2024-03-23 12:10:57', 'Installation-1673548UdLIn-75333', '2023-2024'),
(547, 'not appicable', 'UdLIn-75333', 'Rod', '10000', '0', 'Cash', NULL, '2024-03-23', '0', '-4384937', '2024-03-21 03:38:42', '2024-03-21 03:38:42', 'Due-4777639egzwQ-85397', '2023-2024');

-- --------------------------------------------------------

--
-- Table structure for table `bank_ledgers`
--

CREATE TABLE `bank_ledgers` (
  `id` bigint UNSIGNED NOT NULL,
  `supplier_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `due` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `return_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `balance` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `account_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `financialYear` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_paid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_due` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cash_ledgers`
--

CREATE TABLE `cash_ledgers` (
  `id` bigint UNSIGNED NOT NULL,
  `supplier_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `due` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `return_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `balance` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `account_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `financialYear` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_paid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_due` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cash_ledgers`
--

INSERT INTO `cash_ledgers` (`id`, `supplier_name`, `payment_id`, `product_name`, `paid`, `due`, `cash`, `bank`, `date`, `return_amount`, `balance`, `created_at`, `updated_at`, `account_type`, `financialYear`, `receipt_paid`, `receipt_due`, `payment_status`) VALUES
(548, 'ফারজানা মন্ডল', 'DPAEI26078', '1A', NULL, NULL, 'Cash', '', '2024-03-07', NULL, NULL, '2024-03-19 08:37:40', '2024-03-19 08:37:40', 'Installation-3476014DPAEI26078', '2023-2024', '58235', '0', '0'),
(549, 'ফারজানা মন্ডল', 'DPAEI26078', '1A', NULL, NULL, 'Cash', '', '2024-03-14', NULL, '0', '2024-03-19 08:39:39', '2024-03-19 08:39:39', 'Due-2785528ZBIeF-65576', '2023-2024', '2995000', '0', '1'),
(551, 'এম এম স্বপন রাজা', 'BWxwW19111', '2A', NULL, NULL, 'Cash', '', '2024-03-13', NULL, NULL, '2024-03-19 10:55:36', '2024-03-19 10:55:36', 'Installation-3426642BWxwW19111', '2023-2024', '66666', '0', '0'),
(552, 'এম এম স্বপন রাজা', 'BWxwW19111', '2A', NULL, NULL, 'Cash', '', '2024-03-28', NULL, '61666', '2024-03-19 10:58:04', '2024-03-19 10:58:04', 'Due-4691789JTHBl-76256', '2023-2024', '13000', '0', '0'),
(553, 'not appicable', 'UdLIn-75333', 'Rod', '-105063', '0', 'Cash', '', '2024-03-21', NULL, '-105063', '2024-03-21 03:37:35', '2024-03-21 03:37:35', 'Installation-1673548UdLIn-75333', '2023-2024', NULL, NULL, '0'),
(554, 'not appicable', 'UdLIn-75333', 'Rod', '-10000', '0', 'Cash', '', '2024-03-23', NULL, '-115063', '2024-03-21 03:38:42', '2024-03-21 03:38:42', 'Due-4777639egzwQ-85397', NULL, NULL, NULL, '0');

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `father_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `husban_wife_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birth_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `religion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `occupation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nationality` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `national_id_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permanent_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permanent_post_office` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permanent_thana` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permanent_district` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `temprorary_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `temprorary_post_office` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `temprorary_thana` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `temprorary_district` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tin` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nid_img` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `passport_img` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tin_img` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `clientUnderProject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `profile_photos` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `selectedBuilding` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `share` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`id`, `name`, `father_name`, `mother_name`, `husban_wife_name`, `birth_date`, `religion`, `occupation`, `nationality`, `national_id_no`, `permanent_location`, `permanent_post_office`, `permanent_thana`, `permanent_district`, `temprorary_location`, `temprorary_post_office`, `temprorary_thana`, `temprorary_district`, `tin`, `phone`, `email`, `nid_img`, `passport_img`, `tin_img`, `clientUnderProject`, `created_at`, `updated_at`, `profile_photos`, `client_id`, `selectedBuilding`, `share`) VALUES
(133, 'হুমায়ুন কবীর', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01732170160', 'null', 'null', 'null', 'null', 'Unique Tower', '2024-01-30 08:29:59', '2024-01-30 08:29:59', 'AdminPanel/img/1794341297423551.jpeg', 'UT-001', 'UT', '1'),
(134, 'ফারজানা মন্ডল', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01712711703', NULL, 'AdminPanel/img/1790268146788094.jpeg', 'AdminPanel/img/1794344602429281.png', 'AdminPanel/img/1794344640939248.png', 'Unique Tower', '2024-01-30 08:30:34', '2024-01-30 08:30:34', 'AdminPanel/img/1794344641242475.png', 'UT-002', 'UT', '1'),
(135, 'মোঃ আব্দুল হাই', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01725061831', NULL, NULL, '', '', 'Unique Tower', '2024-01-30 08:31:06', '2024-01-30 08:31:06', '', 'UT-003', 'UT', '1'),
(136, 'সেলিম হোসেন খান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01988035192', NULL, NULL, '', '', 'Unique Tower', '2024-01-30 08:31:40', '2024-01-30 08:31:40', '', 'UT-004', 'UT', '1'),
(137, 'মোঃ মাসুদ রানা', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01879017881', NULL, 'null', 'null', 'null', 'Unique Tower', '2024-01-30 08:32:12', '2024-01-30 08:32:12', 'AdminPanel/img/1789526258058022.png', 'UT-005', 'UT', '2'),
(138, 'মোঃ বজলুল রশিদ হাওলাদার', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01716426835', 'null', 'null', NULL, NULL, 'Unique Tower', '2024-01-30 08:34:25', '2024-01-30 08:34:25', NULL, 'UT-006', 'UT', '1'),
(139, 'মোঃ মাহফুজর রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0172833302', NULL, NULL, '', '', 'Unique Tower', '2024-01-30 08:35:04', '2024-01-30 08:35:04', '', 'UT-007', 'UT', '1'),
(140, 'মোস্তাফিজুর রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01727421893', NULL, NULL, '', '', 'Unique Tower', '2024-01-30 08:35:33', '2024-01-30 08:35:33', '', 'UT-008', 'UT', '1'),
(141, 'মোঃ হারুন উর রশিদ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01720344804', NULL, NULL, '', '', 'Unique Tower', '2024-01-30 08:36:17', '2024-01-30 08:36:17', '', 'UT-009', 'UT', '1'),
(142, 'মোঃ শহিদুল্লাহ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01712207904', NULL, NULL, '', '', 'Unique Tower', '2024-01-30 08:41:00', '2024-01-30 08:41:00', '', 'UT-010', 'UT', '1'),
(143, 'মোঃ শাহজাহান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01718036350', NULL, NULL, '', '', 'Unique Tower', '2024-01-30 08:41:33', '2024-01-30 08:41:33', '', 'UT-011', 'UT', '1'),
(144, 'কাজী সাদিয়া রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01680223779', NULL, NULL, '', '', 'Unique Tower', '2024-01-30 08:41:59', '2024-01-30 08:41:59', '', 'UT-012', 'UT', '1'),
(145, 'কাজী মিজানুর রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01680223779', NULL, NULL, '', '', 'Unique Tower', '2024-01-30 08:42:45', '2024-01-30 08:42:45', '', 'UT-013', 'UT', '1'),
(146, 'মোঃ হাবিবুর রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01680223779', NULL, NULL, '', '', 'Unique Tower', '2024-01-30 08:43:07', '2024-01-30 08:43:07', '', 'UT-014', 'UT', '1'),
(147, 'নাগিস আক্তার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01738456056', NULL, NULL, '', '', 'Unique Tower', '2024-01-30 08:43:41', '2024-01-30 08:43:41', '', 'UT-015', 'UT', '1'),
(148, 'রুহুল আমীন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01682608638', NULL, NULL, '', '', 'Unique Tower', '2024-01-30 08:44:18', '2024-01-30 08:44:18', '', 'UT-016', 'UT', '1'),
(149, 'জাকিরুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01321162520', NULL, NULL, '', '', 'Unique Tower', '2024-01-30 08:44:48', '2024-01-30 08:44:48', '', 'UT-017', 'UT', '1'),
(150, 'হুমায়ুন কবীর', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01732170160', 'null', 'null', NULL, NULL, 'Dream Tower', '2024-01-31 03:49:22', '2024-01-31 03:49:22', NULL, 'DT-001', 'DT', '1'),
(151, 'মোঃ আব্দুল হাই', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01725061831', 'null', 'null', NULL, NULL, 'Dream Tower', '2024-01-31 03:49:36', '2024-01-31 03:49:36', NULL, 'DT-002', 'DT', '1'),
(152, 'ডাঃ ইদ্রিস আলী', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01716223288', NULL, NULL, '', '', 'Dream Tower', '2024-01-31 03:50:49', '2024-01-31 03:50:49', '', 'DT-003', 'DT', '1'),
(153, 'এস এম জাকারিয়া', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01717143145', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 01:45:49', '2024-02-01 01:45:49', '', 'DT-004', 'DT', '1'),
(154, 'আনোয়ার হোসেন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01681495152', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 01:47:14', '2024-02-01 01:47:14', '', 'DT-005', 'DT', '1'),
(155, 'মোঃ গোলাম কবীর', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01712472023', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 01:48:38', '2024-02-01 01:48:38', '', 'DT-006', 'DT', '1'),
(156, 'মোঃ শামীম হাওলাদার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01712041250', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 01:49:52', '2024-02-01 01:49:52', '', 'DT-007', 'DT', '1'),
(157, 'মোঃ জোবায়ের হোসেন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01614259627', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 01:50:47', '2024-02-01 01:50:47', '', 'DT-008', 'DT', '1'),
(158, 'মোঃ শফিকুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01673430060', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 01:51:33', '2024-02-01 01:51:33', '', 'DT-009', 'DT', '1'),
(159, 'এস এম রিয়াজুর রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01558322347', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 01:52:30', '2024-02-01 01:52:30', '', 'DT-010', 'DT', '1'),
(160, 'কাওসার আলম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01767886006', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 01:53:50', '2024-02-01 01:53:50', '', 'DT-011', 'DT', '1'),
(161, 'হাকিকুর রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01912025134', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 01:57:09', '2024-02-01 01:57:09', '', 'DT-012', 'DT', '1'),
(162, 'আতিকুর রহমান(রেজাউল)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01714791465', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 01:58:03', '2024-02-01 01:58:03', '', 'DT-013', 'DT', '1'),
(163, 'মোঃ আজহারুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01711979349', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 01:58:52', '2024-02-01 01:58:52', '', 'DT-014', 'DT', '1'),
(164, 'মোঃ কামরুজ্জামান বাচ্চু', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01716813304', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:00:16', '2024-02-01 02:00:16', '', 'DT-015', 'DT', '1'),
(165, 'আব্দুল কাদের', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01779099241', 'null', 'null', NULL, NULL, 'Dream Tower', '2024-02-01 02:05:34', '2024-02-01 02:05:34', NULL, 'DT-016', 'DT', '2'),
(166, 'খুরশীদ আলম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01683312510', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:06:19', '2024-02-01 02:06:19', '', 'DT-017', 'DT', '1'),
(167, 'রাশেদ আহমেদ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:06:48', '2024-02-01 02:06:48', '', 'DT-018', 'DT', '1'),
(168, 'আকতার  হোসেন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01711362012', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:07:31', '2024-02-01 02:07:31', '', 'DT-019', 'DT', '1'),
(169, 'শচীন সরকার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01711362012', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:08:18', '2024-02-01 02:08:18', '', 'DT-020', 'DT', '1'),
(170, 'মোঃ কামরুজ্জামান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01712629597', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:09:02', '2024-02-01 02:09:02', '', 'DT-021', 'DT', '2'),
(171, 'শাম্মী আকতার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01712629597', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:10:29', '2024-02-01 02:10:29', '', 'DT-022', 'DT', '1'),
(172, 'মোঃ শামছুল আলম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01711468943', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:11:17', '2024-02-01 02:11:17', '', 'DT-023', 'DT', '1'),
(173, 'মোঃ শুকুর আলী', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01821730372', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:26:42', '2024-02-01 02:26:42', '', 'DT-024', 'DT', '1'),
(174, 'মোঃ নূরুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01620653114', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:28:03', '2024-02-01 02:28:03', '', 'DT-025', 'DT', '1'),
(175, 'দেলোয়ার হোসেন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01881991047', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:28:39', '2024-02-01 02:28:39', '', 'DT-026', 'DT', '1'),
(176, 'আয়েশা আক্তার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01799384104', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:29:24', '2024-02-01 02:29:24', '', 'DT-027', 'DT', '1'),
(177, 'মোঃ রাসেল মাহমুদ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01828130525', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:30:06', '2024-02-01 02:30:06', '', 'DT-028', 'DT', '2'),
(178, 'ফারহানা জুবাইদা', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01712994509', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:30:46', '2024-02-01 02:30:46', '', 'DT-029', 'DT', '1'),
(179, 'মোঃ জয়নাল আবেদীন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:31:12', '2024-02-01 02:31:12', '', 'DT-030', 'DT', '1'),
(180, 'আফরুজা পারভীন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01712994509', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:31:52', '2024-02-01 02:31:52', '', 'DT-031', 'DT', '1'),
(181, 'সালমা জাহান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01966732209', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:32:36', '2024-02-01 02:32:36', '', 'DT-032', 'DT', '1'),
(182, 'মিজানুর রহমান/রিতা', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01775668668', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:33:26', '2024-02-01 02:33:26', '', 'DT-033', 'DT', '1'),
(183, 'যতীশ কুমার শান্ত', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01721486151', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:34:07', '2024-02-01 02:34:07', '', 'DT-034', 'DT', '1'),
(184, 'সাজ্জাদ হোসেন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01767466242', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:34:56', '2024-02-01 02:34:56', '', 'DT-035', 'DT', '1'),
(185, 'ফরহাদ হোসেন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01737199650', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:35:30', '2024-02-01 02:35:30', '', 'DT-036', 'DT', '1'),
(186, 'মোঃ শফিকুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01716427434', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:36:09', '2024-02-01 02:36:09', '', 'DT-037', 'DT', '1'),
(187, 'ওমর ফারুক খান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01815243880', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:36:45', '2024-02-01 02:36:45', '', 'DT-038', 'DT', '1'),
(188, 'সোহেল রানা', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01779556930', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:37:20', '2024-02-01 02:37:20', '', 'DT-039', 'DT', '1'),
(189, 'মাহমুদুর রহমান জামাল', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01915906014', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:37:57', '2024-02-01 02:37:57', '', 'DT-040', 'DT', '4'),
(190, 'লিটন কুমার দাস', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01724937145', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:38:34', '2024-02-01 02:38:34', '', 'DT-041', 'DT', '2'),
(191, 'পলাশ মন্ডল', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01724937145', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:39:11', '2024-02-01 02:39:11', '', 'DT-042', 'DT', '1'),
(192, 'মোঃ সজীব হোসেন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01673618184', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:39:45', '2024-02-01 02:39:45', '', 'DT-043', 'DT', '1'),
(193, 'মোঃ আলাউদ্দিন ফারুক', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01850607069', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:40:19', '2024-02-01 02:40:19', '', 'DT-044', 'DT', '1'),
(194, 'মোঃ সজীব মোল্লা', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01822777474', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:40:55', '2024-02-01 02:40:55', '', 'DT-045', 'DT', '1'),
(195, 'হারুন-অর-রশীদ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01730387972', NULL, NULL, '', '', 'Dream Tower', '2024-02-01 02:41:30', '2024-02-01 02:41:30', '', 'DT-046', 'DT', '1'),
(196, 'ফারজানা মন্ডল', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01712711703', 'null', 'null', NULL, NULL, 'Dhanmondi garden city', '2024-02-04 07:20:19', '2024-02-04 07:20:19', NULL, 'DGC4-001', 'DGC4', '1'),
(197, 'মোঃ আব্দুর রাজ্জাক', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01712182755', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 22:37:08', '2024-02-04 22:37:08', '', 'DGC6-001', 'DGC6', '1'),
(198, 'এম এম স্বপন রাজা', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '187485239*', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 22:38:55', '2024-02-04 22:38:55', '', 'DGC6-002', 'DGC6', '4'),
(199, 'সুরাইয়া বেগম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01796924212', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 22:40:08', '2024-02-04 22:40:08', '', 'DGC6-003', 'DGC6', '1'),
(200, 'মোঃ আশাদুল হক', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01718460067', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:07:38', '2024-02-04 23:07:38', '', 'DGC6-004', 'DGC6', '1'),
(201, 'নুরুল ইসলাম রুপালী', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01712907479', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:09:00', '2024-02-04 23:09:00', '', 'DGC6-005', 'DGC6', '1'),
(202, 'জসিম উদ্দিন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:18:11', '2024-02-04 23:18:11', '', 'DGC6-006', 'DGC6', '1'),
(203, 'মোঃ মাসুদ রানা', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01719983039', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:19:13', '2024-02-04 23:19:13', '', 'DGC6-007', 'DGC6', '1'),
(204, 'মোঃ আজগর হোসেন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01779562262', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:20:15', '2024-02-04 23:20:15', '', 'DGC6-008', 'DGC6', '1'),
(205, 'ফাতেমা নাজনীন পল্লবী', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01712002715', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:21:10', '2024-02-04 23:21:10', '', 'DGC6-009', 'DGC6', '1'),
(206, 'ইয়াকুব আলী', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:22:07', '2024-02-04 23:22:07', '', 'DGC6-010', 'DGC6', '1'),
(207, 'সামেয়া আফরোজ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01716710107', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:22:58', '2024-02-04 23:22:58', '', 'DGC6-011', 'DGC6', '1'),
(208, 'আহনাফ আবীদ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01673343834', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:23:53', '2024-02-04 23:23:53', '', 'DGC6-012', 'DGC6', '1'),
(209, 'দেলোয়ারা বেগম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01711357161', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:25:01', '2024-02-04 23:25:01', '', 'DGC6-013', 'DGC6', '1'),
(210, 'কে এম মোস্তাক আহমেদ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01711357161', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:25:51', '2024-02-04 23:25:51', '', 'DGC6-014', 'DGC6', '1'),
(211, 'মোঃ সফিকউল্ল্যা', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01711175522', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:26:52', '2024-02-04 23:26:52', '', 'DGC6-015', 'DGC6', '1'),
(212, 'মোঃ রাসেল মাহমুদ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01828130525', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:27:38', '2024-02-04 23:27:38', '', 'DGC6-016', 'DGC6', '1'),
(213, 'মোহাম্মদ গোলাম মোস্তফা গং', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01949200133', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:28:35', '2024-02-04 23:28:35', '', 'DGC6-017', 'DGC6', '1'),
(214, 'শাহানাজ পারভীন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01711043286', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:29:23', '2024-02-04 23:29:23', '', 'DGC6-018', 'DGC6', '1'),
(215, 'মোঃ আশরাফ হোসেন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01711448961', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:30:08', '2024-02-04 23:30:08', '', 'DGC6-019', 'DGC6', '1'),
(216, 'পাপিয়া আক্তার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01661171926', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:31:03', '2024-02-04 23:31:03', '', 'DGC6-020', 'DGC6', '2'),
(217, 'এ বি এম মাজেদ উদ্দিন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01711702722', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:32:07', '2024-02-04 23:32:07', '', 'DGC6-021', 'DGC6', '1'),
(218, 'বদরুন্নেছা', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01937906300', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:33:11', '2024-02-04 23:33:11', '', 'DGC6-022', 'DGC6', '1'),
(219, 'মহি উদ্দিন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01990779771', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:33:58', '2024-02-04 23:33:58', '', 'DGC6-023', 'DGC6', '1'),
(220, 'সাইদুজ্জামান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01711199642', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:34:55', '2024-02-04 23:34:55', '', 'DGC6-024', 'DGC6', '1'),
(221, 'মোঃ নুরুজ্জামান খান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01715770889', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:35:50', '2024-02-04 23:35:50', '', 'DGC6-025', 'DGC6', '1'),
(222, 'আবুল হাসেম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:36:35', '2024-02-04 23:36:35', '', 'DGC6-026', 'DGC6', '1'),
(223, 'মির্জা গোলাম সারোয়ার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:37:24', '2024-02-04 23:37:24', '', 'DGC6-027', 'DGC6', '1'),
(224, 'মহসিন রেজা', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:38:03', '2024-02-04 23:38:03', '', 'DGC6-028', 'DGC6', '3'),
(225, 'মোঃ বদরুল আলম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01795945797', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:39:06', '2024-02-04 23:39:06', '', 'DGC6-029', 'DGC6', '1'),
(226, 'জাহাঙ্গীর আলম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01620653114', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:42:05', '2024-02-04 23:42:05', '', 'DGC6-030', 'DGC6', '1'),
(227, 'রুমপা সিকদার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01620653114', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:42:51', '2024-02-04 23:42:51', '', 'DGC6-031', 'DGC6', '1'),
(228, 'বেপারী মোহাম্মদ মিনহাজ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01620653114', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:43:45', '2024-02-04 23:43:45', '', 'DGC6-032', 'DGC6', '1'),
(229, 'মোঃ মোয়াজ্জেম হোসেন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:44:29', '2024-02-04 23:44:29', '', 'DGC6-033', 'DGC6', '1'),
(230, 'ফরিদা ইয়াসমিন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01917173112', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:45:17', '2024-02-04 23:45:17', '', 'DGC6-034', 'DGC6', '1'),
(231, 'মোঃ মনজেরুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:46:09', '2024-02-04 23:46:09', '', 'DGC6-035', 'DGC6', '1'),
(232, 'মোছাঃ সুমী শামীম আরা খাতুন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01714785027', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:47:17', '2024-02-04 23:47:17', '', 'DGC6-036', 'DGC6', '1'),
(233, 'সাথী সাহা', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:47:57', '2024-02-04 23:47:57', '', 'DGC6-037', 'DGC6', '1'),
(234, 'স্বপ্না সাহা', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:48:59', '2024-02-04 23:48:59', '', 'DGC6-038', 'DGC6', '1'),
(235, 'এ এস এম কামরুল হাসান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01712225563', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:49:51', '2024-02-04 23:49:51', '', 'DGC6-039', 'DGC6', '1'),
(236, 'সৈয়দ সেলিনা আকতার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:50:43', '2024-02-04 23:50:43', '', 'DGC6-040', 'DGC6', '1'),
(237, 'মোঃ রফিকুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '181928706*', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:51:36', '2024-02-04 23:51:36', '', 'DGC6-041', 'DGC6', '1'),
(238, 'আফরীন আজহার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:52:21', '2024-02-04 23:52:21', '', 'DGC6-042', 'DGC6', '1'),
(239, 'মোঃ মুখলেসুর রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:53:18', '2024-02-04 23:53:18', '', 'DGC6-043', 'DGC6', '1'),
(240, 'মোঃ সোহেল রানা', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:54:00', '2024-02-04 23:54:00', '', 'DGC6-044', 'DGC6', '1'),
(241, 'তাহেরা বেগম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01673642438', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:54:36', '2024-02-04 23:54:36', '', 'DGC6-045', 'DGC6', '1'),
(242, 'রঞ্জন কুমার দাস', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:55:14', '2024-02-04 23:55:14', '', 'DGC6-046', 'DGC6', '1'),
(243, 'মোঃ জুলহাস', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:56:02', '2024-02-04 23:56:02', '', 'DGC6-047', 'DGC6', '1'),
(244, 'মোহাম্মদ আসাদুজ্জামান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:56:51', '2024-02-04 23:56:51', '', 'DGC6-048', 'DGC6', '1'),
(245, 'মনিরুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:57:33', '2024-02-04 23:57:33', '', 'DGC6-049', 'DGC6', '1'),
(246, 'মোঃ মাহবুব আলম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01717314144', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-04 23:58:47', '2024-02-04 23:58:47', '', 'DGC6-050', 'DGC6', '1'),
(247, 'প্রকৌশলী মিমইয়া ইসলাম চৌধুরী', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01911162451', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 00:01:30', '2024-02-05 00:01:30', '', 'DGC6-051', 'DGC6', '1'),
(248, 'সামসুদ্দীন মন্টু', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 00:02:19', '2024-02-05 00:02:19', '', 'DGC6-052', 'DGC6', '6'),
(249, 'ফারজানা মন্ডল', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 00:03:05', '2024-02-05 00:03:05', '', 'DGC6-053', 'DGC6', '4'),
(250, 'সাঈদ হোসেন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01307108941', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 00:03:53', '2024-02-05 00:03:53', '', 'DGC6-054', 'DGC6', '2'),
(251, 'মোঃ আব্দুল হাই', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 00:04:33', '2024-02-05 00:04:33', '', 'DGC6-055', 'DGC6', '1'),
(252, 'নাসিমা আক্তার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 00:05:26', '2024-02-05 00:05:26', '', 'DGC6-056', 'DGC6', '1'),
(253, 'কমল কুমার খৈতান', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '00', NULL, 'null', 'null', 'null', 'Dhanmondi garden city', '2024-02-05 00:07:00', '2024-02-05 00:07:00', 'null', 'DGC6-057', 'DGC6', '6'),
(254, 'মাসুদ করিম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01716031999', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 00:07:44', '2024-02-05 00:07:44', '', 'DGC6-058', 'DGC6', '1'),
(255, 'নাজনীন নাহার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01716031999', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 00:08:20', '2024-02-05 00:08:20', '', 'DGC6-059', 'DGC6', '1'),
(256, 'ছানাউল্লা পাটুয়ারী', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01816301439', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 00:09:06', '2024-02-05 00:09:06', '', 'DGC6-060', 'DGC6', '2'),
(257, 'মফিজুর রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 00:09:53', '2024-02-05 00:09:53', '', 'DGC6-061', 'DGC6', '1'),
(258, 'বিপ্লব হোসেন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 00:10:31', '2024-02-05 00:10:31', '', 'DGC6-062', 'DGC6', '1'),
(259, 'আকতার হোসেন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 00:11:04', '2024-02-05 00:11:04', '', 'DGC6-063', 'DGC6', '1'),
(260, 'আবু বকর', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 00:11:46', '2024-02-05 00:11:46', '', 'DGC6-064', 'DGC6', '1'),
(261, 'যুগল কৃষ্ণ পোদ্দার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01711301983', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 00:12:38', '2024-02-05 00:12:38', '', 'DGC6-065', 'DGC6', '1'),
(262, 'তাবাসসুম এশা', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01712565339', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 00:13:18', '2024-02-05 00:13:18', '', 'DGC6-066', 'DGC6', '1'),
(263, 'মেহেদী হাসান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 00:13:54', '2024-02-05 00:13:54', '', 'DGC6-067', 'DGC6', '1'),
(264, 'এম এম স্বপন রাজা', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '০০', 'null', 'null', NULL, NULL, 'Dhanmondi garden city', '2024-02-05 01:55:38', '2024-02-05 01:55:38', NULL, 'DGC4-002', 'DGC4', '2'),
(265, 'নূর মোহাম্মদ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '০১৭৩৯৭৩৭৯৩৯', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 02:06:15', '2024-02-05 02:06:15', '', 'DGC4-003', 'DGC4', '2'),
(266, 'সাইদ হোসেন পাটোয়ারী', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 02:08:43', '2024-02-05 02:08:43', '', 'DGC4-004', 'DGC4', '2'),
(267, 'সেলিনা পারভীন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '০১৭১৬৪১১৩৩৭', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 02:10:23', '2024-02-05 02:10:23', '', 'DGC4-005', 'DGC4', '1'),
(268, 'রুবিনা আক্তার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 02:12:20', '2024-02-05 02:12:20', '', 'DGC4-006', 'DGC4', '2'),
(269, 'সামসুল আলম', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01869512776', 'null', 'null', NULL, NULL, 'Dhanmondi garden city', '2024-02-05 02:13:30', '2024-02-05 02:13:30', NULL, 'DGC4-007', 'DGC4', '2'),
(270, 'ডঃ মোঃ  রুহুল আমীন', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '০১৭১৭২৮৭৯৭৯৪৬', 'null', 'null', NULL, NULL, 'Dhanmondi garden city', '2024-02-05 02:15:16', '2024-02-05 02:15:16', NULL, 'DGC4-008', 'DGC4', '1'),
(271, 'কমল কুমার খৈতান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01716272270', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:22:06', '2024-02-05 22:22:06', '', 'DGC4-009', 'DGC4', '5'),
(272, 'এ কে এম শফিকুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01685792945', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:23:04', '2024-02-05 22:23:04', '', 'DGC4-010', 'DGC4', '1'),
(273, 'কাজী মাহবুব আলম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01685942027', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:24:10', '2024-02-05 22:24:10', '', 'DGC4-011', 'DGC4', '1'),
(274, 'মোহাম্মদ রফিকুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01552390636', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:24:59', '2024-02-05 22:24:59', '', 'DGC4-012', 'DGC4', '1'),
(275, 'মোঃ শাহিনুর ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01732782120', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:26:03', '2024-02-05 22:26:03', '', 'DGC4-013', 'DGC4', '1'),
(276, 'মোঃ আলমগীর মিয়া', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01842282761', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:27:07', '2024-02-05 22:27:07', '', 'DGC4-014', 'DGC4', '1'),
(277, 'মোঃ শাহ আলমগীর', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01711310216', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:27:53', '2024-02-05 22:27:53', '', 'DGC4-015', 'DGC4', '1'),
(278, 'মোঃ মনোয়ার হোসেন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01714410824', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:28:47', '2024-02-05 22:28:47', '', 'DGC4-016', 'DGC4', '2'),
(279, 'মোঃ মাজহারুল কবির', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01716470203', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:29:43', '2024-02-05 22:29:43', '', 'DGC4-017', 'DGC4', '1'),
(280, 'মোঃ আব্দুল আলীম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01716028539', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:30:24', '2024-02-05 22:30:24', '', 'DGC4-018', 'DGC4', '1'),
(281, 'মোঃ হুমায়ুন কবির তালুকদার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01737417757', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:34:22', '2024-02-05 22:34:22', '', 'DGC4-019', 'DGC4', '1'),
(282, 'চিন্ময় ভূঁইয়া', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01717170957', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:35:26', '2024-02-05 22:35:26', '', 'DGC4-020', 'DGC4', '1'),
(283, 'জুয়েল হালদার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01918327286', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:36:16', '2024-02-05 22:36:16', '', 'DGC4-021', 'DGC4', '1'),
(284, 'মোহাম্মদ মাইজুর রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01712391290', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:37:01', '2024-02-05 22:37:01', '', 'DGC4-022', 'DGC4', '1'),
(285, 'আলিম আল রাজী', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01627635311', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:38:04', '2024-02-05 22:38:04', '', 'DGC4-023', 'DGC4', '1'),
(286, 'রেজাউল করিম বয়াতী', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01716362697', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:39:07', '2024-02-05 22:39:07', '', 'DGC4-024', 'DGC4', '1'),
(287, 'সাদিয়া আফরোজ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:39:57', '2024-02-05 22:39:57', '', 'DGC4-025', 'DGC4', '1'),
(288, 'বশির আলম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01716367835', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:40:44', '2024-02-05 22:40:44', '', 'DGC4-026', 'DGC4', '1'),
(289, 'শ্রাবন্তী মজুমদার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01671542255', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:41:28', '2024-02-05 22:41:28', '', 'DGC4-027', 'DGC4', '1'),
(290, 'সুস্মিতা সরকার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01712236305', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:42:17', '2024-02-05 22:42:17', '', 'DGC4-028', 'DGC4', '1'),
(291, 'মোসাঃ রিফাত জাহান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01711362012', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:42:58', '2024-02-05 22:42:58', '', 'DGC4-029', 'DGC4', '1'),
(292, 'মোঃ মুখলেসুর রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01717512887', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:43:51', '2024-02-05 22:43:51', '', 'DGC4-030', 'DGC4', '2'),
(293, 'মোঃ শরিফুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01755515982', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:44:42', '2024-02-05 22:44:42', '', 'DGC4-031', 'DGC4', '1'),
(294, 'মোঃ আমিনুর রহমান (ইমরোজ)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01819122451', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:45:46', '2024-02-05 22:45:46', '', 'DGC4-032', 'DGC4', '1'),
(295, 'সুশান্ত কুমার দও', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01915555650', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:46:35', '2024-02-05 22:46:35', '', 'DGC4-033', 'DGC4', '1'),
(296, 'আতিয়া সুলতানা', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01717623678', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:47:23', '2024-02-05 22:47:23', '', 'DGC4-034', 'DGC4', '1'),
(297, 'মীর রহমত উল্লাহ', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01766668147', 'null', 'null', NULL, NULL, 'Dhanmondi garden city', '2024-02-05 22:48:05', '2024-02-05 22:48:05', NULL, 'DGC4-035', 'DGC4', '1'),
(298, 'মোঃ আজিজুর রহমান', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01740985330', 'null', 'null', NULL, NULL, 'Dhanmondi garden city', '2024-02-05 22:48:57', '2024-02-05 22:48:57', NULL, 'DGC4-036', 'DGC4', '2'),
(299, 'মোঃ সাইফুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:49:43', '2024-02-05 22:49:43', '', 'DGC4-037', 'DGC4', '1'),
(300, 'মোঃ হাবিবুর রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01894754745', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:50:35', '2024-02-05 22:50:35', '', 'DGC4-038', 'DGC4', '1'),
(301, 'শাহাদৎ হোসেন আজাদ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01711020586', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:52:21', '2024-02-05 22:52:21', '', 'DGC4-039', 'DGC4', '1'),
(302, 'মোসাঃ শাহীনা আক্তার', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01715169182', 'null', 'null', NULL, NULL, 'Dhanmondi garden city', '2024-02-05 22:53:08', '2024-02-05 22:53:08', NULL, 'DGC4-040', 'DGC4', '1'),
(303, 'প্রবীর চন্দ্র রায়', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01712779394', 'null', 'null', NULL, NULL, 'Dhanmondi garden city', '2024-02-05 22:53:50', '2024-02-05 22:53:50', NULL, 'DGC4-041', 'DGC4', '1'),
(304, 'রিজিয়া সুলতানা', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:54:36', '2024-02-05 22:54:36', '', 'DGC4-042', 'DGC4', '1'),
(305, 'মোঃ জহুরুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01712191444', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:56:00', '2024-02-05 22:56:00', '', 'DGC4-043', 'DGC4', '1'),
(306, 'মোছাঃ মনিরা পারভীন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:56:52', '2024-02-05 22:56:52', '', 'DGC4-044', 'DGC4', '1'),
(307, 'এস এম নুরুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:57:49', '2024-02-05 22:57:49', '', 'DGC4-045', 'DGC4', '1'),
(308, 'মিজানুর রহমান গং', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:58:28', '2024-02-05 22:58:28', '', 'DGC4-046', 'DGC4', '1'),
(309, 'মোসাঃ খোদেজা বেগম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01679114225', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:59:09', '2024-02-05 22:59:09', '', 'DGC4-047', 'DGC4', '1'),
(310, 'মোঃ মঈনুল হোসেন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01911113200', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 22:59:50', '2024-02-05 22:59:50', '', 'DGC4-048', 'DGC4', '1'),
(311, 'সাজিয়া আফরিন লাজু', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01720334125', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:00:38', '2024-02-05 23:00:38', '', 'DGC4-049', 'DGC4', '1'),
(312, 'নাজমুন নাহার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01725061831', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:01:44', '2024-02-05 23:01:44', '', 'DGC4-050', 'DGC4', '1'),
(313, 'মোঃ মাইনুদ্দিন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:02:22', '2024-02-05 23:02:22', '', 'DGC4-051', 'DGC4', '1'),
(314, 'শামীম আহমেদ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:03:06', '2024-02-05 23:03:06', '', 'DGC4-052', 'DGC4', '6'),
(315, 'শেখ মোঃ জসিম উদ্দীন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01755730539', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:04:00', '2024-02-05 23:04:00', '', 'DGC4-053', 'DGC4', '1'),
(316, 'গোবিন্দ খৈতান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01716272270', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:05:29', '2024-02-05 23:05:29', '', 'DGC4-054', 'DGC4', '1'),
(317, 'সুজিত কুমার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0173981034*', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:06:15', '2024-02-05 23:06:15', '', 'DGC4-055', 'DGC4', '1'),
(318, 'মোঃ শফিকুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:06:58', '2024-02-05 23:06:58', '', 'DGC4-056', 'DGC4', '2'),
(319, 'মোঃ আমীর হোসেন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0189299122*', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:07:43', '2024-02-05 23:07:43', '', 'DGC4-057', 'DGC4', '1'),
(320, 'রুবেল মিয়া', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01777999230', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:09:26', '2024-02-05 23:09:26', '', 'DGC4-058', 'DGC4', '6'),
(321, 'মোস্তাফিজুর রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:10:26', '2024-02-05 23:10:26', '', 'DGC4-059', 'DGC4', '4'),
(322, 'লিপিকা রানী ঘোষ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:12:08', '2024-02-05 23:12:08', '', 'DGC4-060', 'DGC4', '1'),
(323, 'মোঃ আতিকুর রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:20:05', '2024-02-05 23:20:05', '', 'DGC4-061', 'DGC4', '1');
INSERT INTO `clients` (`id`, `name`, `father_name`, `mother_name`, `husban_wife_name`, `birth_date`, `religion`, `occupation`, `nationality`, `national_id_no`, `permanent_location`, `permanent_post_office`, `permanent_thana`, `permanent_district`, `temprorary_location`, `temprorary_post_office`, `temprorary_thana`, `temprorary_district`, `tin`, `phone`, `email`, `nid_img`, `passport_img`, `tin_img`, `clientUnderProject`, `created_at`, `updated_at`, `profile_photos`, `client_id`, `selectedBuilding`, `share`) VALUES
(324, 'মোঃ ওসমান গনি ভূঁইয়া', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01916783618', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:20:52', '2024-02-05 23:20:52', '', 'DGC4-062', 'DGC4', '1'),
(325, 'মোহাম্মদ রেজাউল করিম ভূঁইয়া', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01916783618', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:21:58', '2024-02-05 23:21:58', '', 'DGC4-063', 'DGC4', '1'),
(326, 'ফাতেমা আক্তার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01720481076', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:22:38', '2024-02-05 23:22:38', '', 'DGC4-064', 'DGC4', '1'),
(327, 'রাজেশ সাহা', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01797553472', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:23:20', '2024-02-05 23:23:20', '', 'DGC4-065', 'DGC4', '1'),
(328, 'ইমন সাহা গং', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01712526584', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:24:10', '2024-02-05 23:24:10', '', 'DGC4-066', 'DGC4', '1'),
(329, 'রিপা রায়হান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:27:50', '2024-02-05 23:27:50', '', 'DGC4-067', 'DGC4', '1'),
(330, 'আফরোজা খাতুন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01912268505', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:28:37', '2024-02-05 23:28:37', '', 'DGC4-068', 'DGC4', '1'),
(331, 'মোঃ সরোয়ার হোসেন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01911779872', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:29:21', '2024-02-05 23:29:21', '', 'DGC4-069', 'DGC4', '1'),
(332, 'মোঃ নুরুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01620653114', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:30:01', '2024-02-05 23:30:01', '', 'DGC4-070', 'DGC4', '1'),
(333, 'সঞ্জয় কুমার দাস', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01706564744', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:30:49', '2024-02-05 23:30:49', '', 'DGC4-071', 'DGC4', '1'),
(334, 'খালিদা আহমেদ সিদ্দিকী', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01777758200', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:31:32', '2024-02-05 23:31:32', '', 'DGC4-072', 'DGC4', '1'),
(335, 'জাহিদুল হাসান খান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01777758207', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:32:10', '2024-02-05 23:32:10', '', 'DGC4-073', 'DGC4', '1'),
(336, 'সালাহ উদ্দিন মাহমুদ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01777758204', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:32:54', '2024-02-05 23:32:54', '', 'DGC4-074', 'DGC4', '1'),
(337, 'মেজবাহ উদ্দিন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01777758205', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:33:34', '2024-02-05 23:33:34', '', 'DGC4-075', 'DGC4', '1'),
(338, 'সঞ্চিতা দাস', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01912697853', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-05 23:34:18', '2024-02-05 23:34:18', '', 'DGC4-076', 'DGC4', '1'),
(339, 'হুমায়ুন কবীর', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01732170160', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:33:36', '2024-02-06 22:33:36', '', 'PT-001', 'PT', '1'),
(340, 'ফারজানা মণ্ডল', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01732170160', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:36:47', '2024-02-06 22:36:47', '', 'PT-002', 'PT', '1'),
(341, 'আব্দুল হাই', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01725061831', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:37:58', '2024-02-06 22:37:58', '', 'PT-003', 'PT', '1'),
(342, 'শফিকুর রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01715004733', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:38:52', '2024-02-06 22:38:52', '', 'PT-004', 'PT', '2'),
(343, 'বেলাল হোসেন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01616303622', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:39:43', '2024-02-06 22:39:43', '', 'PT-005', 'PT', '3'),
(344, 'রওশন জাহান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01711780464', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:40:28', '2024-02-06 22:40:28', '', 'PT-006', 'PT', '1'),
(345, 'রাশেদুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01550153763', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:41:46', '2024-02-06 22:41:46', '', 'PT-007', 'PT', '2'),
(346, 'কল্যাণ সরকার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01912586226', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:42:35', '2024-02-06 22:42:35', '', 'PT-008', 'PT', '1'),
(347, 'রেজাউল করিম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01713266660', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:43:16', '2024-02-06 22:43:16', '', 'PT-009', 'PT', '1'),
(348, 'তাহমিনা সুলতানা', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01911236244', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:44:00', '2024-02-06 22:44:00', '', 'PT-010', 'PT', '1'),
(349, 'পল্লব কুমার পোদ্দার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01817511148', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:44:39', '2024-02-06 22:44:39', '', 'PT-011', 'PT', '1'),
(350, 'বিপ্লব কুমার পোদ্দার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01772377777', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:45:26', '2024-02-06 22:45:26', '', 'PT-012', 'PT', '1'),
(351, 'স্বপন কুমার সরকার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01712194765', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:46:10', '2024-02-06 22:46:10', '', 'PT-013', 'PT', '1'),
(352, 'এমদাদ হোসেন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01914278105', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:46:51', '2024-02-06 22:46:51', '', 'PT-014', 'PT', '1'),
(353, 'হুমায়ুন কবীর', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01732170160', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:49:21', '2024-02-06 22:49:21', '', 'PT-015', 'PT', '1'),
(354, 'মোঃ লিয়াকত আলী খান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01978510509', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:50:12', '2024-02-06 22:50:12', '', 'PT-016', 'PT', '1'),
(355, 'মোঃ আতিয়া রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01766664045', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:50:59', '2024-02-06 22:50:59', '', 'PT-017', 'PT', '1'),
(356, 'মোঃ আলাউদ্দীন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01870251739', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:51:43', '2024-02-06 22:51:43', '', 'PT-018', 'PT', '1'),
(357, 'হেনা রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01731493992', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:52:27', '2024-02-06 22:52:27', '', 'PT-019', 'PT', '1'),
(358, 'আব্দুল লতিফ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01615024432', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:53:05', '2024-02-06 22:53:05', '', 'PT-020', 'PT', '1'),
(359, 'আব্দুস সামাদ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01670238846', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:53:44', '2024-02-06 22:53:44', '', 'PT-021', 'PT', '1'),
(360, 'কাজী একরামুল', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01925438983', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:54:24', '2024-02-06 22:54:24', '', 'PT-022', 'PT', '1'),
(361, 'হারুন উর রশীদ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01556628972', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:55:03', '2024-02-06 22:55:03', '', 'PT-023', 'PT', '1'),
(362, 'মোঃ হুমায়ুন কবীর', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01748004618', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:55:53', '2024-02-06 22:55:53', '', 'PT-024', 'PT', '1'),
(363, 'মোঃ আতিকুর রহমান/রকি', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01831552603', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:56:39', '2024-02-06 22:56:39', '', 'PT-025', 'PT', '1'),
(364, 'মোঃ হাবিবুর রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01704054516', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:57:22', '2024-02-06 22:57:22', '', 'PT-026', 'PT', '1'),
(365, 'মোঃ আউয়াল', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01710523758', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:58:02', '2024-02-06 22:58:02', '', 'PT-027', 'PT', '1'),
(366, 'মোঃ আব্দুল হালিম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01718468659', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:58:44', '2024-02-06 22:58:44', '', 'PT-028', 'PT', '1'),
(367, 'সাবিহা ইয়াসমিন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01912360543', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 22:59:22', '2024-02-06 22:59:22', '', 'PT-029', 'PT', '1'),
(368, 'রোজিনা আক্তার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01712125771', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 23:00:04', '2024-02-06 23:00:04', '', 'PT-030', 'PT', '2'),
(369, 'শামীম আহম্মেদ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01712125771', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 23:00:53', '2024-02-06 23:00:53', '', 'PT-031', 'PT', '2'),
(370, 'নুর মোহাম্মদ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01716579499', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 23:01:52', '2024-02-06 23:01:52', '', 'PT-032', 'PT', '1'),
(371, 'মরিয়ম বেগম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01988035192', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 23:02:42', '2024-02-06 23:02:42', '', 'PT-033', 'PT', '1'),
(372, 'আলী আহাম্মদ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01728768281', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 23:03:24', '2024-02-06 23:03:24', '', 'PT-034', 'PT', '1'),
(373, 'মোহন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01747273705', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 23:05:00', '2024-02-06 23:05:00', '', 'PT-035', 'PT', '1'),
(374, 'নুরুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01620653114', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 23:05:47', '2024-02-06 23:05:47', '', 'PT-036', 'PT', '2'),
(375, 'সুমী জহির', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01732170160', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 23:06:44', '2024-02-06 23:06:44', '', 'PT-037', 'PT', '2'),
(376, 'উম্মে হাবিবা', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01914831433', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 23:07:22', '2024-02-06 23:07:22', '', 'PT-038', 'PT', '1'),
(377, 'জলিল লস্কর', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01817079665', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 23:10:22', '2024-02-06 23:10:22', '', 'PT-039', 'PT', '2'),
(378, 'হুমায়ুন কবীর', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01732170160', NULL, NULL, '', '', 'PEACE TOWER', '2024-02-06 23:11:04', '2024-02-06 23:11:04', '', 'PT-040', 'PT', '2'),
(379, 'মোঃ সইদুল হক', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '0171723368*', 'null', 'AdminPanel/img/1790268037378060.jpeg', NULL, NULL, 'Dhanmondi garden city', '2024-02-07 09:15:17', '2024-02-07 09:15:17', NULL, 'DGC5-001', 'DGC5', '1'),
(380, 'মোঃ শাহ জালাল', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01712362043', 'null', 'null', NULL, NULL, 'Dhanmondi garden city', '2024-02-07 09:18:06', '2024-02-07 09:18:06', NULL, 'DGC5-002', 'DGC5', '1'),
(381, 'আয়শা', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01717877094', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 09:19:34', '2024-02-07 09:19:34', '', 'DGC5-003', 'DGC5', '1'),
(382, 'মৃদুলা চক্রবর্তী', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01711273976', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 09:24:02', '2024-02-07 09:24:02', '', 'DGC5-004', 'DGC5', '1'),
(383, 'মোঃ মিনহজ উদ্দিন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01784393369', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 09:26:02', '2024-02-07 09:26:02', '', 'DGC5-005', 'DGC5', '1'),
(384, 'মোঃ রেজাওয়ানুল রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01717850184', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 09:27:57', '2024-02-07 09:27:57', '', 'DGC5-006', 'DGC5', '1'),
(385, 'মোঃ জামাল উদ্দিন গং', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0171922384', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 09:29:35', '2024-02-07 09:29:35', '', 'DGC5-007', 'DGC5', '1'),
(386, 'শিরীন রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01723730999', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 09:31:55', '2024-02-07 09:31:55', '', 'DGC5-008', 'DGC5', '1'),
(387, 'মো: আব্দুল রশিদ ওরফে আব্দুল', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01625844012', 'null', 'null', NULL, NULL, 'Dhanmondi garden city', '2024-02-07 09:33:26', '2024-02-07 09:33:26', NULL, 'DGC5-009', 'DGC5', '1'),
(388, 'মোছাঃ রেজি বেগম', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01706078004', 'null', 'null', NULL, NULL, 'Dhanmondi garden city', '2024-02-07 09:34:54', '2024-02-07 09:34:54', NULL, 'DGC5-010', 'DGC5', '2'),
(389, 'মোঃ হাফিজুর রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01823433733', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 09:36:23', '2024-02-07 09:36:23', '', 'DGC5-011', 'DGC5', '1'),
(390, 'মোঃ শাহাদাত হোসেন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 09:37:16', '2024-02-07 09:37:16', '', 'DGC5-012', 'DGC5', '1'),
(391, 'মোছাঃ আয়া পারভীন (ফেন্সি)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 09:39:24', '2024-02-07 09:39:24', '', 'DGC5-013', 'DGC5', '1'),
(392, 'শাহিমা আক্তার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01721279644', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 09:40:56', '2024-02-07 09:40:56', '', 'DGC5-014', 'DGC5', '1'),
(393, 'মোছাঃ উম্মে কুলছুম পিংকি', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01713710965', 'null', 'null', NULL, NULL, 'Dhanmondi garden city', '2024-02-07 09:42:29', '2024-02-07 09:42:29', NULL, 'DGC5-015', 'DGC5', '1'),
(394, 'নাজমা খাতুন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01712649994', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 09:44:51', '2024-02-07 09:44:51', '', 'DGC5-016', 'DGC5', '1'),
(395, 'আমিনুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01717877094', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 09:45:53', '2024-02-07 09:45:53', '', 'DGC5-017', 'DGC5', '1'),
(396, 'মোঃ আব্দুস সালাম', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01714514320', 'null', 'null', NULL, NULL, 'Dhanmondi garden city', '2024-02-07 09:46:41', '2024-02-07 09:46:41', NULL, 'DGC5-018', 'DGC5', '1'),
(397, 'মোঃ আতিকুর রহমান', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01755764567', 'null', 'null', NULL, NULL, 'Dhanmondi garden city', '2024-02-07 09:47:28', '2024-02-07 09:47:28', NULL, 'DGC5-019', 'DGC5', '1'),
(398, 'মোঃ একরামুল মিল্লাত', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01711070884', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 09:48:28', '2024-02-07 09:48:28', '', 'DGC5-020', 'DGC5', '1'),
(399, 'রাশেদ বিন রাজ্জাক', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01911194690', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 09:50:13', '2024-02-07 09:50:13', '', 'DGC5-021', 'DGC5', '1'),
(400, 'ওয়াসিম আকরাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01722828286', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 09:51:22', '2024-02-07 09:51:22', '', 'DGC5-022', 'DGC5', '1'),
(401, 'মোঃ জহিরুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01911750589', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 09:52:28', '2024-02-07 09:52:28', '', 'DGC5-023', 'DGC5', '1'),
(402, 'ছুরাইয়া খাতুন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 09:53:12', '2024-02-07 09:53:12', '', 'DGC5-024', 'DGC5', '1'),
(403, 'মোহাম্মদ তারিকুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01750483773', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 09:54:39', '2024-02-07 09:54:39', '', 'DGC5-025', 'DGC5', '1'),
(404, 'মোছাঃ শামসুন্নাহার', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01823433733', 'null', 'null', NULL, NULL, 'Dhanmondi garden city', '2024-02-07 09:55:49', '2024-02-07 09:55:49', NULL, 'DGC5-026', 'DGC5', '1'),
(405, 'কদম কুমার খইতান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01716272270', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 09:56:59', '2024-02-07 09:56:59', '', 'DGC5-027', 'DGC5', '1'),
(406, 'ফেরদৌসী আক্তার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 09:57:48', '2024-02-07 09:57:48', '', 'DGC5-028', 'DGC5', '1'),
(407, 'শামসুন নাহার কাকন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01718175782', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 09:59:44', '2024-02-07 09:59:44', '', 'DGC5-029', 'DGC5', '1'),
(408, 'মোঃ সাইফুর রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 10:00:32', '2024-02-07 10:00:32', '', 'DGC5-030', 'DGC5', '1'),
(409, 'মোহাম্মদ সরোয়ার আলম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01851282855', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 10:01:36', '2024-02-07 10:01:36', '', 'DGC5-031', 'DGC5', '1'),
(410, 'মোঃ খোরশেদ আলম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01818037070', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 10:02:45', '2024-02-07 10:02:45', '', 'DGC5-032', 'DGC5', '1'),
(411, 'নুসরাত জাহান হাবিবা', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01779099241', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 10:03:41', '2024-02-07 10:03:41', '', 'DGC5-033', 'DGC5', '1'),
(412, 'এস, এম জাকারিয়া আহম্মদ  গং', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01717143145', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 10:05:44', '2024-02-07 10:05:44', '', 'DGC5-034', 'DGC5', '1'),
(413, 'মোঃ মাসুদ রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01917746205', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 10:14:07', '2024-02-07 10:14:07', '', 'DGC5-035', 'DGC5', '1'),
(414, 'মোছাঃ শাহনাজ পারভীন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 10:16:26', '2024-02-07 10:16:26', '', 'DGC5-036', 'DGC5', '1'),
(415, 'মোঃ আহসান  হাবিব', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0181 918 9266', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 10:17:55', '2024-02-07 10:17:55', '', 'DGC5-037', 'DGC5', '1'),
(416, 'আবুল কালাম আজাদ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01772465660', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 22:33:12', '2024-02-07 22:33:12', '', 'DGC7-001', 'DGC7', '1'),
(417, 'মোঃ রেজাউল হক', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01877691306', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 22:35:06', '2024-02-07 22:35:06', '', 'DGC7-002', 'DGC7', '1'),
(418, 'মাহফুজুল হক', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01715418018', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 22:36:38', '2024-02-07 22:36:38', '', 'DGC7-003', 'DGC7', '1'),
(419, 'শেখ বদিউজ্জামান গং', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01312866910', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 22:38:04', '2024-02-07 22:38:04', '', 'DGC7-004', 'DGC7', '1'),
(420, 'এম এম স্বপন রাজা', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01874852369', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 22:39:19', '2024-02-07 22:39:19', '', 'DGC7-005', 'DGC7', '2'),
(421, 'শিরিনা আক্তার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01670405980', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 22:40:23', '2024-02-07 22:40:23', '', 'DGC7-006', 'DGC7', '1'),
(422, 'মোঃ মনিরুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01629027200', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 22:41:38', '2024-02-07 22:41:38', '', 'DGC7-007', 'DGC7', '1'),
(423, 'মোঃ সামছুল হক', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01629027200', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 22:43:29', '2024-02-07 22:43:29', '', 'DGC7-008', 'DGC7', '1'),
(424, 'মোঃ ফরহাদ মাহমুদ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01672415944', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 22:44:56', '2024-02-07 22:44:56', '', 'DGC7-009', 'DGC7', '1'),
(425, 'মোঃ মাসুদ রানা', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01818878622', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 22:46:01', '2024-02-07 22:46:01', '', 'DGC7-010', 'DGC7', '1'),
(426, 'তাছলিমা আক্তার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 22:47:03', '2024-02-07 22:47:03', '', 'DGC7-011', 'DGC7', '1'),
(427, 'মনোরঞ্জন  বিশ্বাস', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01912900810', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 22:51:16', '2024-02-07 22:51:16', '', 'DGC7-012', 'DGC7', '1'),
(428, 'সেজুতি আশরাফি নদী', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01712060245', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 22:52:26', '2024-02-07 22:52:26', '', 'DGC7-013', 'DGC7', '1'),
(429, 'মোঃ জাকির হোসেন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01716411337', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 22:56:35', '2024-02-07 22:56:35', '', 'DGC7-014', 'DGC7', '1'),
(430, 'সাজেদা বেগম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01713041968', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 22:59:10', '2024-02-07 22:59:10', '', 'DGC7-015', 'DGC7', '1'),
(431, 'জান্নাতুল ফেরদাউস', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01713041968', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:00:20', '2024-02-07 23:00:20', '', 'DGC7-016', 'DGC7', '1'),
(432, 'মোঃ সাজেদুর রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01817079665', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:01:20', '2024-02-07 23:01:20', '', 'DGC7-017', 'DGC7', '1'),
(433, 'ফারজানা ইয়াসমিন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:02:36', '2024-02-07 23:02:36', '', 'DGC7-018', 'DGC7', '1'),
(434, 'মোঃ লুৎফর রহমান শেখ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:05:00', '2024-02-07 23:05:00', '', 'DGC7-019', 'DGC7', '1'),
(435, 'গোলাম মতুজা', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:06:24', '2024-02-07 23:06:24', '', 'DGC7-020', 'DGC7', '1'),
(436, 'সাঈদ জুলফিকার মাহমুদ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01712994509', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:07:41', '2024-02-07 23:07:41', '', 'DGC7-021', 'DGC7', '2'),
(437, 'হাসানুল বান্না', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01711083838', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:08:36', '2024-02-07 23:08:36', '', 'DGC7-022', 'DGC7', '1'),
(438, 'কবির হোসেন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:09:28', '2024-02-07 23:09:28', '', 'DGC7-023', 'DGC7', '1'),
(439, 'মোঃ আলম তালুকদার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:10:20', '2024-02-07 23:10:20', '', 'DGC7-024', 'DGC7', '1'),
(440, 'এম ডি জয়নাল আবেদীন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:11:18', '2024-02-07 23:11:18', '', 'DGC7-025', 'DGC7', '1'),
(441, 'মুশরিফ মরিয়ম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01709814292', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:12:32', '2024-02-07 23:12:32', '', 'DGC7-026', 'DGC7', '1'),
(442, 'মীর মুহঃ নাছির উদ্দিন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01741491916', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:13:34', '2024-02-07 23:13:34', '', 'DGC7-027', 'DGC7', '1'),
(443, 'মোঃ বিপুল হক গং', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01717829522', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:14:42', '2024-02-07 23:14:42', '', 'DGC7-028', 'DGC7', '1'),
(444, 'মাহাবুব আলম চৌধুরী গং', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01712114374', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:20:40', '2024-02-07 23:20:40', '', 'DGC7-029', 'DGC7', '1'),
(445, 'মুস্তাফিজুর রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:22:20', '2024-02-07 23:22:20', '', 'DGC7-030', 'DGC7', '1'),
(446, 'মোঃ মাইনুদ্দিন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:23:03', '2024-02-07 23:23:03', '', 'DGC7-031', 'DGC7', '1'),
(447, 'শেখ মোঃ নাসির উদ্দিন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01720553255', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:24:22', '2024-02-07 23:24:22', '', 'DGC7-032', 'DGC7', '1'),
(448, 'তাহেরুজ্জামান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:25:03', '2024-02-07 23:25:03', '', 'DGC7-033', 'DGC7', '1'),
(449, 'মোঃ শফিকুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:25:49', '2024-02-07 23:25:49', '', 'DGC7-034', 'DGC7', '1'),
(450, 'মোঃ নাজমুল হুদা', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:26:33', '2024-02-07 23:26:33', '', 'DGC7-035', 'DGC7', '1'),
(451, 'খন্দকার নাছরিন বেগম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:27:32', '2024-02-07 23:27:32', '', 'DGC7-036', 'DGC7', '1'),
(452, 'এস এম শফিকুর রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:28:26', '2024-02-07 23:28:26', '', 'DGC7-037', 'DGC7', '59'),
(453, 'শাহানাজ আক্তার পপি', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:29:26', '2024-02-07 23:29:26', '', 'DGC7-038', 'DGC7', '1'),
(454, 'মোঃ ফায়েজুর হক সেতু', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:30:22', '2024-02-07 23:30:22', '', 'DGC7-039', 'DGC7', '1'),
(455, 'মোঃ আব্দুর মান্নান মিয়া', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:31:08', '2024-02-07 23:31:08', '', 'DGC7-040', 'DGC7', '1'),
(456, 'মোঃ হাবিবুর রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:31:57', '2024-02-07 23:31:57', '', 'DGC7-041', 'DGC7', '1'),
(457, 'কমল কুমার খৈতান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:33:04', '2024-02-07 23:33:04', '', 'DGC7-042', 'DGC7', '1'),
(458, 'এ টি এম ফকরুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01711977932', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:34:13', '2024-02-07 23:34:13', '', 'DGC7-043', 'DGC7', '1'),
(459, 'মোঃ ইব্রাহীম খলিল', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01711544639', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:35:08', '2024-02-07 23:35:08', '', 'DGC7-044', 'DGC7', '1'),
(460, 'আবুল কালাম আজাদ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01886521972', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:36:00', '2024-02-07 23:36:00', '', 'DGC7-045', 'DGC7', '1'),
(461, 'মোছাঃ আসমা ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01620653114', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:38:14', '2024-02-07 23:38:14', '', 'DGC7-046', 'DGC7', '1'),
(462, 'কমল কুমার খৈতান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:38:58', '2024-02-07 23:38:58', '', 'DGC7-047', 'DGC7', '1'),
(463, 'মোঃ তারিকুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:39:35', '2024-02-07 23:39:35', '', 'DGC7-048', 'DGC7', '1'),
(464, 'মোঃ আবির খান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:40:13', '2024-02-07 23:40:13', '', 'DGC7-049', 'DGC7', '1'),
(465, 'মোঃ সাইফুল ইসলাম খোন্দকার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:41:20', '2024-02-07 23:41:20', '', 'DGC7-050', 'DGC7', '1'),
(466, 'মোঃ জেসমিন নাহার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:42:00', '2024-02-07 23:42:00', '', 'DGC7-051', 'DGC7', '1'),
(467, 'মোঃ আকতার হোসেন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:42:37', '2024-02-07 23:42:37', '', 'DGC7-052', 'DGC7', '1'),
(468, 'এস এম রিয়াজুর রহমান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:43:30', '2024-02-07 23:43:30', '', 'DGC7-053', 'DGC7', '1'),
(469, 'রুবানা ইয়াসমিন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-07 23:44:07', '2024-02-07 23:44:07', '', 'DGC7-054', 'DGC7', '1'),
(470, 'রোকেয়া ছিদ্দিকা রেশমা গং', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01712041250', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-10 23:20:52', '2024-02-10 23:20:52', '', 'DGC5-038', 'DGC5', '1'),
(471, 'গাজী মোহাম্মদ জসীম উদ্দিন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01552630462', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-10 23:22:53', '2024-02-10 23:22:53', '', 'DGC5-039', 'DGC5', '1'),
(472, 'এ কে এম জহিরুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-10 23:24:01', '2024-02-10 23:24:01', '', 'DGC5-040', 'DGC5', '1'),
(473, 'জি এম নাসির উদ্দিন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01718584172', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-10 23:26:10', '2024-02-10 23:26:10', '', 'DGC5-041', 'DGC5', '1'),
(474, 'অনুপ কুমার ঘোষ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01716099087', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-10 23:27:26', '2024-02-10 23:27:26', '', 'DGC5-042', 'DGC5', '1'),
(475, 'মোঃ জাকারিয়া', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01717143145', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-10 23:28:22', '2024-02-10 23:28:22', '', 'DGC5-043', 'DGC5', '1'),
(476, 'ফেরদৌস আকলিমা', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-10 23:29:25', '2024-02-10 23:29:25', '', 'DGC5-044', 'DGC5', '1'),
(477, 'মোহাম্মদ মামুনুর রশিদ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-10 23:30:21', '2024-02-10 23:30:21', '', 'DGC5-045', 'DGC5', '1'),
(478, 'এ টি এম ফেরদৌস প্রধান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01730001819', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-10 23:31:25', '2024-02-10 23:31:25', '', 'DGC5-046', 'DGC5', '1'),
(479, 'মোঃ মমিনুর রশিদ সিদ্দিকী', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01725735697', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-10 23:32:54', '2024-02-10 23:32:54', '', 'DGC5-047', 'DGC5', '1'),
(480, 'বিপুল চন্দ্র দেবনাথ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-10 23:33:39', '2024-02-10 23:33:39', '', 'DGC5-048', 'DGC5', '1'),
(481, 'মোঃ সিরাজুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01718185575', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-10 23:34:34', '2024-02-10 23:34:34', '', 'DGC5-049', 'DGC5', '1'),
(482, 'রাশিদা পারভীন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01718185575', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-10 23:35:25', '2024-02-10 23:35:25', '', 'DGC5-050', 'DGC5', '1'),
(483, 'মোঃ আব্দুল হালিম', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01711226848', NULL, 'null', 'null', 'null', 'Dhanmondi garden city', '2024-02-10 23:36:03', '2024-02-10 23:36:03', 'null', 'DGC5-051', 'DGC5', '1'),
(484, 'মমতাজ বেগম', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01711226848', 'null', 'null', NULL, NULL, 'Dhanmondi garden city', '2024-02-10 23:37:17', '2024-02-10 23:37:17', NULL, 'DGC5-052', 'DGC5', '1'),
(485, 'নূর মোহাম্মদ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01716579499', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-10 23:38:52', '2024-02-10 23:38:52', '', 'DGC5-053', 'DGC5', '1'),
(486, 'গোবিন্দ  খৈতান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01716272270', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-10 23:41:26', '2024-02-10 23:41:26', '', 'DGC5-054', 'DGC5', '1'),
(487, 'অমল কুমার খৈতান', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01716272270', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-10 23:42:23', '2024-02-10 23:42:23', '', 'DGC5-055', 'DGC5', '1'),
(488, 'ফারহানা আক্তার', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-10 23:48:17', '2024-02-10 23:48:17', '', 'DGC5-056', 'DGC5', '2'),
(489, 'মোঃ ইসরাইল হোসেন', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01766681307', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-10 23:49:19', '2024-02-10 23:49:19', '', 'DGC5-057', 'DGC5', '1'),
(490, 'মোঃ তারিকুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-10 23:50:02', '2024-02-10 23:50:02', '', 'DGC5-058', 'DGC5', '1'),
(491, 'মিসেস জোহুরা ফেরদাউস', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01755632873', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-10 23:51:39', '2024-02-10 23:51:39', '', 'DGC5-059', 'DGC5', '1'),
(492, 'মুজাম্মেল হক', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01776046581', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-10 23:53:52', '2024-02-10 23:53:52', '', 'DGC5-060', 'DGC5', '2'),
(493, 'অমল চন্দ্র দেবনাথ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-10 23:54:46', '2024-02-10 23:54:46', '', 'DGC5-061', 'DGC5', '1'),
(494, 'শাহরিয়ার রশীদ', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01713289119', 'null', 'null', NULL, NULL, 'Dhanmondi garden city', '2024-02-10 23:56:03', '2024-02-10 23:56:03', NULL, 'DGC5-062', 'DGC5', '1'),
(495, 'মোঃ জালাল উদ্দিন প্রামানিক', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-10 23:56:58', '2024-02-10 23:56:58', '', 'DGC5-063', 'DGC5', '2'),
(496, 'মোঃ জাহাঙ্গীর আলম', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01730013463', 'null', 'null', NULL, NULL, 'Dhanmondi garden city', '2024-02-10 23:57:57', '2024-02-10 23:57:57', NULL, 'DGC5-064', 'DGC5', '1'),
(497, 'মোঃ মাহিদুল ইসলাম', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01711312857', 'null', 'null', NULL, NULL, 'Dhanmondi garden city', '2024-02-10 23:58:39', '2024-02-10 23:58:39', NULL, 'DGC5-065', 'DGC5', '1'),
(498, 'মোঃ শফিকুল ইসলাম', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01711683644', 'null', 'null', NULL, NULL, 'Dhanmondi garden city', '2024-02-10 23:59:23', '2024-02-10 23:59:23', NULL, 'DGC5-066', 'DGC5', '1'),
(499, 'মোঃ শফিকুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '00', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-11 00:00:10', '2024-02-11 00:00:10', '', 'DGC5-067', 'DGC5', '1'),
(500, 'মোঃ মারুফ হোসেন মন্ডল', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01711517193', 'null', 'null', NULL, NULL, 'Dhanmondi garden city', '2024-02-11 00:01:23', '2024-02-11 00:01:23', NULL, 'DGC5-068', 'DGC5', '1'),
(501, 'সীমা সিদ্দিক', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01732705145', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-11 00:02:15', '2024-02-11 00:02:15', '', 'DGC5-069', 'DGC5', '1'),
(502, 'গোলাম মোস্তফা লিটন', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01711666498', 'null', 'null', NULL, NULL, 'Dhanmondi garden city', '2024-02-11 00:03:16', '2024-02-11 00:03:16', NULL, 'DGC5-070', 'DGC5', '1'),
(503, 'মোঃ ইউসূফ আলী', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01711310453', 'null', 'null', NULL, NULL, 'Dhanmondi garden city', '2024-02-11 00:04:11', '2024-02-11 00:04:11', NULL, 'DGC5-071', 'DGC5', '2'),
(504, 'মোঃ আকতার হোসেন', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01711362012', 'null', 'null', NULL, NULL, 'Dhanmondi garden city', '2024-02-11 00:05:07', '2024-02-11 00:05:07', NULL, 'DGC5-072', 'DGC5', '0'),
(505, 'মোঃ সাইফুল ইসলাম', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01711242207', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-11 00:06:01', '2024-02-11 00:06:01', '', 'DGC5-073', 'DGC5', '0'),
(506, 'সাদিয়া আক্তার নিপা', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '447493875648', NULL, NULL, '', '', 'Dhanmondi garden city', '2024-02-11 00:07:04', '2024-02-11 00:07:04', '', 'DGC5-074', 'DGC5', '1'),
(507, 'সামসুদ্দীন মন্টু', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01720908566', 'null', 'null', NULL, NULL, 'Dhanmondi garden city', '2024-02-11 00:08:20', '2024-02-11 00:08:20', NULL, 'DGC5-075', 'DGC5', '0'),
(508, 'নাহিদ নেওয়াজ', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', '01738482464', 'null', 'null', NULL, NULL, 'Dhanmondi garden city', '2024-02-11 00:09:05', '2024-02-11 00:09:05', NULL, 'DGC5-076', 'DGC5', '0'),
(509, 'Quaerat nisi facere', 'Quo ipsum ex in eu', 'Minim voluptates del', 'Sapiente et sit dol', '1989-10-03', 'Vero esse dolorem l', 'Accusamus recusandae', 'Aperiam aut vero num', 'Voluptatem temporib', 'Tenetur et et ducimu', 'Hic distinctio Duci', 'Natus reprehenderit', 'Tempore accusamus u', 'Quo tempora eiusmod', 'Eligendi qui tempor', 'Voluptatem ullam quo', 'Elit in sint et in', 'Ex numquam consectet', 'Reiciendis obcaecati', 'noqonuh@mailinator.com', 'AdminPanel/img/1794348911408739.jpeg', 'AdminPanel/img/1794348911443061.jpeg', 'AdminPanel/img/1794348911474153.jpeg', 'Dream Tower', '2024-03-23 14:07:51', '2024-03-23 14:07:51', 'AdminPanel/img/1794348911504678.jpeg', 'DT-047', 'DT', '53');
INSERT INTO `clients` (`id`, `name`, `father_name`, `mother_name`, `husban_wife_name`, `birth_date`, `religion`, `occupation`, `nationality`, `national_id_no`, `permanent_location`, `permanent_post_office`, `permanent_thana`, `permanent_district`, `temprorary_location`, `temprorary_post_office`, `temprorary_thana`, `temprorary_district`, `tin`, `phone`, `email`, `nid_img`, `passport_img`, `tin_img`, `clientUnderProject`, `created_at`, `updated_at`, `profile_photos`, `client_id`, `selectedBuilding`, `share`) VALUES
(510, 'Iste et quisquam lab', 'Sed excepturi commod', 'Rerum nobis aperiam', 'Numquam cillum place', '2008-08-18', 'Pariatur Ipsum quis', 'Et anim dolores assu', 'Ipsam libero atque p', 'Vel qui sint consect', 'Doloribus quasi ut s', 'Numquam iusto volupt', 'Pariatur Dignissimo', 'Est exercitationem d', 'Labore non officia t', 'Esse Nam non ut ex e', 'Magni quo illum adi', 'Quos magni mollit do', 'Et id enim illo quib', 'Autem tempor eu cons', 'love@mailinator.com', 'AdminPanel/img/1794350796500117.jpeg', 'AdminPanel/img/1794350796538643.jpeg', 'AdminPanel/img/1794350796569828.jpeg', 'Unique Tower', '2024-03-23 14:37:49', '2024-03-23 14:37:49', 'AdminPanel/img/1794350818773105.png', 'UT-018', 'UT', '4'),
(511, 'Animi ratione quod', 'Aut molestiae incidu', 'Non in dolor rerum s', 'Aut iure voluptatem', '2013-08-02', 'Est rerum aut eu est', 'Repudiandae quidem s', 'Eius quia necessitat', 'Quas fugit perferen', 'Aliquam cupiditate p', 'Eu sint exercitation', 'Itaque voluptatem E', 'Totam laborum Dolor', 'Ea asperiores atque', 'Nemo proident non e', 'Repudiandae dolorem', 'Cupidatat et aut exp', 'Quis eum ipsa ullam', 'Quos nihil voluptati', 'cidom@mailinator.com', 'AdminPanel/img/1794352710341136.png', 'AdminPanel/img/1794352710558532.png', 'AdminPanel/img/1794352710769164.png', 'PEACE TOWER', '2024-03-23 15:08:15', '2024-03-23 15:08:15', 'AdminPanel/img/1794352711030636.png', 'PT-041', 'PT', '93');

-- --------------------------------------------------------

--
-- Table structure for table `client_statuses`
--

CREATE TABLE `client_statuses` (
  `id` bigint UNSIGNED NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `construction_histories`
--

CREATE TABLE `construction_histories` (
  `id` bigint UNSIGNED NOT NULL,
  `basic_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selectedProject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selectedBuilding` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `required_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `extra_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `due_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `construction_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `select_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `share` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `construction_pays`
--

CREATE TABLE `construction_pays` (
  `id` bigint UNSIGNED NOT NULL,
  `basic_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selectedProject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selectedBuilding` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `construction_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `physical_voucher` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `selectedPaymentType` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cash_bank_account` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_cheque_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_cheque_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_branch` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Supporting_docs` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `construction_pays`
--

INSERT INTO `construction_pays` (`id`, `basic_date`, `client_name`, `client_id`, `selectedProject`, `selectedBuilding`, `paid_amount`, `note`, `created_at`, `updated_at`, `construction_id`, `physical_voucher`, `selectedPaymentType`, `cash_bank_account`, `bank_cheque_no`, `bank_cheque_date`, `bank_name`, `bank_branch`, `Supporting_docs`) VALUES
(67, '2022-04-16', 'হুমায়ুন কবীর', 'DT-001', 'Dream Tower', 'DT', '1000000', 'construction', '2024-02-02 09:58:03', '2024-03-25 08:10:11', 'BREgk93908', '12345678', 'Cash', NULL, NULL, NULL, NULL, '', 'documents/660185c3a06dc'),
(68, '2023-09-13', 'হুমায়ুন কবীর', 'DT-001', 'Dream Tower', 'DT', '400000', 'biplob', '2024-02-02 09:59:21', '2024-02-02 12:37:03', 'BREgk93908', '264', 'Cash', NULL, NULL, NULL, NULL, '', 'documents/65bd364fd99deহুমায়ুন কবির DT-001.pdf'),
(70, '2024-01-31', 'হুমায়ুন কবীর', 'DT-001', 'Dream Tower', 'DT', '400000', 'Biplob', '2024-02-02 10:02:23', '2024-02-02 12:37:13', 'BREgk93908', '00', 'Cash', NULL, NULL, NULL, NULL, '', 'documents/65bd3659d4bf7হুমায়ুন কবির DT-001.pdf'),
(71, '2022-04-16', 'মোঃ আব্দুল হাই', 'DT-002', 'Dream Tower', 'DT', '1000000', 'Humayun sir', '2024-02-02 10:03:34', '2024-02-02 12:38:56', 'BREgk93908', '00', 'Cash', NULL, NULL, NULL, NULL, '', 'documents/65bd36c04ac08মোঃ আব্দুল হাই  .pdf'),
(72, '2023-09-13', 'মোঃ আব্দুল হাই', 'DT-002', 'Dream Tower', 'DT', '400000', 'Biplob', '2024-02-02 10:04:59', '2024-02-02 12:39:11', 'BREgk93908', '264', 'Cash', NULL, NULL, NULL, NULL, '', 'documents/65bd36cf94442মোঃ আব্দুল হাই  .pdf'),
(73, '2024-01-31', 'মোঃ আব্দুল হাই', 'DT-002', 'Dream Tower', 'DT', '400000', 'construction', '2024-02-02 10:05:36', '2024-02-02 10:07:21', 'BREgk93908', '373', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(74, '2024-01-31', 'মোঃ আব্দুল হাই', 'UT-003', 'Unique Tower', 'UT', '300000', 'plan design & pilling', '2024-02-02 10:14:21', '2024-02-02 12:39:23', 'GPllG45540', '211', 'Cash', NULL, NULL, NULL, NULL, '', 'documents/65bd36db26bdbমোঃ আব্দুল হাই  .pdf'),
(75, '2023-08-12', 'মোঃ মাসুদ রানা', 'UT-005', 'Unique Tower', 'UT', '400000', 'plan design & pilling    ( HK sir )', '2024-02-02 10:17:09', '2024-03-23 13:26:19', 'GPllG45540', '201', 'Cash', NULL, NULL, NULL, NULL, '', 'documents/65ff2cdb9011aeugene-golovesov-uw8jNJ9qgQg-unsplash.jpg'),
(76, '2024-01-05', 'মোঃ মাসুদ রানা', 'UT-005', 'Unique Tower', 'UT', '500000', 'plan design & pilling  HK SIR', '2024-02-02 10:18:23', '2024-03-23 13:27:09', 'GPllG45540', '205', 'Cash', NULL, NULL, NULL, NULL, '', 'documents/65ff2d0d006c0eugene-golovesov-CP59qLdFHhE-unsplash.jpg'),
(77, '2024-01-04', 'মোঃ বজলুল রহমান', 'UT-006', 'Unique Tower', 'UT', '150000', 'plan design & pilling', '2024-02-02 10:22:07', '2024-03-23 13:24:39', 'GPllG45540', '208', 'Cash', NULL, NULL, NULL, NULL, '', 'documents/65ff2c77cd6eabeautiful spring day.png'),
(78, '2024-01-04', 'মোঃ শাহজাহান', 'UT-011', 'Unique Tower', 'UT', '100000', 'plan design & pilling  HK SIR', '2024-02-02 10:23:59', '2024-03-23 13:30:53', 'GPllG45540', '204', 'Cash', NULL, NULL, NULL, NULL, '', 'documents/65ff2deddcbacfile-sample_1MB.docx'),
(79, '2024-01-22', 'মোঃ শহিদুল্লাহ', 'UT-010', 'Unique Tower', 'UT', '250000', 'plan design & pilling', '2024-02-02 10:25:03', '2024-02-02 10:25:03', 'GPllG45540', '206', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(80, '2024-01-26', 'মোঃ বজলুল রহমান', 'UT-006', 'Unique Tower', 'UT', '150000', 'plan design & pilling', '2024-02-02 10:27:39', '2024-02-02 10:27:39', 'GPllG45540', '208', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(81, '2024-01-29', 'মোস্তাফিজুর রহমান', 'UT-008', 'Unique Tower', 'UT', '300000', 'plan design & pilling', '2024-02-02 10:28:31', '2024-02-02 10:28:31', 'GPllG45540', '210', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(82, '2022-03-06', 'এস এম জাকারিয়া', 'DT-004', 'Dream Tower', 'DT', '50000', 'HK', '2024-02-02 10:53:05', '2024-03-23 13:30:00', 'BREgk93908', '00', 'Cash', NULL, NULL, NULL, NULL, '', 'documents/65ff2db834b45beautiful spring day.png'),
(83, '2022-03-06', 'এস এম জাকারিয়া', 'DT-004', 'Dream Tower', 'DT', '100000', 'HK', '2024-02-02 10:54:00', '2024-03-25 07:42:14', 'BREgk93908', '022', 'Cash', NULL, NULL, NULL, NULL, '', 'documents/66017f363879beugene-golovesov-uw8jNJ9qgQg-unsplash.jpg'),
(84, '2022-07-01', 'এস এম জাকারিয়া', 'DT-004', 'Dream Tower', 'DT', '100000', 'plan design & pilling', '2024-02-02 10:54:41', '2024-02-02 10:54:41', 'BREgk93908', '071', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(85, '2022-10-06', 'আনোয়ার হোসেন', 'DT-005', 'Dream Tower', 'DT', '150000', 'construction', '2024-02-02 10:56:02', '2024-03-23 13:26:36', 'BREgk93908', '98', 'Cash', NULL, NULL, NULL, NULL, '', 'documents/65ff2cec96246eugene-golovesov-CP59qLdFHhE-unsplash.jpg'),
(86, '2023-01-01', 'এস এম জাকারিয়া', 'DT-004', 'Dream Tower', 'DT', '150000', 'construction', '2024-02-02 11:01:47', '2024-02-02 11:01:47', 'BREgk93908', '139', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(87, '2022-10-06', 'এস এম জাকারিয়া', 'DT-004', 'Dream Tower', 'DT', '150000', 'construction', '2024-02-02 11:04:08', '2024-02-02 11:04:08', 'BREgk93908', '98', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(88, '2023-02-28', 'এস এম জাকারিয়া', 'DT-004', 'Dream Tower', 'DT', '200000', 'construction', '2024-02-02 11:05:40', '2024-03-25 07:38:18', 'BREgk93908', '158', 'Cash', NULL, NULL, NULL, NULL, '', 'documents/66017e4ae6c82beautiful spring day.png'),
(89, '2023-04-15', 'এস এম জাকারিয়া', 'DT-004', 'Dream Tower', 'DT', '150000', 'Cash  Biplob', '2024-02-02 11:06:36', '2024-02-02 11:06:36', 'BREgk93908', '185', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(90, '2023-06-18', 'এস এম জাকারিয়া', 'DT-004', 'Dream Tower', 'DT', '100000', 'cash biplob', '2024-02-02 11:07:22', '2024-03-23 13:29:43', 'BREgk93908', '00', 'Cash', NULL, NULL, NULL, NULL, '', 'documents/65ff2da720492eugene-golovesov-CP59qLdFHhE-unsplash.jpg'),
(91, '2023-08-03', 'এস এম জাকারিয়া', 'DT-004', 'Dream Tower', 'DT', '100000', 'cash Biplob', '2024-02-02 11:08:13', '2024-02-02 11:08:13', 'BREgk93908', '237', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(92, '2023-10-28', 'এস এম জাকারিয়া', 'DT-004', 'Dream Tower', 'DT', '100000', 'construction', '2024-02-02 11:09:17', '2024-02-02 12:42:35', 'BREgk93908', '00', 'Cash', NULL, NULL, NULL, NULL, '', 'documents/65bd379b665b9এস এম জাকারিয়া .pdf'),
(94, '2024-01-23', 'ডাঃ ইদ্রিস আলী', 'DT-003', 'Dream Tower', 'DT', '2100000', 'bank', '2024-02-02 11:30:06', '2024-02-02 11:37:17', 'BREgk93908', '040', 'Cash', NULL, NULL, NULL, NULL, '', 'documents/65bd284d10e8cজনাব ডঃ ইদ্রিস আলী .pdf'),
(95, '2023-12-19', 'আনোয়ার হোসেন', 'DT-005', 'Dream Tower', 'DT', '1750000', 'নগদ  বিপ্লব', '2024-02-02 12:45:44', '2024-02-02 12:45:44', 'BREgk93908', '348', 'Cash', NULL, NULL, NULL, NULL, '', 'documents/65bd3858dd189মোঃ আনোয়ার হোসেন .pdf'),
(96, '2024-01-28', 'মোঃ গোলাম কবীর', 'DT-006', 'Dream Tower', 'DT', '1800000', 'Bank', '2024-02-02 12:48:04', '2024-02-02 12:48:04', 'BREgk93908', '342', 'Cash', NULL, NULL, NULL, NULL, '', 'documents/65bd38e408478মোঃ গোলাম কবির.pdf'),
(97, '2024-01-13', 'মোঃ শামীম হাওলাদার', 'DT-007', 'Dream Tower', 'DT', '1700000', 'cash 11/02/2022 to 13/01/2024', '2024-02-02 22:49:12', '2024-02-03 01:22:12', 'BREgk93908', '354', 'Cash', NULL, NULL, NULL, NULL, '', 'documents/65bde9a4e9665শামীম হোসেন হাওলাদার সবুজ .pdf'),
(98, '2023-11-23', 'মোঃ জোবায়ের হোসেন', 'DT-008', 'Dream Tower', 'DT', '1600000', '24/10/2021 to 23/11/2023', '2024-02-02 22:57:20', '2024-02-03 01:23:47', 'BREgk93908', '327', 'Cash', NULL, NULL, NULL, NULL, '', 'documents/65bdea03aa5d9মোঃ জোবায়ের হোসেন .pdf'),
(99, '2024-01-26', 'মোঃ শফিকুল ইসলাম', 'DT-009', 'Dream Tower', 'DT', '1550000', 'নগদ  ৬/৩/২২ থেকে ২৬/০১/২০২৪  তারিখ পর্যন্ত হিসাব', '2024-02-03 01:30:14', '2024-02-03 01:30:14', 'BREgk93908', '370', 'Cash', NULL, NULL, NULL, NULL, '', 'documents/65bdeb867062dমোঃ শফিকুল ইসলাম .pdf'),
(100, '2023-01-11', 'এস এম রিয়াজুর রহমান', 'DT-010', 'Dream Tower', 'DT', '1100000', 'নগদ ৬/৬/২২ থেকে ১/১১/২৪  তারিখ পর্যন্ত', '2024-02-03 01:33:15', '2024-02-03 01:33:15', 'BREgk93908', '247', 'Cash', NULL, NULL, NULL, NULL, '', 'documents/65bdec3be762aএস এম রিয়াজুর রহমান .pdf'),
(101, '2023-08-11', 'কাওসার আলম', 'DT-011', 'Dream Tower', 'DT', '1900000', 'নগদ  ১৩/০২/২০২২ থেকে ০৮/১১/২০২৩ তারিখ পর্যন্ত হিসাব', '2024-02-03 02:27:08', '2024-02-03 02:27:08', 'BREgk93908', '309', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(102, '2024-01-24', 'হাকিকুর রহমান', 'DT-012', 'Dream Tower', 'DT', '1500000', 'নগদ  ১১/০২/২০২১ থেকে ২৪/০১/২০২৪ তারিখ পর্যন্ত হিসাব', '2024-02-03 02:30:42', '2024-02-03 02:30:42', 'BREgk93908', '368', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(103, '2023-11-30', 'আতিকুর রহমান(রেজাউল)', 'DT-013', 'Dream Tower', 'DT', '1600000', 'নগদ  ০৭/০৪/২০২২ থেকে ৩০/১১/২০২৩ তারিখ পর্যন্ত হিসাব ব্যাংক জমা ৮ বার ,নগদ ২ বার', '2024-02-03 02:34:34', '2024-02-03 02:34:34', 'BREgk93908', '352', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(104, '0023-01-25', 'মোঃ আজহারুল ইসলাম', 'DT-014', 'Dream Tower', 'DT', '1600000', 'নগদ  ০৭/০৪/২০২২ থেকে ২৫/০১/২০২৩ তারিখ পর্যন্ত হিসাব', '2024-02-03 02:36:57', '2024-02-03 02:36:57', 'BREgk93908', '366', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(105, '2023-12-18', 'মোঃ কামরুজ্জামান বাচ্চু', 'DT-015', 'Dream Tower', 'DT', '1700000', 'নগদ  ১৩/০২/২০২২ থেকে ০৮/১১/২০২৩ তারিখ পর্যন্ত হিসাব ব্যাংক জমা।', '2024-02-03 02:39:10', '2024-02-03 02:39:10', 'BREgk93908', '343', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(106, '2023-12-11', 'আব্দুল কাদের', 'DT-016', 'Dream Tower', 'DT', '3100000', 'নগদ  ০৭/০৪/২০২২ থেকে ১২/১১/২০২৩ তারিখ পর্যন্ত হিসাব', '2024-02-03 02:43:50', '2024-02-03 02:43:50', 'BREgk93908', '৩৩৯', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(107, '2024-01-24', 'খুরশীদ আলম', 'DT-017', 'Dream Tower', 'DT', '1600000', 'নগদ  14/03/22 থেকে 14/01/2024 তারিখ পর্যন্ত হিসাব', '2024-02-03 02:48:07', '2024-02-03 02:48:07', 'BREgk93908', '00', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(108, '2023-02-10', 'রাশেদ আহমেদ', 'DT-018', 'Dream Tower', 'DT', '1000000', 'নগদ  14/03/22 থেকে 02/0110/2023 তারিখ পর্যন্ত হিসাব', '2024-02-03 02:52:34', '2024-02-03 02:52:34', 'BREgk93908', '00', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(109, '2022-03-30', 'আকতার  হোসেন', 'DT-019', 'Dream Tower', 'DT', '1700000', 'নগদ  30/03/2022 থেকে 13/01/2024 তারিখ পর্যন্ত হিসাব', '2024-02-03 02:54:53', '2024-02-03 02:54:53', 'BREgk93908', '00', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(110, '2022-03-30', 'শচীন সরকার', 'DT-020', 'Dream Tower', 'DT', '1700000', 'নগদ  30/03/2022 থেকে 13/01/2024 তারিখ পর্যন্ত হিসাব', '2024-02-03 02:56:48', '2024-02-03 02:56:48', 'BREgk93908', '00', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(111, '2022-03-30', 'মোঃ কামরুজ্জামান', 'DT-021', 'Dream Tower', 'DT', '3200000', 'নগদ  30/03/2022 থেকে 11/01/2024 তারিখ পর্যন্ত হিসাব', '2024-02-03 02:58:21', '2024-02-03 02:58:21', 'BREgk93908', '350', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(112, '2024-01-11', 'শাম্মী আকতার', 'DT-022', 'Dream Tower', 'DT', '1600000', 'নগদ  30/03/20022 থেকে 11/01/2024 তারিখ পর্যন্ত হিসাব', '2024-02-03 03:00:33', '2024-02-03 03:00:33', 'BREgk93908', '351', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(113, '2023-12-17', 'মোঃ শামছুল আলম', 'DT-023', 'Dream Tower', 'DT', '1500000', 'নগদ  1/10/2019 থেকে 17/12/2023 তারিখ পর্যন্ত হিসাব', '2024-02-03 03:03:19', '2024-02-03 03:03:19', 'BREgk93908', '344', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(114, '2024-01-11', 'মোঃ শুকুর আলী', 'DT-024', 'Dream Tower', 'DT', '1500000', 'নগদ  25/11/2019 থেকে 11/01/2024 তারিখ পর্যন্ত হিসাব', '2024-02-03 03:05:36', '2024-02-03 03:05:36', 'BREgk93908', '353', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(115, '2023-11-12', 'মোঃ নূরুল ইসলাম', 'DT-025', 'Dream Tower', 'DT', '1500000', 'নগদ  01/10/2022 থেকে 12/11/2023 তারিখ পর্যন্ত হিসাব', '2024-02-03 03:09:26', '2024-02-03 03:09:26', 'BREgk93908', '314', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(116, '2024-01-29', 'দেলোয়ার হোসেন', 'DT-026', 'Dream Tower', 'DT', '1800000', 'নগদ  07/01/2023 থেকে 29/01/2024 তারিখ পর্যন্ত হিসাব', '2024-02-03 03:14:17', '2024-02-03 03:14:17', 'BREgk93908', '372', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(117, '2023-11-18', 'আয়েশা আক্তার', 'DT-027', 'Dream Tower', 'DT', '1800000', '( নগদ 09/11/2021 থেকে 18/11/2023 তারিখ পর্যন্ত হিসাব )', '2024-02-03 12:53:00', '2024-02-03 12:53:00', 'BREgk93908', '320', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(118, '2023-07-12', 'মোঃ রাসেল মাহমুদ', 'DT-028', 'Dream Tower', 'DT', '3500000', '( নগদ 10/03/2022 থেকে 07/12/2023 তারিখ পর্যন্ত হিসাব )', '2024-02-03 12:54:54', '2024-02-03 12:54:54', 'BREgk93908', '332', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(119, '2023-04-17', 'ফারহানা জুবাইদা', 'DT-029', 'Dream Tower', 'DT', '1000000', '( নগদ 23/08/2022 থেকে 17/04/2023 তারিখ পর্যন্ত হিসাব )', '2024-02-03 12:57:09', '2024-02-03 12:57:09', 'BREgk93908', '190', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(120, '2023-11-27', 'মোঃ জয়নাল আবেদীন', 'DT-030', 'Dream Tower', 'DT', '1500000', '( নগদ 14/02/2021 থেকে 27/11/2023 তারিখ পর্যন্ত হিসাব ) ব্যাংক এর মাদ্ধমে', '2024-02-03 12:59:41', '2024-02-03 12:59:41', 'BREgk93908', '333', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(121, '2023-12-12', 'আফরুজা পারভীন', 'DT-031', 'Dream Tower', 'DT', '1700000', '( নগদ 15/09/2022 থেকে 12/12/2023 তারিখ পর্যন্ত হিসাব )', '2024-02-03 13:01:02', '2024-02-03 13:01:02', 'BREgk93908', '337', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(122, '2023-01-11', 'সালমা জাহান', 'DT-032', 'Dream Tower', 'DT', '1450000', '( নগদ 07/04/2022 থেকে 01/11/2023 তারিখ পর্যন্ত হিসাব )', '2024-02-03 13:02:54', '2024-02-03 13:02:54', 'BREgk93908', '303', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(123, '2023-10-12', 'মিজানুর রহমান/রিতা', 'DT-033', 'Dream Tower', 'DT', '1300000', '( নগদ 9/09/2022 থেকে 10/12/2023 তারিখ পর্যন্ত হিসাব )', '2024-02-03 13:04:42', '2024-02-03 13:04:42', 'BREgk93908', '334', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(124, '2023-12-18', 'যতীশ কুমার শান্ত', 'DT-034', 'Dream Tower', 'DT', '1650000', '( নগদ 02/10/2022 থেকে 18/12/2023 তারিখ পর্যন্ত হিসাব )', '2024-02-03 13:07:00', '2024-02-03 13:07:00', 'BREgk93908', '346', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(125, '2023-12-11', 'সাজ্জাদ হোসেন', 'DT-035', 'Dream Tower', 'DT', '1750000', '( নগদ 01/01/2023 থেকে 14/11/2023 তারিখ পর্যন্ত হিসাব )', '2024-02-03 13:09:04', '2024-02-03 13:09:04', 'BREgk93908', '354', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(126, '2023-11-30', 'ফরহাদ হোসেন', 'DT-036', 'Dream Tower', 'DT', '1450000', '( নগদ 25/11/2022 থেকে 30/11/2023 তারিখ পর্যন্ত হিসাব )', '2024-02-03 13:10:48', '2024-02-03 13:10:48', 'BREgk93908', '335', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(127, '2023-11-15', 'মোঃ শফিকুল ইসলাম', 'DT-037', 'Dream Tower', 'DT', '1700000', '( নগদ 15/12/2022 থেকে 15/11/2023 তারিখ পর্যন্ত হিসাব )', '2024-02-03 13:12:01', '2024-02-03 13:12:01', 'BREgk93908', '310', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(128, '2024-01-11', 'ওমর ফারুক খান', 'DT-038', 'Dream Tower', 'DT', '1550000', '( নগদ 03/12/2022 থেকে 11/01/2024 তারিখ পর্যন্ত হিসাব )', '2024-02-03 13:13:27', '2024-02-03 13:13:27', 'BREgk93908', '365', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(129, '2023-12-18', 'সোহেল রানা', 'DT-039', 'Dream Tower', 'DT', '1600000', '( নগদ 02/01/2023 থেকে 18/12/2023 তারিখ পর্যন্ত হিসাব )', '2024-02-03 13:14:40', '2024-02-03 13:14:40', 'BREgk93908', '00', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(130, '2024-01-25', 'মাহমুদুর রহমান জামাল', 'DT-040', 'Dream Tower', 'DT', '6800000', '( নগদ 25/12/2022 থেকে 25/01/2024 তারিখ পর্যন্ত হিসাব )', '2024-02-03 13:16:00', '2024-02-03 13:16:00', 'BREgk93908', '367', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(131, '2024-01-23', 'লিটন কুমার দাস', 'DT-041', 'Dream Tower', 'DT', '3300000', '( নগদ 06/03/2023 থেকে 23/01/20234তারিখ পর্যন্ত হিসাব )', '2024-02-03 13:17:11', '2024-02-03 13:17:11', 'BREgk93908', '359', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(132, '2023-11-12', 'পলাশ মন্ডল', 'DT-042', 'Dream Tower', 'DT', '1700000', '( নগদ 25/12/2022 থেকে 11/12/2023 তারিখ পর্যন্ত হিসাব ) ব্যাংক এর মাদ্ধমে', '2024-02-03 13:19:05', '2024-02-03 13:19:05', 'BREgk93908', '৩৩৮', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(133, '2024-01-15', 'মোঃ সজীব হোসেন', 'DT-043', 'Dream Tower', 'DT', '1700000', '( নগদ 13/02/2023 থেকে 18/12/2023 তারিখ পর্যন্ত হিসাব )', '2024-02-03 13:21:16', '2024-02-03 13:21:16', 'BREgk93908', '341', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(134, '2023-12-29', 'মোঃ আলাউদ্দিন ফারুক', 'DT-044', 'Dream Tower', 'DT', '1700000', '( নগদ 29/12/2022 থেকে29/12/2023 তারিখ পর্যন্ত হিসাব )', '2024-02-03 13:23:01', '2024-02-03 13:23:01', 'BREgk93908', '349', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(135, '2024-01-13', 'মোঃ সজীব মোল্লা', 'DT-045', 'Dream Tower', 'DT', '1600000', '( নগদ 10/03/2023 থেকে 13/01/2024 তারিখ পর্যন্ত হিসাব )', '2024-02-03 13:26:23', '2024-02-03 13:26:23', 'BREgk93908', '00', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(136, '2024-01-13', 'হারুন-অর-রশীদ', 'DT-046', 'Dream Tower', 'DT', '1750000', '( নগদ 04/07/2023 থেকে 13/01/2024 তারিখ পর্যন্ত হিসাব )', '2024-02-03 13:27:33', '2024-02-03 13:27:33', 'BREgk93908', '355', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(137, '2024-02-05', 'মোঃ জয়নাল আবেদীন', 'DT-030', 'Dream Tower', 'DT', '200000', 'Construction', '2024-02-05 05:44:18', '2024-02-05 05:44:18', 'BREgk93908', '374', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(138, '2024-02-04', 'আব্দুল কাদের', 'DT-016', 'Dream Tower', 'DT', '500000', 'Construction', '2024-02-05 13:09:46', '2024-02-05 13:15:38', 'BREgk93908', '374', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(139, '2024-01-02', 'মোঃ কামরুজ্জামান বাচ্চু', 'DT-015', 'Dream Tower', 'DT', '100000', 'Construction', '2024-02-05 13:11:43', '2024-02-05 13:11:43', 'BREgk93908', '376', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(141, '2024-01-23', 'আতিকুর রহমান(রেজাউল)', 'DT-013', 'Dream Tower', 'DT', '100000', 'Construction', '2024-02-08 23:12:22', '2024-02-08 23:12:22', 'BREgk93908', '00', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(142, '2023-01-19', 'মোহাম্মদ রফিকুল ইসলাম', 'DGC4-012', 'Dhanmondi garden city', 'DGC4', '100000', 'plan & Design', '2024-02-19 11:45:16', '2024-02-19 11:45:16', 'XcOTL64851', '001', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(143, '2023-01-19', 'মোঃ আলমগীর মিয়া', 'DGC4-014', 'Dhanmondi garden city', 'DGC4', '100000', 'plan & Design', '2024-02-19 11:49:14', '2024-02-19 11:49:14', 'XcOTL64851', '002', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(144, '2023-01-20', 'মোঃ মঈনুল হোসেন', 'DGC4-048', 'Dhanmondi garden city', 'DGC4', '100000', 'plan & Design', '2024-02-19 11:58:05', '2024-02-19 11:58:05', 'XcOTL64851', '003', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(145, '2023-01-20', 'মোছাঃ মনিরা পারভীন', 'DGC4-044', 'Dhanmondi garden city', 'DGC4', '100000', 'plan & Design', '2024-02-19 12:01:41', '2024-02-19 12:01:41', 'XcOTL64851', '004', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(146, '2023-01-20', 'এস এম নুরুল ইসলাম', 'DGC4-045', 'Dhanmondi garden city', 'DGC4', '100000', 'plan & Design', '2024-02-19 12:05:39', '2024-02-19 12:05:39', 'XcOTL64851', '005', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(147, '2023-01-20', 'ফাতেমা আক্তার', 'DGC4-064', 'Dhanmondi garden city', 'DGC4', '100000', 'plan & Design', '2024-02-19 12:07:14', '2024-02-19 12:07:14', 'XcOTL64851', '006', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(148, '2023-01-19', 'মোঃ আব্দুল আলীম', 'DGC4-018', 'Dhanmondi garden city', 'DGC4', '100000', 'plan & Design', '2024-02-19 12:08:30', '2024-02-19 12:08:30', 'XcOTL64851', '007', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(150, '2023-01-19', 'মোহাম্মদ মাইজুর রহমান', 'DGC4-022', 'Dhanmondi garden city', 'DGC4', '100000', 'plan & Design', '2024-02-19 12:10:18', '2024-02-19 12:10:18', 'XcOTL64851', '008', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(151, '2023-01-19', 'মোঃ ওসমান গনি ভূঁইয়া', 'DGC4-062', 'Dhanmondi garden city', 'DGC4', '100000', 'plan & Design', '2024-02-19 12:14:08', '2024-02-19 12:14:08', 'XcOTL64851', '009', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(152, '2023-01-19', 'মোহাম্মদ রেজাউল করিম ভূঁইয়া', 'DGC4-063', 'Dhanmondi garden city', 'DGC4', '100000', 'plan & Design', '2024-02-19 12:15:23', '2024-02-19 12:15:23', 'XcOTL64851', '010', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(153, '2023-01-20', 'আফরোজা খাতুন', 'DGC4-068', 'Dhanmondi garden city', 'DGC4', '100000', 'Plan and design', '2024-02-19 13:56:22', '2024-02-19 13:56:22', 'XcOTL64851', '011', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(154, '2023-01-20', 'সঞ্জয় কুমার দাস', 'DGC4-071', 'Dhanmondi garden city', 'DGC4', '100000', 'Plan and design', '2024-02-19 14:01:09', '2024-02-19 14:01:09', 'XcOTL64851', '012', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(155, '2023-01-19', 'আতিয়া সুলতানা', 'DGC4-034', 'Dhanmondi garden city', 'DGC4', '100000', 'Plan and design', '2024-02-19 14:02:12', '2024-02-19 14:02:12', 'XcOTL64851', '013', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(156, '2023-01-21', 'এ কে এম শফিকুল ইসলাম', 'DGC4-010', 'Dhanmondi garden city', 'DGC4', '100000', 'Plan and design', '2024-02-19 14:03:32', '2024-02-19 14:03:32', 'XcOTL64851', '014', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(157, '2023-01-21', 'মোসাঃ খোদেজা বেগম', 'DGC4-047', 'Dhanmondi garden city', 'DGC4', '100000', 'Plan and design', '2024-02-19 14:04:55', '2024-02-19 14:04:55', 'XcOTL64851', '015', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(158, '2023-01-22', 'নূর মোহাম্মদ', 'DGC4-003', 'Dhanmondi garden city', 'DGC4', '200000', 'Plan and design', '2024-02-19 14:06:22', '2024-02-19 14:06:22', 'XcOTL64851', '016', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(159, '2023-01-22', 'মোঃ শরিফুল ইসলাম', 'DGC4-031', 'Dhanmondi garden city', 'DGC4', '100000', 'Plan and design', '2024-02-19 14:07:26', '2024-02-19 14:07:26', 'XcOTL64851', '017', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(160, '2023-01-22', 'খালিদা আহমেদ সিদ্দিকী', 'DGC4-072', 'Dhanmondi garden city', 'DGC4', '100000', 'Plan and design', '2024-02-19 14:09:33', '2024-02-19 14:09:33', 'XcOTL64851', '019', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(161, '2023-01-22', 'জাহিদুল হাসান খান', 'DGC4-073', 'Dhanmondi garden city', 'DGC4', '100000', 'Plan and design', '2024-02-19 14:11:02', '2024-02-19 14:11:02', 'XcOTL64851', '019', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(162, '2023-01-22', 'সালাহ উদ্দিন মাহমুদ', 'DGC4-074', 'Dhanmondi garden city', 'DGC4', '100000', 'Plan and design', '2024-02-19 14:12:53', '2024-02-19 14:12:53', 'XcOTL64851', '020', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(163, '2023-01-22', 'মেজবাহ উদ্দিন', 'DGC4-075', 'Dhanmondi garden city', 'DGC4', '100000', 'Plan and design', '2024-02-19 14:13:48', '2024-02-19 14:13:48', 'XcOTL64851', '021', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(164, '2023-01-23', 'শ্রাবন্তী মজুমদার', 'DGC4-027', 'Dhanmondi garden city', 'DGC4', '100000', 'Plan and design', '2024-02-19 14:15:36', '2024-02-19 14:15:36', 'XcOTL64851', '022', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(165, '2023-01-23', 'সুস্মিতা সরকার', 'DGC4-028', 'Dhanmondi garden city', 'DGC4', '100000', 'Plan and design', '2024-02-19 14:16:30', '2024-02-19 14:16:30', 'XcOTL64851', '023', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(166, '2023-01-23', 'প্রবীর চন্দ্র রায়', 'DGC4-041', 'Dhanmondi garden city', 'DGC4', '50000', 'Plan and design', '2024-02-19 14:17:55', '2024-02-19 14:17:55', 'XcOTL64851', '024', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(167, '2023-01-23', 'ইমন সাহা গং', 'DGC4-066', 'Dhanmondi garden city', 'DGC4', '100000', 'Plan and design', '2024-02-19 14:18:52', '2024-02-19 14:18:52', 'XcOTL64851', '025', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(168, '2023-01-23', 'মোঃ নুরুল ইসলাম', 'DGC4-070', 'Dhanmondi garden city', 'DGC4', '100000', 'Plan and design', '2024-02-19 14:21:33', '2024-02-19 14:21:33', 'XcOTL64851', '026', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(169, '2023-01-19', 'মোঃ আতিকুর রহমান', 'DGC4-061', 'Dhanmondi garden city', 'DGC4', '100000', 'Plan and design', '2024-02-19 14:22:38', '2024-02-19 14:22:38', 'XcOTL64851', '027', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(170, '2023-01-26', 'সেলিনা পারভীন', 'DGC4-005', 'Dhanmondi garden city', 'DGC4', '100000', 'Plan and design', '2024-02-19 14:23:29', '2024-02-19 14:23:29', 'XcOTL64851', '028', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(171, '2023-01-19', 'আবুল কালাম আজাদ', 'DGC7-001', 'Dhanmondi garden city', 'DGC7', '100000', 'Plan & Design', '2024-02-19 14:24:02', '2024-02-19 14:24:02', 'gADCQ85962', '001', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(172, '2023-01-19', 'মোঃ রেজাউল হক', 'DGC7-002', 'Dhanmondi garden city', 'DGC7', '100000', 'Plan & Design', '2024-02-19 14:24:56', '2024-02-19 14:24:56', 'gADCQ85962', '002', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(173, '2023-01-19', 'সঞ্চিতা দাস', 'DGC4-076', 'Dhanmondi garden city', 'DGC4', '100000', 'Plan and design', '2024-02-19 14:25:40', '2024-02-19 14:25:40', 'XcOTL64851', '029', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(174, '2023-01-05', 'মাহফুজুল হক', 'DGC7-003', 'Dhanmondi garden city', 'DGC7', '100000', 'Plan & Design', '2024-02-19 14:26:04', '2024-02-19 14:26:04', 'gADCQ85962', '003', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(175, '2023-01-26', 'শাহাদৎ হোসেন আজাদ', 'DGC4-039', 'Dhanmondi garden city', 'DGC4', '100000', 'Plan and design', '2024-02-19 14:26:43', '2024-02-19 14:26:43', 'XcOTL64851', '030', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(176, '2023-01-20', 'শেখ মোঃ নাসির উদ্দিন', 'DGC7-032', 'Dhanmondi garden city', 'DGC7', '100000', 'Plan & Design', '2024-02-19 14:27:55', '2024-02-19 14:34:55', 'gADCQ85962', '004', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(177, '2023-01-21', 'মোঃ সামছুল হক', 'DGC7-008', 'Dhanmondi garden city', 'DGC7', '100000', 'Plan & Design', '2024-02-19 14:28:32', '2024-02-19 14:35:13', 'gADCQ85962', '005', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(178, '2023-01-21', 'এ টি এম ফকরুল ইসলাম', 'DGC7-043', 'Dhanmondi garden city', 'DGC7', '100000', 'Plan & Design', '2024-02-19 14:30:37', '2024-02-19 14:35:50', 'gADCQ85962', '007', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(179, '2023-01-21', 'মোঃ মনিরুল ইসলাম', 'DGC7-007', 'Dhanmondi garden city', 'DGC7', '100000', 'Plan & Design', '2024-02-19 14:30:53', '2024-02-19 14:35:36', 'gADCQ85962', '006', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(180, '2023-01-20', 'মোঃ ফরহাদ মাহমুদ', 'DGC7-009', 'Dhanmondi garden city', 'DGC7', '100000', 'Plan & Design', '2024-02-19 14:31:37', '2024-02-19 14:36:08', 'gADCQ85962', '008', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(181, '2023-01-22', 'এম এম স্বপন রাজা', 'DGC7-005', 'Dhanmondi garden city', 'DGC7', '100000', 'Plan & Design', '2024-02-19 14:33:01', '2024-02-19 14:33:01', 'gADCQ85962', '009', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(182, '2023-01-23', 'মনোরঞ্জন  বিশ্বাস', 'DGC7-012', 'Dhanmondi garden city', 'DGC7', '100000', 'Plan & Design', '2024-02-19 14:37:31', '2024-02-19 14:37:31', 'gADCQ85962', '010', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(183, '2023-01-23', 'মোঃ মাসুদ রানা', 'DGC7-010', 'Dhanmondi garden city', 'DGC7', '100000', 'Plan & Design', '2024-02-19 14:37:58', '2024-02-19 14:37:58', 'gADCQ85962', '011', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(184, '2023-01-23', 'মোছাঃ আসমা ইসলাম', 'DGC7-046', 'Dhanmondi garden city', 'DGC7', '100000', 'Plan & Design', '2024-02-19 14:40:24', '2024-02-19 14:40:24', 'gADCQ85962', '012', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(185, '2023-01-24', 'হাসানুল বান্না', 'DGC7-022', 'Dhanmondi garden city', 'DGC7', '100000', 'Plan & Design', '2024-02-19 14:41:45', '2024-02-19 14:41:45', 'gADCQ85962', '013', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(186, '2023-01-05', 'সেজুতি আশরাফি নদী', 'DGC7-013', 'Dhanmondi garden city', 'DGC7', '100000', 'Plan & Design', '2024-02-19 14:43:07', '2024-02-19 14:43:07', 'gADCQ85962', '014', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(187, '2023-02-05', 'মোঃ মনোয়ার হোসেন', 'DGC4-016', 'Dhanmondi garden city', 'DGC4', '200000', 'plan & design', '2024-02-22 03:07:35', '2024-02-22 03:07:35', 'XcOTL64851', '031', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(188, '2023-02-07', 'সুজিত কুমার', 'DGC4-055', 'Dhanmondi garden city', 'DGC4', '100000', 'plan & design', '2024-02-22 03:10:32', '2024-02-22 03:10:32', 'XcOTL64851', '033', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(189, '2023-02-08', 'চিন্ময় ভূঁইয়া', 'DGC4-020', 'Dhanmondi garden city', 'DGC4', '100000', 'plan & design', '2024-02-22 03:11:52', '2024-02-22 03:11:52', 'XcOTL64851', '034', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(190, '2023-02-12', 'রাজেশ সাহা', 'DGC4-065', 'Dhanmondi garden city', 'DGC4', '100000', 'plan & design', '2024-02-22 03:13:34', '2024-02-22 03:13:34', 'XcOTL64851', '০৩৬', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(191, '2023-02-12', 'জুয়েল হালদার', 'DGC4-021', 'Dhanmondi garden city', 'DGC4', '100000', 'plan & design', '2024-02-22 03:14:20', '2024-02-22 03:14:20', 'XcOTL64851', '০৩৬', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(192, '2023-02-18', 'জুয়েল হালদার', 'DGC4-021', 'Dhanmondi garden city', 'DGC4', '100000', 'plan & design', '2024-02-22 03:20:21', '2024-02-22 03:20:21', 'XcOTL64851', '০৩৬', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(193, '2023-02-19', 'মোঃ মুখলেসুর রহমান', 'DGC4-030', 'Dhanmondi garden city', 'DGC4', '200000', 'plan & design', '2024-02-22 03:22:34', '2024-02-22 03:22:34', 'XcOTL64851', '037', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(194, '2023-02-26', 'লিপিকা রানী ঘোষ', 'DGC4-060', 'Dhanmondi garden city', 'DGC4', '100000', 'plan & design', '2024-02-22 03:23:35', '2024-02-22 03:23:35', 'XcOTL64851', '038', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(195, '2023-02-26', 'রেজাউল করিম বয়াতী', 'DGC4-024', 'Dhanmondi garden city', 'DGC4', '100000', 'plan & design', '2024-02-22 03:25:12', '2024-02-22 03:25:12', 'XcOTL64851', '039', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(196, '2023-02-28', 'মোঃ মাজহারুল কবির', 'DGC4-017', 'Dhanmondi garden city', 'DGC4', '100000', 'plan & design', '2024-02-22 03:26:10', '2024-02-22 03:26:10', 'XcOTL64851', '040', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(197, '2023-03-08', 'মোঃ শাহ আলমগীর', 'DGC4-015', 'Dhanmondi garden city', 'DGC4', '100000', 'plan & design', '2024-02-22 03:27:28', '2024-02-22 03:27:45', 'XcOTL64851', '041', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(198, '2023-04-14', 'সাজিয়া আফরিন লাজু', 'DGC4-049', 'Dhanmondi garden city', 'DGC4', '75000', 'plan & design', '2024-02-22 03:30:38', '2024-02-22 03:30:38', 'XcOTL64851', '043', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(199, '2023-05-24', 'আলিম আল রাজী', 'DGC4-023', 'Dhanmondi garden city', 'DGC4', '100000', 'plan & design', '2024-02-22 03:33:44', '2024-02-22 03:33:44', 'XcOTL64851', '045', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(200, '2023-01-26', 'মোঃ জাকির হোসেন', 'DGC7-014', 'Dhanmondi garden city', 'DGC7', '100000', 'plan n design', '2024-02-26 22:32:27', '2024-02-26 22:32:27', 'gADCQ85962', '015', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(201, '2023-01-27', 'মীর মুহঃ নাছির উদ্দিন', 'DGC7-027', 'Dhanmondi garden city', 'DGC7', '100000', 'Plan & Design', '2024-02-26 22:38:27', '2024-02-26 22:38:27', 'gADCQ85962', '016', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(202, '2023-01-28', 'মোঃ ইব্রাহীম খলিল', 'DGC7-044', 'Dhanmondi garden city', 'DGC7', '100000', 'Plan & Design', '2024-02-26 22:42:08', '2024-02-26 22:42:08', 'gADCQ85962', '017', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(203, '2023-01-28', 'সাজেদা বেগম', 'DGC7-015', 'Dhanmondi garden city', 'DGC7', '100000', 'Plan & Design', '2024-02-26 22:45:03', '2024-02-26 22:45:03', 'gADCQ85962', '018', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(204, '2023-01-28', 'জান্নাতুল ফেরদাউস', 'DGC7-016', 'Dhanmondi garden city', 'DGC7', '100000', 'Plan & Design', '2024-02-26 22:47:08', '2024-02-26 22:47:08', 'gADCQ85962', '019', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(205, '2023-02-07', 'মোঃ বিপুল হক গং', 'DGC7-028', 'Dhanmondi garden city', 'DGC7', '100000', 'Plan & Design', '2024-02-26 22:49:46', '2024-02-26 22:49:46', 'gADCQ85962', '020', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(206, '2023-02-07', 'মাহাবুব আলম চৌধুরী গং', 'DGC7-029', 'Dhanmondi garden city', 'DGC7', '100000', 'Plan & Design', '2024-02-26 22:52:04', '2024-02-26 22:52:04', 'gADCQ85962', '021', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(208, '2023-03-06', 'আবুল কালাম আজাদ', 'DGC7-045', 'Dhanmondi garden city', 'DGC7', '100000', 'Plan & Design', '2024-02-26 23:03:07', '2024-02-26 23:03:07', 'gADCQ85962', '022', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(209, '2023-03-12', 'মুশরিফ মরিয়ম', 'DGC7-026', 'Dhanmondi garden city', 'DGC7', '100000', 'Plan & Design', '2024-02-26 23:08:24', '2024-02-26 23:08:24', 'gADCQ85962', '023', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(210, '2023-01-30', 'সাঈদ জুলফিকার মাহমুদ', 'DGC7-021', 'Dhanmondi garden city', 'DGC7', '200000', 'Plan & Design', '2024-02-26 23:11:34', '2024-02-26 23:11:34', 'gADCQ85962', '024', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(211, '2023-07-08', 'শিরিনা আক্তার', 'DGC7-006', 'Dhanmondi garden city', 'DGC7', '100000', 'Plan & Design', '2024-02-26 23:13:53', '2024-02-26 23:13:53', 'gADCQ85962', '025', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(212, '2023-01-13', 'মোঃ আব্দুর রাজ্জাক', 'DGC6-001', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-26 23:20:03', '2024-02-26 23:20:03', 'dMVaP13011', '001', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(213, '2023-01-19', 'মোঃ নুরুজ্জামান খান', 'DGC6-025', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-26 23:21:56', '2024-02-26 23:21:56', 'dMVaP13011', '002', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(214, '2023-01-20', 'মোঃ আশাদুল হক', 'DGC6-004', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-26 23:23:37', '2024-02-26 23:23:37', 'dMVaP13011', '003', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(215, '2023-01-19', 'মোঃ মুখলেসুর রহমান', 'DGC6-043', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-26 23:31:12', '2024-02-26 23:31:12', 'dMVaP13011', '004', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(216, '2023-01-19', 'যুগল কৃষ্ণ পোদ্দার', 'DGC6-065', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-26 23:34:40', '2024-02-26 23:34:40', 'dMVaP13011', '005', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(217, '2023-01-13', 'মফিজুর রহমান', 'DGC6-061', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-26 23:37:30', '2024-02-26 23:37:30', 'dMVaP13011', '006', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(218, '2023-01-21', 'মোহাম্মদ গোলাম মোস্তফা গং', 'DGC6-017', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-26 23:39:29', '2024-02-26 23:39:29', 'dMVaP13011', '007', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(219, '2023-01-21', 'মোছাঃ সুমী শামীম আরা খাতুন', 'DGC6-036', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-26 23:41:52', '2024-02-26 23:41:52', 'dMVaP13011', '008', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(220, '2023-01-19', 'মোঃ মাসুদ রানা', 'DGC6-007', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-26 23:43:24', '2024-02-26 23:43:24', 'dMVaP13011', '009', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(221, '2023-01-19', 'আহনাফ আবীদ', 'DGC6-012', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-26 23:44:41', '2024-02-26 23:44:41', 'dMVaP13011', '010', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(222, '2023-01-19', 'দেলোয়ারা বেগম', 'DGC6-013', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-26 23:46:00', '2024-02-26 23:46:00', 'dMVaP13011', '011', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(223, '2023-01-19', 'কে এম মোস্তাক আহমেদ', 'DGC6-014', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-26 23:47:51', '2024-02-26 23:47:51', 'dMVaP13011', '012', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(224, '2023-01-19', 'মোঃ রাসেল মাহমুদ', 'DGC6-016', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-26 23:50:09', '2024-02-26 23:50:09', 'dMVaP13011', '013', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(225, '2023-01-20', 'এ বি এম মাজেদ উদ্দিন', 'DGC6-021', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-26 23:51:46', '2024-02-26 23:51:46', 'dMVaP13011', '014', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(226, '2023-01-20', 'মোঃ মাহবুব আলম', 'DGC6-050', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-26 23:55:02', '2024-02-26 23:55:02', 'dMVaP13011', '015', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(227, '2023-01-20', 'মাসুদ করিম', 'DGC6-058', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-26 23:56:51', '2024-02-26 23:56:51', 'dMVaP13011', '016', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(228, '2023-01-20', 'নাজনীন নাহার', 'DGC6-059', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-26 23:58:53', '2024-02-26 23:58:53', 'dMVaP13011', '017', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(229, '2023-01-22', 'প্রকৌশলী মিমইয়া ইসলাম চৌধুরী', 'DGC6-051', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-27 00:01:17', '2024-02-27 00:01:17', 'dMVaP13011', '019', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(230, '2023-01-23', 'সাইদুজ্জামান', 'DGC6-024', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-27 00:04:53', '2024-02-27 00:04:53', 'dMVaP13011', '020', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(231, '2023-01-23', 'মহি উদ্দিন', 'DGC6-023', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-27 00:06:18', '2024-02-27 00:06:18', 'dMVaP13011', '021', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(232, '2023-01-24', 'রুমপা সিকদার', 'DGC6-031', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-27 00:08:00', '2024-02-27 00:08:00', 'dMVaP13011', '022', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(233, '2023-01-05', 'মোঃ আজগর হোসেন', 'DGC6-008', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-27 00:09:39', '2024-02-27 00:09:39', 'dMVaP13011', '023', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(234, '2023-01-24', 'ইয়াকুব আলী', 'DGC6-010', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-27 00:10:57', '2024-02-27 00:10:57', 'dMVaP13011', '024', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(235, '2023-01-27', 'ফরিদা ইয়াসমিন', 'DGC6-034', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-27 00:12:27', '2024-02-27 00:12:27', 'dMVaP13011', '025', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(236, '2023-01-30', 'তাহেরা বেগম', 'DGC6-045', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-27 00:13:47', '2024-02-27 00:13:47', 'dMVaP13011', '026', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(237, '2023-01-30', 'বেপারী মোহাম্মদ মিনহাজ', 'DGC6-032', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-27 00:15:15', '2024-02-27 00:15:15', 'dMVaP13011', '027', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(238, '2023-02-01', 'এম এম স্বপন রাজা', 'DGC6-002', 'Dhanmondi garden city', 'DGC6', '400000', 'Plan & Design', '2024-02-27 00:16:54', '2024-02-27 00:16:54', 'dMVaP13011', '028', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(239, '2023-02-12', 'মোঃ সফিকউল্ল্যা', 'DGC6-015', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-27 00:18:09', '2024-02-27 00:18:09', 'dMVaP13011', '029', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(240, '2023-02-17', 'সামেয়া আফরোজ', 'DGC6-011', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-27 00:19:25', '2024-02-27 00:19:25', 'dMVaP13011', '030', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(241, '2023-02-23', 'স্বপ্না সাহা', 'DGC6-038', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-27 00:20:40', '2024-02-27 00:20:40', 'dMVaP13011', '031', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(242, '2023-02-19', 'নাসিমা আক্তার', 'DGC6-056', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-27 00:21:53', '2024-02-27 00:21:53', 'dMVaP13011', '032', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(243, '2023-03-17', 'মোঃ রফিকুল ইসলাম', 'DGC6-041', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-27 00:27:04', '2024-02-27 00:27:04', 'dMVaP13011', '033', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(244, '2023-03-22', 'মোঃ বদরুল আলম', 'DGC6-029', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-27 00:28:23', '2024-02-27 00:28:23', 'dMVaP13011', '034', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(245, '2023-03-23', 'এ এস এম কামরুল হাসান', 'DGC6-039', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-27 00:29:39', '2024-02-27 00:29:39', 'dMVaP13011', '035', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(246, '2023-04-07', 'কমল কুমার খৈতান', 'DGC6-057', 'Dhanmondi garden city', 'DGC6', '500000', 'Plan & Design', '2024-02-27 00:43:17', '2024-02-27 00:43:17', 'dMVaP13011', '037', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(247, '2023-05-08', 'নুরুল ইসলাম রুপালী', 'DGC6-005', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-27 00:46:06', '2024-02-27 00:46:06', 'dMVaP13011', '038', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(248, '2023-05-08', 'জসিম উদ্দিন', 'DGC6-006', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & design', '2024-02-27 00:48:00', '2024-02-27 00:48:00', 'dMVaP13011', '039', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(249, '2023-01-30', 'সুরাইয়া বেগম', 'DGC6-003', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-27 00:49:14', '2024-02-27 00:49:14', 'dMVaP13011', '040', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(250, '2023-01-30', 'আবুল হাসেম', 'DGC6-026', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-27 00:50:35', '2024-02-27 00:50:35', 'dMVaP13011', '041', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(251, '2023-05-31', 'জাহাঙ্গীর আলম', 'DGC6-030', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-27 00:52:02', '2024-02-27 00:52:02', 'dMVaP13011', '042', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(252, '2023-07-18', 'শাহানাজ পারভীন', 'DGC6-018', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-27 00:53:22', '2024-02-27 00:53:22', 'dMVaP13011', '043', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(253, '2023-07-18', 'মোঃ আশরাফ হোসেন', 'DGC6-019', 'Dhanmondi garden city', 'DGC6', '100000', 'Plan & Design', '2024-02-27 00:54:43', '2024-02-27 00:54:43', 'dMVaP13011', '044', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(254, '2023-11-08', 'আবুল কালাম আজাদ', 'DGC7-045', 'Dhanmondi garden city', 'DGC7', '100000', 'Construction', '2024-02-27 22:12:11', '2024-02-27 22:12:11', 'gADCQ85962', '027', 'Cash', NULL, NULL, NULL, NULL, '', ''),
(255, '2024-01-13', 'আবুল কালাম আজাদ', 'DGC7-045', 'Dhanmondi garden city', 'DGC7', '100000', 'Plan & Design', '2024-02-27 22:15:35', '2024-03-25 05:58:44', 'gADCQ85962', '030', 'Cash', NULL, NULL, NULL, NULL, '', 'documents/660166f481bd7eugene-golovesov-CP59qLdFHhE-unsplash.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `construction_requireds`
--

CREATE TABLE `construction_requireds` (
  `id` bigint UNSIGNED NOT NULL,
  `basic_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selectedProject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selectedBuilding` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `required_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `extra_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `due_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `construction_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `select_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `share` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `construction_requireds`
--

INSERT INTO `construction_requireds` (`id`, `basic_date`, `client_name`, `client_id`, `selectedProject`, `selectedBuilding`, `required_amount`, `paid_amount`, `extra_amount`, `due_amount`, `note`, `created_at`, `updated_at`, `construction_id`, `select_type`, `share`) VALUES
(192, '2024-01-19', 'mim', 'BD-002', 'Project  B', 'BD', '3000', '0', '0', '0', NULL, '2024-01-19 07:10:47', '2024-01-19 07:10:47', 'QfNUc43642', 'all', '1'),
(193, '2024-01-19', 'enamul', 'BD-003', 'Project  B', 'BD', '12000', '0', '0', '0', NULL, '2024-01-19 07:10:47', '2024-01-19 07:10:47', 'QfNUc43642', 'all', '4'),
(194, '2024-01-19', 'hghfgf', 'sd-004', 'Project E', 'sd', '2000', '0', '0', '0', NULL, '2024-01-19 07:11:11', '2024-01-19 07:11:11', 'VhrqS11642', 'all', '2'),
(195, '2024-01-19', 'mim', 'sd-006', 'Project E', 'sd', '3000', '0', '0', '0', NULL, '2024-01-19 07:11:11', '2024-01-19 07:11:11', 'VhrqS11642', 'all', '3'),
(196, '2024-01-20', 'rakib', 'sd-007', 'Project E', 'G', '6000', '0', '0', '0', NULL, '2024-01-20 06:17:21', '2024-01-20 06:17:21', 'HUEIT56901', 'all', '3'),
(197, '2024-01-20', 'rafa', 'G-001', 'Project E', 'G', '10000', '0', '0', '0', NULL, '2024-01-20 06:17:22', '2024-01-20 06:17:57', 'HUEIT56901', 'all', '2'),
(198, '2024-01-20', 'mim', 'G-003', 'Project E', 'G', '8000', '0', '0', '0', NULL, '2024-01-20 06:17:23', '2024-01-20 06:17:23', 'HUEIT56901', 'all', '4'),
(199, '2024-01-15', 'hghfgf', 'sd-004', 'Project E', 'sd', '10000', '0', '0', '0', NULL, '2024-01-21 07:37:03', '2024-01-21 07:37:03', 'RBYbS68870', 'all', '2'),
(200, '2024-01-15', 'mim', 'sd-006', 'Project E', 'sd', '15000', '0', '0', '0', NULL, '2024-01-21 07:37:03', '2024-01-21 07:37:03', 'RBYbS68870', 'all', '3'),
(203, '2024-01-27', 'mim', 'BD-002', 'Project  B', 'BD', '500', '0', '0', '0', NULL, '2024-01-26 05:43:07', '2024-01-26 05:43:07', 'WAHTG85659', 'all', '1'),
(204, '2024-01-27', 'enamul', 'BD-003', 'Project  B', 'BD', '2000', '0', '0', '0', NULL, '2024-01-26 05:43:07', '2024-01-26 05:43:07', 'WAHTG85659', 'all', '4'),
(205, '2024-01-27', 'dfdsfsd', 'BD-004', 'Project  B', 'BD', '1500', '0', '0', '0', NULL, '2024-01-26 05:43:07', '2024-01-26 05:43:07', 'WAHTG85659', 'all', '3'),
(206, '2024-01-04', 'mim', 'BD-002', 'Project  B', 'BD', '500', '0', '0', '0', NULL, '2024-01-29 09:53:09', '2024-01-29 09:53:09', 'sCxqb30776', 'all', '1'),
(207, '2024-01-04', 'enamul', 'BD-003', 'Project  B', 'BD', '2000', '0', '0', '0', NULL, '2024-01-29 09:53:09', '2024-01-29 09:53:09', 'sCxqb30776', 'all', '4'),
(208, '2024-01-04', 'dfdsfsd', 'BD-004', 'Project  B', 'BD', '1500', '0', '0', '0', NULL, '2024-01-29 09:53:09', '2024-01-29 09:53:09', 'sCxqb30776', 'all', '3'),
(209, '2024-01-04', 'mim', 'BD-005', 'Project  B', 'BD', '1500', '0', '0', '0', NULL, '2024-01-29 09:53:09', '2024-01-29 09:53:09', 'sCxqb30776', 'all', '3'),
(227, '2024-01-15', 'হুমায়ুন কবীর', 'DT-001', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(228, '2024-01-15', 'মোঃ আব্দুল হাই', 'DT-002', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(229, '2024-01-15', 'ডাঃ ইদ্রিস আলী', 'DT-003', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(230, '2024-01-15', 'এস এম জাকারিয়া', 'DT-004', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(231, '2024-01-15', 'আনোয়ার হোসেন', 'DT-005', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(232, '2024-01-15', 'মোঃ গোলাম কবীর', 'DT-006', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(233, '2024-01-15', 'মোঃ শামীম হাওলাদার', 'DT-007', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(234, '2024-01-15', 'মোঃ জোবায়ের হোসেন', 'DT-008', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(235, '2024-01-15', 'মোঃ শফিকুল ইসলাম', 'DT-009', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(236, '2024-01-15', 'এস এম রিয়াজুর রহমান', 'DT-010', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(237, '2024-01-15', 'কাওসার আলম', 'DT-011', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(238, '2024-01-15', 'হাকিকুর রহমান', 'DT-012', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(239, '2024-01-15', 'আতিকুর রহমান(রেজাউল)', 'DT-013', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(240, '2024-01-15', 'মোঃ আজহারুল ইসলাম', 'DT-014', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(241, '2024-01-15', 'মোঃ কামরুজ্জামান বাচ্চু', 'DT-015', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(242, '2024-01-15', 'আব্দুল কাদের', 'DT-016', 'Dream Tower', 'DT', '3600000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '2'),
(243, '2024-01-15', 'খুরশীদ আলম', 'DT-017', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(244, '2024-01-15', 'রাশেদ আহমেদ', 'DT-018', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(245, '2024-01-15', 'আকতার  হোসেন', 'DT-019', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(246, '2024-01-15', 'শচীন সরকার', 'DT-020', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(247, '2024-01-15', 'মোঃ কামরুজ্জামান', 'DT-021', 'Dream Tower', 'DT', '3600000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '2'),
(248, '2024-01-15', 'শাম্মী আকতার', 'DT-022', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(249, '2024-01-15', 'মোঃ শামছুল আলম', 'DT-023', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(250, '2024-01-15', 'মোঃ শুকুর আলী', 'DT-024', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(251, '2024-01-15', 'মোঃ নূরুল ইসলাম', 'DT-025', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(252, '2024-01-15', 'দেলোয়ার হোসেন', 'DT-026', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(253, '2024-01-15', 'আয়েশা আক্তার', 'DT-027', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(254, '2024-01-15', 'মোঃ রাসেল মাহমুদ', 'DT-028', 'Dream Tower', 'DT', '3600000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '2'),
(255, '2024-01-15', 'ফারহানা জুবাইদা', 'DT-029', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(256, '2024-01-15', 'মোঃ জয়নাল আবেদীন', 'DT-030', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(257, '2024-01-15', 'আফরুজা পারভীন', 'DT-031', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(258, '2024-01-15', 'সালমা জাহান', 'DT-032', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(259, '2024-01-15', 'মিজানুর রহমান/রিতা', 'DT-033', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(260, '2024-01-15', 'যতীশ কুমার শান্ত', 'DT-034', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(261, '2024-01-15', 'সাজ্জাদ হোসেন', 'DT-035', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(262, '2024-01-15', 'ফরহাদ হোসেন', 'DT-036', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(263, '2024-01-15', 'মোঃ শফিকুল ইসলাম', 'DT-037', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(264, '2024-01-15', 'ওমর ফারুক খান', 'DT-038', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(265, '2024-01-15', 'সোহেল রানা', 'DT-039', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(266, '2024-01-15', 'মাহমুদুর রহমান জামাল', 'DT-040', 'Dream Tower', 'DT', '7200000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '4'),
(267, '2024-01-15', 'লিটন কুমার দাস', 'DT-041', 'Dream Tower', 'DT', '3600000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '2'),
(268, '2024-01-15', 'পলাশ মন্ডল', 'DT-042', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(269, '2024-01-15', 'মোঃ সজীব হোসেন', 'DT-043', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(270, '2024-01-15', 'মোঃ আলাউদ্দিন ফারুক', 'DT-044', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(271, '2024-01-15', 'মোঃ সজীব মোল্লা', 'DT-045', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(272, '2024-01-15', 'হারুন-অর-রশীদ', 'DT-046', 'Dream Tower', 'DT', '1800000', '0', '0', '0', NULL, '2024-02-02 09:55:36', '2024-02-02 09:55:36', 'BREgk93908', 'all', '1'),
(273, '2024-04-01', 'হুমায়ুন কবীর', 'UT-001', 'Unique Tower', 'UT', '500000', '0', '0', '0', NULL, '2024-02-02 10:11:04', '2024-02-02 10:11:04', 'GPllG45540', 'all', '1'),
(274, '2024-04-01', 'ফারজানা মন্ডল', 'UT-002', 'Unique Tower', 'UT', '500000', '0', '0', '0', NULL, '2024-02-02 10:11:04', '2024-02-02 10:11:04', 'GPllG45540', 'all', '1'),
(275, '2024-04-01', 'মোঃ আব্দুল হাই', 'UT-003', 'Unique Tower', 'UT', '500000', '0', '0', '0', NULL, '2024-02-02 10:11:04', '2024-02-02 10:11:04', 'GPllG45540', 'all', '1'),
(276, '2024-04-01', 'সেলিম হোসেন খান', 'UT-004', 'Unique Tower', 'UT', '500000', '0', '0', '0', NULL, '2024-02-02 10:11:04', '2024-02-02 10:11:04', 'GPllG45540', 'all', '1'),
(277, '2024-04-01', 'মোঃ মাসুদ রানা', 'UT-005', 'Unique Tower', 'UT', '1000000', '0', '0', '0', NULL, '2024-02-02 10:11:04', '2024-02-02 10:11:04', 'GPllG45540', 'all', '2'),
(278, '2024-04-01', 'মোঃ বজলুল রহমান', 'UT-006', 'Unique Tower', 'UT', '500000', '0', '0', '0', NULL, '2024-02-02 10:11:04', '2024-02-02 10:11:04', 'GPllG45540', 'all', '1'),
(279, '2024-04-01', 'মোঃ মাহফুজর রহমান', 'UT-007', 'Unique Tower', 'UT', '500000', '0', '0', '0', NULL, '2024-02-02 10:11:04', '2024-02-02 10:11:04', 'GPllG45540', 'all', '1'),
(280, '2024-04-01', 'মোস্তাফিজুর রহমান', 'UT-008', 'Unique Tower', 'UT', '500000', '0', '0', '0', NULL, '2024-02-02 10:11:04', '2024-02-02 10:11:04', 'GPllG45540', 'all', '1'),
(281, '2024-04-01', 'মোঃ হারুন উর রশিদ', 'UT-009', 'Unique Tower', 'UT', '500000', '0', '0', '0', NULL, '2024-02-02 10:11:04', '2024-02-02 10:11:04', 'GPllG45540', 'all', '1'),
(282, '2024-04-01', 'মোঃ শহিদুল্লাহ', 'UT-010', 'Unique Tower', 'UT', '500000', '0', '0', '0', NULL, '2024-02-02 10:11:04', '2024-02-02 10:11:04', 'GPllG45540', 'all', '1'),
(283, '2024-04-01', 'মোঃ শাহজাহান', 'UT-011', 'Unique Tower', 'UT', '500000', '0', '0', '0', NULL, '2024-02-02 10:11:04', '2024-02-02 10:11:04', 'GPllG45540', 'all', '1'),
(284, '2024-04-01', 'কাজী সাদিয়া রহমান', 'UT-012', 'Unique Tower', 'UT', '500000', '0', '0', '0', NULL, '2024-02-02 10:11:04', '2024-02-02 10:11:04', 'GPllG45540', 'all', '1'),
(285, '2024-04-01', 'কাজী মিজানুর রহমান', 'UT-013', 'Unique Tower', 'UT', '500000', '0', '0', '0', NULL, '2024-02-02 10:11:04', '2024-02-02 10:11:04', 'GPllG45540', 'all', '1'),
(286, '2024-04-01', 'মোঃ হাবিবুর রহমান', 'UT-014', 'Unique Tower', 'UT', '500000', '0', '0', '0', NULL, '2024-02-02 10:11:04', '2024-02-02 10:11:04', 'GPllG45540', 'all', '1'),
(287, '2024-04-01', 'নাগিস আক্তার', 'UT-015', 'Unique Tower', 'UT', '500000', '0', '0', '0', NULL, '2024-02-02 10:11:04', '2024-02-02 10:11:04', 'GPllG45540', 'all', '1'),
(288, '2024-04-01', 'রুহুল আমীন', 'UT-016', 'Unique Tower', 'UT', '500000', '0', '0', '0', NULL, '2024-02-02 10:11:04', '2024-02-02 10:11:04', 'GPllG45540', 'all', '1'),
(289, '2024-04-01', 'জাকিরুল ইসলাম', 'UT-017', 'Unique Tower', 'UT', '500000', '0', '0', '0', NULL, '2024-02-02 10:11:04', '2024-02-02 10:11:04', 'GPllG45540', 'all', '1'),
(290, '2023-01-05', 'ফারজানা মন্ডল', 'DGC4-001', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(291, '2023-01-05', 'এম এম স্বপন রাজা', 'DGC4-002', 'Dhanmondi garden city', 'DGC4', '200000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '2'),
(292, '2023-01-05', 'নূর মোহাম্মদ', 'DGC4-003', 'Dhanmondi garden city', 'DGC4', '200000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '2'),
(293, '2023-01-05', 'সাইদ হোসেন পাটোয়ারী', 'DGC4-004', 'Dhanmondi garden city', 'DGC4', '200000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '2'),
(294, '2023-01-05', 'সেলিনা পারভীন', 'DGC4-005', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(295, '2023-01-05', 'রুবিনা আক্তার', 'DGC4-006', 'Dhanmondi garden city', 'DGC4', '200000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '2'),
(296, '2023-01-05', 'সামসুল আলম', 'DGC4-007', 'Dhanmondi garden city', 'DGC4', '200000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '2'),
(297, '2023-01-05', 'ডঃ মোঃ  রুহুল আমীন', 'DGC4-008', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(298, '2023-01-05', 'কমল কুমার খৈতান', 'DGC4-009', 'Dhanmondi garden city', 'DGC4', '500000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '5'),
(299, '2023-01-05', 'এ কে এম শফিকুল ইসলাম', 'DGC4-010', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(300, '2023-01-05', 'কাজী মাহবুব আলম', 'DGC4-011', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(301, '2023-01-05', 'মোহাম্মদ রফিকুল ইসলাম', 'DGC4-012', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(302, '2023-01-05', 'মোঃ শাহিনুর ইসলাম', 'DGC4-013', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(303, '2023-01-05', 'মোঃ আলমগীর মিয়া', 'DGC4-014', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(304, '2023-01-05', 'মোঃ শাহ আলমগীর', 'DGC4-015', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(305, '2023-01-05', 'মোঃ মনোয়ার হোসেন', 'DGC4-016', 'Dhanmondi garden city', 'DGC4', '200000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '2'),
(306, '2023-01-05', 'মোঃ মাজহারুল কবির', 'DGC4-017', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(307, '2023-01-05', 'মোঃ আব্দুল আলীম', 'DGC4-018', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(308, '2023-01-05', 'মোঃ হুমায়ুন কবির তালুকদার', 'DGC4-019', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(309, '2023-01-05', 'চিন্ময় ভূঁইয়া', 'DGC4-020', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(310, '2023-01-05', 'জুয়েল হালদার', 'DGC4-021', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(311, '2023-01-05', 'মোহাম্মদ মাইজুর রহমান', 'DGC4-022', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(312, '2023-01-05', 'আলিম আল রাজী', 'DGC4-023', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(313, '2023-01-05', 'রেজাউল করিম বয়াতী', 'DGC4-024', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(314, '2023-01-05', 'সাদিয়া আফরোজ', 'DGC4-025', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(315, '2023-01-05', 'বশির আলম', 'DGC4-026', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(316, '2023-01-05', 'শ্রাবন্তী মজুমদার', 'DGC4-027', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(317, '2023-01-05', 'সুস্মিতা সরকার', 'DGC4-028', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(318, '2023-01-05', 'মোসাঃ রিফাত জাহান', 'DGC4-029', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(319, '2023-01-05', 'মোঃ মুখলেসুর রহমান', 'DGC4-030', 'Dhanmondi garden city', 'DGC4', '200000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '2'),
(320, '2023-01-05', 'মোঃ শরিফুল ইসলাম', 'DGC4-031', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(321, '2023-01-05', 'মোঃ আমিনুর রহমান (ইমরোজ)', 'DGC4-032', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(322, '2023-01-05', 'সুশান্ত কুমার দও', 'DGC4-033', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(323, '2023-01-05', 'আতিয়া সুলতানা', 'DGC4-034', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(324, '2023-01-05', 'মীর রহমত উল্লাহ', 'DGC4-035', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(325, '2023-01-05', 'মোঃ আজিজুর রহমান', 'DGC4-036', 'Dhanmondi garden city', 'DGC4', '200000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '2'),
(326, '2023-01-05', 'মোঃ সাইফুল ইসলাম', 'DGC4-037', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(327, '2023-01-05', 'মোঃ হাবিবুর রহমান', 'DGC4-038', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(328, '2023-01-05', 'শাহাদৎ হোসেন আজাদ', 'DGC4-039', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(329, '2023-01-05', 'মোসাঃ শাহীনা আক্তার', 'DGC4-040', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(330, '2023-01-05', 'প্রবীর চন্দ্র রায়', 'DGC4-041', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(331, '2023-01-05', 'রিজিয়া সুলতানা', 'DGC4-042', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(332, '2023-01-05', 'মোঃ জহুরুল ইসলাম', 'DGC4-043', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(333, '2023-01-05', 'মোছাঃ মনিরা পারভীন', 'DGC4-044', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(334, '2023-01-05', 'এস এম নুরুল ইসলাম', 'DGC4-045', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(335, '2023-01-05', 'মিজানুর রহমান গং', 'DGC4-046', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(336, '2023-01-05', 'মোসাঃ খোদেজা বেগম', 'DGC4-047', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:52', '2024-02-19 11:14:52', 'XcOTL64851', 'all', '1'),
(337, '2023-01-05', 'মোঃ মঈনুল হোসেন', 'DGC4-048', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '1'),
(338, '2023-01-05', 'সাজিয়া আফরিন লাজু', 'DGC4-049', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '1'),
(339, '2023-01-05', 'নাজমুন নাহার', 'DGC4-050', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '1'),
(340, '2023-01-05', 'মোঃ মাইনুদ্দিন', 'DGC4-051', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '1'),
(341, '2023-01-05', 'শামীম আহমেদ', 'DGC4-052', 'Dhanmondi garden city', 'DGC4', '600000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '6'),
(342, '2023-01-05', 'শেখ মোঃ জসিম উদ্দীন', 'DGC4-053', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '1'),
(343, '2023-01-05', 'গোবিন্দ খৈতান', 'DGC4-054', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '1'),
(344, '2023-01-05', 'সুজিত কুমার', 'DGC4-055', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '1'),
(345, '2023-01-05', 'মোঃ শফিকুল ইসলাম', 'DGC4-056', 'Dhanmondi garden city', 'DGC4', '200000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '2'),
(346, '2023-01-05', 'মোঃ আমীর হোসেন', 'DGC4-057', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '1'),
(347, '2023-01-05', 'রুবেল মিয়া', 'DGC4-058', 'Dhanmondi garden city', 'DGC4', '600000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '6'),
(348, '2023-01-05', 'মোস্তাফিজুর রহমান', 'DGC4-059', 'Dhanmondi garden city', 'DGC4', '400000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '4'),
(349, '2023-01-05', 'লিপিকা রানী ঘোষ', 'DGC4-060', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '1'),
(350, '2023-01-05', 'মোঃ আতিকুর রহমান', 'DGC4-061', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '1'),
(351, '2023-01-05', 'মোঃ ওসমান গনি ভূঁইয়া', 'DGC4-062', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '1'),
(352, '2023-01-05', 'মোহাম্মদ রেজাউল করিম ভূঁইয়া', 'DGC4-063', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '1'),
(353, '2023-01-05', 'ফাতেমা আক্তার', 'DGC4-064', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '1'),
(354, '2023-01-05', 'রাজেশ সাহা', 'DGC4-065', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '1'),
(355, '2023-01-05', 'ইমন সাহা গং', 'DGC4-066', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '1'),
(356, '2023-01-05', 'রিপা রায়হান', 'DGC4-067', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '1'),
(357, '2023-01-05', 'আফরোজা খাতুন', 'DGC4-068', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '1'),
(358, '2023-01-05', 'মোঃ সরোয়ার হোসেন', 'DGC4-069', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '1'),
(359, '2023-01-05', 'মোঃ নুরুল ইসলাম', 'DGC4-070', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '1'),
(360, '2023-01-05', 'সঞ্জয় কুমার দাস', 'DGC4-071', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '1'),
(361, '2023-01-05', 'খালিদা আহমেদ সিদ্দিকী', 'DGC4-072', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '1'),
(362, '2023-01-05', 'জাহিদুল হাসান খান', 'DGC4-073', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '1'),
(363, '2023-01-05', 'সালাহ উদ্দিন মাহমুদ', 'DGC4-074', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '1'),
(364, '2023-01-05', 'মেজবাহ উদ্দিন', 'DGC4-075', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '1'),
(365, '2023-01-05', 'সঞ্চিতা দাস', 'DGC4-076', 'Dhanmondi garden city', 'DGC4', '100000', '0', '0', '0', NULL, '2024-02-19 11:14:53', '2024-02-19 11:14:53', 'XcOTL64851', 'all', '1'),
(366, '2023-01-05', 'আবুল কালাম আজাদ', 'DGC7-001', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(367, '2023-01-05', 'মোঃ রেজাউল হক', 'DGC7-002', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(368, '2023-01-05', 'মাহফুজুল হক', 'DGC7-003', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(369, '2023-01-05', 'শেখ বদিউজ্জামান গং', 'DGC7-004', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(370, '2023-01-05', 'এম এম স্বপন রাজা', 'DGC7-005', 'Dhanmondi garden city', 'DGC7', '200000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '2'),
(371, '2023-01-05', 'শিরিনা আক্তার', 'DGC7-006', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(372, '2023-01-05', 'মোঃ মনিরুল ইসলাম', 'DGC7-007', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(373, '2023-01-05', 'মোঃ সামছুল হক', 'DGC7-008', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(374, '2023-01-05', 'মোঃ ফরহাদ মাহমুদ', 'DGC7-009', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(375, '2023-01-05', 'মোঃ মাসুদ রানা', 'DGC7-010', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(376, '2023-01-05', 'তাছলিমা আক্তার', 'DGC7-011', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(377, '2023-01-05', 'মনোরঞ্জন  বিশ্বাস', 'DGC7-012', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(378, '2023-01-05', 'সেজুতি আশরাফি নদী', 'DGC7-013', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(379, '2023-01-05', 'মোঃ জাকির হোসেন', 'DGC7-014', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(380, '2023-01-05', 'সাজেদা বেগম', 'DGC7-015', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(381, '2023-01-05', 'জান্নাতুল ফেরদাউস', 'DGC7-016', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(382, '2023-01-05', 'মোঃ সাজেদুর রহমান', 'DGC7-017', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(383, '2023-01-05', 'ফারজানা ইয়াসমিন', 'DGC7-018', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(384, '2023-01-05', 'মোঃ লুৎফর রহমান শেখ', 'DGC7-019', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(385, '2023-01-05', 'গোলাম মতুজা', 'DGC7-020', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(386, '2023-01-05', 'সাঈদ জুলফিকার মাহমুদ', 'DGC7-021', 'Dhanmondi garden city', 'DGC7', '200000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '2'),
(387, '2023-01-05', 'হাসানুল বান্না', 'DGC7-022', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(388, '2023-01-05', 'কবির হোসেন', 'DGC7-023', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(389, '2023-01-05', 'মোঃ আলম তালুকদার', 'DGC7-024', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(390, '2023-01-05', 'এম ডি জয়নাল আবেদীন', 'DGC7-025', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(391, '2023-01-05', 'মুশরিফ মরিয়ম', 'DGC7-026', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(392, '2023-01-05', 'মীর মুহঃ নাছির উদ্দিন', 'DGC7-027', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(393, '2023-01-05', 'মোঃ বিপুল হক গং', 'DGC7-028', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(394, '2023-01-05', 'মাহাবুব আলম চৌধুরী গং', 'DGC7-029', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(395, '2023-01-05', 'মুস্তাফিজুর রহমান', 'DGC7-030', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(396, '2023-01-05', 'মোঃ মাইনুদ্দিন', 'DGC7-031', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(397, '2023-01-05', 'শেখ মোঃ নাসির উদ্দিন', 'DGC7-032', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(398, '2023-01-05', 'তাহেরুজ্জামান', 'DGC7-033', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(399, '2023-01-05', 'মোঃ শফিকুল ইসলাম', 'DGC7-034', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(400, '2023-01-05', 'মোঃ নাজমুল হুদা', 'DGC7-035', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(401, '2023-01-05', 'খন্দকার নাছরিন বেগম', 'DGC7-036', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(402, '2023-01-05', 'এস এম শফিকুর রহমান', 'DGC7-037', 'Dhanmondi garden city', 'DGC7', '5900000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '59'),
(403, '2023-01-05', 'শাহানাজ আক্তার পপি', 'DGC7-038', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(404, '2023-01-05', 'মোঃ ফায়েজুর হক সেতু', 'DGC7-039', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(405, '2023-01-05', 'মোঃ আব্দুর মান্নান মিয়া', 'DGC7-040', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(406, '2023-01-05', 'মোঃ হাবিবুর রহমান', 'DGC7-041', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(407, '2023-01-05', 'কমল কুমার খৈতান', 'DGC7-042', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(408, '2023-01-05', 'এ টি এম ফকরুল ইসলাম', 'DGC7-043', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(409, '2023-01-05', 'মোঃ ইব্রাহীম খলিল', 'DGC7-044', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(410, '2023-01-05', 'আবুল কালাম আজাদ', 'DGC7-045', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(411, '2023-01-05', 'মোছাঃ আসমা ইসলাম', 'DGC7-046', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(412, '2023-01-05', 'কমল কুমার খৈতান', 'DGC7-047', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(413, '2023-01-05', 'মোঃ তারিকুল ইসলাম', 'DGC7-048', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(414, '2023-01-05', 'মোঃ আবির খান', 'DGC7-049', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(415, '2023-01-05', 'মোঃ সাইফুল ইসলাম খোন্দকার', 'DGC7-050', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(416, '2023-01-05', 'মোঃ জেসমিন নাহার', 'DGC7-051', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(417, '2023-01-05', 'মোঃ আকতার হোসেন', 'DGC7-052', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(418, '2023-01-05', 'এস এম রিয়াজুর রহমান', 'DGC7-053', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(419, '2023-01-05', 'রুবানা ইয়াসমিন', 'DGC7-054', 'Dhanmondi garden city', 'DGC7', '100000', '0', '0', '0', NULL, '2024-02-19 14:21:29', '2024-02-19 14:21:29', 'gADCQ85962', 'all', '1'),
(420, '2023-01-05', 'মোঃ আব্দুর রাজ্জাক', 'DGC6-001', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(421, '2023-01-05', 'এম এম স্বপন রাজা', 'DGC6-002', 'Dhanmondi garden city', 'DGC6', '400000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '4'),
(422, '2023-01-05', 'সুরাইয়া বেগম', 'DGC6-003', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(423, '2023-01-05', 'মোঃ আশাদুল হক', 'DGC6-004', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(424, '2023-01-05', 'নুরুল ইসলাম রুপালী', 'DGC6-005', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(425, '2023-01-05', 'জসিম উদ্দিন', 'DGC6-006', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(426, '2023-01-05', 'মোঃ মাসুদ রানা', 'DGC6-007', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(427, '2023-01-05', 'মোঃ আজগর হোসেন', 'DGC6-008', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(428, '2023-01-05', 'ফাতেমা নাজনীন পল্লবী', 'DGC6-009', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(429, '2023-01-05', 'ইয়াকুব আলী', 'DGC6-010', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(430, '2023-01-05', 'সামেয়া আফরোজ', 'DGC6-011', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(431, '2023-01-05', 'আহনাফ আবীদ', 'DGC6-012', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(432, '2023-01-05', 'দেলোয়ারা বেগম', 'DGC6-013', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(433, '2023-01-05', 'কে এম মোস্তাক আহমেদ', 'DGC6-014', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(434, '2023-01-05', 'মোঃ সফিকউল্ল্যা', 'DGC6-015', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(435, '2023-01-05', 'মোঃ রাসেল মাহমুদ', 'DGC6-016', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(436, '2023-01-05', 'মোহাম্মদ গোলাম মোস্তফা গং', 'DGC6-017', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(437, '2023-01-05', 'শাহানাজ পারভীন', 'DGC6-018', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(438, '2023-01-05', 'মোঃ আশরাফ হোসেন', 'DGC6-019', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(439, '2023-01-05', 'পাপিয়া আক্তার', 'DGC6-020', 'Dhanmondi garden city', 'DGC6', '200000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '2'),
(440, '2023-01-05', 'এ বি এম মাজেদ উদ্দিন', 'DGC6-021', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(441, '2023-01-05', 'বদরুন্নেছা', 'DGC6-022', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(442, '2023-01-05', 'মহি উদ্দিন', 'DGC6-023', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(443, '2023-01-05', 'সাইদুজ্জামান', 'DGC6-024', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(444, '2023-01-05', 'মোঃ নুরুজ্জামান খান', 'DGC6-025', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(445, '2023-01-05', 'আবুল হাসেম', 'DGC6-026', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(446, '2023-01-05', 'মির্জা গোলাম সারোয়ার', 'DGC6-027', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(447, '2023-01-05', 'মহসিন রেজা', 'DGC6-028', 'Dhanmondi garden city', 'DGC6', '300000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '3'),
(448, '2023-01-05', 'মোঃ বদরুল আলম', 'DGC6-029', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(449, '2023-01-05', 'জাহাঙ্গীর আলম', 'DGC6-030', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(450, '2023-01-05', 'রুমপা সিকদার', 'DGC6-031', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(451, '2023-01-05', 'বেপারী মোহাম্মদ মিনহাজ', 'DGC6-032', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(452, '2023-01-05', 'মোঃ মোয়াজ্জেম হোসেন', 'DGC6-033', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(453, '2023-01-05', 'ফরিদা ইয়াসমিন', 'DGC6-034', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(454, '2023-01-05', 'মোঃ মনজেরুল ইসলাম', 'DGC6-035', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(455, '2023-01-05', 'মোছাঃ সুমী শামীম আরা খাতুন', 'DGC6-036', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(456, '2023-01-05', 'সাথী সাহা', 'DGC6-037', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(457, '2023-01-05', 'স্বপ্না সাহা', 'DGC6-038', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(458, '2023-01-05', 'এ এস এম কামরুল হাসান', 'DGC6-039', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(459, '2023-01-05', 'সৈয়দ সেলিনা আকতার', 'DGC6-040', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(460, '2023-01-05', 'মোঃ রফিকুল ইসলাম', 'DGC6-041', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(461, '2023-01-05', 'আফরীন আজহার', 'DGC6-042', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(462, '2023-01-05', 'মোঃ মুখলেসুর রহমান', 'DGC6-043', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(463, '2023-01-05', 'মোঃ সোহেল রানা', 'DGC6-044', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(464, '2023-01-05', 'তাহেরা বেগম', 'DGC6-045', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(465, '2023-01-05', 'রঞ্জন কুমার দাস', 'DGC6-046', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(466, '2023-01-05', 'মোঃ জুলহাস', 'DGC6-047', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(467, '2023-01-05', 'মোহাম্মদ আসাদুজ্জামান', 'DGC6-048', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(468, '2023-01-05', 'মনিরুল ইসলাম', 'DGC6-049', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(469, '2023-01-05', 'মোঃ মাহবুব আলম', 'DGC6-050', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(470, '2023-01-05', 'প্রকৌশলী মিমইয়া ইসলাম চৌধুরী', 'DGC6-051', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(471, '2023-01-05', 'সামসুদ্দীন মন্টু', 'DGC6-052', 'Dhanmondi garden city', 'DGC6', '600000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '6'),
(472, '2023-01-05', 'ফারজানা মন্ডল', 'DGC6-053', 'Dhanmondi garden city', 'DGC6', '400000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '4'),
(473, '2023-01-05', 'সাঈদ হোসেন', 'DGC6-054', 'Dhanmondi garden city', 'DGC6', '200000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '2'),
(474, '2023-01-05', 'মোঃ আব্দুল হাই', 'DGC6-055', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(475, '2023-01-05', 'নাসিমা আক্তার', 'DGC6-056', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(476, '2023-01-05', 'কমল কুমার খৈতান', 'DGC6-057', 'Dhanmondi garden city', 'DGC6', '600000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '6'),
(477, '2023-01-05', 'মাসুদ করিম', 'DGC6-058', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(478, '2023-01-05', 'নাজনীন নাহার', 'DGC6-059', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(479, '2023-01-05', 'ছানাউল্লা পাটুয়ারী', 'DGC6-060', 'Dhanmondi garden city', 'DGC6', '200000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '2'),
(480, '2023-01-05', 'মফিজুর রহমান', 'DGC6-061', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(481, '2023-01-05', 'বিপ্লব হোসেন', 'DGC6-062', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(482, '2023-01-05', 'আকতার হোসেন', 'DGC6-063', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(483, '2023-01-05', 'আবু বকর', 'DGC6-064', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1');
INSERT INTO `construction_requireds` (`id`, `basic_date`, `client_name`, `client_id`, `selectedProject`, `selectedBuilding`, `required_amount`, `paid_amount`, `extra_amount`, `due_amount`, `note`, `created_at`, `updated_at`, `construction_id`, `select_type`, `share`) VALUES
(484, '2023-01-05', 'যুগল কৃষ্ণ পোদ্দার', 'DGC6-065', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(485, '2023-01-05', 'তাবাসসুম এশা', 'DGC6-066', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1'),
(486, '2023-01-05', 'মেহেদী হাসান', 'DGC6-067', 'Dhanmondi garden city', 'DGC6', '100000', '0', '0', '0', NULL, '2024-02-26 07:39:27', '2024-02-26 07:39:27', 'dMVaP13011', 'all', '1');

-- --------------------------------------------------------

--
-- Table structure for table `consume_stocks`
--

CREATE TABLE `consume_stocks` (
  `id` bigint UNSIGNED NOT NULL,
  `selectedProject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `consumeQuantity` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `building_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `basic_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `consume_stocks`
--

INSERT INTO `consume_stocks` (`id`, `selectedProject`, `Description`, `consumeQuantity`, `product_name`, `created_at`, `updated_at`, `building_name`, `basic_date`) VALUES
(100, 'Dhanmondi garden city', 'Dhalai', '3', 'Cement', '2024-03-20 04:12:23', '2024-03-20 04:12:23', 'DGC6', '2024-03-20');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` bigint UNSIGNED NOT NULL,
  `employee_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employee_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employee_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employee_designation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `basic_salary` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employee_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `selectedProject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cv` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `building_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `employee_name`, `employee_address`, `employee_phone`, `employee_designation`, `basic_salary`, `employee_id`, `created_at`, `updated_at`, `selectedProject`, `cv`, `building_name`) VALUES
(17, 'Jakir', 'null', '01793607623', 'Engineer', '18000', 'zSvci-63928', '2024-02-03 12:35:28', '2024-03-23 12:09:24', 'Dream Tower', 'documents/65ff1ad412fa8313db204-1635-4cc2-9c90-01a643149e0b.jpg', 'DT'),
(18, 'Rakib', NULL, '01300654013', 'Engineer', '15000', 'bnlEQ-29787', '2024-02-03 12:36:18', '2024-02-03 12:36:18', 'Unique Tower', '', 'UT'),
(19, 'gxc', 'sdfg', '215341531', 'zsxdfvg', '10000', 'kWgKM-99018', '2024-03-15 10:14:58', '2024-03-16 10:42:02', 'Dream Tower', 'documents/65f5cbdad1b8a5421.pdf', 'DT');

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` bigint UNSIGNED NOT NULL,
  `financialYear` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `basic_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selectedPaymentType` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cash_bank_account` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selectedProject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_cheque_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_cheque_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_branch` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receive_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `building_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Supporting_docs` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expense_voucher` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `financialYear`, `basic_date`, `selectedPaymentType`, `cash_bank_account`, `selectedProject`, `product_name`, `bank_cheque_no`, `bank_cheque_date`, `bank_name`, `bank_branch`, `receive_amount`, `payment_id`, `created_at`, `updated_at`, `building_name`, `Supporting_docs`, `note`, `expense_voucher`) VALUES
(52, '2023-2024', '2024-02-15', 'Cash', NULL, 'Dhanmondi garden city', 'ttt', NULL, NULL, NULL, NULL, '600', 'QXmdw-77407', '2024-02-21 09:04:12', '2024-03-23 12:12:27', 'DGC6', 'documents/65ff1b8b8ea86View User - Awesome Shop.pdf', 'null', '123');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventories`
--

CREATE TABLE `inventories` (
  `id` bigint UNSIGNED NOT NULL,
  `property_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `property_project` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `property_details` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `property_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `property_amount` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `property_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_property_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `property_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `squareft` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `floor_level` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `building_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `daag_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_property_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inventories`
--

INSERT INTO `inventories` (`id`, `property_name`, `property_project`, `property_details`, `property_status`, `property_amount`, `created_at`, `updated_at`, `property_type`, `sub_property_type`, `property_id`, `location`, `squareft`, `floor_level`, `size`, `building_name`, `owner`, `daag_no`, `sub_property_id`, `receipt_id`) VALUES
(120, '1A', 'Dream Tower', NULL, 'Sold', '500000', '2024-01-29 21:48:39', '2024-01-31 02:19:47', 'Building', 'flat', 'QdYgK-433093', 'Jhaochar dhaka', NULL, '5', '2300', 'DT', 'ফারজানা মন্ডল', NULL, 'DODzZ-984647', 'DPAEI26078'),
(121, '1A', 'Unique Tower', NULL, 'Sold', '300000', '2024-01-30 08:28:40', '2024-01-30 08:28:40', 'Building', 'flat', 'OUakP-396796', 'Shahjahan market', NULL, '1', '1200', 'UT', 'ফারজানা মন্ডল', NULL, 'WlEGs-384140', 'DPAEI26078'),
(122, '1A', 'Dhanmondi garden city', NULL, 'Sold', '3000000', '2024-02-04 07:17:10', '2024-02-04 07:17:10', 'Building', 'flat', 'mXEFM-54020', 'Tali office', NULL, '1', '2000 sft', 'DGC4', 'ফারজানা মন্ডল', NULL, 'hvnZQ-391785', 'DPAEI26078'),
(123, '2A', 'Dhanmondi garden city', NULL, 'Sold', '3000000', '2024-02-04 07:18:32', '2024-02-04 07:18:32', 'Building', 'flat', 'bwhvK-836834', 'Tali office', NULL, '1', '2000', 'DGC6', 'এম এম স্বপন রাজা', NULL, 'dMiCn-487916', 'BWxwW19111'),
(124, '1A', 'PEACE TOWER', NULL, 'Sold', '3000000', '2024-02-06 22:24:35', '2024-02-06 22:24:35', 'Building', 'flat', 'sQEZr-760889', 'Hazaribagh Dhaka', NULL, '1', '1400', 'PT', 'ফারজানা মন্ডল', NULL, 'HWhrW-560759', 'DPAEI26078'),
(125, '2B', 'Dhanmondi garden city', NULL, 'Available', '2000000', '2024-02-07 09:03:00', '2024-02-07 09:03:00', 'Building', 'flat', 'kvdws-37413', 'Tali office', NULL, '1', '1300', 'DGC5', NULL, NULL, 'GDPNs-116255', NULL),
(126, '3A', 'Dhanmondi garden city', NULL, 'Available', '500000', '2024-02-07 09:03:50', '2024-02-07 09:03:50', 'Building', 'flat', 'qaDzb-23608', 'Tali office', NULL, '3', '1400', 'DGC7', NULL, NULL, 'TmPeW-924802', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `managers`
--

CREATE TABLE `managers` (
  `id` bigint UNSIGNED NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'manager',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `managers`
--

INSERT INTO `managers` (`id`, `username`, `email`, `guard`, `password`, `created_at`, `updated_at`) VALUES
(16, 'maksud2235', 'maksud2235@gmail.com', 'manager', '$2y$10$Z.1FShAW7vAyl0JRaD86t.SPD7mpqewcCGMEXc.Y2T28uzkMCWESW', '2024-02-04 07:12:02', '2024-02-04 07:12:02'),
(17, 'Babu123', 'Babu123@gmail.com', 'manager', '$2y$10$D21OBGZX1W.Vfs04PCEmYO6REPERLJvf7zv2fRIkM.2SqBafWGaz6', '2024-02-09 21:42:32', '2024-02-09 21:42:32'),
(18, 'akib123', 'akib123@ggg.com', 'manager', '$2y$10$s1SmOEVhyvKMCcomvbAbHekm2HEXOqBpUOADzN5elsB28OvefX/kK', '2024-02-19 07:41:21', '2024-02-19 07:41:21');

-- --------------------------------------------------------

--
-- Table structure for table `manager_approves`
--

CREATE TABLE `manager_approves` (
  `id` bigint UNSIGNED NOT NULL,
  `manager_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `project` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `manager_approves`
--

INSERT INTO `manager_approves` (`id`, `manager_name`, `project`, `created_at`, `updated_at`) VALUES
(19, 'Babu123', 'Dhanmondi garden city', '2024-02-09 21:44:17', '2024-02-09 21:44:17');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(2, '2019_08_19_000000_create_failed_jobs_table', 1),
(3, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(4, '2023_02_18_082106_create_clients_table', 1),
(5, '2023_02_20_065342_create_users_table', 1),
(6, '2023_02_20_065421_create_admins_table', 1),
(7, '2023_02_20_071151_create_managers_table', 1),
(8, '2023_02_24_123535_create_managers_table', 2),
(9, '2023_02_24_123630_create_admins_table', 2),
(10, '2023_02_24_124429_create_admins_table', 3),
(11, '2023_02_24_124448_create_managers_table', 3),
(12, '2023_02_25_103516_create_projects_table', 4),
(13, '2023_02_27_205731_create_clients_table', 5),
(14, '2023_02_28_094732_create_clients_table', 6),
(15, '2023_03_01_172305_create_client_statuses_table', 7),
(16, '2023_03_01_205442_create_clients_table', 8),
(17, '2023_03_02_170212_create_clients_table', 9),
(18, '2023_03_03_131546_create_account_types_table', 10),
(19, '2023_03_03_163226_create_account_heads_table', 11),
(20, '2023_03_06_084153_create_receipt_account_infos_table', 12),
(21, '2023_03_06_090132_create_receipt_vouchers_table', 13),
(22, '2023_03_07_082540_create_receipt_vouchers_table', 14),
(23, '2023_03_08_161358_add_profile_photos_to_clients_table', 15),
(24, '2023_03_08_161750_add_client_i_d_to_clients', 16),
(25, '2023_03_08_162824_add_client_i_d_to_clients_table', 17),
(26, '2023_03_12_100738_create_receipt_voucher_groups_table', 18),
(27, '2023_03_12_191121_add_client_id_to_receipt_vouchers_table', 19),
(28, '2023_03_14_070036_add_payment_receipt_details_to_receipt_vouchers_table', 20),
(29, '2023_03_17_130502_create_payment_account_infos_table', 21),
(30, '2023_03_17_130527_create_payment_vouchers_table', 21),
(31, '2023_03_17_130642_create_payment_voucher_groups_table', 21),
(32, '2023_03_17_165905_create_receipt_vouchers_table', 22),
(33, '2023_03_17_170025_create_payment_vouchers_table', 22),
(34, '2023_03_17_170653_create_receipt_vouchers_table', 23),
(35, '2023_03_17_170858_create_receipt_vouchers_table', 24),
(36, '2023_03_19_083120_add_date_to_account_heads', 25),
(37, '2023_03_19_110839_add_receipt_voucher_extras_to_receipt_vouchers', 26),
(38, '2023_03_19_111048_add_payment_vouchers_extras_to_payment_vouchers', 26),
(39, '2023_03_19_131518_delete_purpose_from_receipt_vouchers', 27),
(40, '2023_03_19_131747_delete_purpose_from_payment_vouchers', 27),
(41, '2023_03_20_054756_create_units_table', 28),
(42, '2023_03_20_085454_add_three_column_to_payment_vouchers', 29),
(43, '2023_03_20_123241_create_stocks_table', 30),
(44, '2023_03_21_070024_create_receipt_vouchers_table', 31),
(45, '2023_03_21_070054_create_payment_vouchers_table', 31),
(46, '2023_03_21_114307_create_payable_journals_table', 32),
(47, '2023_03_21_120125_add_date_to_payable_journals_table', 33),
(48, '2023_03_21_120403_add_financial_year_to_payable_journals_table', 34),
(49, '2023_03_22_054827_create_purchased_journals_table', 35),
(50, '2023_03_22_055804_create_payable_journals_table', 35),
(51, '2023_03_22_135237_add_project_to_purchased_journals', 36),
(52, '2023_03_22_135509_add_project_to_payable_journals', 37),
(55, '2023_03_25_074401_create_inventories_table', 38),
(56, '2023_03_25_074713_create_inventories_table', 39),
(57, '2023_03_25_075345_add_status_to_inventories', 40),
(58, '2023_03_25_075552_create_inventories_table', 41),
(59, '2023_03_25_105123_add_columns_to_receipt_vouchers', 42),
(60, '2023_03_25_120557_create_receipt_journals_table', 43),
(61, '2023_03_25_120617_create_receipt_payable_journals_table', 43),
(62, '2023_03_25_195006_add_project_to_receipt_journals', 44),
(63, '2023_03_25_195031_add_project_to_receipt_payable_journals', 44),
(64, '2023_03_27_074104_make_client_id_nullable_in_receipt_vouchers', 45),
(65, '2023_03_28_070636_create_suppliers_table', 46),
(66, '2023_03_28_073057_make_location_nullable_in_suppliers', 47),
(67, '2023_03_28_112008_create_purchase_ledgers_table', 48),
(68, '2023_03_28_115744_add_balance_to_purchase_ledgers', 49),
(69, '2023_03_29_083349_add_payee_id_to_purchase_ledgers', 50),
(70, '2023_03_29_083749_add_supplier_id_to_purchase_ledgers', 51),
(71, '2023_03_30_121027_add_extra_columns_to_purchase_ledgers', 52),
(72, '2023_03_30_121206_make_nullable_in_purchase_ledgers', 52),
(73, '2023_03_31_082932_create_apledgers_table', 53),
(74, '2023_03_31_093122_add_product_to_payable_journals', 53),
(75, '2023_03_31_100742_create_apledgers_table', 54),
(76, '2023_03_31_110848_create_apledgers_table', 55),
(77, '2023_04_01_114939_create_cash_ledgers_table', 56),
(78, '2023_04_01_115311_create_bank_ledgers_table', 56),
(79, '2023_04_02_201147_create_pay_payables_table', 57),
(80, '2023_04_03_091101_create_pay_payables_table', 58),
(81, '2023_04_03_091259_create_pay_payables_table', 59),
(82, '2023_04_03_092903_create_pay_payables_table', 60),
(83, '2023_04_04_082640_add_unique_ap_ledger_id_to_apledgers', 61),
(84, '2023_04_04_142041_add_account_type_to_cash_ledgers', 62),
(85, '2023_04_04_142112_add_account_type_to_bank_ledgers', 62),
(86, '2023_04_04_204048_add_account_type_to_payment_vouchers', 63),
(87, '2023_04_04_204146_add_account_type_to_pay_payables', 63),
(88, '2023_04_06_092606_rename_column_in_apledgers', 64),
(89, '2023_04_06_101629_add_financial_year_to_apledgers', 65),
(90, '2023_04_06_101753_add_financial_year_to_purchase_ledgers', 65),
(91, '2023_04_06_101821_add_financial_year_to_cash_ledgers', 65),
(92, '2023_04_06_102029_add_financial_year_to_bank_ledgers', 65),
(93, '2023_04_10_065843_create_purchase_returns_table', 66),
(94, '2023_04_12_114404_add_initial_total_amount_to_payment_vouchers', 67),
(95, '2023_04_12_115832_add_initial_qty_to_payment_vouchers', 68),
(96, '2023_04_14_101524_add_columns_to_inventories', 69),
(97, '2023_04_14_212850_create_purchase_lands_table', 70),
(98, '2023_04_14_214114_add_land_details_to_payment_vouchers', 71),
(99, '2023_04_15_213510_add_floor_level_to_inventories', 72),
(100, '2023_04_16_085619_add_size_to_inventories', 73),
(101, '2023_04_16_091538_add_building_name_to_inventories', 74),
(102, '2023_04_17_091720_make_project_nullables_in_payment_vouchers', 75),
(103, '2023_04_17_131516_make_nullable_project_in_stocks', 76),
(104, '2023_04_17_131658_make_project_nullable_in_purchased_journals', 77),
(105, '2023_04_17_131943_make_project_nullable_in_payable_journals', 78),
(106, '2023_04_19_072638_add_owner_to_inventories', 79),
(107, '2023_04_19_104910_add_columns_to_receipt_vouchers', 80),
(108, '2023_04_19_115641_add_daag_no_to_purchase_land', 81),
(109, '2023_04_19_120120_remove_column_from_purchase_lands', 82),
(110, '2023_04_19_120319_add_daag_no_to_inventories', 83),
(111, '2023_04_19_212112_add_sub_property_id_to_inventories', 84),
(112, '2023_04_19_213901_add_sub_property_id_to_receipt_vouchers', 85),
(113, '2023_04_19_214419_make_nullable_in_receipt_vouchers', 86),
(114, '2023_04_19_214554_make_nullable_in_receipt_journals', 87),
(115, '2023_04_19_214654_make_nullable_in_receipt_payable_journals', 87),
(116, '2023_04_27_094935_add_property_type_receipt_vouchers', 88),
(117, '2023_04_28_160827_create_sells_ledgers_table', 89),
(118, '2023_04_28_161126_create_r_p_ledgers_table', 89),
(119, '2023_04_28_164159_create_r_p_ledgers_table', 90),
(120, '2023_04_28_171553_add_columns_to_cash_ledgers', 91),
(121, '2023_04_28_171737_add_columns_to_bank_ledgers', 91),
(122, '2023_04_30_083729_add_column_to_payment_vouchers', 92),
(123, '2023_04_30_083758_add_column_to_receipt_vouchers', 92),
(124, '2023_04_30_083943_add_columnt_to_cash_ledgers', 93),
(125, '2023_04_30_084003_add_column_to_bank_ledgers', 93),
(126, '2023_04_30_133244_add_column_to_receipt_payable_journals', 94),
(127, '2023_05_02_152611_create_pay_receivables_table', 95),
(128, '2023_05_08_090105_create_expenses_table', 96),
(129, '2023_05_10_131402_create_salaries_table', 97),
(130, '2023_05_10_135526_create_employees_table', 98),
(131, '2023_05_10_135537_create_salaries_table', 99),
(132, '2023_05_10_135750_add_column_to_salaries', 100),
(133, '2023_05_10_141427_add_column_to_employees', 101),
(134, '2023_05_14_115024_create_stock_journals_table', 102),
(135, '2023_05_14_143300_create_consume_stocks_table', 103),
(136, '2023_05_14_143719_create_consume_stocks_table', 104),
(137, '2023_05_17_124443_add_project_column_to_projects', 105),
(138, '2023_05_18_151739_add_column_to_inventories', 106),
(139, '2023_05_19_104321_remove_column_from_inventories', 107),
(140, '2023_05_19_104455_add_columnname_to_inventories', 108),
(141, '2023_05_20_085735_create_project_stages_table', 109),
(142, '2023_05_20_125636_create_references_table', 110),
(143, '2023_05_20_130919_create_reference_basic_infos_table', 111),
(144, '2023_05_21_120223_create_project_members_table', 112),
(145, '2023_05_21_195402_create_manager_approves_table', 113),
(146, '2023_05_23_144611_create_notifications_table', 114),
(147, '2023_05_26_083729_create_accounts_accesses_table', 115),
(148, '2023_05_26_155153_add_column_to_employees', 116),
(149, '2023_05_30_092917_make_nullable_in_clients', 117),
(150, '2023_06_13_120955_add_building_to_expenses', 118),
(151, '2023_06_13_121048_add_building_to_employees', 118),
(152, '2023_06_14_081911_add_file_to_expenses', 119),
(153, '2023_06_18_081804_create_payment_histories_table', 120),
(154, '2023_06_18_081906_create_receipt_histories_table', 120),
(155, '2023_06_18_085620_add_project_to_payment_histories', 121),
(156, '2023_06_18_085656_add_project_to_receipt_histories', 121),
(157, '2023_06_21_120144_create_advance_pays_table', 122),
(158, '2023_06_21_121304_create_total_advance_pays_table', 123),
(159, '2023_06_24_123254_create_construction_requireds_table', 124),
(160, '2023_06_25_084753_create_construction_pays_table', 125),
(161, '2023_06_26_210441_add_phone_to_references', 126),
(162, '2023_06_26_210946_add_phone_to_reference_basic_infos', 127),
(163, '2023_06_27_062036_add_building_to_payment_vouchers', 128),
(164, '2023_06_27_062419_add_building_to_consume_stocks', 128),
(165, '2023_06_27_071303_add_building_name_to_purchased_journals', 129),
(166, '2023_06_27_071355_add_building_name_to_payable_journals', 129),
(167, '2023_06_27_091603_add_building_name_to_receipt_journals', 130),
(168, '2023_06_27_091651_add_building_name_to_receipt_payable_journals', 130),
(169, '2023_07_06_113027_add_columnt_to_suppliers', 131),
(170, '2023_07_07_135452_add_column_to_construction_requireds', 132),
(171, '2023_07_10_134744_add_column_to_consume_stocks', 133),
(172, '2023_07_12_092058_add_column_to_construction_requireds', 134),
(173, '2023_07_14_135920_create_construction_histories_table', 135),
(174, '2023_07_14_141055_add_column_to_construction_histories', 136),
(175, '2023_07_21_164907_create_task_models_table', 137),
(176, '2023_07_21_174316_add_column_to_task_models', 138),
(177, '2023_08_01_142756_add_column_to_task_models', 139),
(178, '2023_08_03_144701_add_column_to_admins', 140),
(179, '2023_08_06_141836_add_column_to_admins', 141),
(180, '2023_08_06_195928_change_column_to_admins', 142),
(181, '2023_08_11_080924_add_column_to_construction_pays', 143),
(182, '2023_08_16_141104_add_column_to_salaries', 144),
(183, '2023_08_16_143729_add_column_to_salaries', 145),
(184, '2023_08_22_130413_add_column_to_stocks', 146),
(185, '2023_09_13_072035_add_column_to_purchase_lands', 147),
(186, '2023_09_13_131551_add_column_to_expenses', 148),
(187, '2023_09_14_075614_create_stock_transfers_table', 149),
(188, '2023_09_14_131903_add_column_to_stock_transfers', 150),
(189, '2023_09_15_075737_add_column_to_stock_transfers', 151),
(190, '2023_09_15_081108_add_column_to_stock_transfers', 152),
(191, '2023_09_23_045853_add_column_to_construction_pays', 153),
(192, '2023_09_23_143512_add_column_to_clients', 154),
(193, '2023_09_23_151117_modify_clients_table', 155),
(194, '2023_09_27_081555_add_column_to_projects', 156),
(195, '2023_09_27_104432_add_column_to_construction_pays', 157),
(196, '2024_01_17_132745_add_columns_to_clients', 158),
(197, '2024_01_19_131506_add_column_to_expenses', 159);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint UNSIGNED NOT NULL,
  `notification` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `notification`, `created_at`, `updated_at`) VALUES
(2, '0', '2023-05-30 05:52:19', '2023-05-30 05:52:19');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payable_journals`
--

CREATE TABLE `payable_journals` (
  `id` bigint UNSIGNED NOT NULL,
  `payment_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payee_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payee_name_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `due` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cash_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payable_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `financialYear` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `project` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `building_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payable_journals`
--

INSERT INTO `payable_journals` (`id`, `payment_id`, `payee_name`, `payee_name_type`, `due`, `cash`, `bank`, `cash_type`, `bank_type`, `paid`, `payable_date`, `financialYear`, `created_at`, `updated_at`, `project`, `product_name`, `building_name`) VALUES
(397, 'UdLIn-75333', 'not appicable', 'Debit', '4384937', 'Cash', NULL, 'Credit', NULL, '4384937', '2024-03-21', '2023-2024', '2024-03-21 03:37:35', '2024-03-21 03:37:35', 'Dhanmondi garden city', 'Rod', 'DGC4');

-- --------------------------------------------------------

--
-- Table structure for table `payment_histories`
--

CREATE TABLE `payment_histories` (
  `id` bigint UNSIGNED NOT NULL,
  `financialYear` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `basic_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selectedPaymentType` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cash_bank_account` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_cheque_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_cheque_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_branch` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receive_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `project` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_histories`
--

INSERT INTO `payment_histories` (`id`, `financialYear`, `basic_date`, `selectedPaymentType`, `cash_bank_account`, `supplier_name`, `product_name`, `bank_cheque_no`, `bank_cheque_date`, `bank_name`, `bank_branch`, `receive_amount`, `payment_id`, `paid`, `created_at`, `updated_at`, `project`) VALUES
(38, '2023-2024', '2024-03-21', 'Cash', NULL, 'not appicable', 'Rod', NULL, NULL, NULL, NULL, NULL, 'UdLIn-75333', '50000', '2024-03-21 03:37:34', '2024-03-21 03:37:34', 'Dhanmondi garden city'),
(39, '2023-2024', '2024-03-23', 'Cash', NULL, 'not appicable', 'Rod', NULL, NULL, NULL, NULL, NULL, 'UdLIn-75333', '17000', '2024-03-21 03:38:42', '2024-03-21 03:40:45', 'Dhanmondi garden city');

-- --------------------------------------------------------

--
-- Table structure for table `payment_vouchers`
--

CREATE TABLE `payment_vouchers` (
  `id` bigint UNSIGNED NOT NULL,
  `financialYear` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `basic_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selectedPaymentType` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cash_bank_account` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payee_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payee_tin` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payee_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payee_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bank_cheque_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_cheque_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_branch` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receive_amount` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Supporting_docs` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_details` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `qty` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `per_unit_price` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_amount` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_due` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selectedProject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `account_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `initian_total_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `initial_qty` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ledger_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `building_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_vouchers`
--

INSERT INTO `payment_vouchers` (`id`, `financialYear`, `basic_date`, `selectedPaymentType`, `cash_bank_account`, `payee_name`, `payee_tin`, `payee_email`, `payee_phone`, `bank_cheque_no`, `bank_cheque_date`, `bank_name`, `bank_branch`, `receive_amount`, `payment_id`, `Supporting_docs`, `payment_details`, `product_name`, `qty`, `per_unit_price`, `total_amount`, `payment_due`, `selectedProject`, `item_unit`, `item_id`, `created_at`, `updated_at`, `account_type`, `initian_total_amount`, `initial_qty`, `ledger_no`, `payment_status`, `building_name`) VALUES
(437, '2023-2024', '2024-03-21', 'Cash', 'null', 'not appicable', '', '', '0000000', 'null', 'null', 'null', '', '115063', 'UdLIn-75333', 'documents/65ff1b31c4cb7View User - Awesome Shop.pdf', '', 'Rod', '50', '90000', '4500000', '4384937', 'Dhanmondi garden city', 'ton', '12', '2024-03-21 03:37:35', '2024-03-23 12:10:57', 'Installation-1673548UdLIn-75333', '4500000', '50', '0', NULL, 'DGC4');

-- --------------------------------------------------------

--
-- Table structure for table `pay_payables`
--

CREATE TABLE `pay_payables` (
  `id` bigint UNSIGNED NOT NULL,
  `financialYear` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `basic_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selectedPaymentType` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cash_bank_account` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_cheque_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_cheque_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_branch` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receive_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_due` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `second_payment_due` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `account_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pay_payables`
--

INSERT INTO `pay_payables` (`id`, `financialYear`, `basic_date`, `selectedPaymentType`, `cash_bank_account`, `supplier_name`, `product_name`, `bank_cheque_no`, `bank_cheque_date`, `bank_name`, `bank_branch`, `receive_amount`, `payment_id`, `payment_due`, `second_payment_due`, `created_at`, `updated_at`, `account_type`) VALUES
(141, '2023-2024', '2024-03-21', 'Cash', NULL, 'not appicable', 'Rod', NULL, NULL, NULL, NULL, '10000', 'UdLIn-75333', '4394937', '4384937', '2024-03-21 03:38:42', '2024-03-21 03:38:42', 'Due-4777639egzwQ-85397');

-- --------------------------------------------------------

--
-- Table structure for table `pay_receivables`
--

CREATE TABLE `pay_receivables` (
  `id` bigint UNSIGNED NOT NULL,
  `financialYear` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `basic_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selectedPaymentType` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cash_bank_account` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_cheque_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_cheque_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_branch` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receive_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `due` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `second_due` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pay_receivables`
--

INSERT INTO `pay_receivables` (`id`, `financialYear`, `basic_date`, `selectedPaymentType`, `cash_bank_account`, `supplier_name`, `product_name`, `bank_cheque_no`, `bank_cheque_date`, `bank_name`, `bank_branch`, `receive_amount`, `receipt_id`, `account_type`, `due`, `second_due`, `created_at`, `updated_at`) VALUES
(30, '2023-2024', '2024-03-07', 'Cash', NULL, 'ফারজানা মন্ডল', '1A', NULL, NULL, NULL, NULL, '2995000', 'DPAEI26078', 'Due-2785528ZBIeF-65576', '2941765', '-53235', '2024-03-19 08:39:39', '2024-03-19 08:39:39'),
(31, '2023-2024', '2024-03-28', 'Cash', NULL, 'এম এম স্বপন রাজা', '2A', NULL, NULL, NULL, NULL, '13000', 'BWxwW19111', 'Due-4691789JTHBl-76256', '2933334', '2920334', '2024-03-19 10:58:04', '2024-03-19 10:58:04');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` bigint UNSIGNED NOT NULL,
  `project_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `land_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `average_flat_size` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flore_area_size` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `building_height` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `architact_drawing` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `project_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `project_name`, `project_address`, `project_status`, `created_at`, `updated_at`, `logo`, `contact_number`, `land_amount`, `average_flat_size`, `flore_area_size`, `building_height`, `architact_drawing`, `project_code`) VALUES
(55, 'Unique Tower', 'Shahjahan market', 'in-progress', '2024-01-30 08:28:06', '2024-03-23 12:05:19', 'logo/65ff198b7655cuic logo 22.png', '01725061831', '10 katha', '1299', '5000', '10', 'documents/65ff19df748b1313db204-1635-4cc2-9c90-01a643149e0b.jpg', 'UT'),
(56, 'Dream Tower', 'Jhaochar dhaka', 'in-progress', '2024-01-31 02:19:08', '2024-01-31 02:19:08', '', '01725061831', '20', '1500', '5600', 'B+G+12', '', 'DT'),
(57, 'Dhanmondi garden city', 'Tali office', 'in-progress', '2024-02-01 10:47:33', '2024-02-01 10:47:33', '', '01725061831', '110 katha', '1200 sft', '10000 sft', 'B+G+15', '', 'DGC'),
(58, 'PEACE TOWER', 'Hazaribagh Dhaka', 'on-hold', '2024-02-06 22:23:31', '2024-03-23 11:33:48', 'logo/65ff10ae3c87deugene-golovesov-CP59qLdFHhE-unsplash.jpg', '01725061831', '20 katha', '1200', '5000', '...', 'documents/65ff127caa8cffile-sample_1MB.docx', 'PT');

-- --------------------------------------------------------

--
-- Table structure for table `project_members`
--

CREATE TABLE `project_members` (
  `id` bigint UNSIGNED NOT NULL,
  `project` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `member_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `share_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deposit_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `due_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `extra_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_stages`
--

CREATE TABLE `project_stages` (
  `id` bigint UNSIGNED NOT NULL,
  `project_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stage` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `project_stages`
--

INSERT INTO `project_stages` (`id`, `project_id`, `stage`, `created_at`, `updated_at`) VALUES
(4, '55', 'পাইলিং লে-আউট        ০২/০২/২০২৩', '2024-02-02 12:52:16', '2024-02-02 12:52:16'),
(5, '57', 'pilling  2/3/2024', '2024-02-18 11:20:25', '2024-02-18 11:20:25'),
(6, '57', 'pilling  2/3/2024', '2024-02-18 11:20:25', '2024-02-18 11:20:25'),
(7, '55', 'dhalai  21-3-2024', '2024-02-21 09:15:08', '2024-03-21 03:33:12');

-- --------------------------------------------------------

--
-- Table structure for table `purchased_journals`
--

CREATE TABLE `purchased_journals` (
  `id` bigint UNSIGNED NOT NULL,
  `payment_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `purchase_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payee_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payee_name_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `due` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cash_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payable_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `financialYear` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `project` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `building_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchased_journals`
--

INSERT INTO `purchased_journals` (`id`, `payment_id`, `purchase_type`, `product_name`, `total_amount`, `payee_name`, `payee_name_type`, `due`, `cash`, `bank`, `cash_type`, `bank_type`, `paid`, `payable_date`, `financialYear`, `created_at`, `updated_at`, `project`, `building_name`) VALUES
(430, 'UdLIn-75333', 'Debit', 'Rod', '4500000', 'not appicable', 'Credit', '4384937', 'Cash', NULL, 'Credit', NULL, '115063', '2024-03-21', '2023-2024', '2024-03-21 03:37:35', '2024-03-21 03:37:35', 'Dhanmondi garden city', 'DGC4');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_lands`
--

CREATE TABLE `purchase_lands` (
  `id` bigint UNSIGNED NOT NULL,
  `land_office` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `moujar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thana` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `district` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `holding_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `land_class` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ledger_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dag_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `Supporting_docs` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_lands`
--

INSERT INTO `purchase_lands` (`id`, `land_office`, `moujar`, `thana`, `district`, `owner_name`, `holding_number`, `land_class`, `ledger_no`, `dag_no`, `created_at`, `updated_at`, `Supporting_docs`) VALUES
(7, 'dfdsf', 'dfdsfds', 'dsfdsf', 'dsfsdf', 'dsfdsf', 'sdfdsf', 'dsfdsf', 'fdsfds', 'dsfdsf', '2023-09-13 02:19:51', '2024-03-23 12:15:55', 'documents/65ff1c5b4db94Aerobics_Sprint1 (1).pdf');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_ledgers`
--

CREATE TABLE `purchase_ledgers` (
  `id` bigint UNSIGNED NOT NULL,
  `supplier_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `due` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `balance` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `return_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_balance` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `financialYear` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_ledgers`
--

INSERT INTO `purchase_ledgers` (`id`, `supplier_name`, `payment_id`, `product_name`, `paid`, `due`, `cash`, `bank`, `date`, `created_at`, `updated_at`, `balance`, `supplier_id`, `return_amount`, `total_balance`, `financialYear`) VALUES
(404, 'not appicable', 'UdLIn-75333', 'Rod', '105063', '4394937', 'Cash', NULL, '2024-03-21', '2024-03-21 03:37:35', '2024-03-21 03:37:35', '4500000', 'undefined', '0', '4500000', '2023-2024');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_returns`
--

CREATE TABLE `purchase_returns` (
  `id` bigint UNSIGNED NOT NULL,
  `payment_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `per_unit_price` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `max_qty` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `return_qty` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_due` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `return_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remaining_due` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `receipt_histories`
--

CREATE TABLE `receipt_histories` (
  `id` bigint UNSIGNED NOT NULL,
  `financialYear` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `basic_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selectedPaymentType` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cash_bank_account` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_cheque_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_cheque_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_branch` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receive_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `project` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `receipt_histories`
--

INSERT INTO `receipt_histories` (`id`, `financialYear`, `basic_date`, `selectedPaymentType`, `cash_bank_account`, `supplier_name`, `product_name`, `bank_cheque_no`, `bank_cheque_date`, `bank_name`, `bank_branch`, `receive_amount`, `receipt_id`, `paid`, `created_at`, `updated_at`, `project`) VALUES
(29, '2023-2024', '2024-03-07', 'Cash', NULL, 'ফারজানা মন্ডল', '1A', NULL, NULL, NULL, NULL, NULL, 'DPAEI26078', '30000', '2024-03-19 08:35:19', '2024-03-19 08:35:19', 'Dhanmondi garden city'),
(30, '2023-2024', '2024-03-14', 'Cash', NULL, 'ফারজানা মন্ডল', '1A', NULL, NULL, NULL, NULL, NULL, 'DPAEI26078', '5000', '2024-03-19 08:39:39', '2024-03-19 08:39:39', 'Dhanmondi garden city'),
(31, '2023-2024', '2024-03-14', 'Cash', NULL, 'ফারজানা মন্ডল', '1A', NULL, NULL, NULL, NULL, NULL, 'DPAEI26078', '6000', '2024-03-19 08:41:12', '2024-03-19 08:41:12', 'Dhanmondi garden city'),
(32, '2023-2024', '2024-03-14', 'Cash', NULL, 'ফারজানা মন্ডল', '1A', NULL, NULL, NULL, NULL, NULL, 'DPAEI26078', '7000', '2024-03-19 08:41:21', '2024-03-19 08:41:21', 'Dhanmondi garden city'),
(33, '2023-2024', '2024-03-14', 'Cash', NULL, 'ফারজানা মন্ডল', '1A', NULL, NULL, NULL, NULL, NULL, 'DPAEI26078', '2977000', '2024-03-19 09:14:28', '2024-03-19 09:14:28', 'Dhanmondi garden city'),
(34, '2023-2024', '2024-03-13', 'Cash', NULL, 'এম এম স্বপন রাজা', '2A', NULL, NULL, NULL, NULL, NULL, 'BWxwW19111', '66666', '2024-03-19 10:55:36', '2024-03-19 10:55:36', 'Dhanmondi garden city'),
(35, '2023-2024', '2024-03-22', 'Cash', NULL, 'এম এম স্বপন রাজা', '2A', NULL, NULL, NULL, NULL, NULL, 'BWxwW19111', '5000', '2024-03-19 10:58:04', '2024-03-19 10:58:04', 'Dhanmondi garden city'),
(36, '2023-2024', '2024-03-22', 'Cash', NULL, 'এম এম স্বপন রাজা', '2A', NULL, NULL, NULL, NULL, NULL, 'BWxwW19111', '6000', '2024-03-19 11:00:15', '2024-03-19 11:00:15', 'Dhanmondi garden city'),
(37, '2023-2024', '2024-03-28', 'Cash', NULL, 'এম এম স্বপন রাজা', '2A', NULL, NULL, NULL, NULL, NULL, 'BWxwW19111', '2000', '2024-03-19 11:00:28', '2024-03-19 11:00:28', 'Dhanmondi garden city');

-- --------------------------------------------------------

--
-- Table structure for table `receipt_journals`
--

CREATE TABLE `receipt_journals` (
  `id` bigint UNSIGNED NOT NULL,
  `receipt_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `receipt_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_name_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `due` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cash_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `financialYear` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `project` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `building_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `receipt_journals`
--

INSERT INTO `receipt_journals` (`id`, `receipt_id`, `receipt_type`, `product_name`, `product_amount`, `client_name`, `client_name_type`, `due`, `cash`, `bank`, `cash_type`, `bank_type`, `paid`, `receipt_date`, `financialYear`, `created_at`, `updated_at`, `project`, `building_name`) VALUES
(125, 'DPAEI26078', 'Credit', '1A', '3000000', 'ফারজানা মন্ডল', 'Debit', '2941765', 'Cash', NULL, 'Debit', NULL, '58235', '2024-03-07', '2023-2024', '2024-03-19 08:35:19', '2024-03-19 08:35:19', 'Dhanmondi garden city', 'DGC4'),
(126, 'BWxwW19111', 'Credit', '2A', '3000000', 'এম এম স্বপন রাজা', 'Debit', '2920334', 'Cash', NULL, 'Debit', NULL, '79666', '2024-03-13', '2023-2024', '2024-03-19 10:55:36', '2024-03-19 10:55:36', 'Dhanmondi garden city', 'DGC6');

-- --------------------------------------------------------

--
-- Table structure for table `receipt_payable_journals`
--

CREATE TABLE `receipt_payable_journals` (
  `id` bigint UNSIGNED NOT NULL,
  `receipt_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_name_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `due` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cash_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `financialYear` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `project` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `building_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `receipt_payable_journals`
--

INSERT INTO `receipt_payable_journals` (`id`, `receipt_id`, `client_name`, `client_name_type`, `due`, `cash`, `bank`, `cash_type`, `bank_type`, `paid`, `receipt_date`, `financialYear`, `created_at`, `updated_at`, `project`, `product_name`, `building_name`) VALUES
(130, 'BWxwW19111', 'এম এম স্বপন রাজা', 'Credit', '2920334', 'Cash', NULL, 'Debit', NULL, '2920334', '2024-03-13', '2023-2024', '2024-03-19 10:55:36', '2024-03-19 10:55:36', 'Dhanmondi garden city', '2A', 'DGC6'),
(131, 'DPAEI26078', 'ফারজানা মন্ডল', 'Credit', '-53235', 'Cash', NULL, 'Debit', NULL, '-53235', '2024-03-07', '2023-2024', '2024-03-23 12:11:45', '2024-03-23 12:11:45', 'Dhanmondi garden city', '1A', 'DGC4');

-- --------------------------------------------------------

--
-- Table structure for table `receipt_vouchers`
--

CREATE TABLE `receipt_vouchers` (
  `id` bigint UNSIGNED NOT NULL,
  `financialYear` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `basic_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selectedPaymentType` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cash_bank_account` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `selectedProject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_tin` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bank_cheque_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_cheque_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_branch` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_amount` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `receipt_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Supporting_docs` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payees_account_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_receipt_details` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `product_amount` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `due` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `initial_total_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `building_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `property_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selected_label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_property_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `property_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `receipt_vouchers`
--

INSERT INTO `receipt_vouchers` (`id`, `financialYear`, `basic_date`, `selectedPaymentType`, `cash_bank_account`, `client_name`, `selectedProject`, `client_tin`, `client_email`, `client_phone`, `product_name`, `bank_cheque_no`, `bank_cheque_date`, `bank_name`, `bank_branch`, `total_amount`, `receipt_id`, `Supporting_docs`, `payto`, `payees_account_no`, `payment_receipt_details`, `client_id`, `created_at`, `updated_at`, `product_amount`, `due`, `initial_total_amount`, `account_type`, `building_name`, `property_id`, `selected_label`, `sub_property_id`, `property_type`, `payment_status`) VALUES
(131, '2023-2024', '2024-03-07', 'Cash', '', 'ফারজানা মন্ডল', 'Dhanmondi garden city', '', '', '01712711703', '1A', 'null', 'null', 'null', '', '3053235', 'DPAEI26078', 'documents/65ff1b61da059313db204-1635-4cc2-9c90-01a643149e0b.jpg', '', '', '', 'DGC4-001', '2024-03-19 08:35:19', '2024-03-23 12:11:45', '3000000', '-53235', '3000000', 'Installation-3476014DPAEI26078', 'DGC4', 'mXEFM-54020', 'flat', 'hvnZQ-391785', 'others', NULL),
(132, '2023-2024', '2024-03-13', 'Cash', '', 'এম এম স্বপন রাজা', 'Dhanmondi garden city', 'null', 'null', '187485239*', '2A', NULL, NULL, NULL, '', '79666', 'BWxwW19111', 'documents/65f9c38810b24download G.pdf', '', '', '', 'DGC6-002', '2024-03-19 10:55:36', '2024-03-19 10:55:36', '3000000', '2920334', '3000000', 'Installation-3426642BWxwW19111', 'DGC6', 'bwhvK-836834', 'flat', 'dMiCn-487916', 'others', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `references`
--

CREATE TABLE `references` (
  `id` bigint UNSIGNED NOT NULL,
  `reference_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `voucher_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `references`
--

INSERT INTO `references` (`id`, `reference_id`, `reference_name`, `date`, `reference_amount`, `voucher_no`, `client_name`, `product_name`, `created_at`, `updated_at`, `phone`) VALUES
(16, 'lcDDM2416', 'sdfsd', '2024-03-07', '500', 'DPAEI26078', 'ফারজানা মন্ডল', '1A', '2024-03-19 08:35:19', '2024-03-19 08:35:19', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `reference_basic_infos`
--

CREATE TABLE `reference_basic_infos` (
  `id` bigint UNSIGNED NOT NULL,
  `reference_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reference_basic_infos`
--

INSERT INTO `reference_basic_infos` (`id`, `reference_name`, `reference_id`, `created_at`, `updated_at`, `phone`) VALUES
(3, 'Zeodo', 'tgpcA77886', '2023-05-30 14:53:44', '2023-06-26 15:11:09', '45465465'),
(4, 'micky', 'nUPaB80104', '2023-06-26 15:10:13', '2023-06-26 15:10:13', '5454'),
(5, 'sdfsd', 'lcDDM2416', '2023-09-27 14:47:58', '2023-09-27 14:47:58', 'sdfdsf');

-- --------------------------------------------------------

--
-- Table structure for table `r_p_ledgers`
--

CREATE TABLE `r_p_ledgers` (
  `id` bigint UNSIGNED NOT NULL,
  `client_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `due` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `return_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `balance` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `financialYear` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `r_p_ledgers`
--

INSERT INTO `r_p_ledgers` (`id`, `client_name`, `receipt_id`, `product_name`, `paid`, `due`, `cash`, `bank`, `date`, `return_amount`, `balance`, `account_type`, `financialYear`, `created_at`, `updated_at`) VALUES
(125, 'ফারজানা মন্ডল', 'DPAEI26078', '1A', '0', '2941765', 'Cash', NULL, '2024-03-07', '0', NULL, 'Installation-3476014DPAEI26078', '2023-2024', '2024-03-19 08:35:19', '2024-03-19 08:35:19'),
(126, 'ফারজানা মন্ডল', 'DPAEI26078', '1A', '-2995000', '0', 'Cash', NULL, '2024-03-14', '0', NULL, 'Due-2785528ZBIeF-65576', '2023-2024', '2024-03-19 08:39:39', '2024-03-19 08:39:39'),
(127, 'এম এম স্বপন রাজা', 'BWxwW19111', '2A', '0', '2933334', 'Cash', NULL, '2024-03-13', '0', NULL, 'Installation-3426642BWxwW19111', '2023-2024', '2024-03-19 10:55:36', '2024-03-19 10:55:36'),
(128, 'এম এম স্বপন রাজা', 'BWxwW19111', '2A', '-13000', '0', 'Cash', NULL, '2024-03-28', '0', NULL, 'Due-4691789JTHBl-76256', '2023-2024', '2024-03-19 10:58:04', '2024-03-19 10:58:04');

-- --------------------------------------------------------

--
-- Table structure for table `salaries`
--

CREATE TABLE `salaries` (
  `id` bigint UNSIGNED NOT NULL,
  `basic_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selectedPaymentType` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cash_bank_account` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selectedProject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_cheque_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_cheque_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_branch` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `basic_salary` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `commission` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_month` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_year` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employee_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `employee_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selectedBuilding` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employee_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `salaries`
--

INSERT INTO `salaries` (`id`, `basic_date`, `selectedPaymentType`, `cash_bank_account`, `selectedProject`, `bank_cheque_no`, `bank_cheque_date`, `bank_name`, `bank_branch`, `basic_salary`, `commission`, `paid_month`, `paid_year`, `employee_id`, `created_at`, `updated_at`, `employee_name`, `selectedBuilding`, `employee_phone`) VALUES
(18, '2024-02-24', 'Cash', NULL, 'Dream Tower', NULL, NULL, NULL, NULL, '18000', '0', 'March', '2024', 'HsANH-51271', '2024-02-23 09:43:23', '2024-02-23 09:43:23', 'Jakir', 'DT', '01793607623');

-- --------------------------------------------------------

--
-- Table structure for table `sells_ledgers`
--

CREATE TABLE `sells_ledgers` (
  `id` bigint UNSIGNED NOT NULL,
  `client_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `due` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `return_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_balance` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `financialYear` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sells_ledgers`
--

INSERT INTO `sells_ledgers` (`id`, `client_name`, `receipt_id`, `product_name`, `paid`, `due`, `cash`, `bank`, `date`, `client_id`, `return_amount`, `total_balance`, `financialYear`, `created_at`, `updated_at`) VALUES
(99, 'ফারজানা মন্ডল', 'DPAEI26078', '1A', '-58235', '-2941765', 'Cash', NULL, '2024-03-07', 'DGC4-001', '0', '-3000000', '2023-2024', '2024-03-19 08:35:19', '2024-03-19 08:35:19'),
(100, 'এম এম স্বপন রাজা', 'BWxwW19111', '2A', '79666', '2920334', 'Cash', NULL, '2024-03-13', 'DGC6-002', '0', '-3000000', '2023-2024', '2024-03-19 10:55:36', '2024-03-19 10:55:36');

-- --------------------------------------------------------

--
-- Table structure for table `stocks`
--

CREATE TABLE `stocks` (
  `id` bigint UNSIGNED NOT NULL,
  `stock_date` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `project` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `selectedBuilding` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stocks`
--

INSERT INTO `stocks` (`id`, `stock_date`, `payment_id`, `quantity`, `project`, `item_id`, `item_unit`, `product_name`, `created_at`, `updated_at`, `selectedBuilding`) VALUES
(449, '2024-03-20', 'Transfered -xDeKs-21429', '7', 'Dhanmondi garden city', '13', 'Bag', 'Cement', '2024-03-19 09:23:18', '2024-03-19 09:23:18', 'DGC6'),
(450, '2024-03-21', 'UdLIn-75333', '50', 'Dhanmondi garden city', '12', 'ton', 'Rod', '2024-03-21 03:37:35', '2024-03-21 03:37:35', 'DGC4');

-- --------------------------------------------------------

--
-- Table structure for table `stock_journals`
--

CREATE TABLE `stock_journals` (
  `id` bigint UNSIGNED NOT NULL,
  `product_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_quantity` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `consume_quantity` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_transfers`
--

CREATE TABLE `stock_transfers` (
  `id` bigint UNSIGNED NOT NULL,
  `selectedProject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selectedBuilding` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quanity` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purpose` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Supporting_docs` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `fromProject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fromBuilding` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `basic_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stock_transfers`
--

INSERT INTO `stock_transfers` (`id`, `selectedProject`, `selectedBuilding`, `quanity`, `purpose`, `note`, `Supporting_docs`, `created_at`, `updated_at`, `fromProject`, `fromBuilding`, `basic_date`, `unit`, `product_name`) VALUES
(30, 'Dhanmondi garden city', 'DGC6', '10', 'CONSTRUCTION', 'HYJYHJHGMJN YDTJGKTYG', '', '2024-03-19 09:23:18', '2024-03-19 09:23:18', 'Dream Tower', 'DT', '2024-03-20', 'Bag', 'Cement');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` bigint UNSIGNED NOT NULL,
  `supplier_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `supplier_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `supplier_name`, `supplier_location`, `supplier_id`, `created_at`, `updated_at`, `phone`) VALUES
(10, 'not appicable', 'not appicable', 'MAIO-8913', '2024-02-01 08:55:10', '2024-02-01 08:55:10', '0000000');

-- --------------------------------------------------------

--
-- Table structure for table `task_models`
--

CREATE TABLE `task_models` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deadline` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `client_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `task_sender` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `task_models`
--

INSERT INTO `task_models` (`id`, `title`, `description`, `deadline`, `created_at`, `updated_at`, `client_name`, `task_sender`) VALUES
(43, 'fdsfdsf', 'dsfdsfds', '2023-08-15', '2023-08-01 08:32:18', '2023-08-01 08:32:18', 'gggg', 'kkkk'),
(44, 'dsfdsfds', 'dsfdfds', '2023-08-23', '2023-08-05 08:46:01', '2023-08-05 08:46:01', 'gggg', 'kkkk'),
(45, 'dsfdsfds', 'dsfdfds', '2023-08-23', '2023-08-05 08:49:36', '2023-08-05 08:49:36', 'gggg', 'kkkk'),
(46, 'fdsfdsf', 'dsfdsfdsf', '2023-08-21', '2023-08-06 07:49:34', '2023-08-06 07:49:34', 'gggg', 'kkkk'),
(47, 'fdsfds', 'fdsdsdsf', '2023-08-23', '2023-08-06 07:53:00', '2023-08-06 07:53:00', 'gggg', 'kkkk'),
(48, 'fdfdfds', 'dsfdsfdsf', '2023-08-23', '2023-08-06 07:53:40', '2023-08-06 07:53:40', 'gggg', 'kkkk'),
(49, 'fdfdfds', 'dsfdsfdsf', '2023-08-23', '2023-08-06 07:53:44', '2023-08-06 07:53:44', 'gggg', 'kkkk'),
(50, 'fdfdfds', 'dsfdsfdsf', '2023-08-23', '2023-08-06 07:53:48', '2023-08-06 07:53:48', 'gggg', 'kkkk'),
(51, 'ffds', 'dsfds', '2023-08-16', '2023-08-06 07:56:04', '2023-08-06 07:56:04', 'gggg', 'kkkk');

-- --------------------------------------------------------

--
-- Table structure for table `total_advance_pays`
--

CREATE TABLE `total_advance_pays` (
  `id` bigint UNSIGNED NOT NULL,
  `basic_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selectedProject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selectedBuilding` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `total_advance_pays`
--

INSERT INTO `total_advance_pays` (`id`, `basic_date`, `client_name`, `client_id`, `selectedProject`, `selectedBuilding`, `amount`, `note`, `created_at`, `updated_at`) VALUES
(2, '2023-06-22', 'Rakib', 'rrs-1353', 'Project  B', 'BD', '15000', NULL, '2023-06-21 06:22:07', '2023-06-21 06:22:07'),
(3, '2023-06-21', 'Jahid', 'grl-8100', 'Project C', 'C', '0', 'For Flat Purpose, Lorem Ipsum is simply dummy text of the printing and typesetting industry.', '2023-06-21 07:14:51', '2023-06-21 07:14:51'),
(5, '2023-06-22', 'Rhidoy', 'ejb-6016', 'Project E', 'sd', '0', NULL, '2023-06-22 02:58:39', '2023-06-22 02:58:39'),
(6, '2023-06-14', 'Enamul', 'liy-7535', 'Project E', 'sd', '3000000', NULL, '2023-06-26 01:47:02', '2023-06-26 01:47:02'),
(7, '2023-07-08', 'Rakib', 'sbg-7761', 'Project  B', 'BD', '40000', NULL, '2023-07-08 07:20:13', '2023-07-08 07:20:13'),
(8, '2024-01-18', 'rakib', 'sd-007', 'Project E', 'sd', '5000', NULL, '2024-01-19 07:46:41', '2024-01-19 07:46:41');

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` bigint UNSIGNED NOT NULL,
  `item_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `item_name`, `item_unit`, `created_at`, `updated_at`) VALUES
(12, 'Rod', 'ton', '2023-05-30 04:50:02', '2024-02-01 08:56:25'),
(13, 'Cement', 'Bag', '2023-05-30 15:34:43', '2024-02-01 08:56:40'),
(14, 'Stone', 'cft', '2023-05-31 00:16:27', '2024-02-01 08:57:00'),
(15, 'Red Sand', 'Car', '2023-05-31 00:22:18', '2024-02-01 08:57:23'),
(16, 'White Sand', 'car', '2023-06-12 11:05:03', '2024-02-01 08:58:05'),
(17, 'Brick', 'Car', '2024-02-01 08:56:06', '2024-02-01 08:58:17'),
(18, 'Land', 'Decimal', '2024-02-01 08:59:48', '2024-02-01 08:59:48');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts_accesses`
--
ALTER TABLE `accounts_accesses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `account_heads`
--
ALTER TABLE `account_heads`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `account_types`
--
ALTER TABLE `account_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_username_unique` (`username`),
  ADD UNIQUE KEY `admins_email_unique` (`email`);

--
-- Indexes for table `advance_pays`
--
ALTER TABLE `advance_pays`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `apledgers`
--
ALTER TABLE `apledgers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bank_ledgers`
--
ALTER TABLE `bank_ledgers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cash_ledgers`
--
ALTER TABLE `cash_ledgers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `client_statuses`
--
ALTER TABLE `client_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `construction_histories`
--
ALTER TABLE `construction_histories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `construction_pays`
--
ALTER TABLE `construction_pays`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `construction_requireds`
--
ALTER TABLE `construction_requireds`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `consume_stocks`
--
ALTER TABLE `consume_stocks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `inventories`
--
ALTER TABLE `inventories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `managers`
--
ALTER TABLE `managers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `managers_username_unique` (`username`),
  ADD UNIQUE KEY `managers_email_unique` (`email`);

--
-- Indexes for table `manager_approves`
--
ALTER TABLE `manager_approves`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `payable_journals`
--
ALTER TABLE `payable_journals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_histories`
--
ALTER TABLE `payment_histories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_vouchers`
--
ALTER TABLE `payment_vouchers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pay_payables`
--
ALTER TABLE `pay_payables`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pay_receivables`
--
ALTER TABLE `pay_receivables`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_members`
--
ALTER TABLE `project_members`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_stages`
--
ALTER TABLE `project_stages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchased_journals`
--
ALTER TABLE `purchased_journals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchase_lands`
--
ALTER TABLE `purchase_lands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchase_ledgers`
--
ALTER TABLE `purchase_ledgers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchase_returns`
--
ALTER TABLE `purchase_returns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `receipt_histories`
--
ALTER TABLE `receipt_histories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `receipt_journals`
--
ALTER TABLE `receipt_journals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `receipt_payable_journals`
--
ALTER TABLE `receipt_payable_journals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `receipt_vouchers`
--
ALTER TABLE `receipt_vouchers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `references`
--
ALTER TABLE `references`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reference_basic_infos`
--
ALTER TABLE `reference_basic_infos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `r_p_ledgers`
--
ALTER TABLE `r_p_ledgers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `salaries`
--
ALTER TABLE `salaries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sells_ledgers`
--
ALTER TABLE `sells_ledgers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stocks`
--
ALTER TABLE `stocks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_journals`
--
ALTER TABLE `stock_journals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_transfers`
--
ALTER TABLE `stock_transfers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `task_models`
--
ALTER TABLE `task_models`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `total_advance_pays`
--
ALTER TABLE `total_advance_pays`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts_accesses`
--
ALTER TABLE `accounts_accesses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `account_heads`
--
ALTER TABLE `account_heads`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `account_types`
--
ALTER TABLE `account_types`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `advance_pays`
--
ALTER TABLE `advance_pays`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `apledgers`
--
ALTER TABLE `apledgers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=548;

--
-- AUTO_INCREMENT for table `bank_ledgers`
--
ALTER TABLE `bank_ledgers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125;

--
-- AUTO_INCREMENT for table `cash_ledgers`
--
ALTER TABLE `cash_ledgers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=555;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=512;

--
-- AUTO_INCREMENT for table `client_statuses`
--
ALTER TABLE `client_statuses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `construction_histories`
--
ALTER TABLE `construction_histories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `construction_pays`
--
ALTER TABLE `construction_pays`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=256;

--
-- AUTO_INCREMENT for table `construction_requireds`
--
ALTER TABLE `construction_requireds`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=487;

--
-- AUTO_INCREMENT for table `consume_stocks`
--
ALTER TABLE `consume_stocks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventories`
--
ALTER TABLE `inventories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- AUTO_INCREMENT for table `managers`
--
ALTER TABLE `managers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `manager_approves`
--
ALTER TABLE `manager_approves`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=198;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `payable_journals`
--
ALTER TABLE `payable_journals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=398;

--
-- AUTO_INCREMENT for table `payment_histories`
--
ALTER TABLE `payment_histories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `payment_vouchers`
--
ALTER TABLE `payment_vouchers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=438;

--
-- AUTO_INCREMENT for table `pay_payables`
--
ALTER TABLE `pay_payables`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=142;

--
-- AUTO_INCREMENT for table `pay_receivables`
--
ALTER TABLE `pay_receivables`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `project_members`
--
ALTER TABLE `project_members`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `project_stages`
--
ALTER TABLE `project_stages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `purchased_journals`
--
ALTER TABLE `purchased_journals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=431;

--
-- AUTO_INCREMENT for table `purchase_lands`
--
ALTER TABLE `purchase_lands`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `purchase_ledgers`
--
ALTER TABLE `purchase_ledgers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=405;

--
-- AUTO_INCREMENT for table `purchase_returns`
--
ALTER TABLE `purchase_returns`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `receipt_histories`
--
ALTER TABLE `receipt_histories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `receipt_journals`
--
ALTER TABLE `receipt_journals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- AUTO_INCREMENT for table `receipt_payable_journals`
--
ALTER TABLE `receipt_payable_journals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=132;

--
-- AUTO_INCREMENT for table `receipt_vouchers`
--
ALTER TABLE `receipt_vouchers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=133;

--
-- AUTO_INCREMENT for table `references`
--
ALTER TABLE `references`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `reference_basic_infos`
--
ALTER TABLE `reference_basic_infos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `r_p_ledgers`
--
ALTER TABLE `r_p_ledgers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=129;

--
-- AUTO_INCREMENT for table `salaries`
--
ALTER TABLE `salaries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `sells_ledgers`
--
ALTER TABLE `sells_ledgers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `stocks`
--
ALTER TABLE `stocks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=451;

--
-- AUTO_INCREMENT for table `stock_journals`
--
ALTER TABLE `stock_journals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=131;

--
-- AUTO_INCREMENT for table `stock_transfers`
--
ALTER TABLE `stock_transfers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `task_models`
--
ALTER TABLE `task_models`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `total_advance_pays`
--
ALTER TABLE `total_advance_pays`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
